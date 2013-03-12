Content-Type: multipart/mixed; boundary="===============8930692815188715074=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 01/20] handsfree-audio: Add card driver for HFP 1.6
Date: Tue, 12 Mar 2013 11:21:25 -0300
Message-ID: <1363098104-16467-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8930692815188715074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch registers the Handsfree Audio Card driver for devices
compliant with HFP 1.6.
---
 plugins/hfp_hf_bluez5.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index dd0a782..810107f 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -360,6 +360,18 @@ static struct ofono_handsfree_card_driver card_driver1=
5 =3D {
 	.audio_connect	=3D card_audio_connect15,
 };
 =

+static int card_audio_connect16(const char *remote, const char *local)
+{
+	return 0;
+}
+
+static struct ofono_handsfree_card_driver card_driver16 =3D {
+	.version	=3D HFP_VERSION_1_6,
+	.probe		=3D card_probe,
+	.remove		=3D card_remove,
+	.audio_connect	=3D card_audio_connect16,
+};
+
 static ofono_bool_t device_path_compare(struct ofono_modem *modem,
 					void *userdata)
 {
@@ -708,9 +720,18 @@ static int hfp_init(void)
 		return err;
 	}
 =

+	err =3D ofono_handsfree_card_driver_register(&card_driver16);
+	if (err < 0) {
+		ofono_handsfree_card_driver_unregister(&card_driver15);
+		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+		return err;
+	}
+
 	err =3D ofono_modem_driver_register(&hfp_driver);
 	if (err < 0) {
 		ofono_handsfree_card_driver_unregister(&card_driver15);
+		ofono_handsfree_card_driver_unregister(&card_driver16);
 		g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 		return err;
@@ -742,6 +763,7 @@ static void hfp_exit(void)
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
 	ofono_handsfree_card_driver_unregister(&card_driver15);
+	ofono_handsfree_card_driver_unregister(&card_driver16);
 	g_dbus_client_unref(bluez);
 =

 	ofono_handsfree_audio_unref();
-- =

1.7.11.7


--===============8930692815188715074==--

