Content-Type: multipart/mixed; boundary="===============6422553573063549250=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/2] huaweimodem: add frequency band selection support
Date: Thu, 23 Dec 2010 09:17:59 -0200
Message-ID: <1293103080-8895-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6422553573063549250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/radio-settings.c |  206 ++++++++++++++++++++++++++++++=
+++-
 1 files changed, 200 insertions(+), 6 deletions(-)

diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/rad=
io-settings.c
index 30961da..10d46e9 100644
--- a/drivers/huaweimodem/radio-settings.c
+++ b/drivers/huaweimodem/radio-settings.c
@@ -43,11 +43,93 @@
 static const char *none_prefix[] =3D { NULL };
 static const char *syscfg_prefix[] =3D { "^SYSCFG:", NULL };
 =

+#define HUAWEI_BAND_ANY 0x3FFFFFFF
+
 struct radio_settings_data {
 	GAtChat *chat;
 };
 =

-static void syscfg_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+static const struct huawei_band_gsm_table {
+	enum ofono_radio_band_gsm band_gsm;
+	unsigned int band_huawei;
+} huawei_band_gsm_table[] =3D {
+	{ OFONO_RADIO_BAND_GSM_ANY, 0x80000 | 0x200 | 0x100 | 0x80 | 0x200000 },
+	{ OFONO_RADIO_BAND_GSM_850, 0x80000 },
+	{ OFONO_RADIO_BAND_GSM_900P, 0x200 },
+	{ OFONO_RADIO_BAND_GSM_900E, 0x100 },
+	{ OFONO_RADIO_BAND_GSM_1800, 0x80 },
+	{ OFONO_RADIO_BAND_GSM_1900, 0x200000 },
+};
+
+static const struct huawei_band_umts_table {
+	enum ofono_radio_band_umts band_umts;
+	unsigned int band_huawei;
+} huawei_band_umts_table[] =3D {
+	{ OFONO_RADIO_BAND_UMTS_ANY, 0x4000000 | 0x20000 | 800000 | 400000 },
+	{ OFONO_RADIO_BAND_UMTS_850, 0x4000000 },
+	{ OFONO_RADIO_BAND_UMTS_900, 0x20000 },
+	{ OFONO_RADIO_BAND_UMTS_1900, 0x800000 },
+	{ OFONO_RADIO_BAND_UMTS_2100, 0x400000 },
+};
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static unsigned int band_gsm_to_huawei(enum ofono_radio_band_gsm band)
+{
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(huawei_band_gsm_table); i++) {
+		if (huawei_band_gsm_table[i].band_gsm =3D=3D band)
+			return huawei_band_gsm_table[i].band_huawei;
+	}
+
+	return 0;
+}
+
+static unsigned int band_umts_to_huawei(enum ofono_radio_band_umts band)
+{
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(huawei_band_umts_table); i++) {
+		if (huawei_band_umts_table[i].band_umts =3D=3D band)
+			return huawei_band_umts_table[i].band_huawei;
+	}
+
+	return 0;
+}
+
+static enum ofono_radio_band_gsm band_gsm_from_huawei(unsigned int band)
+{
+	size_t i;
+
+	if (band =3D=3D HUAWEI_BAND_ANY)
+		return OFONO_RADIO_BAND_UMTS_ANY;
+
+	for (i =3D ARRAY_SIZE(huawei_band_gsm_table) - 1; i > 0; i--) {
+		if (huawei_band_gsm_table[i].band_huawei & band)
+			return huawei_band_gsm_table[i].band_gsm;
+	}
+
+	return OFONO_RADIO_BAND_GSM_ANY;
+}
+
+static enum ofono_radio_band_umts band_umts_from_huawei(unsigned int band)
+{
+	size_t i;
+
+	if (band =3D=3D HUAWEI_BAND_ANY)
+		return OFONO_RADIO_BAND_UMTS_ANY;
+
+	for (i =3D ARRAY_SIZE(huawei_band_umts_table) - 1; i > 0; i--) {
+		if (huawei_band_umts_table[i].band_huawei & band)
+			return huawei_band_umts_table[i].band_umts;
+	}
+
+	return OFONO_RADIO_BAND_UMTS_ANY;
+}
+
+static void syscfg_query_mode_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
@@ -101,13 +183,14 @@ static void huawei_query_rat_mode(struct ofono_radio_=
settings *rs,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
-					syscfg_query_cb, cbd, g_free) =3D=3D 0) {
+				syscfg_query_mode_cb, cbd, g_free) =3D=3D 0) {
 		CALLBACK_WITH_FAILURE(cb, -1, data);
 		g_free(cbd);
 	}
 }
 =

-static void syscfg_modify_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
+static void syscfg_modify_mode_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
@@ -144,11 +227,11 @@ static void huawei_set_rat_mode(struct ofono_radio_se=
ttings *rs,
 		goto error;
 	}
 =

-	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,3FFFFFFF,2,4",
-			value, acq_order);
+	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,%u,40000000,2,4",
+							value, acq_order);
 =

 	if (g_at_chat_send(rsd->chat, buf, none_prefix,
-					syscfg_modify_cb, cbd, g_free) > 0)
+					syscfg_modify_mode_cb, cbd, g_free) > 0)
 		return;
 =

 error:
@@ -156,6 +239,115 @@ error:
 	g_free(cbd);
 }
 =

+static void syscfg_modify_band_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_band_set_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void huawei_set_band(struct ofono_radio_settings *rs,
+			enum ofono_radio_band_gsm band_gsm,
+			enum ofono_radio_band_umts band_umts,
+			ofono_radio_settings_band_set_cb_t cb, void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[40];
+	unsigned int huawei_band;
+
+	if (band_gsm =3D=3D OFONO_RADIO_BAND_GSM_ANY
+			&& band_umts =3D=3D OFONO_RADIO_BAND_UMTS_ANY) {
+		huawei_band =3D HUAWEI_BAND_ANY;
+	} else {
+		unsigned int huawei_band_gsm;
+		unsigned int huawei_band_umts;
+
+		huawei_band_gsm =3D band_gsm_to_huawei(band_gsm);
+
+		if (!huawei_band_gsm)
+			goto error;
+
+		huawei_band_umts =3D band_umts_to_huawei(band_umts);
+
+		if (!huawei_band_umts)
+			goto error;
+
+		huawei_band =3D huawei_band_gsm | huawei_band_umts;
+	}
+
+	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D16,3,%x,2,4", huawei_band);
+
+	if (g_at_chat_send(rsd->chat, buf, none_prefix,
+					syscfg_modify_band_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void syscfg_query_band_cb(gboolean ok, GAtResult *result, gpointer =
user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_band_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_band_gsm band_gsm;
+	enum ofono_radio_band_umts band_umts;
+	struct ofono_error error;
+	GAtResultIter iter;
+	unsigned int band;
+	const char *band_str;
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		goto error;
+
+	if (g_at_result_iter_skip_next(&iter) =3D=3D FALSE)
+		goto error;
+
+	if(g_at_result_iter_next_unquoted_string(&iter, &band_str) =3D=3D FALSE)
+		goto error;
+
+	sscanf((const char *) band_str, "%x", &band);
+
+	band_gsm =3D band_gsm_from_huawei(band);
+	band_umts =3D band_umts_from_huawei(band);
+
+	cb(&error, band_gsm, band_umts, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, -1, cbd->data);
+}
+
+static void huawei_query_band(struct ofono_radio_settings *rs,
+		ofono_radio_settings_band_query_cb_t cb, void *data)
+{
+	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", syscfg_prefix,
+				syscfg_query_band_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, -1, data);
+		g_free(cbd);
+	}
+}
+
 static void syscfg_support_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -205,6 +397,8 @@ static struct ofono_radio_settings_driver driver =3D {
 	.remove			=3D huawei_radio_settings_remove,
 	.query_rat_mode		=3D huawei_query_rat_mode,
 	.set_rat_mode		=3D huawei_set_rat_mode,
+	.query_band             =3D huawei_query_band,
+	.set_band               =3D huawei_set_band,
 };
 =

 void huawei_radio_settings_init()
-- =

1.7.3.4


--===============6422553573063549250==--

