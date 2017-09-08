Content-Type: multipart/mixed; boundary="===============3737948951847059854=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/7] qmi: provide AvailableTechnologies in radio-settings
Date: Fri, 08 Sep 2017 04:47:33 +0200
Message-ID: <20170908024733.32135-1-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3737948951847059854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides the list of available technologies in the radio-settings
atom.  The list is queried by the DMS Get Capabilities method; ofono
takes care of caching the available technologies for us so we don't need
to worry about this method being called excessively.
---

I forgot to edit the commit message in the first submission.  Here's a
patch with a correct description.
/Jonas

 drivers/qmimodem/radio-settings.c | 77 +++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index 3a2b068..5e76bc5 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -29,11 +29,13 @@
 =

 #include "qmi.h"
 #include "nas.h"
+#include "dms.h"
 =

 #include "qmimodem.h"
 =

 struct settings_data {
 	struct qmi_service *nas;
+	struct qmi_service *dms;
 	uint16_t major;
 	uint16_t minor;
 };
@@ -150,6 +152,78 @@ static void qmi_set_rat_mode(struct ofono_radio_settin=
gs *rs,
 	g_free(cbd);
 }
 =

+static void get_caps_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_radio_settings_available_rats_query_cb_t cb =3D cbd->cb;
+	const struct qmi_dms_device_caps *caps;
+	unsigned int available_rats;
+	uint16_t len;
+	uint8_t i;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	caps =3D qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, &len);
+	if (!caps)
+		goto error;
+
+	available_rats =3D 0;
+        for (i =3D 0; i < caps->radio_if_count; i++) {
+		switch (caps->radio_if[i]) {
+		case QMI_DMS_RADIO_IF_GSM:
+			available_rats |=3D OFONO_RADIO_ACCESS_MODE_GSM;
+			break;
+		case QMI_DMS_RADIO_IF_UMTS:
+			available_rats |=3D OFONO_RADIO_ACCESS_MODE_UMTS;
+			break;
+		case QMI_DMS_RADIO_IF_LTE:
+			available_rats |=3D OFONO_RADIO_ACCESS_MODE_LTE;
+		}
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, available_rats, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void qmi_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data)
+{
+	struct settings_data *rsd =3D ofono_radio_settings_get_data(rs);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (!rsd->dms)
+		goto error;
+
+	if (qmi_service_send(rsd->dms, QMI_DMS_GET_CAPS, NULL,
+					get_caps_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void create_dms_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_radio_settings *rs =3D user_data;
+	struct settings_data *data =3D ofono_radio_settings_get_data(rs);
+
+	DBG("");
+
+	if (!service)
+		return;
+
+	data->dms =3D qmi_service_ref(service);
+}
+
 static void create_nas_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_radio_settings *rs =3D user_data;
@@ -186,6 +260,8 @@ static int qmi_radio_settings_probe(struct ofono_radio_=
settings *rs,
 =

 	ofono_radio_settings_set_data(rs, data);
 =

+	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+						create_dms_cb, rs, NULL);
 	qmi_service_create_shared(device, QMI_SERVICE_NAS,
 						create_nas_cb, rs, NULL);
 =

@@ -213,6 +289,7 @@ static struct ofono_radio_settings_driver driver =3D {
 	.remove		=3D qmi_radio_settings_remove,
 	.set_rat_mode	=3D qmi_set_rat_mode,
 	.query_rat_mode =3D qmi_query_rat_mode,
+	.query_available_rats =3D qmi_query_available_rats,
 };
 =

 void qmi_radio_settings_init(void)
-- =

2.9.3


--===============3737948951847059854==--

