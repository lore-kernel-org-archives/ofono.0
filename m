Content-Type: multipart/mixed; boundary="===============0580604588716393849=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [SMS D-Bus 19/23] SMS: Implement D-Bus SMS-MSG::GetProperties
Date: Fri, 25 Jun 2010 16:15:41 -0700
Message-ID: <5065221d8770d72fc775290f159b19ead7569c41.1277507431.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0580604588716393849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Currently this only returns the state of the SMS message.
---
 src/sms.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 4ad9e61..77904ad 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -86,6 +86,24 @@ enum ofono_sms_tx_state {
 };
 =

 =

+static
+const char *ofono_sms_tx_state_to_string(enum ofono_sms_tx_state status)
+{
+	switch (status) {
+	case OFONO_SMS_TX_ST_UNINITIALIZED:	return "UNINITIALIZED";
+	case OFONO_SMS_TX_ST_QUEUED:		return "QUEUED";
+	case OFONO_SMS_TX_ST_WFA:		return "WFA";
+	case OFONO_SMS_TX_ST_DONE:		return "DONE";
+	case OFONO_SMS_TX_ST_CANCELING:		return "CANCELING";
+	case OFONO_SMS_TX_ST_CANCELLED:		return "CANCELLED";
+	case OFONO_SMS_TX_ST_FAILED:		return "FAILED";
+	case OFONO_SMS_TX_ST_EXPIRED:		return "EXPIRED";
+	default:
+						return "INVALID";
+	}
+}
+
+
 /**
  * @wfaq: Waiting-For-Acknoledgement queue; messages in this queue
  *     have been delivered but are waiting to be acknoledged by the
@@ -426,6 +444,29 @@ static void __ofono_sms_tx_state_set(struct tx_queue_e=
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
 static DBusMessage *dbus_sms_msg_cancel(
 	DBusConnection * conn, DBusMessage *msg, void *data)
 {
@@ -453,6 +494,8 @@ static DBusMessage *dbus_sms_msg_cancel(
 =

 static
 GDBusMethodTable sms_msg_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",
+	  dbus_sms_msg_get_properties, G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Cancel",		DBUS_TYPE_BOOLEAN_AS_STRING,	"",
 	  dbus_sms_msg_cancel, G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
-- =

1.6.6.1


--===============0580604588716393849==--

