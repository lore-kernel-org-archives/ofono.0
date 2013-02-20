Content-Type: multipart/mixed; boundary="===============7455922301371564416=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 6/7] handsfree-audio: Add Agent "Unregister"
Date: Wed, 20 Feb 2013 18:55:50 -0300
Message-ID: <1361397351-5841-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7455922301371564416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch implements the "Unregister" method of the Handsfree Audio
Manager. The agent is unregistered if sender and path match.
---
 src/handsfree-audio.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 07dbda0..2635d76 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdio.h>
+#include <string.h>
 =

 #include <gdbus.h>
 =

@@ -115,7 +116,29 @@ static DBusMessage *am_agent_register(DBusConnection *=
conn,
 static DBusMessage *am_agent_unregister(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	return __ofono_error_not_implemented(msg);
+	const char *sender, *path;
+	DBusMessageIter iter;
+
+	if (agent =3D=3D NULL)
+		return __ofono_error_not_found(msg);
+
+	sender =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	if (strcmp(sender, agent->owner) !=3D 0)
+		return __ofono_error_not_allowed(msg);
+
+	if (strcmp(path, agent->path) !=3D 0)
+		return __ofono_error_not_found(msg);
+
+	agent_free(agent);
+	agent =3D NULL;
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static const GDBusMethodTable am_methods[] =3D {
-- =

1.7.11.7


--===============7455922301371564416==--

