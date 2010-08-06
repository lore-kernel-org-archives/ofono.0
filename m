Content-Type: multipart/mixed; boundary="===============9054214505465736806=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 08/17] sms: export outgoing messages over D-Bus
Date: Thu, 05 Aug 2010 17:55:30 -0700
Message-ID: <d8cfe95bece316a964b0bdea5aa860bb58fb39c8.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9054214505465736806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Splits sms_send_message() into a D-Bus front end and an internal API:

- sms_msg_send(), a full C interface for SMS sending

- dbus_sms_msg_send(): adapts sms_msg_send() to be a D-Bus call,
  exporting the object on the bus, returning its name and setting up
  all the callbacks and D-Bus specific data. The call is synchronous.

This allows internal code to use the same infrastructure as D-Bus
clients to send SMS messages.
---
 src/sms.c |  191 ++++++++++++++++++++++++++++++++++++++++++++-------------=
----
 1 files changed, 139 insertions(+), 52 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 0d786a1..146027d 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -42,6 +42,10 @@
 =

 #define SMS_MANAGER_FLAG_CACHED 0x1
 =

+/* D-Bus interface name for SMS messages (not for the manager!) */
+static
+const char SMS_MSG_INTERFACE[] =3D "org.ofono.SmsMessage";
+
 #define SETTINGS_STORE "sms"
 #define SETTINGS_GROUP "Settings"
 =

@@ -524,6 +528,24 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 =

 =

 /*
+ * D-Bus SMS Message interface
+ *
+ * NOTE: the sms_msg_{methods,signals} tables should be const, but
+ * then g_dbus_register_interface() type warns.
+ */
+
+static
+GDBusMethodTable sms_msg_methods[] =3D {
+	{ }
+};
+
+static
+GDBusSignalTable sms_msg_signals[] =3D {
+	{ "PropertyChanged",	"sv"		},
+	{ }
+};
+
+/*
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
  * This releases resources allocated *inside* @entry and @entry
@@ -543,6 +565,7 @@ static void tx_queue_entry_destroy(struct tx_queue_entr=
y *entry)
 =

 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 	g_free(entry);
+	ofono_debug("%s():%d: sms_msg %p freed", __func__, __LINE__, entry);
 }
 =

 static void tx_queue_entry_destroy_foreach(gpointer _entry, gpointer unuse=
d)
@@ -741,48 +764,36 @@ static struct tx_queue_entry *tx_queue_entry_new(GSLi=
st *msg_list)
 	return entry;
 }
 =

-static void send_message_stch_cb(void *data, enum ofono_sms_tx_state new_s=
tate)
+
+static void sms_msg_dbus_destroy(void *_dbus_path)
 {
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	DBusMessage *msg =3D data;
-	DBusMessage *reply;
-	gboolean ok;
+	char *dbus_path =3D _dbus_path;
 =

-	/*
-	 * We care about only the final states
-	 * (DONE/CANCELLED/FAILED/EXPIRED), the rest are just
-	 * ignored.
-	 */
-	if (new_state =3D=3D OFONO_SMS_TX_ST_DONE)
-		ok =3D TRUE;
-	else if (new_state =3D=3D OFONO_SMS_TX_ST_CANCELLED
-		 || new_state =3D=3D OFONO_SMS_TX_ST_FAILED
-		 || new_state =3D=3D OFONO_SMS_TX_ST_EXPIRED)
-		ok =3D FALSE;
-	else
+	if (dbus_path =3D=3D NULL)
 		return;
 =

-	if (ok)
-		reply =3D dbus_message_new_method_return(msg);
-	else
-		reply =3D __ofono_error_failed(msg);
-
-	g_dbus_send_message(conn, reply);
+	g_dbus_unregister_interface(ofono_dbus_get_connection(),
+				    dbus_path, SMS_MSG_INTERFACE);
+	g_free(dbus_path);
 }
 =

-static void send_message_destroy(void *data)
-{
-	DBusMessage *msg =3D data;
-
-	dbus_message_unref(msg);
-}
+/* Flags to sms_msg_send() */
+enum sms_msg_send_flags {
+	/* Record/dont this message to the history database */
+	SMS_MSG_SEND_HISTORY =3D 0x01,
+};
 =

 /*
- * Pre-process a SMS text message and deliver it [D-Bus SendMessage()]
+ * Pre-process a SMS text message and deliver it
  *
  * @conn: D-Bus connection
  * @msg: message data (telephone number and text)
  * @data: SMS object to use for transmision
+ * @send_flags: flags that manipulate how the message is sent.
+ * @send_cb: function called when the message is sent
+ * @destroy_cb: function called when the message structure is
+ *    being released
+ * @priv: pointer to pass to the @data and @send_cb functions
  *
  * An alphabet is chosen for the text and it (might be) segmented in
  * fragments by sms_text_prepare() into @msg_list. A queue list @entry
@@ -790,31 +801,27 @@ static void send_message_destroy(void *data)
  * appends that entry to the SMS transmit queue. Then the tx_next()
  * function is scheduled to run to process the queue.
  */
-static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
-					void *data)
+static
+struct tx_queue_entry *sms_msg_send(
+	struct ofono_sms *sms, const char *to, const char *text,
+	enum sms_msg_send_flags send_flags,
+	ofono_sms_msg_stch_cb_t stch_cb,
+	void (*destroy_cb)(void *), void *priv)
 {
-	struct ofono_sms *sms =3D data;
-	const char *to;
-	const char *text;
 	GSList *msg_list;
 	int ref_offset;
 	struct ofono_modem *modem;
 	unsigned int flags;
 	struct tx_queue_entry *sms_msg;
 =

-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
-					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_INVALID))
-		return __ofono_error_invalid_args(msg);
-
 	if (valid_phone_number_format(to) =3D=3D FALSE)
-		return __ofono_error_invalid_format(msg);
+		return NULL;
 =

 	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
 					sms->use_delivery_reports);
 =

 	if (!msg_list)
-		return __ofono_error_invalid_format(msg);
+		return NULL;
 =

 	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
 	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
@@ -826,24 +833,105 @@ static DBusMessage *sms_send_message(DBusConnection =
*conn, DBusMessage *msg,
 			sms->ref =3D sms->ref + 1;
 	}
 =

-	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
+	if (send_flags & SMS_MSG_SEND_HISTORY)
+		flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
 	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

-	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags,
-						send_message_stch_cb,
-						dbus_message_ref(msg),
-						send_message_destroy);
+	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, stch_cb,
+						priv, destroy_cb);
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
 =

 	modem =3D __ofono_atom_get_modem(sms->atom);
-	__ofono_history_sms_send_pending(modem, sms_msg->msg_id, to,
-						time(NULL), text);
 =

-	return NULL;
+	if (flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY)
+		__ofono_history_sms_send_pending(modem, sms_msg->msg_id, to,
+							time(NULL), text);
+
+	return sms_msg;
+}
+
+/*
+ * D-Bus: Send a SMS text message
+ *
+ * @conn: D-Bus connection
+ * @msg: message data (telephone number and text)
+ * @data: SMS object to use for transmision
+ *
+ * Unwraps the arguments and sends the request to sms_msg_send()
+ */
+static DBusMessage *dbus_sms_msg_send(DBusConnection *conn, DBusMessage *m=
sg,
+				      void *data)
+{
+	struct ofono_sms *sms =3D data;
+	const char *to;
+	const char *text;
+	struct tx_queue_entry *sms_msg;
+	DBusMessage *reply;
+	char *dbus_path;
+	const char *sms_path =3D __ofono_atom_get_path(sms->atom);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	/*
+	 * This is released by @ sms_msg_dbus_destroy() -- first we
+	 * allocate and then once we have the MSG ID, we re-write it.
+	 */
+	dbus_path =3D g_strdup_printf("%s/%08x", sms_path, 0);
+	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY,
+			       NULL,
+			       sms_msg_dbus_destroy,
+			       dbus_path);
+
+	if (sms_msg =3D=3D NULL)
+		goto error_sms_msg_send;
+
+	/* Set the MSG ID in the D-Bus path now that we have it. */
+	sprintf(dbus_path, "%s/%08x", sms_path, sms_msg->msg_id & 0xffffffff);
+
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+					dbus_path, SMS_MSG_INTERFACE,
+					sms_msg_methods, sms_msg_signals,
+					NULL, sms_msg, NULL)) {
+		ofono_error("%s():%d: %s: Could not create %s interface",
+			    __func__, __LINE__, dbus_path, SMS_MSG_INTERFACE);
+		goto error_dbus_register_interface;
+	}
+
+	ofono_debug("%s():%d: sms %p @ %s: MSG registered",
+		    __func__, __LINE__, sms_msg, dbus_path);
+
+	reply =3D dbus_message_new_method_return(msg);
+
+	if (!reply)
+		goto error_dbus_new_method_return;
+
+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &dbus_path,
+					DBUS_TYPE_INVALID);
+	return reply;
+
+
+error_dbus_new_method_return:
+	g_dbus_unregister_interface(ofono_dbus_get_connection(),
+					dbus_path, SMS_MSG_INTERFACE);
+error_dbus_register_interface:
+	/*
+	 * Note we don't want the destructor called, as we do it's
+	 * steps manually here when falling through. Kind of layering
+	 * violation, but it is the cleaner way as things are
+	 * currently laid out.
+	 */
+	sms_msg->destroy =3D NULL;
+	tx_queue_entry_destroy(sms_msg);
+error_sms_msg_send:
+	g_free(dbus_path);
+	return __ofono_error_invalid_format(msg);
 }
 =

 static GDBusMethodTable sms_manager_methods[] =3D {
@@ -851,8 +939,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		sms_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",	"ss",	"",		sms_send_message,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendMessage",	"ss",	"",		dbus_sms_msg_send, 0 },
 	{ }
 };
 =

-- =

1.6.6.1


--===============9054214505465736806==--

