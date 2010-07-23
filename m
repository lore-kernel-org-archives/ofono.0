Content-Type: multipart/mixed; boundary="===============7010146685005631536=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [patch 20/20] SMS: Implement D-Bus SMS-MSG::GetProperties
Date: Fri, 23 Jul 2010 14:00:08 -0700
Message-ID: <95963779354386a04005f5bf2067149d91a53969.1279918330.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7010146685005631536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Currently this only returns the state of the SMS message.
---
 src/sms.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 97c9eab..5be2e39 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -537,6 +537,29 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
ntry *entry,
 }
 =

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
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					 OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					 &dict);
+	str =3D ofono_sms_tx_state_to_string(sms_msg->state);
+	ofono_dbus_dict_append(&dict, "TXState", DBUS_TYPE_STRING, &str);
+	dbus_message_iter_close_container(&iter, &dict);
+	return reply;
+}
+
+
 /*
  * Note that the D-Bus specific cleanups are taken care by the
  * sms_msg_dbus_destroy() callback passed in dbus_sms_msg_send().
@@ -564,6 +587,8 @@ static DBusMessage *dbus_sms_msg_cancel(
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",
+	  dbus_sms_msg_get_properties, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
 	  dbus_sms_msg_cancel, 0 },
 	{ }
-- =

1.6.6.1


--===============7010146685005631536==--

