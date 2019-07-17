Content-Type: multipart/mixed; boundary="===============1859552928820264345=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] qmimodem: remember lac and cellid
Date: Wed, 17 Jul 2019 15:29:24 +0200
Message-ID: <1563370164-2408-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <ac06329b-9ba3-6ad2-2f1f-1645a3907916@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1859552928820264345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lac and cellid information are optional in ss_info notifications.
Remember them in order to give a correct information each time a
notification is received.
---
 drivers/qmimodem/network-registration.c | 53 ++++++++++++++++++++++-------=
----
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 1fccb57..04f20c6 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -42,6 +42,8 @@ struct netreg_data {
 	struct qmi_service *nas;
 	struct ofono_network_operator operator;
 	uint8_t current_rat;
+	int lac;
+	int cellid;
 	bool is_roaming;
 };
 =

@@ -166,6 +168,31 @@ static bool extract_ss_info(struct qmi_result *result,=
 int *status,
 	return true;
 }
 =

+static int remember_ss_info(struct netreg_data *data, int status, int lac,
+					int cellid, enum roaming_status roaming)
+{
+	if (roaming =3D=3D ROAMING_STATUS_ON)
+		data->is_roaming =3D true;
+	else if (roaming =3D=3D ROAMING_STATUS_OFF)
+		data->is_roaming =3D false;
+
+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (lac >=3D 0)
+			data->lac =3D lac;
+		if (cellid >=3D 0)
+			data->cellid =3D cellid;
+	} else {
+		data->lac =3D -1;
+		data->cellid =3D -1;
+	}
+
+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED &&
+							data->is_roaming)
+		status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+
+	return status;
+}
+
 static void ss_info_notify(struct qmi_result *result, void *user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -183,16 +210,10 @@ static void ss_info_notify(struct qmi_result *result,=
 void *user_data)
 							&data->operator))
 		return;
 =

-	if (roaming =3D=3D ROAMING_STATUS_ON)
-		data->is_roaming =3D true;
-	else if (roaming =3D=3D ROAMING_STATUS_OFF)
-		data->is_roaming =3D false;
-
-	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED &&
-							data->is_roaming)
-		status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+	status =3D remember_ss_info(data, status, lac, cellid, roaming);
 =

-	ofono_netreg_status_notify(netreg, status, lac, cellid, tech);
+	ofono_netreg_status_notify(netreg, status, data->lac, data->cellid,
+									tech);
 }
 =

 static void get_ss_info_cb(struct qmi_result *result, void *user_data)
@@ -216,16 +237,10 @@ static void get_ss_info_cb(struct qmi_result *result,=
 void *user_data)
 		return;
 	}
 =

-	if (roaming =3D=3D ROAMING_STATUS_ON)
-		data->is_roaming =3D true;
-	else if (roaming =3D=3D ROAMING_STATUS_OFF)
-		data->is_roaming =3D false;
-
-	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED &&
-							data->is_roaming)
-		status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+	status =3D remember_ss_info(data, status, lac, cellid, roaming);
 =

-	CALLBACK_WITH_SUCCESS(cb, status, lac, cellid, tech, cbd->data);
+	CALLBACK_WITH_SUCCESS(cb, status, data->lac, data->cellid, tech,
+								cbd->data);
 }
 =

 static void qmi_registration_status(struct ofono_netreg *netreg,
@@ -613,6 +628,8 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 =

 	data->current_rat =3D QMI_NAS_NETWORK_RAT_NO_CHANGE;
 	data->is_roaming =3D false;
+	data->lac =3D -1;
+	data->cellid =3D -1;
 =

 	ofono_netreg_set_data(netreg, data);
 =

-- =

2.7.4


--===============1859552928820264345==--

