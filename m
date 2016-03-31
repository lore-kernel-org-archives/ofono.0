Content-Type: multipart/mixed; boundary="===============6481064939863099467=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 4/6] rilmodem: Add netmon support
Date: Thu, 31 Mar 2016 09:53:58 +0530
Message-ID: <1459398238-5892-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6481064939863099467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |   1 +
 drivers/rilmodem/netmon.c   | 292 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/rilmodem/rilmodem.c |   2 +
 drivers/rilmodem/rilmodem.h |   3 +
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/rilmodem/netmon.c

diff --git a/Makefile.am b/Makefile.am
index ec648bd..ce4c107 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -150,6 +150,7 @@ builtin_sources +=3D drivers/rilmodem/rilmodem.h \
 			drivers/rilmodem/call-forwarding.c \
 			drivers/rilmodem/radio-settings.c \
 			drivers/rilmodem/call-barring.c \
+			drivers/rilmodem/netmon.c \
 			drivers/infineonmodem/infineon_constants.h
 endif
 =

diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
new file mode 100644
index 0000000..5cdfa5e
--- /dev/null
+++ b/drivers/rilmodem/netmon.c
@@ -0,0 +1,292 @@
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
+#include <ofono/netmon.h>
+
+#include "gril.h"
+
+#include "rilmodem.h"
+
+/*
+ * Defined below are copy of
+ * RIL_CellInfoType defined in Ril.h
+ */
+#define NETMON_RIL_CELLINFO_TYPE_GSM		1
+#define NETMON_RIL_CELLINFO_TYPE_CDMA		2
+#define NETMON_RIL_CELLINFO_TYPE_LTE		3
+#define NETMON_RIL_CELLINFO_TYPE_UMTS		4
+#define NETMON_RIL_CELLINFO_TYPE_TDSCDMA	5
+
+/* size of RIL_CellInfoGsm */
+#define NETMON_RIL_CELLINFO_SIZE_GSM		24
+/* size of RIL_CellInfoCDMA */
+#define NETMON_RIL_CELLINFO_SIZE_CDMA		40
+/* size of RIL_CellInfoLte */
+#define NETMON_RIL_CELLINFO_SIZE_LTE		44
+/* size of RIL_CellInfoWcdma */
+#define NETMON_RIL_CELLINFO_SIZE_UMTS		28
+/* size of RIL_CellInfoTdscdma */
+#define NETMON_RIL_CELLINFO_SIZE_TDSCDMA	24
+
+struct netmon_data {
+	GRil *ril;
+};
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
+static int ril_cell_type_to_size(int cell_type)
+{
+	switch (cell_type) {
+	case NETMON_RIL_CELLINFO_TYPE_GSM:
+		return NETMON_RIL_CELLINFO_SIZE_GSM;
+
+	case NETMON_RIL_CELLINFO_TYPE_CDMA:
+		return NETMON_RIL_CELLINFO_SIZE_CDMA;
+
+	case NETMON_RIL_CELLINFO_TYPE_LTE:
+		return NETMON_RIL_CELLINFO_SIZE_LTE;
+
+	case NETMON_RIL_CELLINFO_TYPE_UMTS:
+		return NETMON_RIL_CELLINFO_SIZE_UMTS;
+
+	case NETMON_RIL_CELLINFO_TYPE_TDSCDMA:
+		return NETMON_RIL_CELLINFO_SIZE_TDSCDMA;
+	}
+
+	return 0;
+}
+
+static void ril_netmon_update_cb(struct ril_msg *message, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netmon_cb_t cb =3D cbd->cb;
+	struct ofono_netmon *netmon =3D cbd->data;
+	struct parcel rilp;
+	int skip_len;
+	int cell_info_cnt;
+	int cell_type;
+	int registered =3D 0;
+	int mcc, mnc;
+	int lac, cid, psc;
+	int rssi, ber;
+	char s_mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char s_mnc[OFONO_MAX_MNC_LENGTH + 1];
+	int i, j;
+
+	if (message->error !=3D RIL_E_SUCCESS)
+		goto error;
+
+	g_ril_init_parcel(message, &rilp);
+
+	cell_info_cnt =3D parcel_r_int32(&rilp);
+
+	for (i =3D 0; i < cell_info_cnt; i++) {
+		cell_type =3D parcel_r_int32(&rilp);
+
+		registered =3D parcel_r_int32(&rilp);
+
+		/* skipping timeStampType in Ril cell info which is not needed */
+		(void)parcel_r_int32(&rilp);
+
+		/*skipping timeStamp which is a uint64_t type */
+		(void)parcel_r_int32(&rilp);
+		(void)parcel_r_int32(&rilp);
+
+		if (registered)
+			break;
+
+		/*
+		 * not serving cell,
+		 * skip remainder of current cell info
+		 */
+		skip_len =3D ril_cell_type_to_size(cell_type)/sizeof(int);
+
+		for (j =3D 0; j < skip_len; j++)
+			(void)parcel_r_int32(&rilp);
+
+	}
+
+	if (!registered)
+		goto error;
+
+	if (cell_type =3D=3D NETMON_RIL_CELLINFO_TYPE_GSM) {
+		mcc =3D parcel_r_int32(&rilp);
+		mnc =3D parcel_r_int32(&rilp);
+		lac =3D parcel_r_int32(&rilp);
+		cid =3D parcel_r_int32(&rilp);
+		rssi =3D parcel_r_int32(&rilp);
+		ber =3D parcel_r_int32(&rilp);
+
+		if (mcc >=3D 0 && mcc <=3D 999)
+			snprintf(s_mcc, sizeof(s_mcc), "%03d", mcc);
+		else
+			strcpy(s_mcc, "");
+
+		if (mnc >=3D 0 && mnc <=3D 999)
+			snprintf(s_mnc, sizeof(s_mnc), "%03d", mnc);
+		else
+			strcpy(s_mnc, "");
+
+		lac =3D (lac >=3D 0 && lac <=3D 65535) ? lac : -1;
+
+		cid =3D (cid >=3D 0 && cid <=3D 65535) ? cid : -1;
+
+		rssi =3D (rssi >=3D 0 && rssi <=3D 31) ? rssi : -1;
+
+		ber =3D (ber >=3D 0 && ber <=3D 7) ? ber : -1;
+
+		ofono_netmon_serving_cell_notify(netmon, OFONO_NETMON_CELL_TYPE_GSM,
+				OFONO_NETMON_INFO_MCC, s_mcc,
+				OFONO_NETMON_INFO_MNC, s_mnc,
+				OFONO_NETMON_INFO_LAC, lac,
+				OFONO_NETMON_INFO_CI, cid,
+				OFONO_NETMON_INFO_RSSI, rssi,
+				OFONO_NETMON_INFO_BER, ber,
+				OFONO_NETMON_INFO_INVALID);
+
+	} else if (cell_type =3D=3D NETMON_RIL_CELLINFO_TYPE_UMTS) {
+		mcc =3D parcel_r_int32(&rilp);
+		mnc =3D parcel_r_int32(&rilp);
+		lac =3D parcel_r_int32(&rilp);
+		cid =3D parcel_r_int32(&rilp);
+		psc =3D parcel_r_int32(&rilp);
+		rssi =3D parcel_r_int32(&rilp);
+		ber =3D parcel_r_int32(&rilp);
+
+		if (mcc >=3D 0 && mcc <=3D 999)
+			snprintf(s_mcc, sizeof(s_mcc), "%03d", mcc);
+		else
+			strcpy(s_mcc, "");
+
+		if (mnc >=3D 0 && mnc <=3D 999)
+			snprintf(s_mnc, sizeof(s_mnc), "%03d", mnc);
+		else
+			strcpy(s_mnc, "");
+
+		lac =3D (lac >=3D 0 && lac <=3D 65535) ? lac : -1;
+
+		cid =3D (cid >=3D 0 && cid <=3D 268435455) ? cid : -1;
+
+		psc =3D (psc >=3D 0 && rssi <=3D 511) ? psc : -1;
+
+		rssi =3D (rssi >=3D 0 && rssi <=3D 31) ? rssi : -1;
+
+		ber =3D (ber >=3D 0 && ber <=3D 7) ? ber : -1;
+
+		ofono_netmon_serving_cell_notify(netmon, OFONO_NETMON_CELL_TYPE_UMTS,
+				OFONO_NETMON_INFO_MCC, s_mcc,
+				OFONO_NETMON_INFO_MNC, s_mnc,
+				OFONO_NETMON_INFO_LAC, lac,
+				OFONO_NETMON_INFO_CI, cid,
+				OFONO_NETMON_INFO_PSC, psc,
+				OFONO_NETMON_INFO_RSSI, rssi,
+				OFONO_NETMON_INFO_BER, ber,
+				OFONO_NETMON_INFO_INVALID);
+
+	} else {
+		goto error;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	return;
+}
+
+static int ril_netmon_probe(struct ofono_netmon *netmon,
+		unsigned int vendor, void *user)
+{
+	GRil *ril =3D user;
+
+	struct netmon_data *ud =3D g_new0(struct netmon_data, 1);
+
+	ud->ril =3D g_ril_clone(ril);
+
+	ofono_netmon_set_data(netmon, ud);
+
+	g_idle_add(ril_delayed_register, netmon);
+
+	return 0;
+}
+
+static void ril_netmon_remove(struct ofono_netmon *netmon)
+{
+	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
+
+	ofono_netmon_set_data(netmon, NULL);
+
+	g_ril_unref(nmd->ril);
+}
+
+static void ril_netmon_request_update(struct ofono_netmon *netmon,
+		ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nmd);
+
+	if (g_ril_send(nmd->ril, RIL_REQUEST_GET_CELL_INFO_LIST, NULL,
+			ril_netmon_update_cb, cbd, NULL) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static struct ofono_netmon_driver driver =3D {
+	.name			=3D RILMODEM,
+	.probe			=3D ril_netmon_probe,
+	.remove			=3D ril_netmon_remove,
+	.request_update		=3D ril_netmon_request_update,
+};
+
+void ril_netmon_init(void)
+{
+	ofono_netmon_driver_register(&driver);
+}
+
+void ril_netmon_exit(void)
+{
+	ofono_netmon_driver_unregister(&driver);
+}
diff --git a/drivers/rilmodem/rilmodem.c b/drivers/rilmodem/rilmodem.c
index e693563..e4de3c2 100644
--- a/drivers/rilmodem/rilmodem.c
+++ b/drivers/rilmodem/rilmodem.c
@@ -51,6 +51,7 @@ static int rilmodem_init(void)
 	ril_call_forwarding_init();
 	ril_radio_settings_init();
 	ril_call_barring_init();
+	ril_netmon_init();
 =

 	return 0;
 }
@@ -72,6 +73,7 @@ static void rilmodem_exit(void)
 	ril_call_forwarding_exit();
 	ril_radio_settings_exit();
 	ril_call_barring_exit();
+	ril_netmon_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(rilmodem, "RIL modem driver", VERSION,
diff --git a/drivers/rilmodem/rilmodem.h b/drivers/rilmodem/rilmodem.h
index 987ce3c..f838b6b 100644
--- a/drivers/rilmodem/rilmodem.h
+++ b/drivers/rilmodem/rilmodem.h
@@ -69,3 +69,6 @@ extern void ril_call_barring_exit(void);
 =

 extern void ril_phonebook_init(void);
 extern void ril_phonebook_exit(void);
+
+extern void ril_netmon_init(void);
+extern void ril_netmon_exit(void);
-- =

1.9.1


--===============6481064939863099467==--

