Content-Type: multipart/mixed; boundary="===============6802600245429998929=="
MIME-Version: 1.0
From: Yang Gu <gyagp0@gmail.com>
Subject: [PATCH 1/1] sms: Cancel pending message
Date: Wed, 29 Dec 2010 00:14:15 +0800
Message-ID: <1293552855-15949-2-git-send-email-gyagp0@gmail.com>
In-Reply-To: <1293552855-15949-1-git-send-email-gyagp0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6802600245429998929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/history.h |    1 +
 src/sms.c         |  132 ++++++++++++++++++++++++++++++++++++++++++-------=
----
 2 files changed, 106 insertions(+), 27 deletions(-)

diff --git a/include/history.h b/include/history.h
index c1c4aa1..756097e 100644
--- a/include/history.h
+++ b/include/history.h
@@ -35,6 +35,7 @@ enum ofono_history_sms_status {
 	OFONO_HISTORY_SMS_STATUS_PENDING,
 	OFONO_HISTORY_SMS_STATUS_SUBMITTED,
 	OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED,
+	OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED,
 	OFONO_HISTORY_SMS_STATUS_DELIVERED,
 	OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED,
 };
diff --git a/src/sms.c b/src/sms.c
index 9bb5c93..13acbcf 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -53,9 +53,11 @@ static gboolean tx_next(gpointer user_data);
 static GSList *g_drivers =3D NULL;
 =

 enum message_state {
-	MESSAGE_STATE_PENDING =3D		0,
+	MESSAGE_STATE_IDLE =3D		0,
+	MESSAGE_STATE_PENDING,
 	MESSAGE_STATE_SENT,
-	MESSAGE_STATE_FAILED
+	MESSAGE_STATE_FAILED,
+	MESSAGE_STATE_CANCELLED
 };
 =

 struct message {
@@ -111,6 +113,7 @@ struct tx_queue_entry {
 	ofono_sms_txq_submit_cb_t cb;
 	void *data;
 	ofono_destroy_func destroy;
+	enum message_state state;
 };
 =

 static gboolean uuid_equal(gconstpointer v1, gconstpointer v2)
@@ -166,12 +169,16 @@ static int sms_bearer_from_string(const char *str)
 static const char *message_state_to_string(enum message_state s)
 {
 	switch (s) {
+	case MESSAGE_STATE_IDLE:
+		return "idle";
 	case MESSAGE_STATE_PENDING:
 		return "pending";
 	case MESSAGE_STATE_SENT:
 		return "sent";
 	case MESSAGE_STATE_FAILED:
 		return "failed";
+	case MESSAGE_STATE_CANCELLED:
+		return "cancelled";
 	}
 =

 	return "invalid";
@@ -324,6 +331,14 @@ const char *__ofono_sms_message_path_from_uuid(struct =
ofono_sms *sms,
 	return path;
 }
 =

+static void uuid_from_message_path(const char *path,
+						struct ofono_uuid *uuid)
+{
+	long len_uuid;
+	decode_hex_own_buf(path + strlen(path) - OFONO_SHA1_UUID_LEN * 2,
+						-1, &len_uuid, 0, uuid->uuid);
+}
+
 static gboolean message_dbus_register(struct ofono_sms *sms, struct messag=
e *m)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -424,7 +439,8 @@ static void message_set_state(struct ofono_sms *sms,
 						&state);
 =

 	if (m->state =3D=3D MESSAGE_STATE_SENT ||
-			m->state =3D=3D MESSAGE_STATE_FAILED) {
+			m->state =3D=3D MESSAGE_STATE_FAILED ||
+			m->state =3D=3D MESSAGE_STATE_CANCELLED) {
 		m->entry =3D NULL;
 =

 		g_hash_table_remove(sms->messages, uuid);
@@ -737,10 +753,42 @@ static void tx_queue_entry_destroy_foreach(gpointer _=
entry, gpointer unused)
 	tx_queue_entry_destroy(_entry);
 }
 =

+static void tx_queue_remove_entry(struct ofono_sms *sms,
+						struct tx_queue_entry *entry)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
+
+	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
+		enum ofono_history_sms_status hs;
+
+		switch (entry->state) {
+		case MESSAGE_STATE_SENT:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMITTED;
+			break;
+		case MESSAGE_STATE_FAILED:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED;
+			break;
+		case MESSAGE_STATE_CANCELLED:
+			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_CANCELLED;
+			break;
+		default:
+			ofono_error("Unexpected state when removing sms entry");
+			return;
+		}
+
+		__ofono_history_sms_send_status(modem, &entry->uuid,
+						time(NULL), hs);
+	}
+
+	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS)
+		message_set_state(sms, &entry->uuid, entry->state);
+
+	tx_queue_entry_destroy(entry);
+}
+
 static void tx_finished(const struct ofono_error *error, int mr, void *dat=
a)
 {
 	struct ofono_sms *sms =3D data;
-	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct tx_queue_entry *entry =3D g_queue_peek_head(sms->txq);
 	gboolean ok =3D error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR;
 =

@@ -755,6 +803,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 		if (entry->retry < TXQ_MAX_RETRIES) {
 			DBG("Sending failed, retry in %d secs",
 					entry->retry * 5);
+			entry->state =3D MESSAGE_STATE_IDLE;
 			sms->tx_source =3D g_timeout_add_seconds(entry->retry * 5,
 								tx_next, sms);
 			return;
@@ -775,6 +824,7 @@ static void tx_finished(const struct ofono_error *error=
, int mr, void *data)
 							entry->num_pdus);
 =

 	if (entry->cur_pdu < entry->num_pdus) {
+		entry->state =3D MESSAGE_STATE_IDLE;
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 		return;
 	}
@@ -785,30 +835,12 @@ next_q:
 	if (entry->cb)
 		entry->cb(ok, entry->data);
 =

-	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY) {
-		enum ofono_history_sms_status hs;
-
-		if (ok)
-			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMITTED;
-		else
-			hs =3D OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED;
-
-		__ofono_history_sms_send_status(modem, &entry->uuid,
-						time(NULL), hs);
-	}
-
-	if (entry->flags & OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS) {
-		enum message_state ms;
-
-		if (ok)
-			ms =3D MESSAGE_STATE_SENT;
-		else
-			ms =3D MESSAGE_STATE_FAILED;
-
-		message_set_state(sms, &entry->uuid, ms);
-	}
+	if (ok)
+		entry->state =3D MESSAGE_STATE_SENT;
+	else
+		entry->state =3D MESSAGE_STATE_FAILED;
 =

-	tx_queue_entry_destroy(entry);
+	tx_queue_remove_entry(sms, entry);
 =

 	if (g_queue_peek_head(sms->txq)) {
 		DBG("Scheduling next");
@@ -837,6 +869,7 @@ static gboolean tx_next(gpointer user_data)
 			|| (entry->num_pdus - entry->cur_pdu) > 1)
 		send_mms =3D 1;
 =

+	entry->state =3D MESSAGE_STATE_PENDING;
 	sms->driver->submit(sms, pdu->pdu, pdu->pdu_len, pdu->tpdu_len,
 				send_mms, tx_finished, sms);
 =

@@ -1068,6 +1101,50 @@ static DBusMessage *sms_get_messages(DBusConnection =
*conn, DBusMessage *msg,
 	return reply;
 }
 =

+static gint entry_compare_by_uuid(gconstpointer a, gconstpointer b)
+{
+	const struct tx_queue_entry *entry =3D a;
+	const char *uuid =3D b;
+
+	return strcmp((const char *) entry->uuid.uuid, uuid);
+}
+
+static DBusMessage *sms_cancel_message(DBusConnection *conn, DBusMessage *=
msg,
+					void *data)
+{
+	struct ofono_sms *sms =3D data;
+	char *path;
+	struct ofono_uuid uuid;
+	GList *l;
+	struct tx_queue_entry *entry;
+	struct tx_queue_entry *entry_head;
+
+	if (sms->pending)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	uuid_from_message_path(path, &uuid);
+
+	l =3D g_queue_find_custom(sms->txq, uuid.uuid, entry_compare_by_uuid);
+	if (l =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	entry =3D l->data;
+	entry_head =3D g_queue_peek_head(sms->txq);
+
+	if (entry =3D=3D entry_head &&
+			entry_head->state !=3D MESSAGE_STATE_IDLE)
+		return __ofono_error_failed(msg);
+
+	entry->state =3D MESSAGE_STATE_CANCELLED;
+	g_queue_remove(sms->txq, entry);
+	tx_queue_remove_entry(sms, entry);
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable sms_manager_methods[] =3D {
 	{ "GetProperties",    "",    "a{sv}",        sms_get_properties,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -1076,6 +1153,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 	{ "SendMessage",      "ss",  "o",             sms_send_message,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetMessages",       "",    "a(oa{sv})",    sms_get_messages },
+	{ "CancelMessage",       "o",    "",    sms_cancel_message },
 	{ }
 };
 =

-- =

1.7.1


--===============6802600245429998929==--

