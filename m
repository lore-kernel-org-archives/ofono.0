Content-Type: multipart/mixed; boundary="===============3704592606059435570=="
MIME-Version: 1.0
From: Tom Nguyen <tomirq@earthlink.net>
Subject: [PATCH v2] qmimodem: return all serial numbers
Date: Sat, 28 Sep 2019 01:48:38 +0000
Message-ID: <2097825122.6387.1555084361605@wamui-cinderella.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3704592606059435570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some modems, eg. Quectel EC25E, return the ESN, IMEI, and MEID even
though they support only one network type in a region. Current serial
number query gives precedence to the ESN if it exists, and does not
consider the IMEI and MEID.

Add a check of the supported radio interfaces in deciding which
serial number to return. If radio interfaces are 3GPP based, then
return the IMEI, else return the ESN. If neither exist, return MEID
if available, else fail.
---
 drivers/qmimodem/devinfo.c | 88 +++++++++++++++++++++++++++++++++++++++---=
----
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index af976b7..4722efd 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -36,6 +36,7 @@
 =

 struct devinfo_data {
 	struct qmi_service *dms;
+	bool device_is_3gpp;
 };
 =

 static void string_cb(struct qmi_result *result, void *user_data)
@@ -116,7 +117,12 @@ static void qmi_query_revision(struct ofono_devinfo *d=
evinfo,
 static void get_ids_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
+	struct ofono_devinfo *devinfo =3D cbd->user;
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
 	ofono_devinfo_query_cb_t cb =3D cbd->cb;
+	char *esn;
+	char *imei;
+	char *meid;
 	char *str;
 =

 	DBG("");
@@ -126,20 +132,28 @@ static void get_ids_cb(struct qmi_result *result, voi=
d *user_data)
 		return;
 	}
 =

-	str =3D qmi_result_get_string(result, QMI_DMS_RESULT_ESN);
-	/* Telit qmi modems return a "0" string when ESN is not available. */
-	if (!str || strcmp(str, "0") =3D=3D 0) {
-		qmi_free(str);
-		str =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMEI);
-		if (!str) {
-			CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
-			return;
-		}
-	}
+	esn =3D qmi_result_get_string(result, QMI_DMS_RESULT_ESN);
+	imei =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMEI);
+	meid =3D qmi_result_get_string(result, QMI_DMS_RESULT_MEID);
 =

-	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+	str =3D NULL;
 =

-	qmi_free(str);
+	if (data->device_is_3gpp && imei && strcmp(imei, "0"))
+		str =3D imei;
+	else if (esn && strcmp(esn, "0"))
+		str =3D esn;
+
+	if (str =3D=3D NULL && meid && strcmp(meid, "0"))
+		str =3D meid;
+
+	if (str)
+		CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+	qmi_free(esn);
+	qmi_free(imei);
+	qmi_free(meid);
 }
 =

 static void qmi_query_serial(struct ofono_devinfo *devinfo,
@@ -150,6 +164,8 @@ static void qmi_query_serial(struct ofono_devinfo *devi=
nfo,
 =

 	DBG("");
 =

+	cbd->user =3D (void *) devinfo;
+
 	if (qmi_service_send(data->dms, QMI_DMS_GET_IDS, NULL,
 					get_ids_cb, cbd, g_free) > 0)
 		return;
@@ -159,6 +175,51 @@ static void qmi_query_serial(struct ofono_devinfo *dev=
info,
 	g_free(cbd);
 }
 =

+static void get_caps_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_devinfo *devinfo =3D user_data;
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
+	const struct qmi_dms_device_caps *caps;
+	uint8_t i;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	caps =3D qmi_result_get(result, QMI_DMS_RESULT_DEVICE_CAPS, NULL);
+	if (caps =3D=3D NULL)
+		goto error;
+
+	data->device_is_3gpp =3D false;
+
+	for (i =3D 0; i < caps->radio_if_count; i++) {
+		switch (caps->radio_if[i]) {
+		case QMI_DMS_RADIO_IF_GSM:
+		case QMI_DMS_RADIO_IF_UMTS:
+		case QMI_DMS_RADIO_IF_LTE:
+			data->device_is_3gpp =3D true;
+			break;
+		}
+	}
+
+error:
+	ofono_devinfo_register(devinfo);
+}
+
+static void qmi_query_caps(struct ofono_devinfo *devinfo)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(devinfo);
+
+	DBG("");
+
+	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
+					get_caps_cb, devinfo, NULL) > 0)
+		return;
+
+	ofono_devinfo_register(devinfo);
+}
+
 static void create_dms_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_devinfo *devinfo =3D user_data;
@@ -173,8 +234,9 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 	}
 =

 	data->dms =3D qmi_service_ref(service);
+	data->device_is_3gpp =3D false;
 =

-	ofono_devinfo_register(devinfo);
+	qmi_query_caps(devinfo);
 }
 =

 static int qmi_devinfo_probe(struct ofono_devinfo *devinfo,
-- =

1.9.1


--===============3704592606059435570==--

