Content-Type: multipart/mixed; boundary="===============8000572342517158794=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] netmon: Added netmon driver for xmm7modem
Date: Tue, 09 Oct 2018 17:11:35 +0530
Message-ID: <1539085295-4427-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8000572342517158794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

adding netmon driver for xmm7modem which uses intel proprietary
AT command +XMCI
---
 drivers/xmm7modem/netmon.c    | 264 ++++++++++++++++++++++++++++++++++++++=
++++
 drivers/xmm7modem/xmm7modem.c |   3 +-
 drivers/xmm7modem/xmm7modem.h |   3 +
 3 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xmm7modem/netmon.c

diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
new file mode 100644
index 0000000..64c7858
--- /dev/null
+++ b/drivers/xmm7modem/netmon.c
@@ -0,0 +1,264 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+	XMCI_LTE_NEIGH_CELL
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
+static void xmci_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_netmon *netmon =3D cbd->data;
+	ofono_netmon_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int number;
+	int rxlev =3D -1;
+	int ber =3D -1;
+	int rscp =3D -1;
+	int rsrp =3D -1;
+	int ecn0 =3D -1;
+	int rsrq =3D -1;
+	int tech =3D -1;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+XMCI:")) {
+		if (!g_at_result_iter_next_number(&iter, &number))
+			break;
+		tech =3D xmm7modem_map_radio_access_technology(number);
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
+			rxlev =3D number !=3D 99 ? number:rxlev;
+
+			g_at_result_iter_next_number(&iter, &number);
+			ber =3D number !=3D 99 ? number:ber;
+			break;
+		case XMCI_UMTS_SERV_CELL:
+			/*
+			 * skip <MCC>,<MNC>,<LAC>,<CI><PSC>,<DLUARFNC>,
+			 * <ULUARFCN>,<PATHLOSS>,<RSSI>
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
+			rscp =3D number !=3D 255 ? number:rscp;
+
+			g_at_result_iter_next_number(&iter, &number);
+			ecn0 =3D number !=3D 255 ? number:ecn0;
+			break;
+		case XMCI_LTE_SERV_CELL:
+			/*
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
+			rsrq =3D number !=3D 255 ? number:rsrq;
+
+			g_at_result_iter_next_number(&iter, &number);
+			rsrp =3D number !=3D 255 ? number:rsrp;
+			break;
+		default:
+			break;
+		}
+
+		ofono_netmon_serving_cell_notify(netmon,
+						tech,
+						OFONO_NETMON_INFO_RXLEV, rxlev,
+						OFONO_NETMON_INFO_BER, ber,
+						OFONO_NETMON_INFO_RSCP, rscp,
+						OFONO_NETMON_INFO_ECN0, ecn0,
+						OFONO_NETMON_INFO_RSRQ, rsrq,
+						OFONO_NETMON_INFO_RSRP, rsrp,
+						OFONO_NETMON_INFO_INVALID);
+
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		break;
+	}
+}
+
+static void xmm7modem_netmon_request_update(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("xmm7modem netmon request update");
+
+	if (g_at_chat_send(nmd->chat, "AT+XMCI=3D1", xmci_prefix,
+				xmci_cb, cbd, g_free) =3D=3D 0) {
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+}
+
+static gboolean ril_delayed_register(gpointer user_data)
+{
+	struct ofono_netmon *netmon =3D user_data;
+
+	ofono_netmon_register(netmon);
+
+	return FALSE;
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
+	nmd =3D g_new0(struct netmon_driver_data, 1);
+	if (nmd =3D=3D NULL)
+		return -ENOMEM;
+
+	nmd->chat =3D g_at_chat_clone(chat);
+
+	ofono_netmon_set_data(netmon, nmd);
+
+	g_idle_add(ril_delayed_register, netmon);
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
-- =

1.9.1


--===============8000572342517158794==--

