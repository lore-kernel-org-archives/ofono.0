Content-Type: multipart/mixed; boundary="===============5936613840262399508=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmimodem: fix roaming status report
Date: Fri, 15 Dec 2017 11:28:05 +0100
Message-ID: <1513333685-12008-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1513333685-12008-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5936613840262399508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/network-registration.c | 50 ++++++++++++++++++++++++++++-=
----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 6c1f50b..85de4e1 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -42,6 +42,13 @@ struct netreg_data {
 	struct qmi_service *nas;
 	struct ofono_network_operator operator;
 	uint8_t current_rat;
+	bool is_roaming;
+};
+
+enum roaming_status {
+	ROAMING_STATUS_OFF,
+	ROAMING_STATUS_ON,
+	ROAMING_STATUS_NO_CHANGE,
 };
 =

 static bool extract_ss_info_time(
@@ -78,11 +85,12 @@ static bool extract_ss_info_time(
 =

 static bool extract_ss_info(struct qmi_result *result, int *status,
 				int *lac, int *cellid, int *tech,
+				enum roaming_status *roaming,
 				struct ofono_network_operator *operator)
 {
 	const struct qmi_nas_serving_system *ss;
 	const struct qmi_nas_current_plmn *plmn;
-	uint8_t i, roaming;
+	uint8_t i, is_not_roaming;
 	uint16_t value16, len, opname_len;
 	uint32_t value32;
 =

@@ -105,10 +113,13 @@ static bool extract_ss_info(struct qmi_result *result=
, int *status,
 	}
 =

 	if (qmi_result_get_uint8(result, QMI_NAS_RESULT_ROAMING_STATUS,
-								&roaming)) {
-		if (ss->status =3D=3D 1 && roaming =3D=3D 0)
-			*status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
-	}
+							&is_not_roaming)) {
+		if (is_not_roaming =3D=3D 0)
+			*roaming =3D ROAMING_STATUS_ON;
+		else
+			*roaming =3D ROAMING_STATUS_OFF;
+	} else
+		*roaming =3D ROAMING_STATUS_NO_CHANGE;
 =

 	if (!operator)
 		return true;
@@ -160,16 +171,28 @@ static void ss_info_notify(struct qmi_result *result,=
 void *user_data)
 	struct ofono_network_time net_time;
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
 	int status, lac, cellid, tech;
+	enum roaming_status roaming;
 =

 	DBG("");
 =

 	if (extract_ss_info_time(result, &net_time))
 		ofono_netreg_time_notify(netreg, &net_time);
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
+	if (!extract_ss_info(result, &status, &lac, &cellid, &tech, &roaming,
 							&data->operator))
 		return;
 =

+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (roaming =3D=3D ROAMING_STATUS_ON ||
+				(roaming =3D=3D ROAMING_STATUS_NO_CHANGE &&
+					data->is_roaming)) {
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+			data->is_roaming =3D true;
+		} else
+			data->is_roaming =3D false;
+	} else
+		data->is_roaming =3D false;
+
 	ofono_netreg_status_notify(netreg, status, lac, cellid, tech);
 }
 =

@@ -179,6 +202,7 @@ static void get_ss_info_cb(struct qmi_result *result, v=
oid *user_data)
 	ofono_netreg_status_cb_t cb =3D cbd->cb;
 	struct netreg_data *data =3D cbd->user;
 	int status, lac, cellid, tech;
+	enum roaming_status roaming;
 =

 	DBG("");
 =

@@ -187,12 +211,23 @@ static void get_ss_info_cb(struct qmi_result *result,=
 void *user_data)
 		return;
 	}
 =

-	if (!extract_ss_info(result, &status, &lac, &cellid, &tech,
+	if (!extract_ss_info(result, &status, &lac, &cellid, &tech, &roaming,
 							&data->operator)) {
 		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
 		return;
 	}
 =

+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (roaming =3D=3D ROAMING_STATUS_ON ||
+				(roaming =3D=3D ROAMING_STATUS_NO_CHANGE &&
+					data->is_roaming)) {
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+			data->is_roaming =3D true;
+		} else
+			data->is_roaming =3D false;
+	} else
+		data->is_roaming =3D false;
+
 	CALLBACK_WITH_SUCCESS(cb, status, lac, cellid, tech, cbd->data);
 }
 =

@@ -580,6 +615,7 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 	data->operator.tech =3D -1;
 =

 	data->current_rat =3D QMI_NAS_NETWORK_RAT_NO_CHANGE;
+	data->is_roaming =3D false;
 =

 	ofono_netreg_set_data(netreg, data);
 =

-- =

2.7.4


--===============5936613840262399508==--

