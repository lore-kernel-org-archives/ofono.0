Content-Type: multipart/mixed; boundary="===============6837158412570370675=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/6] qmimodem: simplify driver registration
Date: Fri, 26 Oct 2018 11:54:15 +0200
Message-ID: <20181026095419.26260-3-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6837158412570370675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs-context.c       | 10 +---------
 drivers/qmimodem/location-reporting.c | 10 +---------
 drivers/qmimodem/qmimodem.c           |  4 ----
 drivers/qmimodem/qmimodem.h           |  6 ------
 4 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index dcdf8ae1..0dc33b0f 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -501,12 +501,4 @@ static const struct ofono_gprs_context_driver driver =
=3D {
 	.detach_shutdown	=3D qmi_gprs_context_detach_shutdown,
 };
 =

-void qmi_gprs_context_init(void)
-{
-	ofono_gprs_context_driver_register(&driver);
-}
-
-void qmi_gprs_context_exit(void)
-{
-	ofono_gprs_context_driver_unregister(&driver);
-}
+OFONO_GPRS_CONTEXT_DRIVER(&driver)
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/locat=
ion-reporting.c
index 90d57db7..2052b460 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -287,12 +287,4 @@ static const struct ofono_location_reporting_driver dr=
iver =3D {
 	.disable	=3D qmi_location_reporting_disable,
 };
 =

-void qmi_location_reporting_init()
-{
-	ofono_location_reporting_driver_register(&driver);
-}
-
-void qmi_location_reporting_exit()
-{
-	ofono_location_reporting_driver_unregister(&driver);
-}
+OFONO_LOCATION_REPORTING_DRIVER(&driver)
diff --git a/drivers/qmimodem/qmimodem.c b/drivers/qmimodem/qmimodem.c
index 11e68f2e..5f1a267e 100644
--- a/drivers/qmimodem/qmimodem.c
+++ b/drivers/qmimodem/qmimodem.c
@@ -38,10 +38,8 @@ static int qmimodem_init(void)
 	qmi_sms_init();
 	qmi_ussd_init();
 	qmi_gprs_init();
-	qmi_gprs_context_init();
 	qmi_lte_init();
 	qmi_radio_settings_init();
-	qmi_location_reporting_init();
 	qmi_netmon_init();
 =

 	return 0;
@@ -50,10 +48,8 @@ static int qmimodem_init(void)
 static void qmimodem_exit(void)
 {
 	qmi_netmon_exit();
-	qmi_location_reporting_exit();
 	qmi_radio_settings_exit();
 	qmi_lte_exit();
-	qmi_gprs_context_exit();
 	qmi_gprs_exit();
 	qmi_ussd_exit();
 	qmi_sms_exit();
diff --git a/drivers/qmimodem/qmimodem.h b/drivers/qmimodem/qmimodem.h
index eeb1375a..72e5417d 100644
--- a/drivers/qmimodem/qmimodem.h
+++ b/drivers/qmimodem/qmimodem.h
@@ -45,17 +45,11 @@ extern void qmi_ussd_exit(void);
 extern void qmi_gprs_init(void);
 extern void qmi_gprs_exit(void);
 =

-extern void qmi_gprs_context_init(void);
-extern void qmi_gprs_context_exit(void);
-
 extern void qmi_lte_init(void);
 extern void qmi_lte_exit(void);
 =

 extern void qmi_radio_settings_init(void);
 extern void qmi_radio_settings_exit(void);
 =

-extern void qmi_location_reporting_init(void);
-extern void qmi_location_reporting_exit(void);
-
 extern void qmi_netmon_init(void);
 extern void qmi_netmon_exit(void);
-- =

2.17.1


--===============6837158412570370675==--

