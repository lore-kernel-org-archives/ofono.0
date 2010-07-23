Content-Type: multipart/mixed; boundary="===============3261517754890774497=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 17/20] SMS: export outgoing messages over D-Bus
Date: Fri, 23 Jul 2010 14:00:05 -0700
Message-ID: <25a253bfc7db89cc59a737d9b65538f35ab1ed71.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3261517754890774497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Splits sms_send_message() into a D-Bus front end and an internal API:

- sms_msg_send(), a full C interface for SMS sending

- dbus_sms_msg_send(): adapts sms_msg_send() to be a D-Bus call,
  exporting the object on the bus, returning its name and setting up
  all the callbacks and D-Bus specific data needed in a 'struct
  sms_msg_dbus_data'. The call is synchronous.

This allows internal code to use the same infrastructure as D-Bus
clients to send SMS messages.
---
 src/sms.c     |  192 +++++++++++++++++++++++++++++++++++++++--------------=
----
 src/smsutil.h |   12 ++++
 2 files changed, 145 insertions(+), 59 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 668a645..4569cf3 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -41,6 +41,10 @@
 =

 #define SMS_MANAGER_FLAG_CACHED 0x1
 =

+/* D-Bus interface name for SMS messages (not for the manager!) */
+static
+const char SMS_MSG_INTERFACE[] =3D "org.ofono.SMSMessage";
+
 #define SETTINGS_STORE "sms"
 #define SETTINGS_GROUP "Settings"
 =

@@ -123,11 +127,9 @@ struct tx_queue_entry {
  * Encapsulate information needed to export an SMS message over D-Bus.
  *
  * @dbus_path: path of the object in the D-Bus
- * @dbus_msg: message this originated at
  */
 struct sms_msg_dbus_data {
 	char *dbus_path;
-	DBusMessage *dbus_msg;
 };
 =

 static const char *sms_bearer_to_string(int bearer)
@@ -536,6 +538,26 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
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
+
+static
+GDBusSignalTable sms_msg_signals[] =3D {
+	{ "PropertyChanged",	"sv"		},
+	{ }
+};
+
+
+/*
  * Destroy/release the contents of a 'struct tx_queue_entry'
  *
  * This releases resources allocated *inside* @entry and @entry
@@ -554,6 +576,7 @@ static void tx_queue_entry_destroy_free(gpointer _entry=
, gpointer unused)
 	g_queue_remove(entry->sms_mgr->tx_wsrq, entry);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
 	g_free(entry);
+	ofono_debug("%s():%d: sms_msg %p freed", __func__, __LINE__, entry);
 }
 =

 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
@@ -694,55 +717,35 @@ static struct tx_queue_entry *tx_queue_entry_new(GSLi=
st *msg_list)
 		DBG("pdu_len: %d, tpdu_len: %d",
 				pdu->pdu_len, pdu->tpdu_len);
 	}
-
 	return entry;
 }
 =

-static void send_message_stch_cb(void *data, enum ofono_sms_tx_state new_s=
tate)
-{
-	DBusConnection *conn =3D ofono_dbus_get_connection();
-	struct sms_msg_dbus_data *dbus_data =3D data;
-	DBusMessage *msg =3D dbus_data->dbus_msg;
-	DBusMessage *reply;
-	gboolean ok;
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
-		return;
-
-	if (ok)
-		reply =3D dbus_message_new_method_return(msg);
-	else
-		reply =3D __ofono_error_failed(msg);
-
-	g_dbus_send_message(conn, reply);
-}
-
-static void send_message_destroy(void *data)
+static void sms_msg_dbus_destroy(void *_dbus_data)
 {
-	struct sms_msg_dbus_data *dbus_data =3D data;
-	DBusMessage *msg =3D dbus_data->dbus_msg;
+	struct sms_msg_dbus_data *dbus_data =3D _dbus_data;
 =

-	dbus_message_unref(msg);
+	if (dbus_data =3D=3D NULL)
+		return;
+	g_dbus_unregister_interface(ofono_dbus_get_connection(),
+				    dbus_data->dbus_path, SMS_MSG_INTERFACE);
+	g_free(dbus_data->dbus_path);
+	memset(dbus_data, 0, sizeof(*dbus_data));
 	g_free(dbus_data);
 }
 =

+
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
@@ -753,12 +756,12 @@ static void send_message_destroy(void *data)
  * @sms is the main SMS driver struct, @entry and @msg_list represent
  * the current message being processed.
  */
-static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
-					void *data)
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
@@ -770,13 +773,8 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	DECLARE_SMS_ADDR_STR(receiver_str);
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
 	/*
 	 * Instead of using the telephone number/address we got from
 	 * D-Bus, we do the reverse formatting, so we get something
@@ -786,13 +784,13 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	sms_address_from_string(&receiver, to);
 	if (sms_address_to_hex_string(&receiver, receiver_str)
 	    =3D=3D FALSE)
-		return __ofono_error_failed(msg);
+		return NULL;
 =

 	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
-					sms->use_delivery_reports);
+				    sms->use_delivery_reports);
 =

 	if (!msg_list)
-		return __ofono_error_invalid_format(msg);
+		return NULL;
 =

 	sms_msg_id_init(&sms_msg_id);
 	sms_msg_id_hash(&sms_msg_id, text, strlen(text));
@@ -803,23 +801,100 @@ static DBusMessage *sms_send_message(DBusConnection =
*conn, DBusMessage *msg,
 	set_ref_and_to(msg_list, msg_id, ref_offset, to);
 	DBG("ref: %d, offset: %d", msg_id, ref_offset);
 =

-	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
+	if (send_flags & SMS_MSG_SEND_HISTORY)
+		flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
 	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

 	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id,
-					 send_message_stch_cb,
-					 dbus_message_ref(msg),
-					 send_message_destroy);
+					 stch_cb, priv, destroy_cb);
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
 =

 	modem =3D __ofono_atom_get_modem(sms->atom);
-	__ofono_history_sms_send_pending(modem, msg_id, to, time(NULL), text);
 =

-	return NULL;
+	return sms_msg;
+}
+
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
+	struct sms_msg_dbus_data *dbus_data;
+	const char *sms_path =3D __ofono_atom_get_path(sms->atom);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
+				   DBUS_TYPE_STRING, &text,
+				   DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	dbus_data =3D g_new0(struct sms_msg_dbus_data, 1);
+	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY,
+			       NULL,
+			       sms_msg_dbus_destroy,
+			       dbus_data);
+	if (sms_msg =3D=3D NULL)
+		goto error_sms_msg_send;
+	/* We can only fill out these data when we have the
+	 * information we need off @sms_msg; this is all released by @
+	 * sms_msg_dbus_destroy() */
+	dbus_data->dbus_path =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
+					       sms_msg->msg_id,
+					       sms_msg->num_pdus);
+
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+				       dbus_data->dbus_path, SMS_MSG_INTERFACE,
+				       sms_msg_methods, sms_msg_signals,
+				       NULL, sms_msg, NULL)) {
+		ofono_error("%s():%d: %s: Could not create %s interface",
+			    __func__, __LINE__, dbus_data->dbus_path,
+			    SMS_MSG_INTERFACE);
+		goto error_dbus_register_interface;
+	}
+	ofono_debug("%s():%d: sms %p @ %s: MSG registered",
+		    __func__, __LINE__, sms_msg, dbus_data->dbus_path);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		goto error_dbus_new_method_return;
+	dbus_message_append_args(reply,
+				 DBUS_TYPE_STRING, &dbus_data->dbus_path,
+				 DBUS_TYPE_INVALID);
+	return reply;
+
+
+error_dbus_new_method_return:
+	g_dbus_unregister_interface(ofono_dbus_get_connection(),
+				    dbus_data->dbus_path, SMS_MSG_INTERFACE);
+error_dbus_register_interface:
+	g_free(dbus_data->dbus_path);
+	/*
+	 * Note we don't want the destructor called, as we do it's
+	 * steps manually here when falling through. Kind of layering
+	 * violation, but it is the cleaner way as things are
+	 * currently laid out.
+	 */
+	sms_msg->destroy =3D NULL;
+	tx_queue_entry_destroy_free(sms_msg, NULL);
+error_sms_msg_send:
+	g_free(dbus_data);
+	return __ofono_error_invalid_format(msg);
 }
 =

 static GDBusMethodTable sms_manager_methods[] =3D {
@@ -827,8 +902,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		sms_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",	"ss",	"",		sms_send_message,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendMessage",	"ss",	"",		dbus_sms_msg_send, 0 },
 	{ }
 };
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index 28b5604..20b24f0 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -215,6 +215,12 @@ enum cbs_geo_scope {
 	CBS_GEO_SCOPE_CELL_NORMAL
 };
 =

+/* Flags to sms_msg_send() */
+enum sms_msg_send_flags {
+	/* Record/dont this message to the history database */
+	SMS_MSG_SEND_HISTORY =3D 0x01,
+};
+
 struct sms_address {
 	enum sms_number_type number_type;
 	enum sms_numbering_plan numbering_plan;
@@ -634,3 +640,9 @@ void sms_msg_id_memcpy(void *, size_t, const struct sms=
_msg_id *);
 =

 /* for unit testing only */
 gsize __sms_msg_id_hash_length(void);
+
+/*
+ * UNIQUE-ID_#PDUS -- note we use underscores as to generate a name
+ * suitable to be a D-Bus name.
+ */
+#define SMS_MSG_NAME_FMT "%s/%04x_%i"
-- =

1.6.6.1


--===============3261517754890774497==--

