Content-Type: multipart/mixed; boundary="===============8972805000286406894=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 08/11] hfp_audio: Free agents when exiting
Date: Tue, 19 Feb 2013 17:44:49 -0300
Message-ID: <1361306692-959-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8972805000286406894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free agents allocated resources when hfp_audio plugin exits.
---
 plugins/hfp_audio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index 32ddebc..ffc3138 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -51,6 +51,16 @@ enum hfp_codec {
 =

 static GSList *agents =3D NULL;
 =

+static void agent_free(gpointer data)
+{
+	struct agent *agent =3D data;
+
+	g_free(agent->owner);
+	g_free(agent->path);
+	g_free(agent->codecs);
+	g_free(agent);
+}
+
 static int agent_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct agent *agent =3D a;
@@ -158,6 +168,8 @@ static void hfp_audio_exit(void)
 {
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
 						HFP_AUDIO_MANAGER_INTERFACE);
+
+	g_slist_free_full(agents, agent_free);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_audio, "Handsfree Audio Plugin", VERSION,
-- =

1.7.11.7


--===============8972805000286406894==--

