Content-Type: multipart/mixed; boundary="===============3118951035242903308=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/5] qmi: implement RAT selection
Date: Thu, 07 Sep 2017 14:11:33 +0200
Message-ID: <20170907121136.13520-2-jonas@southpole.se>
In-Reply-To: <20170907121136.13520-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3118951035242903308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The QMI radio-settings atom was just a skeleton and did not even implement
the mandtory property TechnologyPreference.  As such, it probably should
never even have been registered for the modem.  Nonetheless, this patch
puts this mandatory property into place.

This is implemented via the 'Set System Selection' method by way of the
'mode' parameter.  This seems to best reflect the intention of the Ofono
API and works as expected when tested with a Quectel EC21.

Some notes:
i)  There is an alternative function called 'Set Technology Preference'
    which provides similar functionality.  This 'technology preference'
    is updated automatically when the 'system selection mode' is modified
    so everything seems to be in order.
ii) For the EC21, switching the underlying technology works seamlessly.
    There are indications, however, that some modems _might_ require a
    reset before changes take effect; that bridge will need to be crossed
    if reached.
---
 drivers/qmimodem/nas.h            |  11 ++++
 drivers/qmimodem/radio-settings.c | 119 ++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index d2feb46..c3e7546 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -35,6 +35,8 @@
 #define QMI_NAS_SS_INFO_IND		36	/* Current serving system info indication =
*/
 #define QMI_NAS_GET_HOME_INFO		37	/* Get info about home network */
 =

+#define QMI_NAS_SET_SYSTEM_SELECTION_PREF 51
+#define QMI_NAS_GET_SYSTEM_SELECTION_PREF 52
 =

 /* Set NAS state report conditions */
 #define QMI_NAS_PARAM_REPORT_SIGNAL_STRENGTH	0x10
@@ -164,4 +166,13 @@ struct qmi_nas_home_network {
 	char desc[0];
 } __attribute__((__packed__));
 =

+#define QMI_NAS_RAT_MODE_PREF_ANY		(-1)
+#define QMI_NAS_RAT_MODE_PREF_GSM		(1 << 2)
+#define QMI_NAS_RAT_MODE_PREF_UMTS		(1 << 3)
+#define QMI_NAS_RAT_MODE_PREF_LTE		(1 << 4)
+
+#define QMI_NAS_PARAM_SYSTEM_SELECTION_PREF_MODE	0x11
+
+#define QMI_NAS_RESULT_SYSTEM_SELECTION_PREF_MODE	0x11
+
 int qmi_nas_rat_to_tech(uint8_t rat);
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index 04106ea..ed578f8 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -38,6 +38,123 @@ struct settings_data {
 	uint16_t minor;
 };
 =

+static void get_system_selection_pref_cb(struct qmi_result *result,
+							void* user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
+	enum ofono_radio_access_mode mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
+	uint16_t pref;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	qmi_result_get_uint16(result,
+			QMI_NAS_RESULT_SYSTEM_SELECTION_PREF_MODE, &pref);
+
+	switch (pref) {
+	case QMI_NAS_RAT_MODE_PREF_GSM:
+		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
+		break;
+	case QMI_NAS_RAT_MODE_PREF_UMTS:
+		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
+		break;
+	case QMI_NAS_RAT_MODE_PREF_LTE:
+		mode =3D OFONO_RADIO_ACCESS_MODE_LTE;
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
+}
+
+
+static void qmi_query_rat_mode(struct ofono_radio_settings *rs,
+			ofono_radio_settings_rat_mode_query_cb_t cb,
+			void *user_data)
+{
+	struct settings_data *data =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	DBG("");
+
+	if (qmi_service_send(data->nas,
+				QMI_NAS_GET_SYSTEM_SELECTION_PREF, NULL,
+				get_system_selection_pref_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void set_system_selection_pref_cb(struct qmi_result *result,
+							void* user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qmi_set_rat_mode(struct ofono_radio_settings *rs,
+			enum ofono_radio_access_mode mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *user_data)
+{
+	struct settings_data *data =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	uint16_t pref =3D QMI_NAS_RAT_MODE_PREF_ANY;
+	struct qmi_param *param;
+
+	DBG("");
+
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_ANY:
+		pref =3D QMI_NAS_RAT_MODE_PREF_ANY;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_GSM:
+		pref =3D QMI_NAS_RAT_MODE_PREF_GSM;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_UMTS:
+		pref =3D QMI_NAS_RAT_MODE_PREF_UMTS;
+		break;
+	case OFONO_RADIO_ACCESS_MODE_LTE:
+		pref =3D QMI_NAS_RAT_MODE_PREF_LTE;
+		break;
+	}
+
+	param =3D qmi_param_new();
+	if (!param) {
+		CALLBACK_WITH_FAILURE(cb, user_data);
+		return;
+	}
+
+	qmi_param_append_uint16(param, QMI_NAS_PARAM_SYSTEM_SELECTION_PREF_MODE,
+			pref);
+
+	if (qmi_service_send(data->nas,
+				QMI_NAS_SET_SYSTEM_SELECTION_PREF, param,
+				set_system_selection_pref_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+
+	CALLBACK_WITH_FAILURE(cb, user_data);
+
+	g_free(cbd);
+}
+
+
 static void create_nas_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_radio_settings *rs =3D user_data;
@@ -100,6 +217,8 @@ static struct ofono_radio_settings_driver driver =3D {
 	.name		=3D "qmimodem",
 	.probe		=3D qmi_radio_settings_probe,
 	.remove		=3D qmi_radio_settings_remove,
+	.set_rat_mode	=3D qmi_set_rat_mode,
+	.query_rat_mode =3D qmi_query_rat_mode,
 };
 =

 void qmi_radio_settings_init(void)
-- =

2.9.3


--===============3118951035242903308==--

