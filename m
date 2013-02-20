Content-Type: multipart/mixed; boundary="===============5493864136281278814=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/7] handsfree-audio: Add Agent "Register" method
Date: Wed, 20 Feb 2013 18:55:46 -0300
Message-ID: <1361397351-5841-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5493864136281278814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the initial Handsfree Audio Manager "Register"
method implementation. It adds the parsing of the arguments included
in the message and checks if there is an agent registered already.
---
 src/handsfree-audio.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index e75c977..ee67f05 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -32,6 +32,15 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
 =

+struct agent {
+	char *owner;
+	char *path;
+	unsigned char *codecs;
+	int codecs_len;
+};
+
+static struct agent *agent =3D NULL;
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -41,7 +50,35 @@ static DBusMessage *am_get_cards(DBusConnection *conn,
 static DBusMessage *am_agent_register(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return __ofono_error_not_implemented(msg);
+	const char *sender, *path;
+	unsigned char *codecs;
+	DBusMessageIter iter, array;
+	int length;
+
+	if (agent)
+		return __ofono_error_in_use(msg);
+
+	sender =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	dbus_message_iter_next(&iter);
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &codecs, &length);
+
+	if (length =3D=3D 0)
+		return __ofono_error_invalid_args(msg);
+
+	agent =3D g_new0(struct agent, 1);
+	agent->owner =3D g_strdup(sender);
+	agent->path =3D g_strdup(path);
+	agent->codecs =3D g_memdup(codecs, length);
+	agent->codecs_len =3D length;
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *am_agent_unregister(DBusConnection *conn,
-- =

1.7.11.7


--===============5493864136281278814==--

