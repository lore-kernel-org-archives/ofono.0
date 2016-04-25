Content-Type: multipart/mixed; boundary="===============4593496552588544824=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] rilmodem: Driver code to set band mode and value
Date: Mon, 25 Apr 2016 21:12:14 +0530
Message-ID: <1461598934-13781-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4593496552588544824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara Borwankar <antara.borwankar@gmail.com>

set_band driver to set GSM band and UMTS band
---
 drivers/rilmodem/radio-settings.c | 109 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 90b49c6..eb26902 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -64,6 +64,22 @@
 #define MTK_PREF_NET_TYPE_LTE_GSM_TYPE (MTK_PREF_NET_TYPE_BASE + 5)
 #define MTK_PREF_NET_TYPE_LTE_GSM_MMDC_TYPE (MTK_PREF_NET_TYPE_BASE + 6)
 =

+/*GSM Band*/
+#define PREF_NET_BAND_GSM_AUTOMATIC 255
+#define PREF_NET_BAND_GSM850 6
+#define PREF_NET_BAND_GSM900_P 1
+#define PREF_NET_BAND_GSM900_E 2
+#define PREF_NET_BAND_GSM1800 4
+#define PREF_NET_BAND_GSM1900 5
+
+/*UMTS Band*/
+#define PREF_NET_BAND_UMTS_AUTOMATIC 255
+#define PREF_NET_BAND_UMTS_V 54
+#define PREF_NET_BAND_UMTS_VIII 57
+#define PREF_NET_BAND_UMTS_IV 53
+#define PREF_NET_BAND_UMTS_II 51
+#define PREF_NET_BAND_UMTS_I 50
+
 struct radio_data {
 	GRil *ril;
 	gboolean fast_dormancy;
@@ -288,6 +304,98 @@ static void ril_query_available_rats(struct ofono_radi=
o_settings *rs,
 	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
 }
 =

+static void ril_set_band_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_radio_settings *rs =3D cbd->user;
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	ofono_radio_settings_band_set_cb_t cb =3D cbd->cb;
+
+	if (message->error =3D=3D RIL_E_SUCCESS) {
+		g_ril_print_response_no_args(rd->ril, message);
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	}
+}
+
+static void ril_set_band(struct ofono_radio_settings *rs,
+			enum ofono_radio_band_gsm band_gsm,
+			enum ofono_radio_band_umts band_umts,
+			ofono_radio_settings_band_set_cb_t cb,
+			void *data)
+{
+	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data, rs);
+	struct parcel rilp;
+	char cmd_buf[9], gsm_band[4], umts_band[4];
+	/* RIL_OEM_HOOK_STRING_SET_BAND_PREFERENCE =3D 0x000000CE */
+	int cmd_id =3D 0x000000CE;
+	sprintf(cmd_buf, "%d", cmd_id);
+
+	switch (band_gsm) {
+	case OFONO_RADIO_BAND_GSM_ANY:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM_AUTOMATIC);
+		break;
+	case OFONO_RADIO_BAND_GSM_850:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM850);
+		break;
+	case OFONO_RADIO_BAND_GSM_900P:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM900_P);
+		break;
+	case OFONO_RADIO_BAND_GSM_900E:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM900_E);
+		break;
+	case OFONO_RADIO_BAND_GSM_1800:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM1800);
+		break;
+	case OFONO_RADIO_BAND_GSM_1900:
+		sprintf(gsm_band, "%d", PREF_NET_BAND_GSM1900);
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb,  data);
+		return;
+	}
+
+	switch (band_umts) {
+	case OFONO_RADIO_BAND_UMTS_ANY:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_AUTOMATIC);
+		break;
+	case OFONO_RADIO_BAND_UMTS_850:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_V);
+		break;
+	case OFONO_RADIO_BAND_UMTS_900:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_VIII);
+		break;
+	case OFONO_RADIO_BAND_UMTS_1700AWS:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_IV);
+		break;
+	case OFONO_RADIO_BAND_UMTS_1900:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_II);
+		break;
+	case OFONO_RADIO_BAND_UMTS_2100:
+		sprintf(umts_band, "%d", PREF_NET_BAND_UMTS_I);
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb,  data);
+		return;
+	}
+	=

+	parcel_init(&rilp);
+	parcel_w_int32(&rilp, 3);	/* Number of params */
+	parcel_w_string(&rilp, cmd_buf);	=

+	parcel_w_string(&rilp, gsm_band);
+	parcel_w_string(&rilp, umts_band);
+
+	if (g_ril_send(rd->ril, RIL_REQUEST_OEM_HOOK_STRINGS, &rilp,
+			ril_set_band_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb,data);
+}
+
 static void ril_delayed_register(const struct ofono_error *error,
 							void *user_data)
 {
@@ -329,6 +437,7 @@ static struct ofono_radio_settings_driver driver =3D {
 	.remove			=3D ril_radio_settings_remove,
 	.query_rat_mode		=3D ril_query_rat_mode,
 	.set_rat_mode		=3D ril_set_rat_mode,
+	.set_band		=3D ril_set_band,
 	.query_fast_dormancy	=3D ril_query_fast_dormancy,
 	.set_fast_dormancy	=3D ril_set_fast_dormancy,
 	.query_available_rats	=3D ril_query_available_rats
-- =

1.9.1


--===============4593496552588544824==--

