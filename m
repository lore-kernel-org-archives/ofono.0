Content-Type: multipart/mixed; boundary="===============0830955963449394807=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-nofify-v5 PATCH 3/3] isimodem/sim: added PIN and SIM state
 handling
Date: Tue, 08 Feb 2011 14:32:59 +0200
Message-ID: <1297168379-16400-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1297168379-16400-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0830955963449394807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Using PN_SECURITY resource to obtain PIN statuses.

Using ofono_sim_ready_notify() to report the ready state.
---
 drivers/isimodem/debug.c |   59 +++++
 drivers/isimodem/debug.h |    6 +
 drivers/isimodem/sim.c   |  574 ++++++++++++++++++++++++++++++++++++++++--=
---
 drivers/isimodem/sim.h   |   50 ++++-
 4 files changed, 624 insertions(+), 65 deletions(-)

diff --git a/drivers/isimodem/debug.c b/drivers/isimodem/debug.c
index 3d667b4..e641ba4 100644
--- a/drivers/isimodem/debug.c
+++ b/drivers/isimodem/debug.c
@@ -34,6 +34,8 @@
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
 =

 #include "debug.h"
 =

@@ -48,6 +50,7 @@ const char *pn_resource_name(int value)
 		_(PN_CALL);
 		_(PN_SMS);
 		_(PN_SIM);
+		_(PN_SECURITY);
 		_(PN_MTC);
 		_(PN_GSS);
 		_(PN_GPDS);
@@ -379,18 +382,72 @@ const char *sim_message_id_name(enum sim_message_id v=
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
+
 	return "SIM_<UNKNOWN>";
 }
 =

+const char *sim_password_name(enum ofono_sim_password_type type)
+{
+	static const char *const passwd_name[] =3D {
+		[OFONO_SIM_PASSWORD_NONE] =3D "none",
+		[OFONO_SIM_PASSWORD_SIM_PIN] =3D "pin",
+		[OFONO_SIM_PASSWORD_SIM_PUK] =3D "puk",
+		[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D "phone",
+		[OFONO_SIM_PASSWORD_PHFSIM_PIN] =3D "firstphone",
+		[OFONO_SIM_PASSWORD_PHFSIM_PUK] =3D "firstphonepuk",
+		[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "pin2",
+		[OFONO_SIM_PASSWORD_SIM_PUK2] =3D "puk2",
+		[OFONO_SIM_PASSWORD_PHNET_PIN] =3D "network",
+		[OFONO_SIM_PASSWORD_PHNET_PUK] =3D "networkpuk",
+		[OFONO_SIM_PASSWORD_PHNETSUB_PIN] =3D "netsub",
+		[OFONO_SIM_PASSWORD_PHNETSUB_PUK] =3D "netsubpuk",
+		[OFONO_SIM_PASSWORD_PHSP_PIN] =3D "service",
+		[OFONO_SIM_PASSWORD_PHSP_PUK] =3D "servicepuk",
+		[OFONO_SIM_PASSWORD_PHCORP_PIN] =3D "corp",
+		[OFONO_SIM_PASSWORD_PHCORP_PUK] =3D "corppuk",
+		[OFONO_SIM_PASSWORD_INVALID] =3D "invalid",
+	};
+
+	if (OFONO_SIM_PASSWORD_NONE <=3D (int)type &&
+			type <=3D OFONO_SIM_PASSWORD_PHCORP_PUK)
+		return passwd_name[type];
+	else
+		return "UNKNOWN";
+}
+
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
+
+	return "SEC_<UNKNOWN>";
+}
+
 const char *sim_subblock_name(enum sim_subblock value)
 {
 	switch (value) {
@@ -1062,6 +1119,8 @@ static const char *res_to_name(uint8_t res, uint8_t i=
d)
 		return ss_message_id_name(id);
 	case PN_CALL:
 		return call_message_id_name(id);
+	case PN_SECURITY:
+		return sec_message_id_name(id);
 	case PN_SMS:
 		return sms_message_id_name(id);
 	case PN_SIM:
diff --git a/drivers/isimodem/debug.h b/drivers/isimodem/debug.h
index e149c2c..08a5ab6 100644
--- a/drivers/isimodem/debug.h
+++ b/drivers/isimodem/debug.h
@@ -51,6 +51,12 @@ const char *sim_isi_cause_name(enum sim_isi_cause value);
 const char *sim_message_id_name(enum sim_message_id value);
 const char *sim_subblock_name(enum sim_subblock value);
 =

+enum ofono_sim_password_type;
+
+const char *sim_password_name(enum ofono_sim_password_type value);
+
+const char *sec_message_id_name(enum sec_message_id value);
+
 const char *info_isi_cause_name(enum info_isi_cause value);
 const char *info_message_id_name(enum info_message_id value);
 const char *info_subblock_name(enum info_subblock value);
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index bfecbc9..8c83642 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -48,7 +48,10 @@
 =

 struct sim_data {
 	GIsiClient *client;
-	gboolean registered;
+	GIsiClient *sec_client;
+	enum ofono_sim_password_type passwd_state;
+	ofono_bool_t ready;
+	ofono_bool_t notify_ready;
 };
 =

 struct sim_imsi {
@@ -75,6 +78,40 @@ struct file_info {
 	uint8_t file_status;
 };
 =

+static int sim_resp_status(const GIsiMessage *msg, uint8_t msgid,
+				uint8_t service)
+{
+	uint8_t type =3D 0;
+	uint8_t status;
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return -1;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			sim_message_id_name(g_isi_msg_id(msg)));
+		return -1;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 1, &status) ||
+			!g_isi_msg_data_get_byte(msg, 0, &type)) {
+		DBG("Runt msg: %s", sec_message_id_name(msgid));
+		return -1;
+	}
+
+	if (status !=3D SIM_SERV_OK)
+		DBG("Request failed: %s", sim_isi_cause_name(status));
+
+	if (type !=3D service) {
+		DBG("Unexpected service: 0x%02X", type);
+		return -1;
+	}
+
+	return status;
+}
+
 /* Returns file info */
 static gboolean fake_file_info(gpointer user)
 {
@@ -115,30 +152,7 @@ static void isi_read_file_info(struct ofono_sim *sim, =
int fileid,
 static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d,
 					uint8_t service)
 {
-	uint8_t type;
-	uint8_t cause;
-
-	if (g_isi_msg_error(msg) < 0) {
-		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
-		return FALSE;
-	}
-
-	if (g_isi_msg_id(msg) !=3D msgid) {
-		DBG("Unexpected msg: %s",
-			sim_message_id_name(g_isi_msg_id(msg)));
-		return FALSE;
-	}
-
-	if (!g_isi_msg_data_get_byte(msg, 1, &cause) || cause !=3D SIM_SERV_OK) {
-		DBG("Request failed: %s", sim_isi_cause_name(cause));
-		return FALSE;
-	}
-
-	if (!g_isi_msg_data_get_byte(msg, 0, &type) || type !=3D service) {
-		DBG("Unexpected service: 0x%02X", type);
-		return FALSE;
-	}
-	return TRUE;
+	return sim_resp_status(msg, msgid, service) =3D=3D SIM_SERV_OK;
 }
 =

 static void spn_resp_cb(const GIsiMessage *msg, void *data)
@@ -191,9 +205,6 @@ static gboolean isi_read_spn(struct ofono_sim *sim, str=
uct isi_cb_data *cbd)
 		0
 	};
 =

-	if (sd =3D=3D NULL)
-		return FALSE;
-
 	return g_isi_client_send(sd->client, msg, sizeof(msg),
 					spn_resp_cb, cbd, g_free);
 }
@@ -227,9 +238,6 @@ static gboolean isi_read_iccid(struct ofono_sim *sim, s=
truct isi_cb_data *cbd)
 		ICC,
 	};
 =

-	if (sd =3D=3D NULL)
-		return FALSE;
-
 	return g_isi_client_send(sd->client, req, sizeof(req),
 					read_iccid_resp_cb, cbd, g_free);
 }
@@ -315,7 +323,7 @@ static void imsi_resp_cb(const GIsiMessage *msg, void *=
data)
 	struct isi_cb_data *cbd =3D data;
 	ofono_sim_imsi_cb_t cb =3D cbd->cb;
 =

-	struct sim_imsi *resp;
+	const struct sim_imsi *resp;
 	size_t len =3D sizeof(struct sim_imsi);
 =

 	char imsi[SIM_MAX_IMSI_LENGTH + 1];
@@ -370,78 +378,496 @@ error:
 	g_free(cbd);
 }
 =

-static void isi_sim_register(struct ofono_sim *sim)
+static void isi_query_passwd_state(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	if (sd && !sd->registered) {
-		sd->registered =3D TRUE;
-		ofono_sim_register(sim);
-		ofono_sim_inserted_notify(sim, TRUE);
+	DBG("passwd_state %u", sd->passwd_state);
+
+	sd->notify_ready =3D TRUE;
+
+	if (sd->passwd_state !=3D OFONO_SIM_PASSWORD_INVALID) {
+		CALLBACK_WITH_SUCCESS(cb, sd->passwd_state, data);
+
+		if (sd->ready)
+			ofono_sim_ready_notify(sim);
+	} else
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void sim_set_passwd_state(struct ofono_sim *sim,
+					enum ofono_sim_password_type pin_type)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	int inserted;
+	int previous;
+
+	if (pin_type =3D=3D sd->passwd_state)
+		return;
+
+	DBG("new state \"%s\"", sim_password_name(pin_type));
+
+	inserted =3D pin_type !=3D OFONO_SIM_PASSWORD_INVALID;
+	previous =3D sd->passwd_state !=3D OFONO_SIM_PASSWORD_INVALID;
+
+	sd->passwd_state =3D pin_type;
+
+	if (pin_type !=3D OFONO_SIM_PASSWORD_NONE) {
+		sd->ready =3D FALSE;
+		sd->notify_ready =3D FALSE;
 	}
+
+	if (inserted !=3D previous)
+		ofono_sim_inserted_notify(sim, inserted);
 }
 =

-static void read_hplmn_resp_cb(const GIsiMessage *msg, void *data)
+static void check_sec_response(const GIsiMessage *msg, void *opaque,
+					uint8_t success, uint8_t failure)
 {
-	struct ofono_sim *sim =3D data;
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_sim *sim =3D cbd->user;
+	uint8_t id;
+	uint8_t cause;
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		goto failure;
+	}
+
+	id =3D g_isi_msg_id(msg);
 =

-	if (!check_response_status(msg, SIM_NETWORK_INFO_RESP, READ_HPLMN))
+	if (id =3D=3D success) {
+		DBG("%s", sec_message_id_name(id));
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
 		return;
+	}
+
+	if (id =3D=3D failure && g_isi_msg_data_get_byte(msg, 0, &cause)) {
+		DBG("%s(cause=3D%02x)", sec_message_id_name(id), cause);
 =

-	isi_sim_register(sim);
+		if (cause =3D=3D SEC_CAUSE_CODE_BLOCKED)
+			sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_SIM_PUK);
+	} else
+		DBG("Error msg: %s", sec_message_id_name(id));
+
+failure:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+static void sec_code_verify_resp(const GIsiMessage *msg, void *opaque)
+{
+	check_sec_response(msg, opaque,
+			SEC_CODE_VERIFY_OK_RESP, SEC_CODE_VERIFY_FAIL_RESP);
+}
 =

-static void isi_read_hplmn(struct ofono_sim *sim)
+static void isi_send_passwd(struct ofono_sim *sim, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	unsigned char msg[2 + SEC_CODE_MAX_LENGTH + 1] =3D {
+		SEC_CODE_VERIFY_REQ,
+		SEC_CODE_PIN,
+	};
+	int len =3D 2 + strlen(passwd) + 1;
 =

-	const uint8_t req[] =3D {
-		SIM_NETWORK_INFO_REQ,
-		READ_HPLMN, 0
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	strcpy((char *) msg + 2, passwd);
+
+	if (g_isi_client_send(sd->sec_client, msg, len,
+				sec_code_verify_resp, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void isi_reset_passwd(struct ofono_sim *sim,
+				const char *puk, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+	enum ofono_sim_password_type passwd_type =3D OFONO_SIM_PASSWORD_SIM_PIN;
+	unsigned char msg[2 + 2 * (SEC_CODE_MAX_LENGTH + 1)] =3D {
+		SEC_CODE_VERIFY_REQ,
 	};
-	size_t len =3D sizeof(req);
+	size_t len =3D sizeof(msg);
 =

-	if (sd =3D=3D NULL)
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		msg[1] =3D SEC_CODE_PUK;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		msg[1] =3D SEC_CODE_PUK2;
+	else
+		goto error;
+
+	strcpy((char *) &msg[2], puk);
+	strcpy((char *) &msg[2 + SEC_CODE_MAX_LENGTH + 1], passwd);
+
+	if (g_isi_client_send(sd->sec_client, msg, len,
+			sec_code_verify_resp, cbd, g_free))
 		return;
 =

-	g_isi_client_send(sd->client, req, len, read_hplmn_resp_cb, sim, NULL);
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+/* ISI callback: Enable/disable PIN */
+static void pin_enable_resp_cb(const GIsiMessage *msg, void *opaque)
+{
+	check_sec_response(msg, opaque,
+			SEC_CODE_STATE_OK_RESP, SEC_CODE_STATE_FAIL_RESP);
 }
 =

-static void sim_ind_cb(const GIsiMessage *msg, void *data)
+static void isi_lock(struct ofono_sim *sim,
+		enum ofono_sim_password_type passwd_type,
+		int enable, const char *passwd,
+		ofono_sim_lock_unlock_cb_t cb, void *data)
 {
-	struct ofono_sim *sim =3D data;
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct isi_cb_data *cbd =3D isi_cb_data_new(sim, cb, data);
+
+	unsigned char req[3 + SEC_CODE_MAX_LENGTH + 1] =3D {
+		SEC_CODE_STATE_REQ,
+	};
+
+	if (!cbd)
+		goto error;
+
+	DBG("enable %d pintype %d pass %s", enable, passwd_type, passwd);
+
+	if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN)
+		req[1] =3D SEC_CODE_PIN;
+	else if (passwd_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN2)
+		req[1] =3D SEC_CODE_PIN2;
+	else
+		goto error;
+
+	if (enable)
+		req[2] =3D SEC_CODE_ENABLE;
+	else
+		req[2] =3D SEC_CODE_DISABLE;
+
+	strcpy((char *) &req[3], passwd);
+
+	if (g_isi_client_send(sd->sec_client, req, sizeof(req),
+			pin_enable_resp_cb, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+/* ISI callback: PIN state (enabled/disabled) query */
+static void sec_code_change_resp(const GIsiMessage *msg, void *opaque)
+{
+	check_sec_response(msg, opaque,
+			SEC_CODE_CHANGE_OK_RESP, SEC_CODE_CHANGE_FAIL_RESP);
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
+	strcpy((char *) &msg[2], old);
+	strcpy((char *) &msg[2 + SEC_CODE_MAX_LENGTH + 1], new);
+
+	if (g_isi_client_send(sd->sec_client, msg, sizeof(msg),
+			sec_code_change_resp, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+
+/* ISI callback: PIN state (enabled/disabled) query */
+static void sec_code_state_resp_cb(const GIsiMessage *msg, void *opaque)
+{
+	check_sec_response(msg, opaque,
+			SEC_CODE_STATE_OK_RESP, SEC_CODE_STATE_FAIL_RESP);
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
+	if (g_isi_client_send(sd->sec_client, msg, sizeof(msg),
+			sec_code_state_resp_cb, cbd, g_free))
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void sim_ind_cb(const GIsiMessage *msg, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	uint8_t service;
 	uint8_t status;
 =

-	if (sd =3D=3D NULL || g_isi_msg_id(msg) !=3D SIM_IND || sd->registered)
+	DBG("");
+
+	if (g_isi_msg_id(msg) !=3D SIM_IND ||
+			!g_isi_msg_data_get_byte(msg, 0, &service) ||
+			!g_isi_msg_data_get_byte(msg, 1, &status))
+		return;
+
+	if (status =3D=3D SIM_SERV_PIN_VERIFY_REQUIRED && service =3D=3D SIM_ST_P=
IN)
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_SIM_PIN);
+	else if (status =3D=3D SIM_SERV_SIM_BLOCKED)
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_SIM_PUK);
+	else if (status =3D=3D SIM_SERV_INIT_OK && service =3D=3D SIM_ST_INFO)
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
+	else if (status =3D=3D SIM_SERV_SIM_DISCONNECTED)
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_INVALID);
+}
+
+static void sim_server_ready_ind_cb(const GIsiMessage *msg, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (sd =3D=3D NULL || g_isi_msg_id(msg) !=3D SIM_SERVER_READY_IND)
+		return;
+
+	sd->ready =3D TRUE;
+
+	if (sd->notify_ready)
+		ofono_sim_ready_notify(sim);
+}
+
+static void read_dyn_flags_cb(const GIsiMessage *msg, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	int status;
+
+	status =3D sim_resp_status(msg, SIM_DYNAMIC_FLAGS_RESP, READ_DYN_FLAGS);
+
+	if (status < 0 || status =3D=3D SIM_SERV_NOTREADY)
+		return;
+
+	sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
+
+	sd->ready =3D TRUE;
+
+	if (sd->notify_ready)
+		ofono_sim_ready_notify(sim);
+}
+
+static void read_dyn_flags_req(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	unsigned char req[] =3D {
+		SIM_DYNAMIC_FLAGS_REQ,
+		READ_DYN_FLAGS,
+		0
+	};
+
+	g_isi_client_send(sd->client, req, sizeof(req),
+				read_dyn_flags_cb, sim, NULL);
+}
+
+static void sec_state_resp_cb(const GIsiMessage *msg, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	uint8_t msgid;
+	uint8_t cause;
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
 		return;
+	}
 =

-	if (!g_isi_msg_data_get_byte(msg, 0, &status))
+	msgid =3D g_isi_msg_id(msg);
+
+	if (msgid !=3D SEC_STATE_RESP) {
+		DBG("Unexpected msg: %s", sec_message_id_name(msgid));
 		return;
+	}
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &cause)) {
+		DBG("Runt msg: %s", sec_message_id_name(msgid));
+		return;
+	}
+
+	DBG("%s(cause=3D0x%0x)", sec_message_id_name(msgid), cause);
+
+	switch (cause) {
+	case SEC_STARTUP_OK:
+		DBG("SEC_STARTUP_OK");
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
+		/* Check if SIM server is already ready */
+		read_dyn_flags_req(sim);
+		break;
+
+	case SEC_CAUSE_PIN_REQUIRED:
+		DBG("SEC_CAUSE_PIN_REQUIRED");
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_SIM_PIN);
+		break;
+
+	case SEC_CAUSE_PUK_REQUIRED:
+		DBG("SEC_CAUSE_PUK_REQUIRED");
+		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_SIM_PIN);
+		break;
+
+	case SEC_CAUSE_NO_SIM:
+		DBG("SEC_CAUSE_NO_SIM");
+		break;
 =

-	switch (status) {
-	case SIM_ST_PIN:
-		isi_sim_register(sim);
+	case SEC_CAUSE_INVALID_SIM:
+		DBG("SEC_CAUSE_INVALID_SIM");
 		break;
 =

-	case SIM_ST_INFO:
-		isi_read_hplmn(sim);
+	case SEC_CAUSE_SIM_REJECTED:
+		DBG("SEC_CAUSE_SIM_REJECTED");
+		break;
+
+	default:
 		break;
 	}
 }
 =

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
+	g_isi_client_send(sd->sec_client, req, sizeof(req),
+			sec_state_resp_cb, sim, NULL);
+}
+
+static void sim_status_resp_cb(const GIsiMessage *msg, void *opaque)
+{
+	struct ofono_sim *sim =3D opaque;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	int status =3D sim_resp_status(msg, SIM_STATUS_RESP, SIM_ST_CARD_STATUS);
+
+	if (status < 0 || status =3D=3D SIM_SERV_SIM_DISCONNECTED)
+		return;
+
+	/* We probably have a SIM. */
+	if (sd->sec_client)
+		isi_sec_state_req(sim);
+	else
+		read_dyn_flags_req(sim);
+}
+
+static void isi_sim_status_req(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	const unsigned char req[] =3D {
+		SIM_STATUS_REQ,
+		SIM_ST_CARD_STATUS
+	};
+
+	g_isi_client_send(sd->client, req, sizeof(req),
+			sim_status_resp_cb, sim, NULL);
+}
+
+static void sec_reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ofono_sim *sim =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("PN_SECURITY: %s", strerror(-g_isi_msg_error(msg)));
+		DBG("PIN code handling not available");
+		g_isi_client_destroy(sd->sec_client);
+		sd->sec_client =3D NULL;
+	}
+
+	g_isi_client_ind_subscribe(sd->client, SIM_IND, sim_ind_cb, sim);
+	g_isi_client_ind_subscribe(sd->client, SIM_SERVER_READY_IND,
+					sim_server_ready_ind_cb, sim);
+	/* Check if we have a SIM */
+	isi_sim_status_req(sim);
+
+	ofono_sim_register(sim);
+}
+
 static void sim_reachable_cb(const GIsiMessage *msg, void *data)
 {
 	struct ofono_sim *sim =3D data;
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

-	if (g_isi_msg_error(msg) < 0)
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("PN_SIM: %s", strerror(-g_isi_msg_error(msg)));
 		return;
+	}
 =

 	ISI_VERSION_DBG(msg);
 =

-	/* Check if SIM is ready by reading HPLMN */
-	isi_read_hplmn(sim);
+	g_isi_client_verify(sd->sec_client, sec_reachable_cb, sim, NULL);
 }
 =

 static int isi_sim_probe(struct ofono_sim *sim, unsigned int vendor,
@@ -454,11 +880,18 @@ static int isi_sim_probe(struct ofono_sim *sim, unsig=
ned int vendor,
 	if (sd =3D=3D NULL)
 		return -ENOMEM;
 =

+	sd->passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+
 	sd->client =3D g_isi_client_create(modem, PN_SIM);
-	if (sd->client =3D=3D NULL) {
-		g_free(sd);
-		return -ENOMEM;
-	}
+	if (sd->client =3D=3D NULL)
+		goto error;
+
+	sd->sec_client =3D g_isi_client_create(modem, PN_SECURITY);
+	if (sd->sec_client =3D=3D NULL)
+		goto error;
+
+	g_isi_client_set_timeout(sd->client, SIM_TIMEOUT);
+	g_isi_client_set_timeout(sd->sec_client, SIM_TIMEOUT);
 =

 	ofono_sim_set_data(sim, sd);
 =

@@ -466,6 +899,12 @@ static int isi_sim_probe(struct ofono_sim *sim, unsign=
ed int vendor,
 	g_isi_client_verify(sd->client, sim_reachable_cb, sim, NULL);
 =

 	return 0;
+
+error:
+	g_isi_client_destroy(sd->client);
+	g_isi_client_destroy(sd->sec_client);
+
+	return -ENOMEM;
 }
 =

 static void isi_sim_remove(struct ofono_sim *sim)
@@ -478,6 +917,7 @@ static void isi_sim_remove(struct ofono_sim *sim)
 		return;
 =

 	g_isi_client_destroy(data->client);
+	g_isi_client_destroy(data->sec_client);
 	g_free(data);
 }
 =

@@ -493,6 +933,12 @@ static struct ofono_sim_driver driver =3D {
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

 void isi_sim_init(void)
diff --git a/drivers/isimodem/sim.h b/drivers/isimodem/sim.h
index 9b2b076..1585906 100644
--- a/drivers/isimodem/sim.h
+++ b/drivers/isimodem/sim.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 #define PN_SIM							0x09
 #define SIM_TIMEOUT						5
+#define PN_SECURITY						0x08
 #define SIM_MAX_IMSI_LENGTH					15
 =

 enum sim_isi_cause {
@@ -131,31 +132,78 @@ enum sim_message_id {
 	SIM_IMSI_RESP_READ_IMSI =3D				0x1E,
 	SIM_SERV_PROV_NAME_REQ =3D				0x21,
 	SIM_SERV_PROV_NAME_RESP =3D				0x22,
+	SIM_DYNAMIC_FLAGS_REQ =3D					0x29,
+	SIM_DYNAMIC_FLAGS_RESP =3D				0x2A,
 	SIM_READ_FIELD_REQ =3D					0xBA,
 	SIM_READ_FIELD_RESP =3D					0xBB,
 	SIM_SMS_REQ =3D						0xBC,
 	SIM_SMS_RESP =3D						0xBD,
+	SIM_STATUS_REQ =3D					0xC0,
+	SIM_STATUS_RESP =3D					0xC1,
 	SIM_PB_REQ_SIM_PB_READ =3D				0xDC,
 	SIM_PB_RESP_SIM_PB_READ =3D				0xDD,
+	SIM_SERVER_READY_IND =3D					0xED,
 	SIM_IND =3D						0xEF,
 	SIM_COMMON_MESSAGE =3D					0xF0,
 };
 =

 enum sim_service_type {
+	SIM_ST_CARD_STATUS =3D					0x00,
 	SIM_ST_PIN =3D						0x01,
 	SIM_ST_ALL_SERVICES =3D					0x05,
 	SIM_ST_INFO =3D						0x0D,
+	SIM_PB_READ =3D						0x0F,
 	SIM_ST_CAT_SUPPORT_ENABLE =3D				0x15,
 	SIM_ST_CAT_SUPPORT_DISABLE =3D				0x16,
 	SIM_ST_READ_SERV_PROV_NAME =3D				0x2C,
-	SIM_PB_READ =3D						0x0F,
 	READ_IMSI =3D						0x2D,
 	READ_HPLMN =3D						0x2F,
+	READ_DYN_FLAGS =3D					0x35,
 	READ_PARAMETER =3D					0x52,
 	UPDATE_PARAMETER =3D					0x53,
 	ICC =3D							0x66,
 };
 =

+#define SEC_CODE_MAX_LENGTH		0x0A
+
+enum sec_message_id {
+	SEC_CODE_STATE_REQ =3D		0x01,
+	SEC_CODE_STATE_OK_RESP =3D	0x02,
+	SEC_CODE_STATE_FAIL_RESP =3D	0x03,
+	SEC_CODE_CHANGE_REQ =3D		0x04,
+	SEC_CODE_CHANGE_OK_RESP =3D	0x05,
+	SEC_CODE_CHANGE_FAIL_RESP =3D	0x06,
+	SEC_CODE_VERIFY_REQ =3D		0x07,
+	SEC_CODE_VERIFY_OK_RESP =3D	0x08,
+	SEC_CODE_VERIFY_FAIL_RESP =3D	0x09,
+	SEC_STATE_REQ =3D			0x11,
+	SEC_STATE_RESP =3D		0x12,
+};
+
+enum sec_code_id_info {
+	SEC_CODE_PIN =3D			0x02,
+	SEC_CODE_PUK =3D			0x03,
+	SEC_CODE_PIN2 =3D			0x04,
+	SEC_CODE_PUK2 =3D			0x05,
+};
+
+enum sec_code_state_info {
+	SEC_CODE_DISABLE =3D		0x00,
+	SEC_CODE_ENABLE =3D		0x01,
+	SEC_CODE_STATE_QUERY =3D		0x04,
+};
+
+enum sec_state_cause_info {
+	SEC_CAUSE_PIN_REQUIRED =3D	0x02,
+	SEC_CAUSE_PUK_REQUIRED =3D	0x03,
+	SEC_STARTUP_OK =3D		0x05,
+	SEC_STARTUP_ONGOING =3D		0x07,
+	SEC_CAUSE_CODE_BLOCKED =3D	0x08,
+	SEC_CAUSE_NO_SIM =3D		0x16,
+	SEC_CAUSE_SIM_REJECTED =3D	0x1A,
+	SEC_CAUSE_INVALID_SIM =3D		0x1E,
+};
+
 #ifdef __cplusplus
 };
 #endif
-- =

1.7.1


--===============0830955963449394807==--

