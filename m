Content-Type: multipart/mixed; boundary="===============3136023547399162471=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/4] qmimodem: add pin_send feature
Date: Tue, 10 Jan 2017 09:38:45 +0100
Message-ID: <20170110083847.28309-3-c.ronco@kerlink.fr>
In-Reply-To: <20170110083847.28309-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3136023547399162471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ability to send PIN to a QMI modem using QMI_UIM_VERIFY_PIN command.
This has been tested on MC7304 and MC7430 modems.
---
 drivers/qmimodem/sim.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/uim.h | 11 +++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index c4c79afe..ec5cc3e6 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -496,6 +496,70 @@ static void qmi_query_pin_retries(struct ofono_sim *si=
m,
 	g_free(cbd);
 }
 =

+static void pin_send_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qmi_pin_send(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *user_data)
+{
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	int passwd_len;
+	struct qmi_param *param;
+	struct qmi_uim_param_message_info *info_data;
+	unsigned char session_info_data[2];
+
+	DBG("");
+
+	if (!passwd)
+		goto error;
+
+	passwd_len =3D strlen(passwd);
+
+	if (passwd_len <=3D 0 || passwd_len > 0xFF)
+		goto error;
+
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	/* param info */
+	info_data =3D alloca(2 + passwd_len);
+	info_data->pin_id =3D 0x01; /* PIN 1 */
+	info_data->length =3D (uint8_t) passwd_len;
+	memcpy(info_data->pin_value, passwd, passwd_len);
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_INFO, 2 + passwd_len,
+					info_data);
+	/* param Session Information */
+	session_info_data[0] =3D 0x6;
+	session_info_data[1] =3D 0x0;
+	qmi_param_append(param, QMI_UIM_PARAM_MESSAGE_SESSION_INFO, 2,
+					session_info_data);
+
+	if (qmi_service_send(data->uim, QMI_UIM_VERIFY_PIN, param,
+					pin_send_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
 static void get_card_status_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sim *sim =3D user_data;
@@ -646,6 +710,7 @@ static struct ofono_sim_driver driver =3D {
 	.read_imsi		=3D qmi_read_imsi,
 	.query_passwd_state	=3D qmi_query_passwd_state,
 	.query_pin_retries	=3D qmi_query_pin_retries,
+	.send_passwd		=3D qmi_pin_send,
 };
 =

 void qmi_sim_init(void)
diff --git a/drivers/qmimodem/uim.h b/drivers/qmimodem/uim.h
index 8f123e7d..cd10e684 100644
--- a/drivers/qmimodem/uim.h
+++ b/drivers/qmimodem/uim.h
@@ -25,6 +25,8 @@
 #define QMI_UIM_WRITE_RECORD		35	/* Write a record */
 #define QMI_UIM_GET_FILE_ATTRIBUTES	36	/* Get file attributes */
 =

+#define QMI_UIM_VERIFY_PIN		38	/* Verify PIN */
+
 #define QMI_UIM_EVENT_REGISTRATION	46	/* Register for indications */
 #define QMI_UIM_GET_CARD_STATUS		47	/* Get card status */
 =

@@ -91,3 +93,12 @@ struct qmi_uim_file_attributes {
 	uint16_t raw_len;
 	uint8_t raw_value[0];
 } __attribute__((__packed__));
+
+/* Verify PIN parameter */
+#define QMI_UIM_PARAM_MESSAGE_SESSION_INFO	0x01
+#define QMI_UIM_PARAM_MESSAGE_INFO	0x02
+struct qmi_uim_param_message_info {
+	uint8_t pin_id;
+	uint8_t length;
+	uint8_t pin_value[0];
+} __attribute__((__packed__));
-- =

2.11.0


--===============3136023547399162471==--

