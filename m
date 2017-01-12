Content-Type: multipart/mixed; boundary="===============5615523132512023006=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] qmimodem: query_passwd_state can be retried
Date: Thu, 12 Jan 2017 15:09:18 +0100
Message-ID: <20170112140918.28845-2-c.ronco@kerlink.fr>
In-Reply-To: <20170112140918.28845-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5615523132512023006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Retry command QMI_UIM_GET_CARD_STATUS during query_passwd_state if a
temporary error status has been detected.
This happens with a MC7430 modem when query_passwd_state is called just
after PIN is entered.
---
 drivers/qmimodem/sim.c | 74 ++++++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 8e5042db..8aac88ba 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <string.h>
+#include <unistd.h>
 =

 #include <ofono/log.h>
 #include <ofono/modem.h>
@@ -39,6 +40,15 @@
 #define EF_STATUS_INVALIDATED 0
 #define EF_STATUS_VALID 1
 =

+/* max number of retry of commands that can temporary fail */
+#define MAX_RETRY_COUNT 100
+
+enum get_card_status_result {
+	GET_CARD_STATUS_RESULT_OK, /* No error */
+	GET_CARD_STATUS_RESULT_ERROR, /* Definitive error */
+	GET_CARD_STATUS_RESULT_TEMP_ERROR, /* error, a retry could work */
+};
+
 /* information from QMI_UIM_GET_CARD_STATUS command */
 struct sim_status {
 	uint8_t card_state;
@@ -53,8 +63,12 @@ struct sim_data {
 	struct qmi_service *uim;
 	uint32_t event_mask;
 	uint8_t app_type;
+	uint32_t retry_count;
 };
 =

+static void qmi_query_passwd_state(struct ofono_sim *sim,
+				ofono_sim_passwd_cb_t cb, void *user_data);
+
 static int create_fileid_data(uint8_t app_type, int fileid,
 					const unsigned char *path,
 					unsigned int path_len,
@@ -344,11 +358,13 @@ static void qmi_read_imsi(struct ofono_sim *sim,
 	g_free(cbd);
 }
 =

-static void get_card_status(const struct qmi_uim_slot_info *slot,
+/* Return true if a retry could give another (better) result */
+static bool get_card_status(const struct qmi_uim_slot_info *slot,
 					const struct qmi_uim_app_info1 *info1,
 					const struct qmi_uim_app_info2 *info2,
 					struct sim_status *sim_stat)
 {
+	bool need_retry =3D false;
 	sim_stat->card_state =3D slot->card_state;
 	sim_stat->app_type =3D info1->app_type;
 =

@@ -362,6 +378,7 @@ static void get_card_status(const struct qmi_uim_slot_i=
nfo *slot,
 	case 0x04:	/* Personalization state must be checked. */
 		/* This is temporary, we could retry and get another result */
 		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+		need_retry =3D true;
 		break;
 	case 0x07:	/* Ready */
 		sim_stat->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
@@ -378,16 +395,18 @@ static void get_card_status(const struct qmi_uim_slot=
_info *slot,
 =

 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PIN2] =3D info2->pin2_retries;
 	sim_stat->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D info2->puk2_retries;
+
+	return need_retry;
 }
 =

-static bool handle_get_card_status_result(
+static enum get_card_status_result handle_get_card_status_result(
 		struct qmi_result *result, struct sim_status *sim_stat)
 {
 	const void *ptr;
 	const struct qmi_uim_card_status *status;
 	uint16_t len, offset;
 	uint8_t i;
-	bool res =3D false;
+	enum get_card_status_result res =3D GET_CARD_STATUS_RESULT_ERROR;
 =

 	if (qmi_result_set_error(result, NULL))
 		goto done;
@@ -421,8 +440,11 @@ static bool handle_get_card_status_result(
 			index =3D GUINT16_FROM_LE(status->index_gw_pri);
 =

 			if ((index & 0xff) =3D=3D i && (index >> 8) =3D=3D n) {
-				get_card_status(slot, info1, info2, sim_stat);
-				res =3D true;
+				if (get_card_status(slot, info1, info2,
+								sim_stat))
+					res =3D GET_CARD_STATUS_RESULT_TEMP_ERROR;
+				else
+					res =3D GET_CARD_STATUS_RESULT_OK;
 			}
 		}
 	}
@@ -436,16 +458,36 @@ static void query_passwd_state_cb(struct qmi_result *=
result,
 {
 	struct cb_data *cbd =3D user_data;
 	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *data =3D ofono_sim_get_data(sim);
 	struct sim_status sim_stat;
-
-	DBG("");
-
-	if (!handle_get_card_status_result(result, &sim_stat)) {
+	enum get_card_status_result res;
+
+	res =3D handle_get_card_status_result(result, &sim_stat);
+	switch (res) {
+	case GET_CARD_STATUS_RESULT_OK:
+		DBG("passwd state %d", sim_stat.passwd_state);
+		data->retry_count =3D 0;
+		CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
+		break;
+	case GET_CARD_STATUS_RESULT_TEMP_ERROR:
+		data->retry_count++;
+		if (data->retry_count > MAX_RETRY_COUNT) {
+			DBG("Failed after %d attempts", data->retry_count);
+			data->retry_count =3D 0;
+			CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		} else {
+			usleep(20000);
+			DBG("Retry command");
+			qmi_query_passwd_state(sim, cb, cbd->data);
+		}
+		break;
+	case GET_CARD_STATUS_RESULT_ERROR:
+		DBG("Command failed");
+		data->retry_count =3D 0;
 		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
+		break;
 	}
-
-	CALLBACK_WITH_SUCCESS(cb, sim_stat.passwd_state, cbd->data);
 }
 =

 static void qmi_query_passwd_state(struct ofono_sim *sim,
@@ -456,6 +498,8 @@ static void qmi_query_passwd_state(struct ofono_sim *si=
m,
 =

 	DBG("");
 =

+	cbd->user =3D sim;
+
 	if (qmi_service_send(data->uim, QMI_UIM_GET_CARD_STATUS, NULL,
 					query_passwd_state_cb, cbd, g_free) > 0)
 		return;
@@ -473,7 +517,8 @@ static void query_pin_retries_cb(struct qmi_result *res=
ult, void *user_data)
 =

 	DBG("");
 =

-	if (!handle_get_card_status_result(result, &sim_stat)) {
+	if (handle_get_card_status_result(result, &sim_stat) !=3D
+					GET_CARD_STATUS_RESULT_OK) {
 		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 		return;
 	}
@@ -570,7 +615,8 @@ static void get_card_status_cb(struct qmi_result *resul=
t, void *user_data)
 =

 	DBG("");
 =

-	if (!handle_get_card_status_result(result, &sim_stat)) {
+	if (handle_get_card_status_result(result, &sim_stat) !=3D
+					GET_CARD_STATUS_RESULT_OK) {
 		data->app_type =3D 0;	/* Unknown */
 		sim_stat.card_state =3D 0x00;	/* Absent */
 	} else {
-- =

2.11.0


--===============5615523132512023006==--

