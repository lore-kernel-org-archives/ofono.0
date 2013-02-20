Content-Type: multipart/mixed; boundary="===============2180586316484536741=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 5/7] handsfree-audio: Call Agent "Release" when exiting
Date: Wed, 20 Feb 2013 18:55:49 -0300
Message-ID: <1361397351-5841-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361397351-5841-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2180586316484536741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch notifies the Agent implementation that it is no longer
registered to the service daemon.
---
 src/handsfree-audio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 28053b4..07dbda0 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -31,6 +31,7 @@
 #include "ofono.h"
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
+#define HFP_AUDIO_AGENT_INTERFACE		OFONO_SERVICE ".HandsfreeAudioAgent"
 =

 /* Supported agent codecs */
 enum hfp_codec {
@@ -55,6 +56,16 @@ static void agent_free(struct agent *agent)
 	g_free(agent);
 }
 =

+static void agent_release(struct agent *agent)
+{
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
@@ -136,6 +147,8 @@ void __ofono_handsfree_audio_manager_cleanup(void)
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
 						HFP_AUDIO_MANAGER_INTERFACE);
 =

-	if (agent)
+	if (agent) {
+		agent_release(agent);
 		agent_free(agent);
+	}
 }
-- =

1.7.11.7


--===============2180586316484536741==--

