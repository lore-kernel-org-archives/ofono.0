Content-Type: multipart/mixed; boundary="===============3817460906860119999=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 15/23] SMS: split sms_send_message() into a D-Bus front
 end and an internal API
Date: Fri, 25 Jun 2010 16:15:37 -0700
Message-ID: <10cb10940067c61519b1d73c113a67c91fe21f5e.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3817460906860119999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

sms_send_message() is unfolded into:

- sms_msg_send(), a full C interface for SMS sending

- dbus_SendMessage(), which adapts sms_msg_send() to be a D-Bus call

This is done to allow plugins to use the same infrastructure as D-Bus
clients to send SMS messages.
---
 src/sms.c     |   66 +++++++++++++++++++++++++++++++++++++++++------------=
---
 src/smsutil.h |    6 +++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 49b9c4c..0182ac8 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -466,6 +466,10 @@ static void tx_queue_entry_destroy(struct tx_queue_ent=
ry *entry)
 	g_free(entry->pdus);
 	g_free(entry->name);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
+	if (entry->msg) {
+		dbus_message_unref(entry->msg);
+		entry->msg =3D NULL;
+	}
 }
 =

 static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
@@ -615,8 +619,9 @@ static struct tx_queue_entry *create_tx_queue_entry(GSL=
ist *msg_list)
 	return entry;
 }
 =

+
 /*
- * Pre-process a SMS text message and deliver it [D-Bus SendMessage()]
+ * Pre-process a SMS text message and deliver it
  *
  * @conn: D-Bus connection
  * @msg: message data (telephone number and text)
@@ -631,12 +636,10 @@ static struct tx_queue_entry *create_tx_queue_entry(G=
SList *msg_list)
  * @sms is the main SMS driver struct, @entry and @msg_list represent
  * the current message being processed.
  */
-static DBusMessage *sms_send_message(DBusConnection *conn, DBusMessage *ms=
g,
-					void *data)
+struct tx_queue_entry *sms_msg_send(
+	struct ofono_sms *sms, const char *to, const char *text,
+	enum sms_msg_send_flags flags)
 {
-	struct ofono_sms *sms =3D data;
-	const char *to;
-	const char *text;
 	GSList *msg_list;
 	int ref_offset, ref;
 	struct tx_queue_entry *entry;
@@ -647,13 +650,8 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	DECLARE_SMS_ADDR_STR(receiver_str);
 	const char *sms_path =3D __ofono_atom_get_path(sms->atom);
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

 	/*
 	 * Instead of using the telephone number/address we got from
@@ -664,13 +662,13 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	sms_address_from_string(&receiver, to);
 	if (sms_assembly_encode_address(&receiver, receiver_str)
 	    =3D=3D FALSE)
-		return __ofono_error_failed(msg);
+		return NULL;
 =

 	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
 					sms->use_delivery_reports);
 =

 	if (!msg_list)
-		return __ofono_error_invalid_format(msg);
+		return NULL;
 =

 	sms_msg_id_init(&sms_msg_id);
 	sms_msg_id_hash(&sms_msg_id, text, strlen(text));
@@ -688,7 +686,6 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
-	entry->msg =3D dbus_message_ref(msg);
 	entry->status_report =3D sms->use_delivery_reports;
 	entry->name =3D g_strdup_printf(SMS_MSG_NAME_FMT, sms_path,
 				      msg_id_str, entry->num_pdus);
@@ -699,21 +696,54 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	ofono_sms_tx_state_set(entry, OFONO_SMS_TX_ST_QUEUED);
 =

 	modem =3D __ofono_atom_get_modem(sms->atom);
-	__ofono_history_sms_send_pending(modem, entry->msg_id, to,
-						time(NULL), text);
+	if (flags & SMS_MSG_SEND_HISTORY)
+		__ofono_history_sms_send_pending(modem, entry->msg_id, to,
+						 time(NULL), text);
 =

 	if (g_queue_get_length(sms->txq) =3D=3D 1)
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 =

+	return entry;
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
+static DBusMessage *dbus_SendMessage(DBusConnection *conn, DBusMessage *ms=
g,
+				     void *data)
+{
+	struct ofono_sms *sms =3D data;
+	const char *to;
+	const char *text;
+	struct tx_queue_entry *sms_msg;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY);
+	if (sms_msg =3D=3D NULL)
+		return __ofono_error_invalid_format(msg);
+	/* Unreferenced upon tx_queue_entry_destroy() */
+	sms_msg->msg =3D dbus_message_ref(msg);
 	return NULL;
 }
 =

+
 static GDBusMethodTable sms_manager_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	sms_get_properties,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		sms_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",	"ss",	"",		sms_send_message,
+	{ "SendMessage",	"ss",	"",		dbus_SendMessage,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
diff --git a/src/smsutil.h b/src/smsutil.h
index b87dffb..40df71f 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -217,6 +217,12 @@ enum cbs_geo_scope {
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
-- =

1.6.6.1


--===============3817460906860119999==--

