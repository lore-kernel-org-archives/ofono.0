Content-Type: multipart/mixed; boundary="===============8491668008442769857=="
MIME-Version: 1.0
From: Joshua Watt <jpewhacker@gmail.com>
Subject: [PATCH] qmimodem: return all serial numbers
Date: Fri, 05 Apr 2019 11:15:25 -0500
Message-ID: <20190405161525.7342-1-JPEWhacker@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8491668008442769857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Tom Nguyen <tom.nguyen@garmin.com>

ESN and MEID are used for CDMA devices. IMEI is used for GSM devices.
Some modems, eg. Quectel EC25E, have variants that support each network
for in various regions. So, the modems may return the ESN, MEID, and
IMEI regardless of the variant. To support this case, the ESN, MEID,
and IMEI should all be reported. Then the user application can decide
which to use.
---
 drivers/qmimodem/devinfo.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index af976b77..08e71fdf 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -117,7 +117,10 @@ static void get_ids_cb(struct qmi_result *result, void=
 *user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_devinfo_query_cb_t cb =3D cbd->cb;
-	char *str;
+	char *esn;
+	char *imei;
+	char *meid;
+	char buf[64];
 =

 	DBG("");
 =

@@ -126,20 +129,22 @@ static void get_ids_cb(struct qmi_result *result, voi=
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
-
-	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+	esn =3D qmi_result_get_string(result, QMI_DMS_RESULT_ESN);
+	imei =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMEI);
+	meid =3D qmi_result_get_string(result, QMI_DMS_RESULT_MEID);
+
+	if (esn || imei || meid) {
+		sprintf(buf, "ESN:%s,IMEI:%s,MEID:%s",
+					(esn) ? esn : "unknown",
+					(imei) ? imei : "unknown",
+					(meid) ? meid : "unknown");
+		CALLBACK_WITH_SUCCESS(cb, buf, cbd->data);
+	} else
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 =

-	qmi_free(str);
+	qmi_free(esn);
+	qmi_free(imei);
+	qmi_free(meid);
 }
 =

 static void qmi_query_serial(struct ofono_devinfo *devinfo,
-- =

2.20.1


--===============8491668008442769857==--

