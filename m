Content-Type: multipart/mixed; boundary="===============5110993127673967222=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv1 1/5] service: Add GetConversation method
Date: Wed, 25 Apr 2012 11:01:49 +0200
Message-ID: <1335344513-2347-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1335344513-2347-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5110993127673967222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/src/service.c b/src/service.c
index f89fd3f..24c89b6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -690,6 +690,26 @@ static DBusMessage *get_messages(DBusConnection *conn,
 	return reply;
 }

+static DBusMessage *get_conversation(DBusConnection *conn,
+					DBusMessage *dbus_msg, void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+
+	reply =3D dbus_message_new_method_return(dbus_msg);
+	if (reply =3D=3D NULL)
+		return __mms_error_trans_failure(dbus_msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+							"(oa{sv})", &array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
 static gboolean mms_attachment_is_smil(const struct mms_attachment *part)
 {
 	if (g_str_has_prefix(part->content_type, "application/smil"))
@@ -813,6 +833,7 @@ release_msg:
 static GDBusMethodTable service_methods[] =3D {
 	{ "SendMessage", "assa(sss)", "o", send_message },
 	{ "GetMessages", "", "a(oa{sv})", get_messages },
+	{ "GetConversation", "su", "a(oa{sv})", get_conversation },
 	{ }
 };

--
1.7.4.1


--===============5110993127673967222==--

