Content-Type: multipart/mixed; boundary="===============8847927707802249348=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 13/13] SMS: implement SHA256-based message IDs
 [incomplete]
Date: Wed, 26 May 2010 12:49:27 -0700
Message-ID: <038b4f028e0caf4bd6c3316bddb0559a9b89daf1.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8847927707802249348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

This patch removes the sequential SMS message identification gig and
replaces it with a 16-bit hash cookie based off message contents.

FIXME: not yet complete, need to figure out how to do so that
identical messages sent to the same number also have a different ID.
---
 src/sms.c |   37 +++++++++++++++++++++++++++----------
 1 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 26b1653..24539cd 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -55,7 +55,6 @@ struct ofono_sms {
 	DBusMessage *pending;
 	struct ofono_phone_number sca;
 	struct sms_assembly *assembly;
-	unsigned int next_msg_id;
 	guint ref;
 	GQueue *txq;
 	time_t last_mms;
@@ -81,6 +80,7 @@ struct tx_queue_entry {
 	unsigned char num_pdus;
 	unsigned char cur_pdu;
 	unsigned int msg_id;
+	struct sms_msg_id sms_msg_id;
 	unsigned int retry;
 	DBusMessage *msg;
 };
@@ -421,6 +421,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	int ref_offset;
 	struct tx_queue_entry *entry;
 	struct ofono_modem *modem;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -451,7 +452,17 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	}
 =

 	entry->msg =3D dbus_message_ref(msg);
-	entry->msg_id =3D sms->next_msg_id++;
+	sms_msg_id_init(&entry->sms_msg_id);
+	sms_msg_id_hash(&entry->sms_msg_id, text, strlen(text));
+	sms_msg_id_hash(&entry->sms_msg_id, to, strlen(to));
+#warning FIXME: add source time or something? otherwise repeats are the sa=
me; using ref for now, doesn't really work
+	sms_msg_id_hash(&entry->sms_msg_id, &sms->ref, sizeof(sms->ref));
+	sms_msg_id_hash(&entry->sms_msg_id, NULL, 0);
+	sms_msg_id_memcpy(&entry->msg_id, sizeof(entry->msg_id),
+			  &entry->sms_msg_id);
+	sms_msg_id_printf(&entry->sms_msg_id, msg_id_str, sizeof(msg_id_str));
+	ofono_debug("SMS TX: ref %08x, msg id: %s\n",
+		    sms->ref, msg_id_str);
 =

 	g_queue_push_tail(sms->txq, entry);
 =

@@ -508,6 +519,9 @@ static void dispatch_text_message(struct ofono_sms *sms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	struct sms_msg_id sms_msg_id;
+	unsigned int id;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
 =

 	if (!message)
 		return;
@@ -549,11 +563,18 @@ static void dispatch_text_message(struct ofono_sms *s=
ms,
 =

 	g_dbus_send_message(conn, signal);
 =

-	if (cls !=3D SMS_CLASS_0) {
-		__ofono_history_sms_received(modem, sms->next_msg_id, str,
+	sms_msg_id_init(&sms_msg_id);
+	sms_msg_id_hash(&sms_msg_id, message, strlen(message));
+	sms_msg_id_hash(&sms_msg_id, addr->address, strlen(addr->address));
+#warning FIXME: add RX time?
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
@@ -896,8 +917,6 @@ static void sms_remove(struct ofono_atom *atom)
 =

 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
-					"NextMessageId", sms->next_msg_id);
-		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
 =

 		storage_close(sms->imsi, SETTINGS_STORE, sms->settings, TRUE);
@@ -981,8 +1000,6 @@ static void sms_load_settings(struct ofono_sms *sms, c=
onst char *imsi)
 =

 	sms->imsi =3D g_strdup(imsi);
 =

-	sms->next_msg_id =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
-							"NextMessageId", NULL);
 	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
 							"NextReference", NULL);
 =

-- =

1.6.6.1


--===============8847927707802249348==--

