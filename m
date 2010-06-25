Content-Type: multipart/mixed; boundary="===============8313737465911257237=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 09/23] SMS: implement SHA256-based message IDs [incomplete]
Date: Fri, 25 Jun 2010 16:15:31 -0700
Message-ID: <c19be808c19856e377c351066532023d51cc4bed.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8313737465911257237==
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
 src/sms.c |   64 +++++++++++++++++++++++++++++++++++++++------------------=
---
 1 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index b5c0614..66a0be3 100644
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
@@ -450,9 +449,13 @@ static DBusMessage *sms_send_message(DBusConnection *c=
onn, DBusMessage *msg,
 	const char *to;
 	const char *text;
 	GSList *msg_list;
-	int ref_offset;
+	int ref_offset, ref;
 	struct tx_queue_entry *entry;
 	struct ofono_modem *modem;
+	struct sms_msg_id sms_msg_id;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
+	struct sms_address receiver;
+	DECLARE_SMS_ADDR_STR(receiver_str);
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -462,31 +465,40 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

+	/*
+	 * Instead of using the telephone number/address we got from
+	 * D-Bus, we do the reverse formatting, so we get something
+	 * that has been normalized--this is used later and we do it
+	 * here to simplify error handling.
+	 */
+	sms_address_from_string(&receiver, to);
+	if (sms_assembly_encode_address(&receiver, receiver_str)
+	    =3D=3D FALSE)
+		return __ofono_error_failed(msg);
+
 	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
 					sms->use_delivery_reports);
 =

 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
 =

-	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
+	sms_msg_id_init(&sms_msg_id);
+	sms_msg_id_hash(&sms_msg_id, text, strlen(text));
+	sms_msg_id_hash(&sms_msg_id, receiver_str, strlen(receiver_str));
+	sms_msg_id_hash(&sms_msg_id, NULL, 0);
+	sms_msg_id_memcpy(&ref, sizeof(ref), &sms_msg_id);
+	sms_msg_id_printf(&sms_msg_id, msg_id_str, sizeof(msg_id_str));
 =

-	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
+	set_ref_and_to(msg_list, ref, ref_offset, to);
 	entry =3D create_tx_queue_entry(msg_list);
-
-	sms_address_from_string(&entry->receiver, to);
+	ofono_debug("SMS: %p: ref %08x, offset %d, msg id: %s\n",
+		    entry, ref, ref_offset, msg_id_str);
+	entry->msg_id =3D ref;
+	entry->receiver =3D receiver;
 =

 	g_slist_foreach(msg_list, (GFunc)g_free, NULL);
 	g_slist_free(msg_list);
-
-	if (ref_offset !=3D 0) {
-		if (sms->ref =3D=3D 65536)
-			sms->ref =3D 1;
-		else
-			sms->ref =3D sms->ref + 1;
-	}
-
 	entry->msg =3D dbus_message_ref(msg);
-	entry->msg_id =3D sms->next_msg_id++;
 	entry->status_report =3D sms->use_delivery_reports;
 =

 	g_queue_push_tail(sms->txq, entry);
@@ -544,6 +556,9 @@ static void dispatch_text_message(struct ofono_sms *sms,
 	struct tm remote;
 	struct tm local;
 	const char *str =3D buf;
+	struct sms_msg_id sms_msg_id;
+	unsigned int id;
+	DECLARE_SMS_MSG_ID_STRBUF(msg_id_str);
 =

 	if (!message)
 		return;
@@ -585,11 +600,18 @@ static void dispatch_text_message(struct ofono_sms *s=
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
@@ -972,8 +994,6 @@ static void sms_remove(struct ofono_atom *atom)
 =

 	if (sms->settings) {
 		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
-					"NextMessageId", sms->next_msg_id);
-		g_key_file_set_integer(sms->settings, SETTINGS_GROUP,
 					"NextReference", sms->ref);
 		g_key_file_set_boolean(sms->settings, SETTINGS_GROUP,
 					"UseDeliveryReports",
@@ -1065,8 +1085,6 @@ static void sms_load_settings(struct ofono_sms *sms, =
const char *imsi)
 =

 	sms->imsi =3D g_strdup(imsi);
 =

-	sms->next_msg_id =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
-							"NextMessageId", NULL);
 	sms->ref =3D g_key_file_get_integer(sms->settings, SETTINGS_GROUP,
 							"NextReference", NULL);
 	sms->use_delivery_reports =3D
-- =

1.6.6.1


--===============8313737465911257237==--

