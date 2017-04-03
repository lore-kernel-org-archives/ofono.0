Content-Type: multipart/mixed; boundary="===============4397806731340410634=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/3] qmi: add service ID's
Date: Mon, 03 Apr 2017 14:27:32 +0200
Message-ID: <20170403122734.12638-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4397806731340410634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 14 ++++++++++++++
 drivers/qmimodem/qmi.h |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 9b80455..e113b85 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -341,8 +341,12 @@ static const char *__service_type_to_string(uint8_t ty=
pe)
 		return "UIM";
 	case QMI_SERVICE_PBM:
 		return "PBM";
+	case QMI_SERVICE_QCHAT:
+		return "QCHAT";
 	case QMI_SERVICE_RMTFS:
 		return "RMTFS";
+	case QMI_SERVICE_TEST:
+		return "TEST";
 	case QMI_SERVICE_LOC:
 		return "LOC";
 	case QMI_SERVICE_SAR:
@@ -357,8 +361,18 @@ static const char *__service_type_to_string(uint8_t ty=
pe)
 		return "TMD";
 	case QMI_SERVICE_WDA:
 		return "WDA";
+	case QMI_SERVICE_CSVT:
+		return "CSVT";
+	case QMI_SERVICE_COEX:
+		return "COEX";
 	case QMI_SERVICE_PDC:
 		return "PDC";
+	case QMI_SERVICE_RFRPE:
+		return "RFRPE";
+	case QMI_SERVICE_DSD:
+		return "DSD";
+	case QMI_SERVICE_SSCTL:
+		return "SSCTL";
 	case QMI_SERVICE_CAT_OLD:
 		return "CAT";
 	case QMI_SERVICE_RMS:
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 2233cdb..0cd8f7c 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -35,7 +35,9 @@
 #define QMI_SERVICE_CAT		10	/* Card application toolkit service */
 #define QMI_SERVICE_UIM		11	/* UIM service */
 #define QMI_SERVICE_PBM		12	/* Phonebook service */
+#define QMI_SERVICE_QCHAT	13
 #define QMI_SERVICE_RMTFS	14	/* Remote file system service */
+#define QMI_SERVICE_TEST	15
 #define QMI_SERVICE_LOC		16	/* Location service */
 #define QMI_SERVICE_SAR		17	/* Specific absorption rate service */
 #define QMI_SERVICE_CSD		20	/* Core sound driver service */
@@ -43,7 +45,12 @@
 #define QMI_SERVICE_TS		23	/* Thermal sensors service */
 #define QMI_SERVICE_TMD		24	/* Thermal mitigation device service */
 #define QMI_SERVICE_WDA		26	/* Wireless data administrative service */
+#define QMI_SERVICE_CSVT	29
+#define QMI_SERVICE_COEX	34
 #define QMI_SERVICE_PDC		36	/* Persistent device configuration service */
+#define QMI_SERVICE_RFRPE	41
+#define QMI_SERVICE_DSD		42
+#define QMI_SERVICE_SSCTL	43
 #define QMI_SERVICE_CAT_OLD	224	/* Card application toolkit service */
 #define QMI_SERVICE_RMS		225	/* Remote management service */
 #define QMI_SERVICE_OMA		226	/* OMA device management service */
-- =

2.9.3


--===============4397806731340410634==--

