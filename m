Content-Type: multipart/mixed; boundary="===============5616478747326423027=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 21/23] SMS: make D-Bus SendMessage and Cancel fully
 synchronous
Date: Fri, 25 Jun 2010 16:15:43 -0700
Message-ID: <e817d8f9d7b4cf0fe6eafdd7f324b7ee27ef9038.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5616478747326423027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Up until now, SMSManager::SendMessage() and SMSMessage::Cancel() where
D-Bus asynchronous. They would perform the D-Bus method return reply
inside the callbacks, as they needed to wait for the operation to
complete.

Relying on previous commits that make the SMS message object send
D-Bus updates when changing state, this makes Sendmessage and Cancel
return inmediately. SendMessage() will return an string with the
SMS Message object name and Cancel() will just return.

This renders all the D-Bus message bookeeping in 'struct
tx_queue_entry' uneeded.
---
 src/sms.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 11d1f33..96315b2 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -504,11 +504,7 @@ static DBusMessage *dbus_sms_msg_cancel(
 		return __ofono_error_invalid_args(msg);
 	sms_msg_cancel(sms_msg,
 		       do_network_cancel ? SMS_MSG_CANCEL_IN_NETWORK : 0);
-	sms_msg->dbus_msg =3D dbus_message_ref(msg);
-	__ofono_dbus_pending_reply(
-		&sms_msg->dbus_msg,
-		dbus_message_new_method_return(sms_msg->dbus_msg));
-	return NULL;
+	return dbus_message_new_method_return(msg);
 }
 =

 =

@@ -522,9 +518,9 @@ static DBusMessage *dbus_sms_msg_cancel(
 static
 GDBusMethodTable sms_msg_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",
-	  dbus_sms_msg_get_properties, G_DBUS_METHOD_FLAG_ASYNC },
+	  dbus_sms_msg_get_properties, 0 },
 	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
-	  dbus_sms_msg_cancel, G_DBUS_METHOD_FLAG_ASYNC },
+	  dbus_sms_msg_cancel, 0 },
 	{ }
 };
 =

@@ -577,10 +573,6 @@ static void tx_queue_entry_destroy(struct tx_queue_ent=
ry *entry)
 	g_free(entry->pdus);
 	g_free(entry->name);
 	entry->state =3D __OFONO_SMS_TX_ST_INVALID;
-	if (entry->dbus_msg) {
-		dbus_message_unref(entry->dbus_msg);
-		entry->dbus_msg =3D NULL;
-	}
 }
 =

 static void tx_queue_entry_destroy_free(gpointer _entry, gpointer unused)
@@ -872,6 +864,7 @@ static DBusMessage *dbus_SendMessage(DBusConnection *co=
nn, DBusMessage *msg,
 	const char *to;
 	const char *text;
 	struct tx_queue_entry *sms_msg;
+	DBusMessage *reply;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -881,9 +874,13 @@ static DBusMessage *dbus_SendMessage(DBusConnection *c=
onn, DBusMessage *msg,
 	sms_msg =3D sms_msg_send(sms, to, text, SMS_MSG_SEND_HISTORY);
 	if (sms_msg =3D=3D NULL)
 		return __ofono_error_invalid_format(msg);
-	/* Unreferenced upon tx_queue_entry_destroy() */
-	sms_msg->dbus_msg =3D dbus_message_ref(msg);
-	return NULL;
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+	dbus_message_append_args(reply,
+				 DBUS_TYPE_STRING, &sms_msg->dbus_path,
+				 DBUS_TYPE_INVALID);
+	return reply;
 }
 =

 =

-- =

1.6.6.1


--===============5616478747326423027==--

