Content-Type: multipart/mixed; boundary="===============3480984166146901164=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 12/13] qmi: rely on destroy callback
Date: Fri, 14 Apr 2017 23:36:45 +0200
Message-ID: <20170414213646.32066-13-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3480984166146901164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and move creation of cb_data structures closer to their usage point
in order to prevent them from leaking when earlier code fails.
---
 drivers/qmimodem/network-registration.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index a3f9cf9..d0f4853 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -188,8 +188,6 @@ static void qmi_registration_status(struct ofono_netreg=
 *netreg,
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void qmi_current_operator(struct ofono_netreg *netreg,
@@ -300,8 +298,6 @@ static void qmi_list_operators(struct ofono_netreg *net=
reg,
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void register_net_cb(struct qmi_result *result, void *user_data)
@@ -330,7 +326,7 @@ static void qmi_register_auto(struct ofono_netreg *netr=
eg,
 				ofono_netreg_register_cb_t cb, void *user_data)
 {
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 	struct qmi_param *param;
 =

 	DBG("");
@@ -340,6 +336,8 @@ static void qmi_register_auto(struct ofono_netreg *netr=
eg,
 	if (!param)
 		goto error;
 =

+	cbd =3D cb_data_new(cb, user_data);
+
 	if (qmi_service_send(data->nas, QMI_NAS_REGISTER_NET, param,
 					register_net_cb, cbd, g_free) > 0)
 		return;
@@ -347,9 +345,7 @@ static void qmi_register_auto(struct ofono_netreg *netr=
eg,
 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void qmi_register_manual(struct ofono_netreg *netreg,
@@ -357,7 +353,7 @@ static void qmi_register_manual(struct ofono_netreg *ne=
treg,
 				ofono_netreg_register_cb_t cb, void *user_data)
 {
 	struct netreg_data *data =3D ofono_netreg_get_data(netreg);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 	struct qmi_nas_param_register_manual_info info;
 	struct qmi_param *param;
 =

@@ -375,6 +371,8 @@ static void qmi_register_manual(struct ofono_netreg *ne=
treg,
 	qmi_param_append(param, QMI_NAS_PARAM_REGISTER_MANUAL_INFO,
 						sizeof(info), &info);
 =

+	cbd =3D cb_data_new(cb, user_data);
+
 	if (qmi_service_send(data->nas, QMI_NAS_REGISTER_NET, param,
 					register_net_cb, cbd, g_free) > 0)
 		return;
@@ -382,9 +380,7 @@ static void qmi_register_manual(struct ofono_netreg *ne=
treg,
 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static int dbm_to_strength(int8_t dbm)
@@ -446,8 +442,6 @@ static void qmi_signal_strength(struct ofono_netreg *ne=
treg,
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-
-	g_free(cbd);
 }
 =

 static void event_notify(struct qmi_result *result, void *user_data)
-- =

2.9.3


--===============3480984166146901164==--

