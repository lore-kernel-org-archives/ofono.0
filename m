Content-Type: multipart/mixed; boundary="===============3434518942067117231=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 1/4] cdmamodem: Add sim driver implementation
Date: Mon, 21 Nov 2011 11:54:02 +0100
Message-ID: <1321872845-24754-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1321872845-24754-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3434518942067117231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                   |    3 +-
 drivers/cdmamodem/cdmamodem.c |    2 +
 drivers/cdmamodem/cdmamodem.h |    3 +
 drivers/cdmamodem/sim.c       |  582 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 589 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/sim.c

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..db39000 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -273,7 +273,8 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
-			drivers/cdmamodem/connman.c
+			drivers/cdmamodem/connman.c \
+			drivers/cdmamodem/sim.c
 =

 builtin_modules +=3D huaweicdmamodem
 builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 50908e3..771b408 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -37,6 +37,7 @@ static int cdmamodem_init(void)
 	cdma_voicecall_init();
 	cdma_devinfo_init();
 	cdma_connman_init();
+	cdma_sim_init();
 =

 	return 0;
 }
@@ -46,6 +47,7 @@ static void cdmamodem_exit(void)
 	cdma_voicecall_exit();
 	cdma_devinfo_exit();
 	cdma_connman_exit();
+	cdma_sim_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 3554705..53b617d 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -20,6 +20,7 @@
  */
 =

 #include <drivers/atmodem/atutil.h>
+#include <drivers/atmodem/vendor.h>
 =

 extern void cdma_voicecall_init(void);
 extern void cdma_voicecall_exit(void);
@@ -27,3 +28,5 @@ extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
 extern void cdma_connman_init(void);
 extern void cdma_connman_exit(void);
+extern void cdma_sim_init(void);
+extern void cdma_sim_exit(void);
diff --git a/drivers/cdmamodem/sim.c b/drivers/cdmamodem/sim.c
new file mode 100644
index 0000000..26cd572
--- /dev/null
+++ b/drivers/cdmamodem/sim.c
@@ -0,0 +1,582 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/sim.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "cdmamodem.h"
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+struct sim_data {
+	GAtChat *chat;
+	unsigned int vendor;
+	guint ready_id;
+};
+
+static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
+static const char *clck_prefix[] =3D { "+CLCK:", NULL };
+static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
+static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
+static const char *none_prefix[] =3D { NULL };
+
+static void cdma_cimi_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char *imsi;
+	int i;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	for (i =3D 0; i < g_at_result_num_response_lines(result); i++)
+		g_at_result_iter_next(&iter, NULL);
+
+	imsi =3D g_at_result_iter_raw_line(&iter);
+
+	DBG("cimi_cb: %s", imsi);
+
+	cb(&error, imsi, cbd->data);
+}
+
+static void cdma_read_imsi(struct ofono_sim *sim, ofono_sim_imsi_cb_t cb,
+			void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(sd->chat, "AT+CIMI", NULL,
+				cdma_cimi_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static struct {
+	enum ofono_sim_password_type type;
+	const char *name;
+} const cdma_sim_name[] =3D {
+	{ OFONO_SIM_PASSWORD_NONE,		"READY"		},
+	{ OFONO_SIM_PASSWORD_SIM_PIN,		"SIM PIN"	},
+	{ OFONO_SIM_PASSWORD_SIM_PUK,		"SIM PUK"	},
+	{ OFONO_SIM_PASSWORD_PHSIM_PIN,		"PH-SIM PIN"	},
+	{ OFONO_SIM_PASSWORD_PHFSIM_PIN,	"PH-FSIM PIN"	},
+	{ OFONO_SIM_PASSWORD_PHFSIM_PUK,	"PH-FSIM PUK"	},
+	{ OFONO_SIM_PASSWORD_SIM_PIN2,		"SIM PIN2"	},
+	{ OFONO_SIM_PASSWORD_SIM_PUK2,		"SIM PUK2"	},
+	{ OFONO_SIM_PASSWORD_PHNET_PIN,		"PH-NET PIN"	},
+	{ OFONO_SIM_PASSWORD_PHNET_PUK,		"PH-NET PUK"	},
+	{ OFONO_SIM_PASSWORD_PHNETSUB_PIN,	"PH-NETSUB PIN"	},
+	{ OFONO_SIM_PASSWORD_PHNETSUB_PUK,	"PH-NETSUB PUK"	},
+	{ OFONO_SIM_PASSWORD_PHSP_PIN,		"PH-SP PIN"	},
+	{ OFONO_SIM_PASSWORD_PHSP_PUK,		"PH-SP PUK"	},
+	{ OFONO_SIM_PASSWORD_PHCORP_PIN,	"PH-CORP PIN"	},
+	{ OFONO_SIM_PASSWORD_PHCORP_PUK,	"PH-CORP PUK"	},
+};
+
+#define BUILD_PIN_RETRIES_ARRAY(passwd_types, passwd_types_cnt, retry)	\
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)		\
+		retry[i] =3D -1;						\
+									\
+	for (i =3D 0; i < passwd_types_cnt; i++) {			\
+		int val;						\
+									\
+		if (!g_at_result_iter_next_number(&iter, &val))		\
+			goto error;					\
+									\
+		retry[passwd_types[i]] =3D val;				\
+									\
+		DBG("retry counter id=3D%d, val=3D%d", passwd_types[i],	\
+					retry[passwd_types[i]]);	\
+	}								\
+
+static void huawei_cpin_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
+	static enum ofono_sim_password_type password_types[] =3D {
+		OFONO_SIM_PASSWORD_SIM_PUK,
+		OFONO_SIM_PASSWORD_SIM_PIN,
+		OFONO_SIM_PASSWORD_SIM_PUK2,
+		OFONO_SIM_PASSWORD_SIM_PIN2,
+	};
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^CPIN:"))
+		goto error;
+
+	/* Skip status since we are not interested in this */
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	/* Skip "overall counter" since we'll grab each one individually */
+	if (!g_at_result_iter_skip_next(&iter))
+		goto error;
+
+	BUILD_PIN_RETRIES_ARRAY(password_types, ARRAY_SIZE(password_types),
+				retries);
+
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void cdma_cpinr_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t len =3D sizeof(cdma_sim_name) / sizeof(*cdma_sim_name);
+	size_t i;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	g_at_result_iter_init(&iter, result);
+
+	/* Ignore +CPINRE results... */
+	while (g_at_result_iter_next(&iter, "+CPINR:")) {
+		const char *name;
+		int val;
+
+		if (!g_at_result_iter_next_unquoted_string(&iter, &name))
+			continue;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			continue;
+
+		for (i =3D 1; i < len; i++) {
+			if (!strcmp(name, cdma_sim_name[i].name)) {
+				retries[i] =3D val;
+				break;
+			}
+		}
+	}
+
+	cb(&error, retries, cbd->data);
+}
+
+static void cdma_pin_retries_query(struct ofono_sim *sim,
+					ofono_sim_pin_retries_cb_t cb,
+					void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	switch (sd->vendor) {
+	case OFONO_VENDOR_HUAWEI:
+		if (g_at_chat_send(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
+					huawei_cpin_cb, cbd, g_free) > 0)
+			return;
+		break;
+	default:
+		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
+					cdma_cpinr_cb, cbd, g_free) > 0)
+			return;
+		break;
+	}
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void cdma_cpin_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_passwd_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	const char *pin_required;
+	int pin_type =3D OFONO_SIM_PASSWORD_INVALID;
+	int i;
+	int len =3D sizeof(cdma_sim_name) / sizeof(*cdma_sim_name);
+	const char *final =3D g_at_result_final_response(result);
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CPIN:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_next_unquoted_string(&iter, &pin_required);
+
+
+	for (i =3D 0; i < len; i++) {
+		if (strcmp(pin_required, cdma_sim_name[i].name))
+			continue;
+
+		pin_type =3D cdma_sim_name[i].type;
+		break;
+	}
+
+	if (pin_type =3D=3D OFONO_SIM_PASSWORD_INVALID) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	DBG("crsm_pin_cb: %s", pin_required);
+
+	cb(&error, pin_type, cbd->data);
+}
+
+static void cdma_pin_query(struct ofono_sim *sim, ofono_sim_passwd_cb_t cb,
+			void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	cbd->user =3D sim;
+
+	if (g_at_chat_send(sd->chat, "AT+CPIN?", cpin_prefix,
+				cdma_cpin_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static void cdma_pin_send_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+
+	g_free(cbd);
+}
+
+static void cdma_pin_send(struct ofono_sim *sim, const char *passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+
+	cbd->user =3D sd;
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				cdma_pin_send_cb, cbd, NULL);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void cdma_pin_send_puk(struct ofono_sim *sim, const char *puk,
+				const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+
+	cbd->user =3D sd;
+
+	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				cdma_pin_send_cb, cbd, NULL);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void cdma_lock_unlock_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	cb(&error, cbd->data);
+}
+
+static const char *const cdma_clck_cpwd_fac[] =3D {
+	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "SC",
+	[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "P2",
+	[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D "PS",
+	[OFONO_SIM_PASSWORD_PHFSIM_PIN] =3D "PF",
+	[OFONO_SIM_PASSWORD_PHNET_PIN] =3D "PN",
+	[OFONO_SIM_PASSWORD_PHNETSUB_PIN] =3D "PU",
+	[OFONO_SIM_PASSWORD_PHSP_PIN] =3D "PP",
+	[OFONO_SIM_PASSWORD_PHCORP_PIN] =3D "PC",
+};
+
+static void cdma_pin_enable(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				int enable, const char *passwd,
+				ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+	unsigned int len =3D sizeof(cdma_clck_cpwd_fac) / sizeof(*cdma_clck_cpwd_=
fac);
+
+	if (passwd_type >=3D len || cdma_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
+			cdma_clck_cpwd_fac[passwd_type], enable ? 1 : 0, passwd);
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				cdma_lock_unlock_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void cdma_change_passwd(struct ofono_sim *sim,
+			enum ofono_sim_password_type passwd_type,
+			const char *old_passwd, const char *new_passwd,
+			ofono_sim_lock_unlock_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	int ret;
+	unsigned int len =3D sizeof(cdma_clck_cpwd_fac) / sizeof(*cdma_clck_cpwd_=
fac);
+
+	if (passwd_type >=3D len ||
+			cdma_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
+			cdma_clck_cpwd_fac[passwd_type], old_passwd, new_passwd);
+
+	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
+				cdma_lock_unlock_cb, cbd, g_free);
+
+	memset(buf, 0, sizeof(buf));
+
+	if (ret > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void cdma_lock_status_cb(gboolean ok, GAtResult *result,
+		gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	GAtResultIter iter;
+	ofono_sim_locked_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	int locked;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CLCK:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_next_number(&iter, &locked);
+
+	DBG("lock_status_cb: %i", locked);
+
+	cb(&error, locked, cbd->data);
+}
+
+static void cdma_pin_query_enabled(struct ofono_sim *sim,
+				enum ofono_sim_password_type passwd_type,
+				ofono_sim_locked_cb_t cb, void *data)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+	unsigned int len =3D sizeof(cdma_clck_cpwd_fac) / sizeof(*cdma_clck_cpwd_=
fac);
+
+	if (passwd_type >=3D len || cdma_clck_cpwd_fac[passwd_type] =3D=3D NULL)
+		goto error;
+
+	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
+			cdma_clck_cpwd_fac[passwd_type]);
+
+	if (g_at_chat_send(sd->chat, buf, clck_prefix,
+				cdma_lock_status_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static gboolean cdma_sim_register(gpointer user)
+{
+	struct ofono_sim *sim =3D user;
+
+	ofono_sim_register(sim);
+
+	return FALSE;
+}
+
+static int cdma_sim_probe(struct ofono_sim *sim, unsigned int vendor,
+				void *data)
+{
+	GAtChat *chat =3D data;
+	struct sim_data *sd;
+
+	sd =3D g_new0(struct sim_data, 1);
+	sd->chat =3D g_at_chat_clone(chat);
+	sd->vendor =3D vendor;
+
+	ofono_sim_set_data(sim, sd);
+	g_idle_add(cdma_sim_register, sim);
+
+	return 0;
+}
+
+static void cdma_sim_remove(struct ofono_sim *sim)
+{
+	struct sim_data *sd =3D ofono_sim_get_data(sim);
+
+	ofono_sim_set_data(sim, NULL);
+
+	g_at_chat_unref(sd->chat);
+	g_free(sd);
+}
+
+static struct ofono_sim_driver driver =3D {
+	.name			=3D "cdmamodem",
+	.probe			=3D cdma_sim_probe,
+	.remove			=3D cdma_sim_remove,
+	.read_imsi		=3D cdma_read_imsi,
+	.query_passwd_state	=3D cdma_pin_query,
+	.query_pin_retries	=3D cdma_pin_retries_query,
+	.send_passwd		=3D cdma_pin_send,
+	.reset_passwd		=3D cdma_pin_send_puk,
+	.lock			=3D cdma_pin_enable,
+	.change_passwd		=3D cdma_change_passwd,
+	.query_locked		=3D cdma_pin_query_enabled,
+};
+
+void cdma_sim_init(void)
+{
+	ofono_sim_driver_register(&driver);
+}
+
+void cdma_sim_exit(void)
+{
+	ofono_sim_driver_unregister(&driver);
+}
-- =

1.7.1


--===============3434518942067117231==--

