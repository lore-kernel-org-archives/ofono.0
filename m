Content-Type: multipart/mixed; boundary="===============4136734487114879806=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 5/6] coex: Added xmm7modem driver for coex
Date: Mon, 01 Oct 2018 16:05:12 +0530
Message-ID: <1538390112-6440-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4136734487114879806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

adding coex driver for xmm7modem which uses intel  proprietory
AT commands. To enable/disable coex in modem and get bt and wifi
notifications. The driver will also be able to get the PLMN history.
---
 drivers/xmm7modem/coex.c | 641 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 641 insertions(+)
 create mode 100644 drivers/xmm7modem/coex.c

diff --git a/drivers/xmm7modem/coex.c b/drivers/xmm7modem/coex.c
new file mode 100644
index 0000000..fa0b0c4
--- /dev/null
+++ b/drivers/xmm7modem/coex.c
@@ -0,0 +1,641 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2016  Intel Corporation. All rights reserved.
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
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/log.h>
+#include <ofono/coex.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "xmm7modem.h"
+
+#define BAND_LEN 20
+static const char *xnvmplmn_prefix[] =3D { "+XNVMPLMN:", NULL };
+
+struct coex_data {
+	GAtChat *chat;
+	ofono_bool_t wlan_active;
+	enum ofono_wlan_bw wlan_bw;
+	ofono_bool_t bt_active;
+	ofono_bool_t wlan_active_pending;
+	enum ofono_wlan_bw wlan_bw_pending;
+	ofono_bool_t bt_active_pending;
+};
+
+enum xmm_net_band_lte {
+	NET_BAND_LTE_INVALID =3D 0,
+	NET_BAND_LTE_1 =3D 101,
+	NET_BAND_LTE_2,
+	NET_BAND_LTE_3,
+	NET_BAND_LTE_4,
+	NET_BAND_LTE_5,
+	NET_BAND_LTE_6,
+	NET_BAND_LTE_7,
+	NET_BAND_LTE_8,
+	NET_BAND_LTE_9,
+	NET_BAND_LTE_10,
+	NET_BAND_LTE_11,
+	NET_BAND_LTE_12,
+	NET_BAND_LTE_13,
+	NET_BAND_LTE_14,
+	NET_BAND_LTE_15,
+	NET_BAND_LTE_16,
+	NET_BAND_LTE_17,
+	NET_BAND_LTE_18,
+	NET_BAND_LTE_19,
+	NET_BAND_LTE_20,
+	NET_BAND_LTE_21,
+	NET_BAND_LTE_22,
+	NET_BAND_LTE_23,
+	NET_BAND_LTE_24,
+	NET_BAND_LTE_25,
+	NET_BAND_LTE_26,
+	NET_BAND_LTE_27,
+	NET_BAND_LTE_28,
+	NET_BAND_LTE_29,
+	NET_BAND_LTE_30,
+	NET_BAND_LTE_31,
+	NET_BAND_LTE_32,
+	NET_BAND_LTE_33,
+	NET_BAND_LTE_34,
+	NET_BAND_LTE_35,
+	NET_BAND_LTE_36,
+	NET_BAND_LTE_37,
+	NET_BAND_LTE_38,
+	NET_BAND_LTE_39,
+	NET_BAND_LTE_40,
+	NET_BAND_LTE_41,
+	NET_BAND_LTE_42,
+	NET_BAND_LTE_43 =3D 143
+};
+
+static const char *none_prefix[] =3D { NULL };
+
+static void xmm_set_bt_active_cb(gboolean ok, GAtResult *result,
+					gpointer user_data);
+
+static void xmm_set_wlan_active_cb(gboolean ok, GAtResult *result,
+					gpointer user_data);
+
+static void xmm_coex_l_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int lte_active;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSL:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &lte_active))
+		return;
+
+	DBG("lte_active:%d", lte_active);
+
+	ofono_lte_coex_status_notify(coex, lte_active);
+}
+
+void xmm_get_band_string(int lte_band, char* band)
+{
+	switch (lte_band) {
+		case NET_BAND_LTE_1:
+		strncpy(band,"BAND_LTE_1",BAND_LEN);
+		break;
+		case NET_BAND_LTE_2:
+		strncpy(band,"BAND_LTE_2",BAND_LEN);
+		break;
+		case NET_BAND_LTE_3:
+		strncpy(band,"BAND_LTE_3",BAND_LEN);
+		break;
+		case NET_BAND_LTE_4:
+		strncpy(band,"BAND_LTE_4",BAND_LEN);
+		break;
+		case NET_BAND_LTE_5:
+		strncpy(band,"BAND_LTE_5",BAND_LEN);
+		break;
+		case NET_BAND_LTE_6:
+		strncpy(band,"BAND_LTE_6",BAND_LEN);
+		break;
+		case NET_BAND_LTE_7:
+		strncpy(band,"BAND_LTE_7",BAND_LEN);
+		break;
+		case NET_BAND_LTE_8:
+		strncpy(band,"BAND_LTE_8",BAND_LEN);
+		break;
+		case NET_BAND_LTE_9:
+		strncpy(band,"BAND_LTE_9",BAND_LEN);
+		break;
+		case NET_BAND_LTE_10:
+		strncpy(band,"BAND_LTE_10",BAND_LEN);
+		break;
+		case NET_BAND_LTE_11:
+		strncpy(band,"BAND_LTE_11",BAND_LEN);
+		break;
+		case NET_BAND_LTE_12:
+		strncpy(band,"BAND_LTE_12",BAND_LEN);
+		break;
+		case NET_BAND_LTE_13:
+		strncpy(band,"BAND_LTE_13",BAND_LEN);
+		break;
+		case NET_BAND_LTE_14:
+		strncpy(band,"BAND_LTE_14",BAND_LEN);
+		break;
+		case NET_BAND_LTE_15:
+		strncpy(band,"BAND_LTE_15",BAND_LEN);
+		break;
+		case NET_BAND_LTE_16:
+		strncpy(band,"BAND_LTE_16",BAND_LEN);
+		break;
+		case NET_BAND_LTE_17:
+		strncpy(band,"BAND_LTE_17",BAND_LEN);
+		break;
+		case NET_BAND_LTE_18:
+		strncpy(band,"BAND_LTE_18",BAND_LEN);
+		break;
+		case NET_BAND_LTE_19:
+		strncpy(band,"BAND_LTE_19",BAND_LEN);
+		break;
+		case NET_BAND_LTE_20:
+		strncpy(band,"BAND_LTE_20",BAND_LEN);
+		break;
+		case NET_BAND_LTE_21:
+		strncpy(band,"BAND_LTE_21",BAND_LEN);
+		break;
+		case NET_BAND_LTE_22:
+		strncpy(band,"BAND_LTE_22",BAND_LEN);
+		break;
+		case NET_BAND_LTE_23:
+		strncpy(band,"BAND_LTE_23",BAND_LEN);
+		break;
+		case NET_BAND_LTE_24:
+		strncpy(band,"BAND_LTE_24",BAND_LEN);
+		break;
+		case NET_BAND_LTE_25:
+		strncpy(band,"BAND_LTE_25",BAND_LEN);
+		break;
+		case NET_BAND_LTE_26:
+		strncpy(band,"BAND_LTE_26",BAND_LEN);
+		break;
+		case NET_BAND_LTE_27:
+		strncpy(band,"BAND_LTE_27",BAND_LEN);
+		break;
+		case NET_BAND_LTE_28:
+		strncpy(band,"BAND_LTE_28",BAND_LEN);
+		break;
+		case NET_BAND_LTE_33:
+		strncpy(band,"BAND_LTE_33",BAND_LEN);
+		break;
+		case NET_BAND_LTE_34:
+		strncpy(band,"BAND_LTE_34",BAND_LEN);
+		break;
+		case NET_BAND_LTE_35:
+		strncpy(band,"BAND_LTE_35",BAND_LEN);
+		break;
+		case NET_BAND_LTE_36:
+		strncpy(band,"BAND_LTE_36",BAND_LEN);
+		break;
+		case NET_BAND_LTE_37:
+		strncpy(band,"BAND_LTE_37",BAND_LEN);
+		break;
+		case NET_BAND_LTE_38:
+		strncpy(band,"BAND_LTE_38",BAND_LEN);
+		break;
+		case NET_BAND_LTE_39:
+		strncpy(band,"BAND_LTE_39",BAND_LEN);
+		break;
+		case NET_BAND_LTE_40:
+		strncpy(band,"BAND_LTE_40",BAND_LEN);
+		break;
+		case NET_BAND_LTE_41:
+		strncpy(band,"BAND_LTE_41",BAND_LEN);
+		break;
+		case NET_BAND_LTE_42:
+		strncpy(band,"BAND_LTE_42",BAND_LEN);
+		break;
+		case NET_BAND_LTE_43:
+		strncpy(band,"BAND_LTE_43",BAND_LEN);
+		break;
+		default:
+		strncpy(band,"INVALID",BAND_LEN);
+		break;
+	}
+}
+
+static void xmm_lte_band_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int lte_band;
+	char band[BAND_LEN];
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XCCINFO:"))
+		return;
+
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+	g_at_result_iter_skip_next(&iter);
+
+	if (!g_at_result_iter_next_number(&iter, &lte_band))
+		return;
+
+	xmm_get_band_string(lte_band, band);
+
+	DBG("lte_band:%s", band);
+	ofono_coex_ril_lte_band_notify(coex, band);
+}
+
+static void xmm_coex_w_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+	int count;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSW:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &safe_rx_min);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &safe_rx_max);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &safe_tx_min);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &safe_tx_max);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_skip_next(&iter);
+
+	g_at_result_iter_next_number(&iter, &num_safe_vector);
+
+	for(count =3D 0; count < num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &safe_vector[count]);
+	}
+
+	DBG("WLAN notification");
+
+	ofono_wlan_coex_status_notify(coex, safe_tx_min, safe_tx_max,
+		safe_rx_min, safe_rx_max,num_safe_vector,safe_vector);
+}
+
+
+static void xmm_coex_b_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_coex *coex =3D user_data;
+	GAtResultIter iter;
+	int safe_tx_min;
+	int safe_tx_max;
+	int safe_rx_min;
+	int safe_rx_max;
+	int safe_vector[MAX_BT_SAFE_VECTOR];
+	int num_safe_vector;
+	int count;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XNRTCWSB:"))
+		return;
+
+	g_at_result_iter_next_number(&iter, &safe_rx_min);
+
+	g_at_result_iter_next_number(&iter, &safe_rx_max);
+
+	g_at_result_iter_next_number(&iter, &safe_tx_min);
+
+	g_at_result_iter_next_number(&iter, &safe_tx_max);
+
+	g_at_result_iter_next_number(&iter, &num_safe_vector);
+
+	for(count =3D 0; count < num_safe_vector; count++) {
+		g_at_result_iter_next_number(&iter, &safe_vector[count]);
+	}
+
+	DBG("BT notification");
+
+	ofono_wlan_coex_status_notify(coex, safe_tx_min, safe_tx_max,
+		safe_rx_min, safe_rx_max,num_safe_vector,safe_vector);
+}
+
+static void xmm_coex_enable_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_coex_enable_cb_t cd =3D cbd->cb;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+		decode_at_error(&error, g_at_result_final_response(result));
+		cd(&error, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cd, cbd->data);
+}
+
+
+
+static void xmm_coex_enable(struct ofono_coex *coex,
+			ofono_coex_enable_cb_t cb, void *data)
+{
+	struct coex_data *cd =3D ofono_coex_get_data(coex);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if(g_at_chat_send(cd->chat, "AT+XNRTCWS=3D7", none_prefix,
+				xmm_coex_enable_cb, cbd, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static int xmm_coex_probe(struct ofono_coex *coex, unsigned int vendor,
+				void *user)
+{
+	GAtChat *chat =3D user;
+	struct coex_data *cd;
+
+	DBG("at coex probe");
+
+	cd =3D g_try_new0(struct coex_data, 1);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->chat =3D g_at_chat_clone(chat);
+
+	ofono_coex_set_data(coex, cd);
+
+	g_at_chat_register(cd->chat, "+XNRTCWSL:", xmm_coex_l_notify,
+					FALSE, coex, NULL);
+	g_at_chat_register(cd->chat, "+XNRTCWSW:", xmm_coex_w_notify,
+					FALSE, coex, NULL);
+	g_at_chat_register(cd->chat, "+XNRTCWSB:", xmm_coex_b_notify,
+					FALSE, coex, NULL);
+	g_at_chat_register(cd->chat, "+XCCINFO:", xmm_lte_band_notify,
+					FALSE, coex, NULL);
+
+	g_at_chat_send(cd->chat, "AT+XCCINFO=3D1", none_prefix,
+				NULL, NULL, NULL);
+	g_at_chat_send(cd->chat, "AT+XNRTAPP=3D10,100", none_prefix,
+				NULL, NULL, NULL);
+
+	ofono_coex_register(coex);
+
+	return 0;
+}
+
+static void xmm_coex_remove_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_coex_enable_cb_t cd =3D cbd->cb;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+		decode_at_error(&error, g_at_result_final_response(result));
+		cd(&error, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cd, cbd->data);
+}
+
+
+static void xmm_coex_remove(struct ofono_coex *coex,
+			ofono_coex_remove_cb_t cb, void *data)
+{
+	struct coex_data *cd =3D ofono_coex_get_data(coex);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if(g_at_chat_send(cd->chat, "AT+XNRTCWS=3D0", none_prefix,
+				xmm_coex_remove_cb, cbd, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void xmm_set_bt_active_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_coex_enable_cb_t cd =3D cbd->cb;
+	struct coex_data* coex =3D ofono_coex_get_data(cbd->data);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+		decode_at_error(&error, g_at_result_final_response(result));
+		cd(&error, cbd->data);
+		return;
+	}
+
+	coex->bt_active =3D coex->bt_active_pending;
+	CALLBACK_WITH_SUCCESS(cd, cbd->data);
+}
+
+
+
+static void xmm_set_bt_active(struct ofono_coex *coex, ofono_bool_t bt_act=
ive,
+			ofono_coex_bt_active_set_cb_t cb, void *data)
+{
+	struct coex_data *cd =3D ofono_coex_get_data(coex);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	DBG("");
+	sprintf(buf, "AT+XNRTCWS=3D65535,%u,%u,%u", (int)cd->wlan_active,
+				(int)cd->wlan_bw,bt_active);
+	if(g_at_chat_send(cd->chat, buf, none_prefix,
+				xmm_set_bt_active_cb, cbd, NULL) > 0) {
+	cd->bt_active_pending =3D bt_active;
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+
+static void xmm_set_wlan_active_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_coex_enable_cb_t cd =3D cbd->cb;
+	struct coex_data* coex =3D ofono_coex_get_data(cbd->data);
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+		decode_at_error(&error, g_at_result_final_response(result));
+		cd(&error, cbd->data);
+		return;
+	}
+
+	coex->wlan_active =3D coex->wlan_active_pending;
+	coex->wlan_bw =3D coex->wlan_bw_pending;
+	CALLBACK_WITH_SUCCESS(cd, cbd->data);
+}
+
+static void xmm_get_plmn_history_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_coex_get_plmn_history_cb_t cd =3D cbd->cb;
+	struct Plmnhist *list =3D NULL;
+	GAtResultIter iter;
+	int list_size =3D 0;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(cd, 0, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+XNVMPLMN:")) {
+		if (!list_size)
+			list =3D g_new0(struct Plmnhist, ++list_size);
+		else
+			list =3D g_renew(struct Plmnhist, list, ++list_size);
+
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].mcc);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].mnc);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].fdd);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].tdd);
+		g_at_result_iter_next_number(&iter, (int*)&list[list_size - 1].bw);
+
+		DBG("list_size =3D %d", list_size);
+	}
+
+	CALLBACK_WITH_SUCCESS(cd, list_size, list, cbd->data);
+	if(list)
+		g_free(list);
+}
+
+static void xmm_get_plmn_history(struct ofono_coex *coex,
+			ofono_coex_get_plmn_history_cb_t cb, void *data)
+{
+	struct coex_data *cd =3D ofono_coex_get_data(coex);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+	if(g_at_chat_send(cd->chat, "AT+XNVMPLMN=3D2,2", xnvmplmn_prefix,
+				xmm_get_plmn_history_cb, cbd, NULL) > 0) {
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, 0, NULL, cbd->data);
+	g_free(cbd);
+}
+
+
+static void xmm_set_wlan_active(struct ofono_coex *coex,
+			ofono_bool_t wlan_active, enum ofono_wlan_bw wlan_bw,
+			ofono_coex_bt_active_set_cb_t cb, void *data)
+{
+	struct coex_data *cd =3D ofono_coex_get_data(coex);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char buf[64];
+
+	DBG("");
+	sprintf(buf, "AT+XNRTCWS=3D65535,%u,%u", (int)wlan_active,
+				(int)wlan_bw);
+	if(g_at_chat_send(cd->chat, buf, none_prefix,
+				xmm_set_wlan_active_cb, cbd, NULL) > 0) {
+		cd->wlan_active_pending =3D wlan_active;
+		cd->wlan_bw =3D wlan_bw;
+		return;
+	}
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+
+static struct ofono_coex_driver driver =3D {
+	.name =3D "xmm7modem",
+	.probe =3D xmm_coex_probe,
+	.enable =3D xmm_coex_enable,
+	.remove =3D xmm_coex_remove,
+	.set_bt_active =3D xmm_set_bt_active,
+	.set_wlan_active =3D xmm_set_wlan_active,
+	.get_plmn_history =3D xmm_get_plmn_history
+};
+
+void xmm_coex_init(void)
+{
+	ofono_coex_driver_register(&driver);
+}
+
+void xmm_coex_exit(void)
+{
+	ofono_coex_driver_unregister(&driver);
+}
-- =

1.9.1


--===============4136734487114879806==--

