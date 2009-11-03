Content-Type: multipart/mixed; boundary="===============3122428762912145685=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Tue, 03 Nov 2009 15:44:36 -0200
Message-ID: <1257270276-13728-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3122428762912145685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This driver handles phone informations about registration status, signal
strength and roaming status listening +CIEV commands.  It also gets the
Network Operator name with +COPS commands.
---
 Makefile.am                             |    3 +-
 drivers/hfpmodem/hfpmodem.c             |    2 +
 drivers/hfpmodem/hfpmodem.h             |    3 +
 drivers/hfpmodem/network-registration.c |  356 +++++++++++++++++++++++++++=
++++
 plugins/hfp.c                           |    1 +
 5 files changed, 364 insertions(+), 1 deletions(-)
 create mode 100644 drivers/hfpmodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 8e56568..c3e06b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -126,7 +126,8 @@ builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/hfpmodem.h \
 			drivers/hfpmodem/hfpmodem.c \
-			drivers/hfpmodem/voicecall.c
+			drivers/hfpmodem/voicecall.c \
+			drivers/hfpmodem/network-registration.c
 =

 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/hfpmodem/hfpmodem.c b/drivers/hfpmodem/hfpmodem.c
index 03b5ea0..58ae03d 100644
--- a/drivers/hfpmodem/hfpmodem.c
+++ b/drivers/hfpmodem/hfpmodem.c
@@ -42,6 +42,7 @@
 static int hfpmodem_init(void)
 {
 	hfp_voicecall_init();
+	hfp_netreg_init();
 =

 	return 0;
 }
@@ -49,6 +50,7 @@ static int hfpmodem_init(void)
 static void hfpmodem_exit(void)
 {
 	hfp_voicecall_exit();
+	hfp_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(hfpmodem, "Hands-Free Profile Driver", VERSION,
diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index c4e2a34..02f5a4b 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -61,6 +61,9 @@ struct hfp_data {
 	unsigned int cind_val[HFP_INDICATOR_LAST];
 };
 =

+extern void hfp_netreg_init();
+extern void hfp_netreg_exit();
+
 extern void hfp_voicecall_init();
 extern void hfp_voicecall_exit();
 =

diff --git a/drivers/hfpmodem/network-registration.c b/drivers/hfpmodem/net=
work-registration.c
new file mode 100644
index 0000000..e163b79
--- /dev/null
+++ b/drivers/hfpmodem/network-registration.c
@@ -0,0 +1,356 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2009  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2009 ProFUSION embedded systems. All rights reserved.
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
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "common.h"
+
+#include "hfpmodem.h"
+
+#define HFP_MAX_OPERATOR_NAME_LENGTH 16
+
+static const char *cops_prefix[] =3D { "+COPS:", NULL };
+static const char *cind_prefix[] =3D { "+CIND:", NULL };
+
+struct netreg_data {
+	GAtChat *chat;
+	unsigned char cind_pos[HFP_INDICATOR_LAST];
+	int cind_val[HFP_INDICATOR_LAST];
+};
+
+static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_operator_cb_t cb =3D cbd->cb;
+	struct ofono_network_operator op;
+	GAtResultIter iter;
+	int format;
+	const char *name;
+	struct ofono_error error;
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
+	if (!g_at_result_iter_next(&iter, "+COPS:"))
+		goto error;
+
+	g_at_result_iter_skip_next(&iter);
+
+	ok =3D g_at_result_iter_next_number(&iter, &format);
+
+	if (ok =3D=3D FALSE || format !=3D 0)
+		goto error;
+
+	if (g_at_result_iter_next_string(&iter, &name) =3D=3D FALSE)
+		goto error;
+
+	strncpy(op.name, name, HFP_MAX_OPERATOR_NAME_LENGTH);
+	op.name[HFP_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
+
+	op.mcc[0] =3D '\0';
+	op.mnc[0] =3D '\0';
+
+	cb(&error, &op, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
+static void ciev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	int index, value, status;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIEV:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &index))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &value))
+		return;
+
+	if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SERVICE]) {
+		nd->cind_val[HFP_INDICATOR_SERVICE] =3D value;
+		if (value)
+			status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+		else
+			status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+		ofono_netreg_status_notify(netreg, status, -1, -1, -1);
+	} else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_ROAM]) {
+		nd->cind_val[HFP_INDICATOR_ROAM] =3D value;
+		if (value)
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+
+		ofono_netreg_status_notify(netreg, status, -1, -1, -1);
+	} else if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SIGNAL]) {
+		nd->cind_val[HFP_INDICATOR_SIGNAL] =3D value;
+		ofono_netreg_strength_notify(netreg, value * 20);
+	}
+
+	return;
+}
+
+static void signal_strength_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_strength_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
+	GAtResultIter iter;
+	int index, strength;
+	struct ofono_error error;
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
+	if (!g_at_result_iter_next(&iter, "+CIND:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		return;
+	}
+
+	index =3D 1;
+
+	while (g_at_result_iter_next_number(&iter, &strength)) {
+		if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SIGNAL]) {
+			nd->cind_val[HFP_INDICATOR_SIGNAL] =3D strength;
+			break;
+		}
+
+		index++;
+	}
+
+	ofono_debug("signal_strength_cb: %d", strength);
+
+	cb(&error, strength * 20, cbd->data);
+}
+
+static void registration_status_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_status_cb_t cb =3D cbd->cb;
+	struct netreg_data *nd =3D ofono_netreg_get_data(cbd->user);
+	GAtResultIter iter;
+	int index, value, status;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, -1, -1, -1, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CIND:")) {
+		CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, cbd->data);
+		return;
+	}
+
+	index =3D 1;
+
+	while (g_at_result_iter_next_number(&iter, &value)) {
+
+		if (index =3D=3D nd->cind_pos[HFP_INDICATOR_SERVICE])
+			nd->cind_val[HFP_INDICATOR_SERVICE] =3D value;
+
+		if (index =3D=3D nd->cind_pos[HFP_INDICATOR_ROAM])
+			nd->cind_val[HFP_INDICATOR_ROAM] =3D value;
+
+		index++;
+	}
+
+	if (nd->cind_val[HFP_INDICATOR_SERVICE])
+		status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+	else
+		status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+	if (nd->cind_val[HFP_INDICATOR_ROAM])
+		status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+
+	cb(&error, status, -1, -1, -1, cbd->data);
+}
+
+static void hfp_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	gboolean ok;
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D netreg;
+
+	ok =3D g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+				registration_status_cb, cbd, g_free);
+	if (ok)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, -1, data);
+}
+
+static void hfp_current_operator(struct ofono_netreg *netreg,
+				ofono_netreg_operator_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	gboolean ok;
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D netreg;
+
+	ok =3D g_at_chat_send(nd->chat, "AT+COPS=3D3,0", NULL,
+			NULL, cbd, NULL);
+
+	if (ok)
+		ok =3D g_at_chat_send(nd->chat, "AT+COPS?", cops_prefix,
+				cops_cb, cbd, g_free);
+
+	if (ok)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+}
+
+static void hfp_signal_strength(struct ofono_netreg *netreg,
+				ofono_netreg_strength_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (!cbd)
+		goto error;
+
+	cbd->user =3D netreg;
+
+	if (g_at_chat_send(nd->chat, "AT+CIND?", cind_prefix,
+			signal_strength_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	if (cbd)
+		g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+}
+
+static gboolean hfp_netreg_register(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	ofono_netreg_register(netreg);
+
+	return FALSE;
+}
+
+static int hfp_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *user_data)
+{
+	struct hfp_data *data =3D user_data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+	nd->chat =3D data->chat;
+	memcpy(nd->cind_pos, data->cind_pos, HFP_INDICATOR_LAST);
+	memcpy(nd->cind_val, data->cind_val, HFP_INDICATOR_LAST);
+
+	ofono_netreg_set_data(netreg, nd);
+
+	g_at_chat_register(nd->chat, "+CIEV:", ciev_notify, FALSE,
+			netreg, NULL);
+
+	g_idle_add(hfp_netreg_register, netreg);
+
+	return 0;
+}
+
+static void hfp_netreg_remove(struct ofono_netreg *netreg)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+
+	g_free(nd);
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D "hfpmodem",
+	.probe				=3D hfp_netreg_probe,
+	.remove				=3D hfp_netreg_remove,
+	.registration_status		=3D hfp_registration_status,
+	.current_operator		=3D hfp_current_operator,
+	.strength			=3D hfp_signal_strength,
+};
+
+void hfp_netreg_init()
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void hfp_netreg_exit()
+{
+	ofono_netreg_driver_unregister(&driver);
+}
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 5e94a05..be812cd 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -311,6 +311,7 @@ static void hfp_pre_sim(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 	ofono_voicecall_create(modem, 0, "hfpmodem", data);
+	ofono_netreg_create(modem, 0, "hfpmodem", data);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
-- =

1.6.4.4


--===============3122428762912145685==--

