Content-Type: multipart/mixed; boundary="===============9196857614244925596=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC sim-ready-v0 PATCH 3/3] isimodem/sim: added PIN and SIM state
 handling
Date: Tue, 05 Oct 2010 19:04:21 +0300
Message-ID: <1286294661-24300-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286294661-24300-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9196857614244925596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jukka Saunamaki <jukka.saunamaki@nokia.com>

Using ofono_sim_ready_notify().
---
 drivers/isimodem/debug.c |   30 +++
 drivers/isimodem/debug.h |    3 +
 drivers/isimodem/sim.c   |  558 ++++++++++++++++++++++++++++++++++++++++++=
+---
 drivers/isimodem/sim.h   |   50 ++++-
 4 files changed, 605 insertions(+), 36 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index d226c51..f9ae6fe 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -48,6 +48,7 @@ const char *pn_resource_name(int value)
 		_(PN_CALL);
 		_(PN_SMS);
 		_(PN_SIM);
+		_(PN_SECURITY);
 		_(PN_MTC);
 		_(PN_GSS);
 		_(PN_GPDS);
@@ -377,18 +378,41 @@ const char *sim_message_id_name(enum sim_message_id v=
alue)
 		_(SIM_IMSI_RESP_READ_IMSI);
 		_(SIM_SERV_PROV_NAME_REQ);
 		_(SIM_SERV_PROV_NAME_RESP);
+		_(SIM_DYNAMIC_FLAGS_REQ);
+		_(SIM_DYNAMIC_FLAGS_RESP);
 		_(SIM_READ_FIELD_REQ);
 		_(SIM_READ_FIELD_RESP);
 		_(SIM_SMS_REQ);
 		_(SIM_SMS_RESP);
+		_(SIM_STATUS_REQ);
+		_(SIM_STATUS_RESP);
 		_(SIM_PB_REQ_SIM_PB_READ);
 		_(SIM_PB_RESP_SIM_PB_READ);
+		_(SIM_SERVER_READY_IND);
 		_(SIM_IND);
 		_(SIM_COMMON_MESSAGE);
 	}
 	return "SIM_<UNKNOWN>";
 }
 =

+const char *sec_message_id_name(enum sec_message_id value)
+{
+	switch (value) {
+		_(SEC_CODE_STATE_REQ);
+		_(SEC_CODE_STATE_OK_RESP);
+		_(SEC_CODE_STATE_FAIL_RESP);
+		_(SEC_CODE_CHANGE_REQ);
+		_(SEC_CODE_CHANGE_OK_RESP);
+		_(SEC_CODE_CHANGE_FAIL_RESP);
+		_(SEC_CODE_VERIFY_REQ);
+		_(SEC_CODE_VERIFY_OK_RESP);
+		_(SEC_CODE_VERIFY_FAIL_RESP);
+		_(SEC_STATE_REQ);
+		_(SEC_STATE_RESP);
+	}
+	return "SEC_<UNKNOWN>";
+}
+
 const char *sim_subblock_name(enum sim_subblock value)
 {
 	switch (value) {
@@ -1069,6 +1093,12 @@ void sim_debug(const void *restrict buf, size_t len,=
 void *data)
 	hex_dump(sim_message_id_name(m[0]), m, len);
 }
 =

+void sec_debug(const void *restrict buf, size_t len, void *data)
+{
+	const uint8_t *m =3D buf;
+	hex_dump(sec_message_id_name(m[0]), m, len);
+}
+
 void info_debug(const void *restrict buf, size_t len, void *data)
 {
 	const uint8_t *m =3D buf;
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index f03f4ec..f0b34ae 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -49,6 +49,8 @@ const char *sim_isi_cause_name(enum sim_isi_cause value);
 const char *sim_message_id_name(enum sim_message_id value);
 const char *sim_subblock_name(enum sim_subblock value);
 =

+const char *sec_message_id_name(enum sec_message_id value);
+
 const char *info_isi_cause_name(enum info_isi_cause value);
 const char *info_message_id_name(enum info_message_id value);
 const char *info_subblock_name(enum info_subblock value);
@@ -78,6 +80,7 @@ void ss_debug(const void *restrict buf, size_t len, void =
*data);
 void mtc_debug(const void *restrict buf, size_t len, void *data);
 void sms_debug(const void *restrict buf, size_t len, void *data);
 void sim_debug(const void *restrict buf, size_t len, void *data);
+void sec_debug(const void *restrict buf, size_t len, void *data);
 void info_debug(const void *restrict buf, size_t len, void *data);
 void call_debug(const void *restrict buf, size_t len, void *data);
 void net_debug(const void *restrict buf, size_t len, void *data);
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index e2ea275..833cbee 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -45,7 +45,9 @@
 =

 struct sim_data {
 	GIsiClient *client;
-	gboolean registered;
+	GIsiClient *sec_client;
+	enum ofono_sim_password_type passwd_state;
+	gboolean ready;
 };
 =

 struct file_info {
@@ -319,6 +321,7 @@ static gboolean imsi_resp_cb(GIsiClient *client,
 	goto out;
 =

 error:
+	DBG("IMSI error");
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 =

 out:
@@ -335,12 +338,12 @@ static void isi_read_imsi(struct ofono_sim *sim,
 		SIM_IMSI_REQ_READ_IMSI,
 		READ_IMSI
 	};
+	DBG("");
 =

 	if (!cbd)
 		goto error;
 =

-	if (g_isi_request_make(sd->client, msg, sizeof(msg),
-				SIM_TIMEOUT,
+	if (g_isi_request_make(sd->client, msg, sizeof(msg), SIM_TIMEOUT,
 				imsi_resp_cb, cbd))
 		return;
 =

@@ -349,50 +352,325 @@ error:
 	g_free(cbd);
 }
 =

-static void isi_sim_register(struct ofono_sim *sim)
+static void isi_query_passwd_state(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	enum ofono_sim_password_type passwd_state =3D sd->passwd_state;
 =

-	if (!sd->registered) {
-		sd->registered =3D TRUE;
-		ofono_sim_register(sim);
-		ofono_sim_inserted_notify(sim, TRUE);
+	DBG("passwd_state %u", passwd_state);
+
+	if (passwd_state =3D=3D OFONO_SIM_PASSWORD_INVALID) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		return;
 	}
+
+	if (!sd->ready && passwd_state =3D=3D OFONO_SIM_PASSWORD_NONE)
+		passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+
+	CALLBACK_WITH_SUCCESS(cb, sd->passwd_state, data);
 }
 =

-static gboolean read_hplmn_resp_cb(GIsiClient *client,
+static gboolean sec_code_verify_resp(GIsiClient *client,
 					const void *restrict data, size_t len,
 					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
-	struct ofono_sim *sim =3D opaque;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		return TRUE;
+	DBG("");
+
+	if (len >=3D 1 && msg[0] =3D=3D SEC_CODE_VERIFY_OK_RESP) {
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto done;
 	}
 =

-	if (len < 3 || msg[0] !=3D SIM_NETWORK_INFO_RESP || msg[1] !=3D READ_HPLM=
N)
-		return FALSE;
+	if (len >=3D 2 && msg[0] =3D=3D SEC_CODE_VERIFY_FAIL_RESP &&
+			msg[1] =3D=3D SEC_CAUSE_CODE_BLOCKED)
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
 =

-	if (msg[2] !=3D SIM_SERV_NOTREADY)
-		isi_sim_register(sim);
+	DBG("verify failure %s", !msg ? "(timeout)" : "");
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+done:
+	g_free(cbd);
 =

 	return TRUE;
 }
 =

+static void isi_send_passwd(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	unsigned char msg[2 + SEC_CODE_MAX_LENGTH + 1] =3D {
+		SEC_CODE_VERIFY_REQ,
+		SEC_CODE_PIN,
+	};
+	int len =3D 2 + strlen(passwd) + 1;
+
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	strcpy((char *)msg + 2, passwd);
 =

-static void isi_read_hplmn(struct ofono_sim *sim)
+	if (g_isi_request_make(sd->sec_client, msg, len, SIM_TIMEOUT,
+				sec_code_verify_resp, cbd))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_reset_passwd(struct ofono_sim *sim,
+				const char *puk, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	enum ofono_sim_password_type passwd_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
+	unsigned char msg[2 + 2 * (SEC_CODE_MAX_LENGTH + 1)] =3D {
+		SEC_CODE_VERIFY_REQ,
+	};
 =

-	const unsigned char req[] =3D {
-		SIM_NETWORK_INFO_REQ,
-		READ_HPLMN, 0
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		msg[1] =3D SEC_CODE_PIN;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		msg[1] =3D SEC_CODE_PIN2;
+	else
+		goto error;
+
+	strcpy((char *)&msg[2], puk);
+	strcpy((char *)&msg[2 + SEC_CODE_MAX_LENGTH + 1], passwd);
+
+	if (g_isi_request_make(sd->sec_client, msg, sizeof(msg), SIM_TIMEOUT,
+				sec_code_verify_resp, cbd))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+/* ISI callback: Enable/disable PIN */
+static gboolean pin_enable_resp_cb(GIsiClient *client,
+				const void *restrict data,
+				size_t len, uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (len < 1 || msg[0] !=3D SEC_CODE_STATE_OK_RESP)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+	else
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	g_free(cbd);
+
+	return TRUE;
+}
+
+static void isi_lock(struct ofono_sim *sim,
+		enum ofono_sim_password_type passwd_type,
+		int enable, const char *passwd,
+		ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	unsigned char msg[3 + SEC_CODE_MAX_LENGTH + 1] =3D {
+		SEC_CODE_STATE_REQ,
 	};
 =

-	g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
-				read_hplmn_resp_cb, sim);
+	if (!cbd)
+		goto error;
+
+	DBG("enable %d pintype %d pass %s", enable, passwd_type, passwd);
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		msg[1] =3D SEC_CODE_PIN;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		msg[1] =3D SEC_CODE_PIN2;
+	else
+		goto error;
+
+	if (enable)
+		msg[2] =3D SEC_CODE_ENABLE;
+	else
+		msg[2] =3D SEC_CODE_DISABLE;
+
+	strcpy((char *)&msg[3], passwd);
+
+	if (g_isi_request_make(sd->sec_client, msg, sizeof(msg),
+				SIM_TIMEOUT, pin_enable_resp_cb, cbd))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+
+/* ISI callback: PIN state (enabled/disabled) query */
+static gboolean sec_code_change_resp(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+
+	if (len < 1)
+		goto failure;
+
+	if (msg[0] !=3D SEC_CODE_CHANGE_OK_RESP) {
+		if (msg[0] =3D=3D SEC_CODE_CHANGE_FAIL_RESP && len >=3D 2)
+			DBG("SEC_CODE_CHANGE_FAIL_RESP(cause=3D%02x)", msg[1]);
+		goto failure;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	goto done;
+
+failure:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+done:
+	g_free(cbd);
+
+	return TRUE;
+}
+
+
+static void isi_change_passwd(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old, const char *new,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	unsigned char msg[2 + 2 * (SEC_CODE_MAX_LENGTH + 1)] =3D {
+		SEC_CODE_CHANGE_REQ,
+	};
+
+	DBG("passwd_type %d", passwd_type);
+
+	if (!cbd)
+		goto error;
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		msg[1] =3D SEC_CODE_PIN;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		msg[1] =3D SEC_CODE_PIN2;
+	else
+		goto error;
+
+	strcpy((char *)&msg[2], old);
+	strcpy((char *)&msg[2 + SEC_CODE_MAX_LENGTH + 1], new);
+
+	if (g_isi_request_make(sd->sec_client, msg, sizeof(msg),
+				SIM_TIMEOUT, sec_code_change_resp, cbd))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+/* ISI callback: PIN state (enabled/disabled) query */
+static gboolean sec_code_state_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_locked_cb_t cb =3D cbd->cb;
+	int locked;
+
+	if (msg =3D=3D NULL || len < 4)
+		goto failure;
+
+	if (msg[0] !=3D SEC_CODE_STATE_OK_RESP)
+		goto failure;
+
+	DBG("sec state: %02x", msg[1]);
+
+	if (msg[1] =3D=3D SEC_CODE_ENABLE)
+		locked =3D 1;
+	else if (msg[1] =3D=3D SEC_CODE_DISABLE)
+		locked =3D 0;
+	else
+		goto failure;
+
+	CALLBACK_WITH_SUCCESS(cb, locked, cbd->data);
+
+	goto done;
+
+failure:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+done:
+	g_free(cbd);
+
+	return TRUE;
+}
+
+static void isi_query_locked(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_locked_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	unsigned char msg[] =3D {
+		SEC_CODE_STATE_REQ,
+		0,
+		SEC_CODE_STATE_QUERY
+	};
+
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		msg[1] =3D SEC_CODE_PIN;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		msg[1] =3D SEC_CODE_PIN2;
+	else
+		goto error;
+
+	if (g_isi_request_make(sd->sec_client, msg, sizeof(msg),
+				SIM_TIMEOUT, sec_code_state_resp_cb, cbd))
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

 static void sim_ind_cb(GIsiClient *client,
@@ -403,19 +681,200 @@ static void sim_ind_cb(GIsiClient *client,
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	const unsigned char *msg =3D data;
 =

-	if (sd->registered)
+	uint8_t servicetype;
+	uint8_t status;
+	uint8_t state;
+	uint8_t cause;
+
+	DBG("");
+	if (!msg || len < 5 ||
+		(msg[0] !=3D SIM_IND && msg[0] !=3D SIM_SERVER_READY_IND))
 		return;
 =

+	servicetype =3D msg[1];
+	status =3D msg[2];
+	state =3D msg[3];
+	cause =3D msg[4];
+
+	if (servicetype =3D=3D SIM_ST_PIN &&
+		status =3D=3D SIM_SERV_PIN_VERIFY_REQUIRED) {
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		sd->ready =3D FALSE;
+		ofono_sim_inserted_notify(sim, TRUE);
+	} else if (status =3D=3D SIM_SERV_SIM_BLOCKED) {
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		sd->ready =3D FALSE;
+		ofono_sim_inserted_notify(sim, TRUE);
+	} else if (servicetype =3D=3D SIM_ST_INFO &&
+		status =3D=3D SIM_SERV_INIT_OK) {
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+		ofono_sim_inserted_notify(sim, TRUE);
+	} else if (status =3D=3D SIM_SERV_SIM_DISCONNECTED) {
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+		sd->ready =3D FALSE;
+		ofono_sim_inserted_notify(sim, FALSE);
+	}
+}
+
+static void sim_server_ready_ind_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	const unsigned char *msg =3D data;
+
+	DBG("");
+
+	if (!msg || len < 5 || msg[0] !=3D SIM_SERVER_READY_IND)
+		return;
+
+	sd->ready =3D TRUE;
+
+	ofono_sim_ready_notify(sim);
+}
+
+static gboolean isi_sim_read_dyn_flags_resp(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (!msg)
+		return TRUE;
+
+	if (len < 2 || msg[0] !=3D SIM_DYNAMIC_FLAGS_RESP)
+		return FALSE;
+
+	if (msg[1] !=3D READ_DYN_FLAGS || msg[2] =3D=3D SIM_SERV_NOTREADY)
+		return TRUE;
+
+	sd->ready =3D TRUE;
+
+	ofono_sim_ready_notify(sim);
+
+	return TRUE;
+}
+
+static void isi_sim_read_dyn_flags_req(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	unsigned char req[] =3D {
+		SIM_DYNAMIC_FLAGS_REQ,
+		READ_DYN_FLAGS,
+		0
+	};
+
+	g_isi_send(sd->client, req, sizeof(req), SIM_TIMEOUT,
+			isi_sim_read_dyn_flags_resp, sim, NULL);
+}
+
+static gboolean sec_state_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	ofono_bool_t inserted =3D FALSE;
+
+	DBG("");
+
+	if (!msg) {
+		DBG("ISI client error: %d", g_isi_client_error(client));
+		return TRUE;
+	}
+	if (len < 2 || msg[0] !=3D SEC_STATE_RESP)
+		return FALSE;
+
+	if (!sd)
+		return TRUE;
+
 	switch (msg[1]) {
-	case SIM_ST_PIN:
-		isi_sim_register(sim);
+	case SEC_STARTUP_OK:
+		DBG("SEC_STARTUP_OK");
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+		inserted =3D TRUE;
+		/* Check if SIM server is already ready */
+		isi_sim_read_dyn_flags_req(sim);
+		break;
+	case SEC_CAUSE_PIN_REQUIRED:
+		DBG("SEC_CAUSE_PIN_REQUIRED");
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		inserted =3D TRUE;
+		break;
+	case SEC_CAUSE_PUK_REQUIRED:
+		DBG("SEC_CAUSE_PUK_REQUIRED");
+		sd->passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		inserted =3D TRUE;
 		break;
-	case SIM_ST_INFO:
-		isi_read_hplmn(sim);
+	case SEC_CAUSE_NO_SIM:
+		DBG("SEC_CAUSE_NO_SIM");
+		break;
+	case SEC_CAUSE_INVALID_SIM:
+		DBG("SEC_CAUSE_INVALID_SIM");
+		break;
+	case SEC_CAUSE_SIM_REJECTED:
+		DBG("SEC_CAUSE_SIM_REJECTED");
+		break;
+	default:
 		break;
 	}
+
+	ofono_sim_inserted_notify(sim, inserted);
+
+	return TRUE;
+}
+
+static void isi_sec_state_req(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	unsigned char req[] =3D {
+		SEC_STATE_REQ,
+		0,
+		0
+	};
+
+	g_isi_request_make(sd->sec_client, req, sizeof(req), SIM_TIMEOUT,
+			sec_state_resp_cb, sim);
+}
+
+static gboolean sim_status_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
+{
+	const unsigned char *msg =3D data;
+	struct ofono_sim *sim =3D opaque;
+
+	if (!msg || len < 3)
+		return TRUE;
+
+	if (msg[0] =3D=3D SIM_STATUS_RESP && msg[1] =3D=3D SIM_ST_CARD_STATUS &&
+			msg[2] !=3D SIM_SERV_SIM_DISCONNECTED)
+		/* We probably have a SIM. Now get PIN/PUK status  */
+		isi_sec_state_req(sim); /* Try Sec-server first */
+
+	return TRUE;
 }
 =

+static void isi_sim_status_req(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	const unsigned char req[] =3D {
+		SIM_STATUS_REQ,
+		SIM_ST_CARD_STATUS
+	};
+
+	g_isi_request_make(sd->client, req, sizeof(req), SIM_TIMEOUT,
+			sim_status_resp_cb, sim);
+}
+
+
 static void sim_reachable_cb(GIsiClient *client, gboolean alive,
 				uint16_t object, void *opaque)
 {
@@ -433,9 +892,13 @@ static void sim_reachable_cb(GIsiClient *client, gbool=
ean alive,
 		g_isi_version_minor(client));
 =

 	g_isi_subscribe(client, SIM_IND, sim_ind_cb, opaque);
+	g_isi_subscribe(client, SIM_SERVER_READY_IND,
+			sim_server_ready_ind_cb, opaque);
 =

-	/* Check if SIM is ready. */
-	isi_read_hplmn(sim);
+	ofono_sim_register(sim);
+
+	/* Check if we have a SIM */
+	isi_sim_status_req(sim);
 }
 =

 static int isi_sim_probe(struct ofono_sim *sim, unsigned int vendor,
@@ -443,23 +906,41 @@ static int isi_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 {
 	GIsiModem *idx =3D user;
 	struct sim_data *sd =3D g_try_new0(struct sim_data, 1);
+	GIsiClient *client =3D NULL;
+	GIsiClient *sec_client =3D NULL;
 	const char *debug =3D getenv("OFONO_ISI_DEBUG");
 =

 	if (!sd)
-		return -ENOMEM;
+		goto error;
 =

-	sd->client =3D g_isi_client_create(idx, PN_SIM);
-	if (!sd->client)
-		return -ENOMEM;
+	client =3D g_isi_client_create(idx, PN_SIM);
+	if (!client)
+		goto error;
+
+	sec_client =3D g_isi_client_create(idx, PN_SECURITY);
+	if (!sec_client)
+		goto error;
+
+	sd->client =3D client;
+	sd->sec_client =3D sec_client;
+	sd->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
 =

 	ofono_sim_set_data(sim, sd);
 =

-	if (debug && (strcmp(debug, "all") =3D=3D 0 || strcmp(debug, "sim") =3D=
=3D 0))
+	if (debug && (!strcmp(debug, "all") || !strcmp(debug, "sim"))) {
 		g_isi_client_set_debug(sd->client, sim_debug, NULL);
+		g_isi_client_set_debug(sd->sec_client, sec_debug, NULL);
+	}
 =

 	g_isi_verify(sd->client, sim_reachable_cb, sim);
 =

 	return 0;
+
+error:
+	g_isi_client_destroy(client);
+	g_isi_client_destroy(sec_client);
+
+	return -ENOMEM;
 }
 =

 static void isi_sim_remove(struct ofono_sim *sim)
@@ -471,6 +952,7 @@ static void isi_sim_remove(struct ofono_sim *sim)
 =

 	ofono_sim_set_data(sim, NULL);
 	g_isi_client_destroy(data->client);
+	g_isi_client_destroy(data->sec_client);
 	g_free(data);
 }
 =

@@ -486,6 +968,12 @@ static struct ofono_sim_driver driver =3D {
 	.write_file_linear	=3D isi_write_file_linear,
 	.write_file_cyclic	=3D isi_write_file_cyclic,
 	.read_imsi		=3D isi_read_imsi,
+	.query_passwd_state	=3D isi_query_passwd_state,
+	.send_passwd		=3D isi_send_passwd,
+	.reset_passwd		=3D isi_reset_passwd,
+	.lock			=3D isi_lock,
+	.change_passwd		=3D isi_change_passwd,
+	.query_locked		=3D isi_query_locked,
 };
 =

 void isi_sim_init()
diff --git a/drivers/isimodem/sim.h b/drivers/isimodem/sim.h
index e1450b7..a47835a 100644
--- a/drivers/isimodem/sim.h
+++ b/drivers/isimodem/sim.h
@@ -27,9 +27,12 @@ extern "C" {
 #endif
 =

 #define PN_SIM			0x09
+#define PN_SECURITY             0x08
 #define SIM_TIMEOUT		5
 #define SIM_MAX_IMSI_LENGTH	15
 =

+#define SEC_CODE_MAX_LENGTH	0x0A
+
 enum sim_isi_cause {
 	SIM_SERV_NOT_AVAIL =3D 0x00,
 	SIM_SERV_OK =3D 0x01,
@@ -131,29 +134,74 @@ enum sim_message_id {
 	SIM_IMSI_RESP_READ_IMSI =3D 0x1E,
 	SIM_SERV_PROV_NAME_REQ =3D 0x21,
 	SIM_SERV_PROV_NAME_RESP =3D 0x22,
+	SIM_DYNAMIC_FLAGS_REQ =3D 0x29,
+	SIM_DYNAMIC_FLAGS_RESP =3D 0x2A,
 	SIM_READ_FIELD_REQ =3D 0xBA,
 	SIM_READ_FIELD_RESP =3D 0xBB,
 	SIM_SMS_REQ =3D 0xBC,
 	SIM_SMS_RESP =3D 0xBD,
+	SIM_STATUS_REQ =3D 0xC0,
+	SIM_STATUS_RESP =3D 0xC1,
 	SIM_PB_REQ_SIM_PB_READ =3D 0xDC,
 	SIM_PB_RESP_SIM_PB_READ =3D 0xDD,
+	SIM_SERVER_READY_IND =3D 0xED,
 	SIM_IND =3D 0xEF,
 	SIM_COMMON_MESSAGE =3D 0xF0
 };
 =

 enum sim_service_type {
+	SIM_ST_CARD_STATUS =3D 0x00,
 	SIM_ST_PIN =3D 0x01,
 	SIM_ST_ALL_SERVICES =3D 0x05,
 	SIM_ST_INFO =3D 0x0D,
-	SIM_ST_READ_SERV_PROV_NAME =3D 0x2C,
 	SIM_PB_READ =3D 0x0F,
+	SIM_ST_READ_SERV_PROV_NAME =3D 0x2C,
 	READ_IMSI =3D 0x2D,
 	READ_HPLMN =3D 0x2F,
+	READ_DYN_FLAGS =3D 0x35,
 	READ_PARAMETER =3D 0x52,
 	UPDATE_PARAMETER =3D 0x53,
 	ICC =3D 0x66,
 };
 =

+enum sec_message_id {
+	SEC_CODE_STATE_REQ =3D 0x01,
+	SEC_CODE_STATE_OK_RESP =3D 0x02,
+	SEC_CODE_STATE_FAIL_RESP =3D 0x03,
+	SEC_CODE_CHANGE_REQ =3D 0x04,
+	SEC_CODE_CHANGE_OK_RESP =3D 0x05,
+	SEC_CODE_CHANGE_FAIL_RESP =3D 0x06,
+	SEC_CODE_VERIFY_REQ =3D 0x07,
+	SEC_CODE_VERIFY_OK_RESP =3D 0x08,
+	SEC_CODE_VERIFY_FAIL_RESP =3D 0x09,
+	SEC_STATE_REQ =3D 0x11,
+	SEC_STATE_RESP =3D 0x12,
+};
+
+enum sec_code_id_info {
+	SEC_CODE_PIN =3D 0x02,
+	SEC_CODE_PUK =3D 0x03,
+	SEC_CODE_PIN2 =3D 0x04,
+	SEC_CODE_PUK2 =3D 0x05,
+};
+
+enum sec_code_state_info {
+	SEC_CODE_DISABLE =3D 0x00,
+	SEC_CODE_ENABLE =3D 0x01,
+	SEC_CODE_STATE_QUERY =3D 0x04,
+};
+
+enum sec_state_cause_info {
+	SEC_CAUSE_PIN_REQUIRED =3D 0x02,
+	SEC_CAUSE_PUK_REQUIRED =3D 0x03,
+	SEC_STARTUP_OK =3D 0x05,
+	SEC_STARTUP_ONGOING =3D 0x07,
+	SEC_CAUSE_CODE_BLOCKED =3D 0x08,
+	SEC_CAUSE_NO_SIM =3D 0x16,
+	SEC_CAUSE_SIM_REJECTED =3D 0x1A,
+	SEC_CAUSE_INVALID_SIM =3D 0x1E,
+};
+
 #ifdef __cplusplus
 };
 #endif
-- =

1.7.0.4


--===============9196857614244925596==--

