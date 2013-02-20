Content-Type: multipart/mixed; boundary="===============3899492332393786770=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 4/7] handsfree-audio: Free agent when exiting
Date: Wed, 20 Feb 2013 18:55:48 -0300
Message-ID: <1361397351-5841-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3899492332393786770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free agent allocated resources when oFono exits.
---
 src/handsfree-audio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 499e0de..28053b4 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -47,6 +47,14 @@ struct agent {
 =

 static struct agent *agent =3D NULL;
 =

+static void agent_free(struct agent *agent)
+{
+	g_free(agent->owner);
+	g_free(agent->path);
+	g_free(agent->codecs);
+	g_free(agent);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -127,4 +135,7 @@ void __ofono_handsfree_audio_manager_cleanup(void)
 {
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
 						HFP_AUDIO_MANAGER_INTERFACE);
+
+	if (agent)
+		agent_free(agent);
 }
-- =

1.7.11.7


--===============3899492332393786770==--

