Content-Type: multipart/mixed; boundary="===============1274265883509939063=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 11/11] hfp_audio: Add Agent tracking
Date: Tue, 19 Feb 2013 17:44:52 -0300
Message-ID: <1361306692-959-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1274265883509939063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch tracks when the Handsfree Audio Agent leaves the system BUS,
and free agent allocated resources.
---
 plugins/hfp_audio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index f46d739..a553afa 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -42,6 +42,7 @@ struct agent {
 	char *path;
 	unsigned char *codecs;
 	int codecs_len;
+	guint watch;
 };
 =

 /* Supported agents codecs */
@@ -56,6 +57,9 @@ static void agent_free(gpointer data)
 {
 	struct agent *agent =3D data;
 =

+	if (agent->watch > 0)
+		g_dbus_remove_watch(ofono_dbus_get_connection(), agent->watch);
+
 	g_free(agent->owner);
 	g_free(agent->path);
 	g_free(agent->codecs);
@@ -86,6 +90,16 @@ static void agent_release(gpointer data, gpointer user_d=
ata)
 	g_dbus_send_message(ofono_dbus_get_connection(), msg);
 }
 =

+static void agent_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct agent *agent =3D user_data;
+
+	DBG("Agent %s disconnected", agent->owner);
+
+	agents =3D g_slist_remove(agents, agent);
+	agent_free(agent);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -133,6 +147,8 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	agent->path =3D g_strdup(path);
 	agent->codecs =3D g_memdup(codecs, length);
 	agent->codecs_len =3D length;
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
+						agent_disconnect, agent, NULL);
 =

 	agents =3D g_slist_prepend(agents, agent);
 =

-- =

1.7.11.7


--===============1274265883509939063==--

