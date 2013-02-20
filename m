Content-Type: multipart/mixed; boundary="===============9057432176803696719=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 7/7] handsfree-audio: Add Agent tracking
Date: Wed, 20 Feb 2013 18:55:51 -0300
Message-ID: <1361397351-5841-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9057432176803696719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch tracks when the Handsfree Audio Agent leaves the system BUS,
and free agent allocated resources.
---
 src/handsfree-audio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 2635d76..f10aeb4 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -45,12 +45,16 @@ struct agent {
 	char *path;
 	unsigned char *codecs;
 	int codecs_len;
+	guint watch;
 };
 =

 static struct agent *agent =3D NULL;
 =

 static void agent_free(struct agent *agent)
 {
+	if (agent->watch > 0)
+		g_dbus_remove_watch(ofono_dbus_get_connection(), agent->watch);
+
 	g_free(agent->owner);
 	g_free(agent->path);
 	g_free(agent->codecs);
@@ -67,6 +71,14 @@ static void agent_release(struct agent *agent)
 	g_dbus_send_message(ofono_dbus_get_connection(), msg);
 }
 =

+static void agent_disconnect(DBusConnection *conn, void *user_data)
+{
+	DBG("Agent %s disconnected", agent->owner);
+
+	agent_free(agent);
+	agent =3D NULL;
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -109,6 +121,8 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	agent->path =3D g_strdup(path);
 	agent->codecs =3D g_memdup(codecs, length);
 	agent->codecs_len =3D length;
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
+						agent_disconnect, NULL, NULL);
 =

 	return dbus_message_new_method_return(msg);
 }
-- =

1.7.11.7


--===============9057432176803696719==--

