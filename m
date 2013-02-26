Content-Type: multipart/mixed; boundary="===============4283416586183334920=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 2/9] handsfree-audio: Add removing Audio Card
Date: Tue, 26 Feb 2013 10:50:46 -0300
Message-ID: <1361886653-30873-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4283416586183334920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes a registered Handsfree Audio Card when the service
level connection is disconnected.
---
 include/handsfree-audio.h |  1 +
 plugins/hfp_hf_bluez5.c   |  5 +++++
 src/handsfree-audio.c     | 18 +++++++++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index 0572965..af3c4c0 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -31,6 +31,7 @@ extern "C" {
 void ofono_handsfree_audio_ref(void);
 void ofono_handsfree_audio_unref(void);
 char *ofono_handsfree_card_create(const char *remote);
+void ofono_handsfree_card_remove(const char *path);
 =

 #ifdef __cplusplus
 }
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index eb2648e..f22b030 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -126,6 +126,11 @@ static void hfp_disconnected_cb(gpointer user_data)
 =

 	ofono_modem_set_powered(modem, FALSE);
 =

+	if (hfp->card) {
+		ofono_handsfree_card_remove(hfp->card);
+		g_free(hfp->card);
+	}
+
 	g_at_chat_unref(info->chat);
 	info->chat =3D NULL;
 }
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d4d9796..a9eb7c9 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -69,6 +69,14 @@ static void agent_free(struct agent *agent)
 	g_free(agent);
 }
 =

+static void audio_card_free(gpointer data)
+{
+	struct audio_card *card =3D data;
+
+	g_free(card->remote);
+	g_free(card);
+}
+
 static void agent_release(struct agent *agent)
 {
 	DBusMessage *msg;
@@ -234,7 +242,7 @@ char *ofono_handsfree_card_create(const char *remote)
 =

 	if (!g_dbus_register_interface(ofono_dbus_get_connection(), path,
 				HFP_AUDIO_CARD_INTERFACE, card_methods,
-				NULL, NULL, card, NULL)) {
+				NULL, NULL, card, audio_card_free)) {
 		g_free(path);
 		g_free(card);
 		return NULL;
@@ -246,6 +254,14 @@ char *ofono_handsfree_card_create(const char *remote)
 	return path;
 }
 =

+void ofono_handsfree_card_remove(const char *path)
+{
+	g_dbus_unregister_interface(ofono_dbus_get_connection(), path,
+						HFP_AUDIO_CARD_INTERFACE);
+
+	DBG("Audio Card removed: %s", path);
+}
+
 int __ofono_handsfree_audio_manager_init(void)
 {
 	return 0;
-- =

1.7.11.7


--===============4283416586183334920==--

