Content-Type: multipart/mixed; boundary="===============3221727311639281308=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 07/16] stemodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:09 +0200
Message-ID: <1294829538-3893-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3221727311639281308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/gprs-context.c   |    4 ++--
 drivers/stemodem/radio-settings.c |    4 ++--
 drivers/stemodem/stemodem.h       |   12 ++++++------
 drivers/stemodem/voicecall.c      |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 1762fb3..4325628 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -596,13 +596,13 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D ste_gprs_deactivate_primary,
 };
 =

-void ste_gprs_context_init()
+void ste_gprs_context_init(void)
 {
 	caif_rtnl_init();
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void ste_gprs_context_exit()
+void ste_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 	caif_rtnl_exit();
diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index e65baf4..5b50126 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -220,12 +220,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_rat_mode	=3D ste_set_rat_mode
 };
 =

-void ste_radio_settings_init()
+void ste_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void ste_radio_settings_exit()
+void ste_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
index b1691a2..f522ecd 100644
--- a/drivers/stemodem/stemodem.h
+++ b/drivers/stemodem/stemodem.h
@@ -22,11 +22,11 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void ste_gprs_context_init();
-extern void ste_gprs_context_exit();
+extern void ste_gprs_context_init(void);
+extern void ste_gprs_context_exit(void);
 =

-extern void ste_voicecall_init();
-extern void ste_voicecall_exit();
+extern void ste_voicecall_init(void);
+extern void ste_voicecall_exit(void);
 =

-extern void ste_radio_settings_init();
-extern void ste_radio_settings_exit();
+extern void ste_radio_settings_init(void);
+extern void ste_radio_settings_exit(void);
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 99383cf..8f3533d 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -597,12 +597,12 @@ static struct ofono_voicecall_driver driver =3D {
 	.send_tones		=3D ste_send_dtmf
 };
 =

-void ste_voicecall_init()
+void ste_voicecall_init(void)
 {
 	ofono_voicecall_driver_register(&driver);
 }
 =

-void ste_voicecall_exit()
+void ste_voicecall_exit(void)
 {
 	ofono_voicecall_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============3221727311639281308==--

