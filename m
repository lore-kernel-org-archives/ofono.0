Content-Type: multipart/mixed; boundary="===============5743693906854745310=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 13/13] qmi: consolidate ss_info handling functions
Date: Fri, 14 Apr 2017 23:36:46 +0200
Message-ID: <20170414213646.32066-14-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5743693906854745310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/network-registration.c | 51 ++++++++++++++---------------=
----
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index d0f4853..9bd88df 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -135,42 +135,32 @@ static bool extract_ss_info(struct qmi_result *result=
, int *status,
 	return true;
 }
 =

-static void ss_info_notify(struct qmi_result *result, void *user_data)
+static void handle_ss_info(struct qmi_result *result, void *user_data)
 {
-	struct ofono_netreg *netreg =3D user_data;
+	struct cb_data *cbd =3D user_data;
+	struct ofono_netreg *netreg =3D cbd->user;
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
 	int status, lac, cellid, tech;
 =

 	DBG("");
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
-							&data->operator))
-		return;
-
-	ofono_netreg_status_notify(netreg, status, lac, cellid, tech);
-}
-
-static void get_ss_info_cb(struct qmi_result *result, void *user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_netreg_status_cb_t cb =3D cbd->cb;
-	struct netreg_data *data =3D cbd->user;
-	int status, lac, cellid, tech;
+	if (cb && qmi_result_set_error(result, NULL))
+		goto error;
 =

-	DBG("");
+	if (!extract_ss_info(result, &status, &lac,
+				&cellid, &tech, &data->operator))
+		goto error;
 =

-	if (qmi_result_set_error(result, NULL)) {
-		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
-		return;
-	}
+	if (cb)
+		CALLBACK_WITH_SUCCESS(cb, status,
+					lac, cellid, tech, cbd->data);
+	else
+		ofono_netreg_status_notify(netreg, status, lac, cellid, tech);
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
-							&data->operator)) {
+error:
+	if (cb)
 		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
-		return;
-	}
-
-	CALLBACK_WITH_SUCCESS(cb, status, lac, cellid, tech, cbd->data);
 }
 =

 static void qmi_registration_status(struct ofono_netreg *netreg,
@@ -181,10 +171,10 @@ static void qmi_registration_status(struct ofono_netr=
eg *netreg,
 =

 	DBG("");
 =

-	cbd->user =3D data;
+	cbd->user =3D netreg;
 =

 	if (qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
-					get_ss_info_cb, cbd, g_free) > 0)
+					handle_ss_info, cbd, g_free) > 0)
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
@@ -492,6 +482,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 	struct ofono_netreg *netreg =3D user_data;
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
 	struct qmi_param *param;
+	struct cb_data *cbd;
 	struct qmi_nas_param_event_signal_strength ss =3D { .report =3D 0x01,
 				.count =3D 5, .dbm[0] =3D -55, .dbm[1] =3D -65,
 				.dbm[2] =3D -75, .dbm[3] =3D -85, .dbm[4] =3D -95 };
@@ -509,8 +500,10 @@ static void create_nas_cb(struct qmi_service *service,=
 void *user_data)
 	qmi_service_register(data->nas, QMI_NAS_EVENT,
 					event_notify, netreg, NULL);
 =

+	cbd =3D cb_data_new(NULL, NULL);
+	cbd->user =3D netreg;
 	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
-					ss_info_notify, netreg, NULL);
+					handle_ss_info, cbd, g_free);
 =

 	param =3D qmi_param_new();
 	if (!param)
-- =

2.9.3


--===============5743693906854745310==--

