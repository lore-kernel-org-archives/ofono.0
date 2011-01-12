Content-Type: multipart/mixed; boundary="===============7275961215702276992=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 06/16] huaweimodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:08 +0200
Message-ID: <1294829538-3893-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7275961215702276992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/audio-settings.c |    4 ++--
 drivers/huaweimodem/gprs-context.c   |    4 ++--
 drivers/huaweimodem/huaweimodem.h    |   16 ++++++++--------
 drivers/huaweimodem/radio-settings.c |    4 ++--
 drivers/huaweimodem/voicecall.c      |    4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/huaweimodem/audio-settings.c b/drivers/huaweimodem/aud=
io-settings.c
index 305776f..46d4e44 100644
--- a/drivers/huaweimodem/audio-settings.c
+++ b/drivers/huaweimodem/audio-settings.c
@@ -119,12 +119,12 @@ static struct ofono_audio_settings_driver driver =3D {
 	.remove		=3D huawei_audio_settings_remove,
 };
 =

-void huawei_audio_settings_init()
+void huawei_audio_settings_init(void)
 {
 	ofono_audio_settings_driver_register(&driver);
 }
 =

-void huawei_audio_settings_exit()
+void huawei_audio_settings_exit(void)
 {
 	ofono_audio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index ef3d93c..30f423b 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -406,12 +406,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D huawei_gprs_deactivate_primary,
 };
 =

-void huawei_gprs_context_init()
+void huawei_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void huawei_gprs_context_exit()
+void huawei_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/huaweimodem/huaweimodem.h b/drivers/huaweimodem/huawei=
modem.h
index 596aa08..f8323e3 100644
--- a/drivers/huaweimodem/huaweimodem.h
+++ b/drivers/huaweimodem/huaweimodem.h
@@ -21,14 +21,14 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void huawei_voicecall_init();
-extern void huawei_voicecall_exit();
+extern void huawei_voicecall_init(void);
+extern void huawei_voicecall_exit(void);
 =

-extern void huawei_audio_settings_init();
-extern void huawei_audio_settings_exit();
+extern void huawei_audio_settings_init(void);
+extern void huawei_audio_settings_exit(void);
 =

-extern void huawei_radio_settings_init();
-extern void huawei_radio_settings_exit();
+extern void huawei_radio_settings_init(void);
+extern void huawei_radio_settings_exit(void);
 =

-extern void huawei_gprs_context_init();
-extern void huawei_gprs_context_exit();
+extern void huawei_gprs_context_init(void);
+extern void huawei_gprs_context_exit(void);
diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index bece2cd..68112fe 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -404,12 +404,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_band               =3D huawei_set_band,
 };
 =

-void huawei_radio_settings_init()
+void huawei_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void huawei_radio_settings_exit()
+void huawei_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index ff08124..0c0aaa1 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -508,12 +508,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.release_specific	=3D huawei_release_specific,
 };
 =

-void huawei_voicecall_init()
+void huawei_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void huawei_voicecall_exit()
+void huawei_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============7275961215702276992==--

