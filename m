Content-Type: multipart/mixed; boundary="===============0968306565059389593=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmi: support sim hotplug
Date: Fri, 15 Feb 2019 15:37:24 +0100
Message-ID: <1550241444-14106-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1550241444-14106-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0968306565059389593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use card status indication to detect SIM removal and insertions
---
 drivers/qmimodem/sim.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 drivers/qmimodem/uim.h |  2 +-
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index e91c657..b96f8ef 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -524,7 +524,7 @@ static bool get_card_status(const struct qmi_uim_slot_i=
nfo *slot,
 	return need_retry;
 }
 =

-static enum get_card_status_result handle_get_card_status_result(
+static enum get_card_status_result handle_get_card_status_data(
 		struct qmi_result *result, struct sim_status *sim_stat)
 {
 	const void *ptr;
@@ -533,9 +533,6 @@ static enum get_card_status_result handle_get_card_stat=
us_result(
 	uint8_t i;
 	enum get_card_status_result res =3D GET_CARD_STATUS_RESULT_ERROR;
 =

-	if (qmi_result_set_error(result, NULL))
-		goto done;
-
 	ptr =3D qmi_result_get(result, QMI_UIM_RESULT_CARD_STATUS, &len);
 	if (!ptr)
 		goto done;
@@ -578,6 +575,15 @@ done:
 	return res;
 }
 =

+static enum get_card_status_result handle_get_card_status_result(
+		struct qmi_result *result, struct sim_status *sim_stat)
+{
+	if (qmi_result_set_error(result, NULL))
+		return GET_CARD_STATUS_RESULT_ERROR;
+
+	return handle_get_card_status_data(result, sim_stat);
+}
+
 static gboolean query_passwd_state_retry(gpointer userdata)
 {
 	struct cb_data *cbd =3D userdata;
@@ -796,6 +802,33 @@ static void get_card_status_cb(struct qmi_result *resu=
lt, void *user_data)
 	}
 }
 =

+static void card_status_notify(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct sim_status sim_stat;
+
+	DBG("");
+
+	if (handle_get_card_status_data(result, &sim_stat) !=3D
+					GET_CARD_STATUS_RESULT_OK) {
+		data->app_type =3D 0;	/* Unknown */
+		sim_stat.card_state =3D 0x00;	/* Absent */
+	} else {
+		data->app_type =3D sim_stat.app_type;
+	}
+
+	switch (sim_stat.card_state) {
+	case 0x00:	/* Absent */
+	case 0x02:	/* Error */
+		ofono_sim_inserted_notify(sim, FALSE);
+		break;
+	case 0x01:	/* Present */
+		ofono_sim_inserted_notify(sim, TRUE);
+		break;
+	}
+}
+
 static void event_registration_cb(struct qmi_result *result, void *user_da=
ta)
 {
 	struct ofono_sim *sim =3D user_data;
@@ -811,6 +844,9 @@ static void event_registration_cb(struct qmi_result *re=
sult, void *user_data)
 		goto error;
 =

 	DBG("event mask 0x%04x", data->event_mask);
+	if (data->event_mask & 0x0001)
+		qmi_service_register(data->uim, QMI_UIM_GET_CARD_STATUS_EVENT,
+						card_status_notify, sim, NULL);
 =

 	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
 					get_card_status_cb, sim, NULL) > 0)
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index cd10e68..9003aba 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -29,7 +29,7 @@
 =

 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
 #define QMI_UIM_GET_CARD_STATUS		47	/* Get card status */
-
+#define QMI_UIM_GET_CARD_STATUS_EVENT	50	/* Card status indication */
 =

 /* Register for indications */
 #define QMI_UIM_PARAM_EVENT_MASK	0x01	/* uint32 */
-- =

2.7.4


--===============0968306565059389593==--

