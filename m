Content-Type: multipart/mixed; boundary="===============7538582908307295112=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 07/20] SMS: implement SHA256-based message IDs [incomplete]
Date: Fri, 23 Jul 2010 13:59:55 -0700
Message-ID: <47f01a9253e6f181da9435a7d52a600220665aee.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7538582908307295112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This patch removes the sequential SMS message identification gig and
replaces it with a 16-bit hash cookie based off message contents.

FIXME: [incomplete] need to figure out how to do so that identical
messages sent to the same number also have a different ID.

Note that in order to feed the reference 16-bit ID to
set_ref_and_to(), the UUID has to be computed as early as
possible.
---
 src/ofono.h |    4 +-
 src/sms.c   |   68 +++++++++++++++++++++++++++++++++++++------------------=
---
 src/stk.c   |    4 +-
 3 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index aaa01d9..1b72381 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -185,8 +185,8 @@ enum ofono_sms_submit_flag {
 =

 typedef void (*ofono_sms_txq_submit_cb_t)(gboolean ok, void *data);
 =

-unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
-					unsigned int flags,
+struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, GSLi=
st *list,
+					unsigned int flags, unsigned ref,
 					ofono_sms_txq_submit_cb_t cb,
 					void *data, ofono_destroy_func destroy);
 =

diff --git a/src/sms.c b/src/sms.c
index 71e24c1..49f3e54 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -55,7 +55,6 @@ struct ofono_sms {
 	DBusMessage *pending;
 	struct ofono_phone_number sca;
 	struct sms_assembly *assembly;
-	unsigned int next_msg_id;
 	guint ref;
 	GQueue *txq;
 	gint tx_source;
@@ -590,7 +589,12 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	struct ofono_modem *modem;
 	unsigned int flags;
 	unsigned int msg_id;
-
+	struct sms_msg_id sms_msg_id;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
+	struct sms_address receiver;
+	DECLARE_SMS_ADDR_STR(receiver_str);
+	struct tx_queue_entry *sms_msg;
+	=

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
 					DBUS_TYPE_INVALID))
@@ -598,6 +602,16 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 =

 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
+	/*
+	 * Instead of using the telephone number/address we got from
+	 * D-Bus, we do the reverse formatting, so we get something
+	 * that has been normalized--this is used later and we do it
+	 * here to simplify error handling.
+	 */
+	sms_address_from_string(&receiver, to);
+	if (sms_address_to_hex_string(&receiver, receiver_str)
+	    =3D=3D FALSE)
+		return __ofono_error_failed(msg);
 =

 	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
 					sms->use_delivery_reports);
@@ -605,22 +619,21 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
 =

-	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
-	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
-
-	if (ref_offset !=3D 0) {
-		if (sms->ref =3D=3D 65536)
-			sms->ref =3D 1;
-		else
-			sms->ref =3D sms->ref + 1;
-	}
+	sms_msg_id_init(&sms_msg_id);
+	sms_msg_id_hash(&sms_msg_id, text, strlen(text));
+	sms_msg_id_hash(&sms_msg_id, receiver_str, strlen(receiver_str));
+	sms_msg_id_hash(&sms_msg_id, NULL, 0);
+	sms_msg_id_memcpy(&msg_id, sizeof(msg_id), &sms_msg_id);
+	sms_msg_id_printf(&sms_msg_id, msg_id_str, sizeof(msg_id_str));
+	set_ref_and_to(msg_list, msg_id, ref_offset, to);
+	DBG("ref: %d, offset: %d", msg_id, ref_offset);
 =

 	flags =3D OFONO_SMS_SUBMIT_FLAG_RECORD_HISTORY;
 	flags |=3D OFONO_SMS_SUBMIT_FLAG_RETRY;
 	if (sms->use_delivery_reports)
 		flags |=3D OFONO_SMS_SUBMIT_FLAG_REQUEST_SR;
 =

-	msg_id =3D __ofono_sms_txq_submit(sms, msg_list, flags, send_message_cb,
+	sms_msg =3D __ofono_sms_txq_submit(sms, msg_list, flags, msg_id, send_mes=
sage_cb,
 						dbus_message_ref(msg),
 						send_message_destroy);
 =

@@ -676,6 +689,9 @@ static void dispatch_text_message(struct ofono_sms *sms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	struct sms_msg_id sms_msg_id;
+	unsigned int id;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
 =

 	if (!message)
 		return;
@@ -717,11 +733,18 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 =

 	g_dbus_send_message(conn, signal);
 =

-	if (cls !=3D SMS_CLASS_0) {
-		__ofono_history_sms_received(modem, sms->next_msg_id, str,
+	sms_msg_id_init(&sms_msg_id);
+	sms_msg_id_hash(&sms_msg_id, message, strlen(message));
+	sms_msg_id_hash(&sms_msg_id, addr->address, strlen(addr->address));
+	/* FIXME: add RX time? */
+	sms_msg_id_hash(&sms_msg_id, NULL, 0);
+	sms_msg_id_memcpy(&id, sizeof(id), &sms_msg_id);
+	sms_msg_id_printf(&sms_msg_id, msg_id_str, sizeof(msg_id_str));
+	ofono_debug("SMS RX: msg id is %s\n", msg_id_str);
+
+	if (cls !=3D SMS_CLASS_0)
+		__ofono_history_sms_received(modem, id, str,
 						&remote, &local, message);
-		sms->next_msg_id +=3D 1;
-	}
 }
 =

 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
@@ -1104,8 +1127,6 @@ static void sms_remove(struct ofono_atom *atom)
 =

 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
-					"NextMessageId", sms->next_msg_id);
-		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
 		g_key_file_set_boolean(sms->settings, SETTINGS_GROUP,
 					"UseDeliveryReports",
@@ -1201,9 +1222,6 @@ static void sms_load_settings(struct ofono_sms *sms, =
const char *imsi)
 =

 	sms->imsi =3D g_strdup(imsi);
 =

-	sms->next_msg_id =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
-							"NextMessageId", NULL);
-
 	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
 							"NextReference", NULL);
 	if (sms->ref >=3D 65536)
@@ -1306,8 +1324,8 @@ void *ofono_sms_get_data(struct ofono_sms *sms)
 	return sms->driver_data;
 }
 =

-unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *list,
-					unsigned int flags,
+struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, GSLi=
st *list,
+					unsigned int flags, unsigned msg_id,
 					ofono_sms_txq_submit_cb_t cb,
 					void *data, ofono_destroy_func destroy)
 {
@@ -1320,7 +1338,7 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sms =
*sms, GSList *list,
 				sizeof(entry->receiver));
 	}
 =

-	entry->msg_id =3D sms->next_msg_id++;
+	entry->msg_id =3D msg_id;
 	entry->flags =3D flags;
 	entry->cb =3D cb;
 	entry->data =3D data;
@@ -1331,5 +1349,5 @@ unsigned int __ofono_sms_txq_submit(struct ofono_sms =
*sms, GSList *list,
 	if (g_queue_get_length(sms->txq) =3D=3D 1)
 		sms->tx_source =3D g_timeout_add(0, tx_next, sms);
 =

-	return entry->msg_id;
+	return entry;
 }
diff --git a/src/stk.c b/src/stk.c
index 556dc68..400b033 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -338,8 +338,8 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 =

 	msg_list.data =3D (void *) &cmd->send_sms.gsm_sms;
 	msg_list.next =3D NULL;
-
-	__ofono_sms_txq_submit(sms, &msg_list, 0, send_sms_submit_cb,
+#warning FIXME: fix msg_id, missing
+	__ofono_sms_txq_submit(sms, &msg_list, 0, 0, send_sms_submit_cb,
 				stk->sms_submit_req, g_free);
 =

 	stk->cancel_cmd =3D send_sms_cancel;
-- =

1.6.6.1


--===============7538582908307295112==--

