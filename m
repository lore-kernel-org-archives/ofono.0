Content-Type: multipart/mixed; boundary="===============6859292917408953485=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus v5 11/17] sms: Implement D-Bus SMS-MSG::GetProperties
Date: Thu, 05 Aug 2010 17:55:33 -0700
Message-ID: <ff262a82b5e0f37858c8880acc989f4679124b81.1281054654.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1281054654.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6859292917408953485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Currently this only returns the state of the SMS message and the
destination number. Note we make the @receiver field in 'struct
tx_queue_entry' be always filled out in __ofono_sms_txq_submit() as
now it is always needed for the properties, not only when a Status
Report is requested.
---
 src/sms.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 40b4cf1..e648fd0 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -526,7 +526,35 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 		entry->stch_cb(entry->data, state_new);
 }
 =

+static DBusMessage *dbus_sms_msg_get_properties(
+	DBusConnection * conn, DBusMessage *dbus_msg, void *_sms_msg)
+{
+	struct tx_queue_entry *sms_msg =3D _sms_msg;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *str;
+
+	reply =3D dbus_message_new_method_return(dbus_msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
 =

+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					 OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					 &dict);
+
+	str =3D ofono_sms_tx_state_to_string(sms_msg->state);
+	ofono_dbus_dict_append(&dict, "State", DBUS_TYPE_STRING, &str);
+
+	str =3D sms_address_to_string(&sms_msg->receiver);
+	ofono_dbus_dict_append(&dict, "To", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
 =

 static void sms_msg_cancel(struct tx_queue_entry *);
 /*
@@ -550,6 +578,8 @@ static DBusMessage *dbus_sms_msg_cancel(
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",
+	  dbus_sms_msg_get_properties, 0 },
 	{ "Cancel",		"",	"",
 	  dbus_sms_msg_cancel, 0 },
 	{ }
@@ -1757,13 +1787,10 @@ struct tx_queue_entry *__ofono_sms_txq_submit(struc=
t ofono_sms *sms,
 						ofono_destroy_func destroy)
 {
 	struct tx_queue_entry *entry =3D tx_queue_entry_new(list);
+	struct sms *head =3D list->data;
 =

-	if (flags & OFONO_SMS_SUBMIT_FLAG_REQUEST_SR) {
-		struct sms *head =3D list->data;
-
-		memcpy(&entry->receiver, &head->submit.daddr,
-				sizeof(entry->receiver));
-	}
+	memcpy(&entry->receiver, &head->submit.daddr,
+		sizeof(entry->receiver));
 =

 	entry->flags =3D flags;
 	entry->stch_cb =3D stch_cb;
-- =

1.6.6.1


--===============6859292917408953485==--

