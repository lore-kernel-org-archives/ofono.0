Content-Type: multipart/mixed; boundary="===============2600971844367624972=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v5 4/4] qmi: activate default bearer context for LTE
 networks
Date: Sat, 29 Apr 2017 14:46:43 +0200
Message-ID: <20170429124643.21080-5-jonas@southpole.se>
In-Reply-To: <20170429124643.21080-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2600971844367624972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the modem attaches to an LTE network, a default bearer is
automatically negotiated using the "defalt profile" settings.  The
QMI modem, however, does not given any explicit indication that
the bearer exists; instead, we must assume its existence based on
the network registration state.

This patch extends the GPRS atom to signal the presence of a
default bearer when it detects network connectivity on an LTE
network.
---
 drivers/qmimodem/gprs.c | 65 +++++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index e3bfd1f..a3461e4 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -37,10 +37,11 @@ struct gprs_data {
 	struct qmi_service *nas;
 };
 =

-static bool extract_ss_info(struct qmi_result *result, int *status)
+static bool extract_ss_info(struct qmi_result *result, int *status, int *t=
ech)
 {
 	const struct qmi_nas_serving_system *ss;
 	uint16_t len;
+	int i;
 =

 	DBG("");
 =

@@ -53,20 +54,53 @@ static bool extract_ss_info(struct qmi_result *result, =
int *status)
 	else
 		*status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 =

+	*tech =3D -1;
+	for (i =3D 0; i < ss->radio_if_count; i++) {
+		DBG("radio in use %d", ss->radio_if[i]);
+
+		*tech =3D qmi_nas_rat_to_tech(ss->radio_if[i]);
+	}
+
 	return true;
 }
 =

+static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gp=
rs)
+{
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	int status;
+	int tech;
+
+	DBG("");
+
+	if (!extract_ss_info(result, &status, &tech))
+		return -1;
+
+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+		if (tech =3D=3D ACCESS_TECHNOLOGY_EUTRAN) {
+			/* On LTE we are effectively always attached; and
+			 * the default bearer is established as soon as the
+			 * network is joined.
+			 */
+			/* FIXME: query default profile number and APN
+			 * instead of assuming profile 1 and ""
+			 */
+			ofono_gprs_cid_activated(gprs, 1 , "");
+		}
+
+	return status;
+}
+
 static void ss_info_notify(struct qmi_result *result, void *user_data)
 {
-	struct ofono_gprs *gprs =3D user_data;
+	struct ofono_gprs* gprs =3D user_data;
 	int status;
 =

 	DBG("");
 =

-	if (!extract_ss_info(result, &status))
-		return;
+	status =3D handle_ss_info(result, gprs);
 =

-	ofono_gprs_status_notify(gprs, status);
+	if (status >=3D 0)
+		ofono_gprs_status_notify(gprs, status);
 }
 =

 static void attach_detach_cb(struct qmi_result *result, void *user_data)
@@ -125,22 +159,26 @@ error:
 static void get_ss_info_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
+	struct ofono_gprs* gprs =3D cbd->user;
 	ofono_gprs_status_cb_t cb =3D cbd->cb;
 	int status;
 =

 	DBG("");
 =

-	if (qmi_result_set_error(result, NULL)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
+	if (qmi_result_set_error(result, NULL))
+		goto error;
 =

-	if (!extract_ss_info(result, &status)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
+	status =3D handle_ss_info(result, gprs);
+
+	if (status < 0)
+		goto error;
 =

 	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

 static void qmi_attached_status(struct ofono_gprs *gprs,
@@ -151,6 +189,7 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 =

 	DBG("");
 =

+	cbd->user =3D gprs;
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
 					get_ss_info_cb, cbd, g_free) > 0)
 		return;
-- =

2.9.3


--===============2600971844367624972==--

