Content-Type: multipart/mixed; boundary="===============0694037171377679655=="
MIME-Version: 1.0
From: Marius Gripsgard <marius@ubports.com>
Subject: [PATCH v2] [qmimodem] Implement data capability bearer notify
Date: Wed, 10 Jun 2020 15:44:18 +0200
Message-ID: <20200610134418.745509-1-marius@ubports.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0694037171377679655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements data capability bearer notify to qmi modem.
Since this is included in the serving system response this
just adds a new data extraction for dc.
---
 drivers/qmimodem/gprs.c | 27 +++++++++++++++++++++++++++
 drivers/qmimodem/nas.c  | 36 ++++++++++++++++++++++++++++++++++++
 drivers/qmimodem/nas.h  | 23 +++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 07adbe9a..d2bbb2d5 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -68,6 +68,28 @@ static bool extract_ss_info(struct qmi_result *result, i=
nt *status, int *tech)
 	return true;
 }
 =

+static bool extract_dc_info(struct qmi_result *result, int *bearer_tech)
+{
+	const struct qmi_nas_data_capability *dc;
+	uint16_t len;
+	int i;
+
+	DBG("");
+
+	dc =3D qmi_result_get(result, QMI_NAS_RESULT_DATA_CAPABILITY_STATUS, &len=
);
+	if (!dc)
+		return false;
+
+	*bearer_tech =3D -1;
+	for (i =3D 0; i < dc->cap_count; i++) {
+		DBG("radio tech in use %d", dc->cap[i]);
+
+		*bearer_tech =3D qmi_nas_cap_to_bearer_tech(dc->cap[i]);
+	}
+
+	return true;
+}
+
 static void get_lte_attach_param_cb(struct qmi_result *result, void *user_=
data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -188,6 +210,7 @@ static int handle_ss_info(struct qmi_result *result, st=
ruct ofono_gprs *gprs)
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
 	int status;
 	int tech;
+	int bearer_tech;
 =

 	DBG("");
 =

@@ -209,6 +232,10 @@ static int handle_ss_info(struct qmi_result *result, s=
truct ofono_gprs *gprs)
 		data->last_auto_context_id =3D 0;
 	}
 =

+	// DC is optional so only notify on successful extraction
+	if (extract_dc_info(result, &bearer_tech))
+		ofono_gprs_bearer_notify(gprs, bearer_tech);
+
 	return status;
 }
 =

diff --git a/drivers/qmimodem/nas.c b/drivers/qmimodem/nas.c
index 48d7f11c..630f901d 100644
--- a/drivers/qmimodem/nas.c
+++ b/drivers/qmimodem/nas.c
@@ -36,3 +36,39 @@ int qmi_nas_rat_to_tech(uint8_t rat)
 =

 	return -1;
 }
+
+int qmi_nas_cap_to_bearer_tech(int cap_tech)
+{
+
+	switch (cap_tech) {
+	case QMI_NAS_DATA_CAPABILITY_GSM:
+	case QMI_NAS_DATA_CAPABILITY_NONE:
+		return PACKET_BEARER_NONE;
+	case QMI_NAS_DATA_CAPABILITY_GPRS:
+		return PACKET_BEARER_GPRS;
+	case QMI_NAS_DATA_CAPABILITY_EDGE:
+		return PACKET_BEARER_EGPRS;
+	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_0:
+	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_A:
+	case QMI_NAS_DATA_CAPABILITY_EVDO_REV_B:
+		return PACKET_BEARER_UMTS;
+	case QMI_NAS_DATA_CAPABILITY_HSDPA:
+		return PACKET_BEARER_HSDPA;
+	case QMI_NAS_DATA_CAPABILITY_HSUPA:
+		return PACKET_BEARER_HSUPA;
+    case QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS:
+    case QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS:
+		/*
+		 * HSPAP is HSPA+; which ofono doesn't define;
+		 * so, if differentiating HSPA and HSPA+ is
+		 * important, then ofono needs to be patched,
+		 * and we probably also need to introduce a
+		 * new indicator icon.
+		 */
+		return PACKET_BEARER_HSUPA_HSDPA;
+	case QMI_NAS_DATA_CAPABILITY_LTE:
+		return PACKET_BEARER_EPS;
+	default:
+		return PACKET_BEARER_NONE;
+	}
+}
diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index 9f67707e..30badabe 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -135,6 +135,28 @@ struct qmi_nas_serving_system {
 	uint8_t radio_if[0];
 } __attribute__((__packed__));
 #define QMI_NAS_RESULT_ROAMING_STATUS		0x10	/* uint8 */
+
+#define QMI_NAS_RESULT_DATA_CAPABILITY_STATUS		0x11	/* uint8 */
+struct qmi_nas_data_capability {
+	uint8_t cap_count;
+	uint8_t cap[0];
+} __attribute__((__packed__));
+
+#define QMI_NAS_DATA_CAPABILITY_NONE          0x00
+#define QMI_NAS_DATA_CAPABILITY_GPRS          0x01
+#define QMI_NAS_DATA_CAPABILITY_EDGE          0x02
+#define QMI_NAS_DATA_CAPABILITY_HSDPA         0x03
+#define QMI_NAS_DATA_CAPABILITY_HSUPA         0x04
+#define QMI_NAS_DATA_CAPABILITY_WCDMA         0x05
+#define QMI_NAS_DATA_CAPABILITY_CDMA          0x06
+#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_0    0x07
+#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_A    0x08
+#define QMI_NAS_DATA_CAPABILITY_GSM           0x09
+#define QMI_NAS_DATA_CAPABILITY_EVDO_REV_B    0x0A
+#define QMI_NAS_DATA_CAPABILITY_LTE           0x0B
+#define QMI_NAS_DATA_CAPABILITY_HSDPA_PLUS    0x0C
+#define QMI_NAS_DATA_CAPABILITY_DC_HSDPA_PLUS 0x0D
+
 #define QMI_NAS_RESULT_CURRENT_PLMN		0x12
 struct qmi_nas_current_plmn {
 	uint16_t mcc;
@@ -188,3 +210,4 @@ struct qmi_nas_home_network {
 #define QMI_NAS_RESULT_SYSTEM_SELECTION_PREF_MODE	0x11
 =

 int qmi_nas_rat_to_tech(uint8_t rat);
+int qmi_nas_cap_to_bearer_tech(int cap_tech);
-- =

2.25.1

--===============0694037171377679655==--

