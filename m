Content-Type: multipart/mixed; boundary="===============3449466267469047195=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 02/13] hfp_hf_bluez5: Register handsfree audio driver
Date: Fri, 08 Mar 2013 20:11:14 -0300
Message-ID: <1362784285-22731-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3449466267469047195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch registers the Handsfree Audio Card driver for devices
compliant with HFP 1.5.
---
 plugins/hfp_hf_bluez5.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 381a541..0b9061d 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -311,6 +311,26 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static int card_probe(struct ofono_handsfree_card *card, void *data)
+{
+	return 0;
+}
+
+static void card_remove(struct ofono_handsfree_card *card)
+{
+}
+
+static int card_audio_connect(const char *remote, const char *local)
+{
+	return 0;
+}
+
+static struct ofono_handsfree_card_driver card_driver15 =3D {
+	.probe		=3D card_probe,
+	.remove		=3D card_remove,
+	.audio_connect	=3D card_audio_connect,
+};
+
 static ofono_bool_t device_path_compare(struct ofono_modem *modem,
 					void *userdata)
 {
@@ -615,8 +635,16 @@ static int hfp_init(void)
 		return -EIO;
 	}
 =

+	err =3D ofono_handsfree_card_driver_register(&card_driver15);
+	if (err < 0) {
+		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+		return err;
+	}
+
 	err =3D ofono_modem_driver_register(&hfp_driver);
 	if (err < 0) {
+		ofono_handsfree_card_driver_register(&card_driver15);
 		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 		return err;
@@ -647,6 +675,7 @@ static void hfp_exit(void)
 	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
+	ofono_handsfree_card_driver_register(&card_driver15);
 	g_dbus_client_unref(bluez);
 =

 	ofono_handsfree_audio_unref();
-- =

1.7.11.7


--===============3449466267469047195==--

