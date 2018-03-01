Content-Type: multipart/mixed; boundary="===============1587372651058852595=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/4] qmimodem: initialize LTE driver
Date: Thu, 01 Mar 2018 11:48:02 +0100
Message-ID: <20180301104804.24058-3-jonas@southpole.se>
In-Reply-To: <20180301104804.24058-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1587372651058852595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmimodem.c | 2 ++
 drivers/qmimodem/qmimodem.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/qmimodem/qmimodem.c b/drivers/qmimodem/qmimodem.c
index b10ce28c..11e68f2e 100644
--- a/drivers/qmimodem/qmimodem.c
+++ b/drivers/qmimodem/qmimodem.c
@@ -39,6 +39,7 @@ static int qmimodem_init(void)
 	qmi_ussd_init();
 	qmi_gprs_init();
 	qmi_gprs_context_init();
+	qmi_lte_init();
 	qmi_radio_settings_init();
 	qmi_location_reporting_init();
 	qmi_netmon_init();
@@ -51,6 +52,7 @@ static void qmimodem_exit(void)
 	qmi_netmon_exit();
 	qmi_location_reporting_exit();
 	qmi_radio_settings_exit();
+	qmi_lte_exit();
 	qmi_gprs_context_exit();
 	qmi_gprs_exit();
 	qmi_ussd_exit();
diff --git a/drivers/qmimodem/qmimodem.h b/drivers/qmimodem/qmimodem.h
index 4b0fad3f..eeb1375a 100644
--- a/drivers/qmimodem/qmimodem.h
+++ b/drivers/qmimodem/qmimodem.h
@@ -48,6 +48,9 @@ extern void qmi_gprs_exit(void);
 extern void qmi_gprs_context_init(void);
 extern void qmi_gprs_context_exit(void);
 =

+extern void qmi_lte_init(void);
+extern void qmi_lte_exit(void);
+
 extern void qmi_radio_settings_init(void);
 extern void qmi_radio_settings_exit(void);
 =

-- =

2.14.1


--===============1587372651058852595==--

