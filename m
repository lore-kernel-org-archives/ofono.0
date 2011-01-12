Content-Type: multipart/mixed; boundary="===============0693752683397737537=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 09/16] ifxmodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:11 +0200
Message-ID: <1294829538-3893-10-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0693752683397737537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/audio-settings.c |    4 ++--
 drivers/ifxmodem/gprs-context.c   |    4 ++--
 drivers/ifxmodem/ifxmodem.h       |   20 ++++++++++----------
 drivers/ifxmodem/radio-settings.c |    4 ++--
 drivers/ifxmodem/stk.c            |    4 ++--
 drivers/ifxmodem/voicecall.c      |    4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/ifxmodem/audio-settings.c b/drivers/ifxmodem/audio-set=
tings.c
index 8273335..287221f 100644
--- a/drivers/ifxmodem/audio-settings.c
+++ b/drivers/ifxmodem/audio-settings.c
@@ -145,12 +145,12 @@ static struct ofono_audio_settings_driver driver =3D {
 	.remove		=3D ifx_audio_settings_remove,
 };
 =

-void ifx_audio_settings_init()
+void ifx_audio_settings_init(void)
 {
 	ofono_audio_settings_driver_register(&driver);
 }
 =

-void ifx_audio_settings_exit()
+void ifx_audio_settings_exit(void)
 {
 	ofono_audio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index fcfe698..2c68b44 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -489,12 +489,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D ifx_gprs_deactivate_primary,
 };
 =

-void ifx_gprs_context_init()
+void ifx_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void ifx_gprs_context_exit()
+void ifx_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/ifxmodem/ifxmodem.h b/drivers/ifxmodem/ifxmodem.h
index 8ea52e5..fbd3c06 100644
--- a/drivers/ifxmodem/ifxmodem.h
+++ b/drivers/ifxmodem/ifxmodem.h
@@ -21,17 +21,17 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void ifx_voicecall_init();
-extern void ifx_voicecall_exit();
+extern void ifx_voicecall_init(void);
+extern void ifx_voicecall_exit(void);
 =

-extern void ifx_audio_settings_init();
-extern void ifx_audio_settings_exit();
+extern void ifx_audio_settings_init(void);
+extern void ifx_audio_settings_exit(void);
 =

-extern void ifx_radio_settings_init();
-extern void ifx_radio_settings_exit();
+extern void ifx_radio_settings_init(void);
+extern void ifx_radio_settings_exit(void);
 =

-extern void ifx_gprs_context_init();
-extern void ifx_gprs_context_exit();
+extern void ifx_gprs_context_init(void);
+extern void ifx_gprs_context_exit(void);
 =

-extern void ifx_stk_init();
-extern void ifx_stk_exit();
+extern void ifx_stk_init(void);
+extern void ifx_stk_exit(void);
diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-set=
tings.c
index 2ec94f1..fd590ae 100644
--- a/drivers/ifxmodem/radio-settings.c
+++ b/drivers/ifxmodem/radio-settings.c
@@ -204,12 +204,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_rat_mode		=3D ifx_set_rat_mode
 };
 =

-void ifx_radio_settings_init()
+void ifx_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void ifx_radio_settings_exit()
+void ifx_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index 6494c4d..1a1805c 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -306,12 +306,12 @@ static struct ofono_stk_driver driver =3D {
 	.terminal_response	=3D ifx_stk_terminal_response,
 };
 =

-void ifx_stk_init()
+void ifx_stk_init(void)
 {
 	ofono_stk_driver_register(&driver);
 }
 =

-void ifx_stk_exit()
+void ifx_stk_exit(void)
 {
 	ofono_stk_driver_unregister(&driver);
 }
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index d43e6f9..f673624 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -771,12 +771,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D ifx_send_dtmf
 };
 =

-void ifx_voicecall_init()
+void ifx_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void ifx_voicecall_exit()
+void ifx_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============0693752683397737537==--

