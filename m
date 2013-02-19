Content-Type: multipart/mixed; boundary="===============3188951443998233797=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 09/11] hfp_audio: Call Agent "Release" when exiting
Date: Tue, 19 Feb 2013 17:44:50 -0300
Message-ID: <1361306692-959-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3188951443998233797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch notifies the Agent implementation that it is no longer
registered to the service daemon.
---
 plugins/hfp_audio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index ffc3138..a8e365c 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -35,6 +35,7 @@
 #include <ofono/log.h>
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
+#define HFP_AUDIO_AGENT_INTERFACE		OFONO_SERVICE ".HandsfreeAudioAgent"
 =

 struct agent {
 	char *owner;
@@ -74,6 +75,17 @@ static int agent_cmp(gconstpointer a, gconstpointer b)
 	return strcmp(agent->path, match->path);
 }
 =

+static void agent_release(gpointer data, gpointer user_data)
+{
+	struct agent *agent =3D data;
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(agent->owner, agent->path,
+					HFP_AUDIO_AGENT_INTERFACE, "Release");
+
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -169,6 +181,7 @@ static void hfp_audio_exit(void)
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
 						HFP_AUDIO_MANAGER_INTERFACE);
 =

+	g_slist_foreach(agents, agent_release, NULL);
 	g_slist_free_full(agents, agent_free);
 }
 =

-- =

1.7.11.7


--===============3188951443998233797==--

