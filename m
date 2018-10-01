Content-Type: multipart/mixed; boundary="===============0471252929358846313=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] netmon: Added netmon driver for xmm7modem
Date: Mon, 01 Oct 2018 16:34:07 +0530
Message-ID: <1538391847-9208-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0471252929358846313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

adding netmon driver for xmm7modem which uses intel propreitory
AT command +XMCI
---
 Makefile.am                   |   3 +-
 drivers/xmm7modem/netmon.c    | 329 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/xmm7modem/xmm7modem.c |   3 +-
 drivers/xmm7modem/xmm7modem.h |   3 +
 plugins/xmm7xxx.c             |   2 +
 5 files changed, 338 insertions(+), 2 deletions(-)
 create mode 100755 drivers/xmm7modem/netmon.c

diff --git a/Makefile.am b/Makefile.am
index 6dee4ce..e4ea2ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -404,7 +404,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/xmm7modem/xmm7modem.h \
 			drivers/xmm7modem/xmm7modem.c \
 			drivers/xmm7modem/radio-settings.c \
-			drivers/xmm7modem/ims.c
+			drivers/xmm7modem/ims.c \
+			drivers/xmm7modem/netmon.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
new file mode 100755
index 0000000..bbb585b
--- /dev/null
+++ b/drivers/xmm7modem/netmon.c
@@ -0,0 +1,329 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  EndoCode AG. All rights reserved.
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
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+#include <ofono/netmon.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "common.h"
+#include "xmm7modem.h"
+#include "drivers/atmodem/vendor.h"
+
+static const char *xmci_prefix[] =3D { "+XMCI:", NULL };
+
+struct netmon_driver_data {
+	GAtChat *chat;
+};
+
+enum xmci_ofono_type_info {
+	XMCI_GSM_SERV_CELL,
+	XMCI_GSM_NEIGH_CELL,
+	XMCI_UMTS_SERV_CELL,
+	XMCI_UMTS_NEIGH_CELL,
+	XMCI_LTE_SERV_CELL,
+	XMCI_LTE_NEIGH_CELL,
+	_MAX
+};
+
+struct req_cb_data {
+	gint ref_count; /* Ref count */
+
+	struct ofono_netmon *netmon;
+
+	ofono_netmon_cb_t cb;
+	void *data;
+
+	struct ofono_network_operator op;
+
+	int rxlev;	/* XMCI: Received Signal Strength Indication */
+	int ber;	/* XMCI: Bit Error Rate */
+	int rscp;	/* XMCI: Received Signal Code Powe */
+	int rsrp;	/* XMCI: Reference Signal Received Power */
+	int ecn0;	/* XMCI: Received Energy Ratio */
+	int rsrq;	/* XMCI: Reference Signal Received Quality */
+};
+
+/*
+ * Returns the appropriate radio access technology.
+ *
+ * If we can not resolve to a specific radio access technolgy
+ * we return OFONO_NETMON_CELL_TYPE_GSM by default.
+ */
+static int xmm7modem_map_radio_access_technology(int tech)
+{
+	switch (tech) {
+	case XMCI_GSM_SERV_CELL:
+	case XMCI_GSM_NEIGH_CELL:
+		return OFONO_NETMON_CELL_TYPE_GSM;
+	case XMCI_UMTS_SERV_CELL:
+	case XMCI_UMTS_NEIGH_CELL:
+		return OFONO_NETMON_CELL_TYPE_UMTS;
+	case XMCI_LTE_SERV_CELL:
+	case XMCI_LTE_NEIGH_CELL:
+		return OFONO_NETMON_CELL_TYPE_LTE;
+	}
+
+	return OFONO_NETMON_CELL_TYPE_GSM;
+}
+
+static inline struct req_cb_data *req_cb_data_new0(void *cb, void *data,
+							void *user)
+{
+	struct req_cb_data *ret =3D g_new0(struct req_cb_data, 1);
+
+	ret->ref_count =3D 1;
+	ret->cb =3D cb;
+	ret->data =3D data;
+	ret->netmon =3D user;
+	ret->rxlev =3D -1;
+	ret->ber =3D -1;
+	ret->rscp =3D -1;
+	ret->rsrp =3D -1;
+	ret->ecn0 =3D -1;
+	ret->rsrq =3D -1;
+
+	return ret;
+}
+
+static inline struct req_cb_data *req_cb_data_ref(struct req_cb_data *cbd)
+{
+	if (cbd =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&cbd->ref_count);
+
+	return cbd;
+}
+
+static void req_cb_data_unref(gpointer user_data)
+{
+	gboolean is_zero;
+	struct req_cb_data *cbd =3D user_data;
+
+	if (cbd =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&cbd->ref_count);
+
+	if (is_zero =3D=3D TRUE)
+		g_free(cbd);
+}
+
+static void xmm7modem_netmon_finish_success(struct req_cb_data *cbd)
+{
+	struct ofono_netmon *nm =3D cbd->netmon;
+
+	ofono_netmon_serving_cell_notify(nm,
+					cbd->op.tech,
+					OFONO_NETMON_INFO_RXLEV, cbd->rxlev,
+					OFONO_NETMON_INFO_BER, cbd->ber,
+					OFONO_NETMON_INFO_RSCP, cbd->rscp,
+					OFONO_NETMON_INFO_ECN0, cbd->ecn0,
+					OFONO_NETMON_INFO_RSRQ, cbd->rsrq,
+					OFONO_NETMON_INFO_RSRP, cbd->rsrp,
+					OFONO_NETMON_INFO_INVALID);
+
+	CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+}
+
+static void xmci_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int number;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+
+	while (g_at_result_iter_next(&iter, "+XMCI:")) {
+		if (!g_at_result_iter_next_number(&iter, &number))
+			break;
+		cbd->op.tech =3D xmm7modem_map_radio_access_technology(number);
+
+		switch(number) {
+		case XMCI_GSM_SERV_CELL:
+			/* skip <MCC>,<MNC>,<LAC>,<CI>,<BSIC> */
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->rxlev =3D number !=3D 99 ? number:cbd->rxlev;
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->ber =3D number !=3D 99 ? number:cbd->ber;
+			break;
+		case XMCI_UMTS_SERV_CELL:
+			/* =

+			 * skip <MCC>,<MNC>,<LAC>,<CI><PSC>,<DLUARFNC>,
+			 * <ULUARFCN>,<PATHLOSS>,<RSSI> =

+			 */
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->rscp =3D number !=3D 255 ? number:cbd->rscp;
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->ecn0 =3D number !=3D 255 ? number:cbd->ecn0;
+			break;
+		case XMCI_LTE_SERV_CELL:
+			/* =

+			 * skip <MCC>,<MNC>,<TAC>,<CI>,<PCI>,<DLUARFNC>,
+			 * <ULUARFCN>,<PATHLOSS_LTE>
+			 */
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->rsrq =3D number !=3D 255 ? number:cbd->rsrq;
+
+			g_at_result_iter_next_number(&iter, &number);
+			cbd->rsrp =3D number !=3D 255 ? number:cbd->rsrp;
+			break;
+		default:
+			break;
+		}
+
+		/*
+		 * We never fail at this point we always send what we collected so
+		 * far
+		 */
+		xmm7modem_netmon_finish_success(cbd);
+	}
+
+	DBG(" RXLEV	%d ", cbd->rxlev);
+	DBG(" BER	%d ", cbd->ber);
+	DBG(" RSCP	%d ", cbd->rscp);
+	DBG(" ECN0	%d ", cbd->ecn0);
+	DBG(" RSRQ	%d ", cbd->rsrq);
+	DBG(" RSRP	%d ", cbd->rsrp);
+
+}
+
+static void xmm7modem_netmon_request_update(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct req_cb_data *cbd;
+
+	DBG("xmm7modem netmon request update");
+
+	cbd =3D req_cb_data_new0(cb, data, netmon);
+
+	if (g_at_chat_send(nmd->chat, "AT+XMCI=3D1", xmci_prefix,
+				xmci_cb, cbd, req_cb_data_unref) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+		req_cb_data_unref(cbd);
+	}
+}
+
+static int xmm7modem_netmon_probe(struct ofono_netmon *netmon,
+					unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
+	struct netmon_driver_data *nmd;
+
+	DBG("xmm7modem netmon probe");
+
+	nmd =3D g_try_new0(struct netmon_driver_data, 1);
+	if (nmd =3D=3D NULL)
+		return -ENOMEM;
+
+	nmd->chat =3D g_at_chat_clone(chat);
+
+	ofono_netmon_set_data(netmon, nmd);
+	ofono_netmon_register(netmon);
+
+	return 0;
+}
+
+static void xmm7modem_netmon_remove(struct ofono_netmon *netmon)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+
+	DBG("xmm7modem netmon remove");
+
+	g_at_chat_unref(nmd->chat);
+
+	ofono_netmon_set_data(netmon, NULL);
+
+	g_free(nmd);
+}
+
+static struct ofono_netmon_driver driver =3D {
+	.name			=3D XMM7MODEM,
+	.probe			=3D xmm7modem_netmon_probe,
+	.remove			=3D xmm7modem_netmon_remove,
+	.request_update		=3D xmm7modem_netmon_request_update,
+};
+
+void xmm_netmon_init(void)
+{
+	ofono_netmon_driver_register(&driver);
+}
+
+void xmm_netmon_exit(void)
+{
+	ofono_netmon_driver_unregister(&driver);
+}
diff --git a/drivers/xmm7modem/xmm7modem.c b/drivers/xmm7modem/xmm7modem.c
index 5c08343..2cce2a7 100644
--- a/drivers/xmm7modem/xmm7modem.c
+++ b/drivers/xmm7modem/xmm7modem.c
@@ -37,7 +37,7 @@ static int xmm7modem_init(void)
 {
 	xmm_radio_settings_init();
 	xmm_ims_init();
-
+	xmm_netmon_init();
 	return 0;
 }
 =

@@ -45,6 +45,7 @@ static void xmm7modem_exit(void)
 {
 	xmm_radio_settings_exit();
 	xmm_ims_exit();
+	xmm_netmon_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(xmm7modem, "Intel xmm7xxx series modem driver",
diff --git a/drivers/xmm7modem/xmm7modem.h b/drivers/xmm7modem/xmm7modem.h
index 5f8f172..a5cd55e 100644
--- a/drivers/xmm7modem/xmm7modem.h
+++ b/drivers/xmm7modem/xmm7modem.h
@@ -28,3 +28,6 @@ extern void xmm_radio_settings_exit(void);
 =

 extern void xmm_ims_init(void);
 extern void xmm_ims_exit(void);
+
+extern void xmm_netmon_init(void);
+extern void xmm_netmon_exit(void);
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 9db87ad..6008cf9 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -50,6 +50,7 @@
 #include <ofono/lte.h>
 #include <ofono/ims.h>
 #include <ofono/sim-auth.h>
+#include <ofono/netmon.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -347,6 +348,7 @@ static void xmm7xxx_post_online(struct ofono_modem *mod=
em)
 		ofono_gprs_add_context(gprs, gc);
 =

 	ofono_ims_create(modem, "xmm7modem", data->chat);
+	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
 =

 static int xmm7xxx_probe(struct ofono_modem *modem)
-- =

1.9.1


--===============0471252929358846313==--

