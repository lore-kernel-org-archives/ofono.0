Content-Type: multipart/mixed; boundary="===============7205956945263530620=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: [PATCH 06/11] samsungipcmodem: add sim driver implementation
Date: Tue, 18 Sep 2012 20:18:50 +0200
Message-ID: <1347992335-9016-7-git-send-email-morphis@gravedo.de>
In-Reply-To: <1347992335-9016-1-git-send-email-morphis@gravedo.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7205956945263530620==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                               |    3 +-
 drivers/samsungipcmodem/samsungipcmodem.c |    2 +
 drivers/samsungipcmodem/samsungipcmodem.h |    2 +
 drivers/samsungipcmodem/sim.c             |  674 +++++++++++++++++++++++++=
++++
 4 files changed, 680 insertions(+), 1 deletion(-)
 create mode 100644 drivers/samsungipcmodem/sim.c

diff --git a/Makefile.am b/Makefile.am
index a6f8ce5..5553489 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -188,7 +188,8 @@ builtin_sources +=3D \
 	drivers/samsungipcmodem/samsungipcmodem.h \
 	drivers/samsungipcmodem/ipc.c \
 	drivers/samsungipcmodem/ipc.h \
-	drivers/samsungipcmodem/devinfo.c
+	drivers/samsungipcmodem/devinfo.c \
+	drivers/samsungipcmodem/sim.c
 builtin_cflags +=3D @SAMSUNGIPC_CFLAGS@
 builtin_libadd +=3D @SAMSUNGIPC_LIBS@
 endif
diff --git a/drivers/samsungipcmodem/samsungipcmodem.c b/drivers/samsungipc=
modem/samsungipcmodem.c
index 32a00de..78e698c 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.c
+++ b/drivers/samsungipcmodem/samsungipcmodem.c
@@ -31,11 +31,13 @@
 static int samsungipcmodem_init(void)
 {
 	samsungipc_devinfo_init();
+	samsungipc_sim_init();
 	return 0;
 }
 =

 static void samsungipcmodem_exit(void)
 {
+	samsungipc_sim_exit();
 	samsungipc_devinfo_exit();
 }
 =

diff --git a/drivers/samsungipcmodem/samsungipcmodem.h b/drivers/samsungipc=
modem/samsungipcmodem.h
index 64fe7eb..c98d213 100644
--- a/drivers/samsungipcmodem/samsungipcmodem.h
+++ b/drivers/samsungipcmodem/samsungipcmodem.h
@@ -21,3 +21,5 @@
 =

 extern void samsungipc_devinfo_init(void);
 extern void samsungipc_devinfo_exit(void);
+extern void samsungipc_sim_init(void);
+extern void samsungipc_sim_exit(void);
diff --git a/drivers/samsungipcmodem/sim.c b/drivers/samsungipcmodem/sim.c
new file mode 100644
index 0000000..b0e7e2a
--- /dev/null
+++ b/drivers/samsungipcmodem/sim.c
@@ -0,0 +1,674 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2012 Simon Busch <morphis@gravedo.de>. All rights rese=
rved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+
+#include <glib.h>
+
+#include "samsungipcmodem.h"
+#include "ipc.h"
+#include "util.h"
+#include "simutil.h"
+
+struct sim_data {
+	struct ipc_device *device;
+	guint sim_state_query;
+	int pin_attempts[OFONO_SIM_PASSWORD_INVALID];
+};
+
+#define EF_STATUS_INVALIDATED 0
+#define EF_STATUS_VALID 1
+
+#define SIM_MAX_IMSI_LENGTH	16
+
+static void pin_query_locked_cb(uint16_t cmd, void *data, uint16_t length,=
 uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_locked_cb_t cb =3D cbd->cb;
+	struct ipc_sec_phone_lock_response *resp =3D data;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, resp->status, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_pin_query_enabled(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_locked_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_phone_lock_get *req;
+
+	DBG("");
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		return;
+	}
+
+	req =3D g_try_new0(struct ipc_sec_phone_lock_get, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, -1, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_PHONE_LOCK, IPC_TYPE_GE=
T,
+						req, sizeof(struct ipc_sec_phone_lock_get),
+						pin_query_locked_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void change_passwd_cb(uint16_t cmd, void *data, uint16_t length, ui=
nt8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ipc_gen_phone_res *resp =3D data;
+
+	if (error || cmd !=3D IPC_GEN_PHONE_RES ||
+		ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_change_passwd(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				const char *old_passwd, const char *new_passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_change_locking_pw_set *req;
+
+	DBG("");
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	req =3D g_try_new0(struct ipc_sec_change_locking_pw_set, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+
+	ipc_sec_change_locking_pw_set_setup(req, IPC_SEC_FACILITY_TYPE_SC,
+									(char*) old_passwd, (char*) new_passwd);
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_CHANGE_LOCKING_PW, IPC_=
TYPE_SET,
+						req, sizeof(struct ipc_sec_change_locking_pw_set),
+						change_passwd_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void pin_enable_cb(uint16_t cmd, void *data, uint16_t length, uint8=
_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ipc_gen_phone_res *resp =3D data;
+
+	if (error || cmd !=3D IPC_GEN_PHONE_RES ||
+		ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_pin_enable(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_phone_lock_set *req;
+	int pin_type;
+
+	switch (passwd_type) {
+	case OFONO_SIM_PASSWORD_SIM_PIN:
+		pin_type =3D IPC_SEC_PIN_TYPE_PIN1;
+		break;
+	case OFONO_SIM_PASSWORD_SIM_PIN2:
+		pin_type =3D IPC_SEC_PIN_TYPE_PIN2;
+		break;
+	default:
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	req =3D g_try_new0(struct ipc_sec_phone_lock_set, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+
+	ipc_sec_phone_lock_set_setup(req, pin_type, enable, (char*) passwd);
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_PHONE_LOCK, IPC_TYPE_SE=
T,
+						req, sizeof(struct ipc_sec_phone_lock_set),
+						pin_enable_cb, cbd) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void puk_send_cb(uint16_t cmd, void *data, uint16_t length, uint8_t=
 error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ipc_gen_phone_res *resp =3D data;
+
+	if (error || cmd !=3D IPC_GEN_PHONE_RES ||
+		ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_send_puk(struct ofono_sim *sim, const char *puk,
+				const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+
+	struct ipc_sec_pin_status_set *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_sec_pin_status_set, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+
+	ipc_sec_pin_status_set_setup(req, IPC_SEC_PIN_TYPE_PIN1, (char*) passwd, =
(char*) puk);
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_SIM_STATUS, IPC_TYPE_SE=
T,
+						req, sizeof(struct ipc_sec_pin_status_set),
+						puk_send_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void read_binary_cb(uint16_t cmd, void *data, uint16_t length, uint=
8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_read_cb_t cb =3D cbd->cb;
+	const guint8 *response;
+	struct ipc_sec_rsim_access_response *resp;
+	struct ofono_error err;
+
+	if (error || cmd !=3D IPC_SEC_RSIM_ACCESS) {
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
+		goto done;
+	}
+
+	resp =3D data;
+
+	DBG("rsim_access_cb: sw1=3D%02x, sw2=3D%02x, len=3D%i", resp->sw1, resp->=
sw2, resp->len);
+
+	/* taken from drivers/atmodem/sim.c */
+	if ((resp->sw1 !=3D 0x90 && resp->sw1 !=3D 0x91 && resp->sw1 !=3D 0x92) ||
+		(resp->sw1 =3D=3D 0x90 && resp->sw2 !=3D 0x00)) {
+		memset(&error, 0, sizeof(error));
+
+		err.type =3D OFONO_ERROR_TYPE_SIM;
+		err.error =3D (resp->sw1 << 8) | resp->sw2;
+
+		cb(&err, NULL, 0, cbd->data);
+		goto done;
+	}
+
+	response =3D (const guint8*) data + sizeof(struct ipc_sec_rsim_access_res=
ponse);
+
+	cb(&err, response, resp->len, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_read_binary(struct ofono_sim *sim, int fileid,
+					int start, int length,
+					ofono_sim_read_cb_t cb, void *cb_data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_rsim_access_get *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_sec_rsim_access_get, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, NULL, 0, cb_data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, cb_data);
+
+	req->command =3D IPC_SEC_RSIM_COMMAND_READ_BINARY;
+	req->fileid =3D (unsigned short) fileid;
+	req->p1 =3D start >> 8;
+	req->p2 =3D start & 0xff;
+	req->p3 =3D length;
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_RSIM_ACCESS, IPC_TYPE_G=
ET,
+						req, sizeof(struct ipc_sec_rsim_access_get),
+						read_binary_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, 0, cb_data);
+}
+
+static void query_passwd_state_cb(uint16_t cmd, void *data, uint16_t lengt=
h, uint8_t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ipc_sec_sim_status_response *resp =3D data;
+	enum ofono_sim_password_type passwd_state;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	switch (resp->facility_lock) {
+	case IPC_SEC_FACILITY_LOCK_TYPE_SC_PIN1_REQ:
+		passwd_state =3D OFONO_SIM_PASSWORD_SIM_PIN;
+		break;
+	case IPC_SEC_FACILITY_LOCK_TYPE_SC_PUK_REQ:
+		passwd_state =3D OFONO_SIM_PASSWORD_SIM_PUK;
+		break;
+	case IPC_SEC_FACILITY_LOCK_TYPE_SC_UNLOCKED:
+		passwd_state =3D OFONO_SIM_PASSWORD_NONE;
+		break;
+	default:
+		passwd_state =3D OFONO_SIM_PASSWORD_INVALID;
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, passwd_state, cbd->data);
+
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_query_passwd_state(struct ofono_sim *sim,
+					ofono_sim_passwd_cb_t cb, void *user_data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	DBG("");
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_SIM_STATUS, IPC_TYPE_GE=
T,
+						NULL, 0, query_passwd_state_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, user_data);
+}
+
+static void notify_sim_status_cb(uint16_t cmd, void *data, uint16_t length=
, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ipc_sec_sim_status_response *resp =3D data;
+	struct sim_data *sd =3D cbd->user;
+
+	switch (resp->status) {
+	case IPC_SEC_SIM_STATUS_INITIALIZING:
+	case IPC_SEC_SIM_STATUS_PB_INIT_COMPLETE:
+		/* Ok, SIM is initializing now; next status update will tell us more */
+		break;
+	case IPC_SEC_SIM_STATUS_INIT_COMPLETE:
+		/* SIM initialization is done now */
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		goto done;
+	default:
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		goto done;
+	}
+
+	return;
+
+done:
+	ipc_device_remove_watch(sd->device, sd->sim_state_query);
+	g_free(cbd);
+}
+
+static void pin_send_cb(uint16_t cmd, void *data, uint16_t length, uint8_t=
 error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct sim_data *sd =3D cbd->user;
+	struct ipc_gen_phone_res *resp =3D data;
+
+	if (error || cmd !=3D IPC_GEN_PHONE_RES ||
+		ipc_gen_phone_res_check(resp) < 0) {
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		g_free(cbd);
+		return;
+	}
+
+	/* wait until SIM init complete status notification arrives */
+	sd->sim_state_query =3D ipc_device_add_notifcation_watch(sd->device,
+												IPC_SEC_SIM_STATUS, notify_sim_status_cb, cbd);
+}
+
+static void samsungipc_pin_send(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_pin_status_set *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_sec_pin_status_set, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+	cbd->user =3D sd;
+
+	ipc_sec_pin_status_set_setup(req, IPC_SEC_PIN_TYPE_PIN1, (char*) passwd, =
NULL);
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_SIM_STATUS, IPC_TYPE_SE=
T,
+						req, sizeof(struct ipc_sec_pin_status_set),
+						pin_send_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void read_imsi_cb(uint16_t cmd, void *data, uint16_t length, uint8_=
t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	char imsi[SIM_MAX_IMSI_LENGTH + 1];
+	guint8 len;
+	char *imsi_data;
+
+	len =3D *((guint8*) data);
+	imsi_data =3D ((char*) data)  + 1;
+
+	strncpy(imsi, imsi_data, len);
+
+	CALLBACK_WITH_SUCCESS(cb, imsi, cbd->data);
+
+	g_free(cbd);
+}
+
+static void samsungipc_read_imsi(struct ofono_sim *sim,
+				ofono_sim_imsi_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+
+	cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if(ipc_device_enqueue_message(sd->device, IPC_MISC_ME_IMSI, IPC_TYPE_GET,
+						NULL, 0, read_imsi_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void lock_info_cb(uint16_t cmd, void *data, uint16_t length, uint8_=
t error, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	struct ipc_sec_lock_info_response *resp =3D data;
+	struct sim_data *sd =3D cbd->user;
+	struct ipc_sec_lock_info_get *req;
+
+	if (error) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		goto done;
+	}
+
+	switch (resp->type) {
+	case IPC_SEC_PIN_TYPE_PIN1:
+		sd->pin_attempts[OFONO_SIM_PASSWORD_SIM_PIN] =3D resp->attempts;
+
+		req =3D g_try_new0(struct ipc_sec_lock_info_get, 1);
+		if (!req) {
+			CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+			goto done;
+		}
+
+		ipc_sec_lock_info_get_setup(req, IPC_SEC_PIN_TYPE_PIN2);
+
+		if(ipc_device_enqueue_message(sd->device, IPC_SEC_LOCK_INFO, IPC_TYPE_GE=
T,
+						req, sizeof(struct ipc_sec_lock_info_get),
+						lock_info_cb, cbd) > 0)
+			return;
+
+		goto error;
+	case IPC_SEC_PIN_TYPE_PIN2:
+		sd->pin_attempts[OFONO_SIM_PASSWORD_SIM_PIN2] =3D resp->attempts;
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, sd->pin_attempts, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+done:
+	g_free(cbd);
+}
+
+static void samsungipc_query_pin_retries(struct ofono_sim *sim,
+					ofono_sim_pin_retries_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd;
+	struct ipc_sec_lock_info_get *req;
+
+	DBG("");
+
+	req =3D g_try_new0(struct ipc_sec_lock_info_get, 1);
+	if (!req) {
+		CALLBACK_WITH_FAILURE(cb, NULL, data);
+		return;
+	}
+
+	cbd =3D cb_data_new(cb, data);
+	cbd->user =3D sd;
+
+	ipc_sec_lock_info_get_setup(req, IPC_SEC_PIN_TYPE_PIN1);
+
+	memset(sd->pin_attempts, 0, sizeof(sd->pin_attempts));
+
+	if(ipc_device_enqueue_message(sd->device, IPC_SEC_LOCK_INFO, IPC_TYPE_GET,
+						req, sizeof(struct ipc_sec_lock_info_get),
+						lock_info_cb, cbd) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void initial_sim_status_cb(uint16_t cmd, void *data, uint16_t lengt=
h, uint8_t error, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct ipc_sec_sim_status_response *resp =3D data;
+
+	if (error) {
+		ofono_sim_remove(sim);
+		return;
+	}
+
+	ofono_sim_register(sim);
+
+	switch (resp->status) {
+	case IPC_SEC_SIM_STATUS_INITIALIZING:
+	case IPC_SEC_SIM_STATUS_SIM_LOCK_REQUIRED:
+	case IPC_SEC_SIM_STATUS_INIT_COMPLETE:
+	case IPC_SEC_SIM_STATUS_PB_INIT_COMPLETE:
+	case IPC_SEC_SIM_STATUS_LOCK_SC:
+	case IPC_SEC_SIM_STATUS_LOCK_FD:
+	case IPC_SEC_SIM_STATUS_LOCK_PN:
+	case IPC_SEC_SIM_STATUS_LOCK_PU:
+	case IPC_SEC_SIM_STATUS_LOCK_PP:
+		ofono_sim_inserted_notify(sim, TRUE);
+		break;
+	case IPC_SEC_SIM_STATUS_CARD_ERROR:
+	case IPC_SEC_SIM_STATUS_CARD_NOT_PRESENT:
+	case IPC_SEC_SIM_STATUS_INSIDE_PF_ERROR:
+		ofono_sim_inserted_notify(sim, FALSE);
+		break;
+	}
+}
+
+static int samsungipc_sim_probe(struct ofono_sim *sim, unsigned int vendor,
+				void *user_data)
+{
+	struct sim_data *sd;
+
+	DBG("");
+
+	sd =3D g_try_new0(struct sim_data, 1);
+	if (sd =3D=3D NULL)
+		return -ENOMEM;
+
+	sd->device =3D user_data;
+
+	ofono_sim_set_data(sim, sd);
+
+	ipc_device_enqueue_message(sd->device, IPC_SEC_SIM_STATUS, IPC_TYPE_GET,
+						NULL, 0, initial_sim_status_cb, sim);
+
+	return 0;
+}
+
+static void samsungipc_sim_remove(struct ofono_sim *sim)
+{
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+
+	ofono_sim_set_data(sim, NULL);
+
+	if (data =3D=3D NULL)
+		return;
+
+	g_free(data);
+}
+
+static struct ofono_sim_driver driver =3D {
+	.name					=3D "samsungipcmodem",
+	.probe					=3D samsungipc_sim_probe,
+	.remove					=3D samsungipc_sim_remove,
+	.query_passwd_state		=3D samsungipc_query_passwd_state,
+	.query_pin_retries		=3D samsungipc_query_pin_retries,
+	.send_passwd			=3D samsungipc_pin_send,
+	.reset_passwd			=3D samsungipc_send_puk,
+	.lock					=3D samsungipc_pin_enable,
+	.change_passwd			=3D samsungipc_change_passwd,
+	.query_locked			=3D samsungipc_pin_query_enabled,
+	.read_imsi				=3D samsungipc_read_imsi,
+	.read_file_transparent	=3D samsungipc_read_binary,
+};
+
+void samsungipc_sim_init(void)
+{
+	ofono_sim_driver_register(&driver);
+}
+
+void samsungipc_sim_exit(void)
+{
+	ofono_sim_driver_unregister(&driver);
+}
-- =

1.7.9.5


--===============7205956945263530620==--

