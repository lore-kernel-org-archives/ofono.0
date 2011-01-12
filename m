Content-Type: multipart/mixed; boundary="===============7222364980241628164=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 11/16] nwmodem: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:13 +0200
Message-ID: <1294829538-3893-12-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7222364980241628164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/nwmodem/nwmodem.h        |    4 ++--
 drivers/nwmodem/radio-settings.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nwmodem/nwmodem.h b/drivers/nwmodem/nwmodem.h
index 68a829b..e87f375 100644
--- a/drivers/nwmodem/nwmodem.h
+++ b/drivers/nwmodem/nwmodem.h
@@ -21,5 +21,5 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void nw_radio_settings_init();
-extern void nw_radio_settings_exit();
+extern void nw_radio_settings_init(void);
+extern void nw_radio_settings_exit(void);
diff --git a/drivers/nwmodem/radio-settings.c b/drivers/nwmodem/radio-setti=
ngs.c
index 36fab39..b8b5719 100644
--- a/drivers/nwmodem/radio-settings.c
+++ b/drivers/nwmodem/radio-settings.c
@@ -201,12 +201,12 @@ static struct ofono_radio_settings_driver driver =3D {
 	.set_rat_mode		=3D nw_set_rat_mode
 };
 =

-void nw_radio_settings_init()
+void nw_radio_settings_init(void)
 {
 	ofono_radio_settings_driver_register(&driver);
 }
 =

-void nw_radio_settings_exit()
+void nw_radio_settings_exit(void)
 {
 	ofono_radio_settings_driver_unregister(&driver);
 }
-- =

1.7.0.4


--===============7222364980241628164==--

