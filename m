Content-Type: multipart/mixed; boundary="===============6954500052362623283=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 05/11] hfp_audio: Add "Register" agent arguments parsing
Date: Tue, 19 Feb 2013 17:44:46 -0300
Message-ID: <1361306692-959-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6954500052362623283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the D-Bus parsing of the arguments included in the
"Register" method of the Handsfree Audio Manager method.
---
 plugins/hfp_audio.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index e3646e5..7b334e2 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -46,9 +46,28 @@ static DBusMessage *am_get_cards(DBusConnection *conn,
 static DBusMessage *am_agent_register(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
-						".NotImplemented",
-						"Implementation not provided");
+	const char *path;
+	unsigned char *codecs;
+	DBusMessageIter iter, array;
+	int length;
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		goto invalid_args;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &codecs, &length);
+
+	if (length =3D=3D 0)
+		goto invalid_args;
+
+	return dbus_message_new_method_return(msg);
+
+invalid_args:
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *am_agent_unregister(DBusConnection *conn,
-- =

1.7.11.7


--===============6954500052362623283==--

