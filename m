Content-Type: multipart/mixed; boundary="===============4569216229839614858=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 1/9] handsfree-audio: Add creating Audio Card
Date: Tue, 26 Feb 2013 10:50:45 -0300
Message-ID: <1361886653-30873-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4569216229839614858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Handsfree Audio Card registration when the service
level connection is established.
---
 include/handsfree-audio.h |  1 +
 plugins/hfp_hf_bluez5.c   |  4 ++++
 src/handsfree-audio.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
index d6e2d0d..0572965 100644
--- a/include/handsfree-audio.h
+++ b/include/handsfree-audio.h
@@ -30,6 +30,7 @@ extern "C" {
 =

 void ofono_handsfree_audio_ref(void);
 void ofono_handsfree_audio_unref(void);
+char *ofono_handsfree_card_create(const char *remote);
 =

 #ifdef __cplusplus
 }
diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 7057d71..eb2648e 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -46,6 +46,7 @@
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
+#include <ofono/handsfree-audio.h>
 #include <ofono/handsfree.h>
 =

 #include <drivers/hfpmodem/slc.h>
@@ -61,6 +62,7 @@
 struct hfp {
 	struct hfp_slc_info info;
 	DBusMessage *msg;
+	char *card;
 };
 =

 static GDBusClient *bluez =3D NULL;
@@ -78,6 +80,7 @@ static void slc_established(gpointer userdata)
 {
 	struct ofono_modem *modem =3D userdata;
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	const char *remote =3D ofono_modem_get_string(modem, "Remote");
 	DBusMessage *msg;
 =

 	ofono_modem_set_powered(modem, TRUE);
@@ -88,6 +91,7 @@ static void slc_established(gpointer userdata)
 	hfp->msg =3D NULL;
 =

 	ofono_info("Service level connection established");
+	hfp->card =3D ofono_handsfree_card_create(remote);
 }
 =

 static void slc_failed(gpointer userdata)
diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 4e2cf93..d4d9796 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -35,6 +35,7 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE	OFONO_SERVICE ".HandsfreeAudioManager"
 #define HFP_AUDIO_AGENT_INTERFACE	OFONO_SERVICE ".HandsfreeAudioAgent"
+#define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

 /* Supported agent codecs */
 enum hfp_codec {
@@ -50,6 +51,10 @@ struct agent {
 	guint watch;
 };
 =

+struct audio_card {
+	char *remote;
+};
+
 static struct agent *agent =3D NULL;
 static int ref_count =3D 0;
 =

@@ -205,6 +210,42 @@ void ofono_handsfree_audio_unref(void)
 	}
 }
 =

+static DBusMessage *card_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	return __ofono_error_not_implemented(msg);
+}
+
+static const GDBusMethodTable card_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			card_get_properties) },
+	{ }
+};
+
+char *ofono_handsfree_card_create(const char *remote)
+{
+	static int audio_card_id =3D 0;
+	struct audio_card *card;
+	char *path;
+
+	path =3D g_strdup_printf("/device%d", audio_card_id++);
+	card =3D g_new0(struct audio_card, 1);
+
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(), path,
+				HFP_AUDIO_CARD_INTERFACE, card_methods,
+				NULL, NULL, card, NULL)) {
+		g_free(path);
+		g_free(card);
+		return NULL;
+	}
+
+	card->remote =3D g_strdup(remote);
+	DBG("Audio Card added: %s", path);
+
+	return path;
+}
+
 int __ofono_handsfree_audio_manager_init(void)
 {
 	return 0;
-- =

1.7.11.7


--===============4569216229839614858==--

