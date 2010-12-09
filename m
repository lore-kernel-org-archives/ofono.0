Content-Type: multipart/mixed; boundary="===============9165591761243859743=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/6] huaweimodem: add frequency band selection support
Date: Thu, 09 Dec 2010 14:43:40 -0200
Message-ID: <1291913020-3103-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9165591761243859743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/radio-settings.c |  172 ++++++++++++++++++++++++++++++=
++-
 1 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 1281d8b..d72a82c 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -43,16 +43,122 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *syscfg_prefix[] =3D { "^SYSCFG:", NULL };
 =

+static const unsigned int HUAWEI_BAND_ANY =3D 0x3FFFFFFF;
+
 struct radio_settings_data {
 	GAtChat *chat;
 	enum ofono_radio_access_mode mode;
+	enum ofono_radio_band_gsm band_gsm;
+	enum ofono_radio_band_umts band_umts;
 	struct {
 		enum ofono_radio_access_mode mode;
 	} pending;
 };
 =

-static ofono_bool_t syscfg_query_parse(struct radio_settings_data *rsd,
-					GAtResult *result)
+static unsigned int band_gsm_to_huawei(enum ofono_radio_band_gsm band)
+{
+	switch (band) {
+	case OFONO_RADIO_BAND_GSM_ANY:
+		return HUAWEI_BAND_ANY;
+	case OFONO_RADIO_BAND_GSM_850:
+		return 0x80000;
+	case OFONO_RADIO_BAND_GSM_900P:
+		return 0x200;
+	case OFONO_RADIO_BAND_GSM_900E:
+		return 0x100;
+	case OFONO_RADIO_BAND_GSM_1800:
+		return 0x80;
+	case OFONO_RADIO_BAND_GSM_1900:
+		return 0x200000;
+	default:
+		return 0;
+	}
+}
+
+static enum ofono_radio_band_gsm band_gsm_from_huawei(unsigned int band)
+{
+	switch(band) {
+	case 0x80000:
+		return OFONO_RADIO_BAND_GSM_850;
+	case 0x200:
+		return OFONO_RADIO_BAND_GSM_900P;
+	case 0x100:
+		return OFONO_RADIO_BAND_GSM_900E;
+	case 0x80:
+		return OFONO_RADIO_BAND_GSM_1800;
+	case 0x200000:
+		return OFONO_RADIO_BAND_GSM_1900;
+	default:
+		return OFONO_RADIO_BAND_GSM_ANY;
+	}
+}
+
+static unsigned int band_umts_to_huawei(enum ofono_radio_band_umts band)
+{
+	switch (band) {
+	case OFONO_RADIO_BAND_UMTS_ANY:
+		return HUAWEI_BAND_ANY;
+	case OFONO_RADIO_BAND_UMTS_850:
+		return 0x4000000;
+	case OFONO_RADIO_BAND_UMTS_900:
+		return 0x20000;
+	case OFONO_RADIO_BAND_UMTS_1900:
+		return 0x800000;
+	case OFONO_RADIO_BAND_UMTS_2100:
+		return 0x400000;
+	default:
+		return 0;
+	}
+}
+
+static enum ofono_radio_band_umts band_umts_from_huawei(unsigned int band)
+{
+	switch(band) {
+	case 0x4000000:
+		return OFONO_RADIO_BAND_UMTS_850;
+	case 0x20000:
+		return OFONO_RADIO_BAND_UMTS_900;
+	case 0x800000:
+		return OFONO_RADIO_BAND_UMTS_1900;
+	case 0x400000:
+		return OFONO_RADIO_BAND_UMTS_2100;
+	default:
+		return OFONO_RADIO_BAND_UMTS_ANY;
+	}
+}
+
+static ofono_bool_t syscfg_query_parse_band(struct radio_settings_data *rs=
d,
+						GAtResult *result)
+{
+	GAtResultIter iter;
+	int mode, acq_order, len;
+	unsigned int band;
+	const guint8 *band_str;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_number(&iter, &acq_order) =3D=3D FALSE)
+		return FALSE;
+
+	if (g_at_result_iter_next_hexstring(&iter, &band_str, &len) =3D=3D FALSE)
+		return FALSE;
+
+	sscanf((const char *) band_str, "%x", &band);
+
+	rsd->band_gsm =3D band_gsm_from_huawei(band);
+	rsd->band_umts =3D band_umts_from_huawei(band);
+
+	return TRUE;
+}
+
+static ofono_bool_t syscfg_query_parse_mode(struct radio_settings_data *rs=
d,
+						GAtResult *result)
 {
 	GAtResultIter iter;
 	int value;
@@ -82,6 +188,14 @@ static ofono_bool_t syscfg_query_parse(struct radio_set=
tings_data *rsd,
 	return TRUE;
 }
 =

+static void huawei_query_band(struct ofono_radio_settings *rs,
+			ofono_radio_settings_band_query_cb_t cb, void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+
+	CALLBACK_WITH_SUCCESS(cb, rsd->band_gsm, rsd->band_umts, data);
+}
+
 static void huawei_query_rat_mode_cb(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -97,7 +211,7 @@ static void huawei_query_rat_mode_cb(gboolean ok, GAtRes=
ult *result,
 		return;
 	}
 =

-	if (!syscfg_query_parse(rsd, result)) {
+	if (!syscfg_query_parse_mode(rsd, result)) {
 		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 		return;
 	}
@@ -143,6 +257,7 @@ static void huawei_set_rat_mode(struct ofono_radio_sett=
ings *rs,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[40];
 	unsigned int value =3D 2, acq_order =3D 0;
+	unsigned int band =3D HUAWEI_BAND_ANY;
 =

 	switch (mode) {
 	case OFONO_RADIO_ACCESS_MODE_ANY:
@@ -152,17 +267,19 @@ static void huawei_set_rat_mode(struct ofono_radio_se=
ttings *rs,
 	case OFONO_RADIO_ACCESS_MODE_GSM:
 		value =3D 13;
 		acq_order =3D 1;
+		band =3D band_gsm_to_huawei(rsd->band_gsm);
 		break;
 	case OFONO_RADIO_ACCESS_MODE_UMTS:
 		value =3D 14;
 		acq_order =3D 2;
+		band =3D band_umts_to_huawei(rsd->band_umts);
 		break;
 	case OFONO_RADIO_ACCESS_MODE_LTE:
 		goto error;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,3FFFFFFF,2,4",
-			value, acq_order);
+	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,%x,2,4",
+			value, acq_order, band);
 =

 	rsd->pending.mode =3D mode;
 	cbd->user =3D rsd;
@@ -176,6 +293,44 @@ error:
 	g_free(cbd);
 }
 =

+static void huawei_set_band(struct ofono_radio_settings *rs,
+			enum ofono_radio_band_gsm band_gsm,
+			enum ofono_radio_band_umts band_umts,
+			ofono_radio_settings_band_set_cb_t cb, void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	ofono_bool_t change_mode =3D FALSE;
+
+	if (!band_gsm_to_huawei(band_gsm))
+		goto error;
+
+	if (!band_umts_to_huawei(band_umts))
+		goto error;
+
+	if (rsd->mode =3D=3D OFONO_RADIO_ACCESS_MODE_ANY ||
+			(rsd->mode =3D=3D OFONO_RADIO_ACCESS_MODE_GSM &&
+			 rsd->band_gsm !=3D band_gsm) ||
+			(rsd->mode =3D=3D OFONO_RADIO_ACCESS_MODE_UMTS &&
+			 rsd->band_umts !=3D band_umts))
+		change_mode =3D TRUE;
+
+	rsd->band_gsm =3D band_gsm;
+	rsd->band_umts =3D band_umts;
+
+	if (!change_mode) {
+		CALLBACK_WITH_SUCCESS(cb, data);
+
+		return;
+	}
+
+	huawei_set_rat_mode(rs, rsd->mode, cb, data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static void syscfg_support_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -185,7 +340,10 @@ static void syscfg_support_cb(gboolean ok, GAtResult *=
result,
 	if (!ok)
 		goto error_not_supported;
 =

-	if (!syscfg_query_parse(rsd, result))
+	if (!syscfg_query_parse_mode(rsd, result))
+		goto error_parsing;
+
+	if (!syscfg_query_parse_band(rsd, result))
 		goto error_parsing;
 =

 	ofono_radio_settings_register(rs);
@@ -236,6 +394,8 @@ static struct ofono_radio_settings_driver driver =3D {
 	.remove			=3D huawei_radio_settings_remove,
 	.query_rat_mode		=3D huawei_query_rat_mode,
 	.set_rat_mode		=3D huawei_set_rat_mode,
+	.query_band		=3D huawei_query_band,
+	.set_band		=3D huawei_set_band,
 };
 =

 void huawei_radio_settings_init()
-- =

1.7.3.3


--===============9165591761243859743==--

