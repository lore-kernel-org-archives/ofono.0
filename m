Content-Type: multipart/mixed; boundary="===============4221363096201536158=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 10/16] hsomodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:12 +0200
Message-ID: <1294829538-3893-11-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4221363096201536158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hsomodem/gprs-context.c   |    4 ++--
 drivers/hsomodem/hsomodem.h       |    8 ++++----
 drivers/hsomodem/radio-settings.c |    4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index a3f55ab..d140d2e 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -389,12 +389,12 @@ static struct ofono_gprs_context_driver driver =3D {
 	.deactivate_primary	=3D hso_gprs_deactivate_primary,
 };
 =

-void hso_gprs_context_init()
+void hso_gprs_context_init(void)
 {
 	ofono_gprs_context_driver_register(&driver);
 }
 =

-void hso_gprs_context_exit()
+void hso_gprs_context_exit(void)
 {
 	ofono_gprs_context_driver_unregister(&driver);
 }
diff --git a/drivers/hsomodem/hsomodem.h b/drivers/hsomodem/hsomodem.h
index b75fafc..0f0b76f 100644
--- a/drivers/hsomodem/hsomodem.h
+++ b/drivers/hsomodem/hsomodem.h
@@ -21,8 +21,8 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void hso_gprs_context_init();
-extern void hso_gprs_context_exit();
+extern void hso_gprs_context_init(void);
+extern void hso_gprs_context_exit(void);
 =

-extern void hso_radio_settings_init();
-extern void hso_radio_settings_exit();
+extern void hso_radio_settings_init(void);
+extern void hso_radio_settings_exit(void);
diff --git a/drivers/hsomodem/radio-settings.c b/drivers/hsomodem/radio-set=
tings.c
index 0f234ce..cefd415 100644
--- a/drivers/hsomodem/radio-settings.c
+++ b/drivers/hsomodem/radio-settings.c
@@ -205,12 +205,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_rat_mode		=3D hso_set_rat_mode
 };
 =

-void hso_radio_settings_init()
+void hso_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void hso_radio_settings_exit()
+void hso_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============4221363096201536158==--

