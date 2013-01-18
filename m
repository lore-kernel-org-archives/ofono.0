Content-Type: multipart/mixed; boundary="===============4464352396326333019=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH 2/2] qmimodem: implement send_passwd
Date: Fri, 18 Jan 2013 09:51:09 +0100
Message-ID: <1358499069-13103-2-git-send-email-cedric.jehasse@gmail.com>
In-Reply-To: <1358499069-13103-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4464352396326333019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

---
 drivers/qmimodem/sim.c |  155 +++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 139 insertions(+), 16 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 197da50..e05aac8 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -45,6 +45,8 @@ struct sim_data {
 	uint8_t app_type;
 	uint8_t passwd_state;
 	int retries[OFONO_SIM_PASSWORD_INVALID];
+	struct cb_data *pin_cbd;
+	guint pin_timeout;
 };
 =

 static int create_fileid_data(uint8_t app_type, int fileid,
@@ -355,25 +357,12 @@ static void card_setup(const struct qmi_uim_slot_info=
 *slot,
 	data->retries[OFONO_SIM_PASSWORD_SIM_PUK2] =3D info2->puk2_retries;
 }
 =

-static void get_card_status_cb(struct qmi_result *result, void *user_data)
+static void handle_card_status(struct sim_data *data, const void *ptr)
 {
-	struct ofono_sim *sim =3D user_data;
-	struct sim_data *data =3D ofono_sim_get_data(sim);
-	const void *ptr;
-	const struct qmi_uim_card_status *status;
-	uint16_t len, offset;
+	const struct qmi_uim_card_status *status =3D ptr;
+	uint16_t offset;
 	uint8_t i;
 =

-	DBG("");
-
-	if (qmi_result_set_error(result, NULL))
-		goto done;
-
-	ptr =3D qmi_result_get(result, QMI_UIM_RESULT_CARD_STATUS, &len);
-	if (!ptr)
-		goto done;
-
-	status =3D ptr;
 	offset =3D sizeof(struct qmi_uim_card_status);
 =

 	for (i =3D 0; i < status->num_slot; i++) {
@@ -401,6 +390,25 @@ static void get_card_status_cb(struct qmi_result *resu=
lt, void *user_data)
 				card_setup(slot, info1, info2, data);
 		}
 	}
+}
+
+static void get_card_status_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	const void *ptr;
+	uint16_t len;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto done;
+
+	ptr =3D qmi_result_get(result, QMI_UIM_RESULT_CARD_STATUS, &len);
+	if (!ptr)
+		goto done;
+
+	handle_card_status(data, ptr);
 =

 done:
 	ofono_sim_register(sim);
@@ -415,6 +423,33 @@ done:
 	}
 }
 =

+static void card_status_ind(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	const void *ptr;
+	uint16_t len;
+
+	DBG("");
+
+	ptr =3D qmi_result_get(result, QMI_UIM_RESULT_CARD_STATUS, &len);
+	if (!ptr)
+		return;
+
+	handle_card_status(data, ptr);
+
+	if (data->passwd_state =3D=3D OFONO_SIM_PASSWORD_NONE && data->pin_cbd) {
+		/*send_passwd pending*/
+		struct cb_data *cbd =3D data->pin_cbd;
+		ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+		g_source_remove(data->pin_timeout);
+		data->pin_cbd =3D NULL;
+		data->pin_timeout =3D 0;
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		g_free(cbd);
+	}
+}
+
 static void event_registration_cb(struct qmi_result *result, void *user_da=
ta)
 {
 	struct ofono_sim *sim =3D user_data;
@@ -455,6 +490,8 @@ static void create_uim_cb(struct qmi_service *service, =
void *user_data)
 	}
 =

 	data->uim =3D qmi_service_ref(service);
+	qmi_service_register(data->uim, QMI_UIM_CARD_STATUS_IND,
+					card_status_ind, sim, NULL);
 =

 	param =3D qmi_param_new_uint32(QMI_UIM_PARAM_EVENT_MASK, mask);
 	if (!param)
@@ -508,6 +545,91 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 	g_free(data);
 }
 =

+static gboolean send_passwd_timeout(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(cbd->user);
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	data->pin_cbd =3D cbd;
+	data->pin_timeout =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	g_free(cbd);
+
+	return FALSE;
+}
+
+static void send_passwd_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(cbd->user);
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto error;
+
+	/* wait for CARD_STATUS_IND */
+	if (data->passwd_state =3D=3D OFONO_SIM_PASSWORD_NONE) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	} else {
+		data->pin_cbd =3D cbd;
+		data->pin_timeout =3D g_timeout_add_seconds(10, send_passwd_timeout,
+					user_data);
+	}
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	g_free(cbd);
+}
+
+static void qmi_send_passwd(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *user_data)
+{
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct qmi_param *param;
+	int len;
+	unsigned char passwd_data[16];
+	unsigned char aid_data[2] =3D { 0x06, 0x00 };
+
+	DBG("");
+
+	len =3D strlen(passwd);
+	if ((len - 3) > sizeof(passwd_data))
+		goto error;
+
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	passwd_data[0] =3D 0x01;
+	passwd_data[1] =3D len;
+	memcpy(&passwd_data[2], passwd, len);
+
+	qmi_param_append(param, 0x01, sizeof(aid_data), aid_data);
+	qmi_param_append(param, 0x02, len + 2, passwd_data);
+
+	cbd->user =3D sim;
+
+	if (qmi_service_send(data->uim, QMI_UIM_VERIFY_PIN, param,
+					send_passwd_cb, cbd, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, user_data);
+
+	g_free(cbd);
+}
+
 static struct ofono_sim_driver driver =3D {
 	.name			=3D "qmimodem",
 	.probe			=3D qmi_sim_probe,
@@ -518,6 +640,7 @@ static struct ofono_sim_driver driver =3D {
 	.read_file_cyclic	=3D qmi_read_record,
 	.query_passwd_state	=3D qmi_query_passwd_state,
 	.query_pin_retries	=3D qmi_query_pin_retries,
+	.send_passwd		=3D qmi_send_passwd,
 };
 =

 void qmi_sim_init(void)
-- =

1.7.9.5


--===============4464352396326333019==--

