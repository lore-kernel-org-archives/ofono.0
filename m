Content-Type: multipart/mixed; boundary="===============3646943206281436447=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [RFC PATCH 1/2] gemalto: add netmon driver
Date: Sun, 10 Jan 2021 22:44:04 +0300
Message-ID: <20210110194405.1994055-2-geomatsi@gmail.com>
In-Reply-To: <20210110194405.1994055-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3646943206281436447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Implement network monitoring driver for gemalto modems that
are able to provide serving cell information and basic
measurements using AT+CQS and AT^SMONI commands.
---
 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/netmon.c       | 609 ++++++++++++++++++++++++++++
 4 files changed, 616 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/netmon.c

diff --git a/Makefile.am b/Makefile.am
index c0631081..5e7614c1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -483,7 +483,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.c \
 			drivers/gemaltomodem/location-reporting.c \
 			drivers/gemaltomodem/voicecall.c \
-			drivers/gemaltomodem/gprs-context.c
+			drivers/gemaltomodem/gprs-context.c \
+			drivers/gemaltomodem/netmon.c
 =

 builtin_modules +=3D xmm7modem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 4b20dd1b..f7e4ff3e 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -38,6 +38,7 @@ static int gemaltomodem_init(void)
 	gemalto_location_reporting_init();
 	gemalto_gprs_context_init();
 	gemalto_voicecall_init();
+	gemalto_netmon_init();
 =

 	return 0;
 }
@@ -47,6 +48,7 @@ static void gemaltomodem_exit(void)
 	gemalto_location_reporting_exit();
 	gemalto_gprs_context_exit();
 	gemalto_voicecall_exit();
+	gemalto_netmon_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index dc0d346b..ae8f2141 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -30,3 +30,6 @@ extern void gemalto_voicecall_exit();
 =

 extern void gemalto_gprs_context_init();
 extern void gemalto_gprs_context_exit();
+
+extern void gemalto_netmon_init(void);
+extern void gemalto_netmon_exit(void);
diff --git a/drivers/gemaltomodem/netmon.c b/drivers/gemaltomodem/netmon.c
new file mode 100644
index 00000000..93e6d02f
--- /dev/null
+++ b/drivers/gemaltomodem/netmon.c
@@ -0,0 +1,609 @@
+/*
+ *
+ *  oFono - Open Source Telephony
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
+#include "gemaltomodem.h"
+#include "drivers/atmodem/vendor.h"
+
+static const char *smoni_prefix[] =3D { "^SMONI:", NULL };
+static const char *csq_prefix[] =3D { "+CSQ:", NULL };
+
+struct netmon_driver_data {
+	GAtChat *chat;
+};
+
+struct req_cb_data {
+	gint ref_count; /* Ref count */
+
+	struct ofono_netmon *netmon;
+	ofono_netmon_cb_t cb;
+	void *data;
+
+	struct ofono_network_operator op;
+
+	int rssi;	/* CSQ: received signal strength indicator (RSSI) */
+
+	union {
+		struct {
+			int arfcn;	/* SMONI: Absolute Radio Frequency Channel Number */
+			int bcch;	/* SMONI: Receiving level of the BCCH carrier in dBm */
+			int lac;	/* SMONI: Location Area Code */
+			int ci;		/* SMONI: Cell ID */
+		} gsm;
+		struct {
+			int uarfcn;	/* SMONI: UTRAN Absolute Radio Frequency Channel Number */
+			int psc;	/* SMONI: Primary Scrambling Code */
+			int ecn0;	/* SMONI: Carrier to noise ratio in dB */
+			int rscp;	/* SMONI: Received Signal Code Power in dBm */
+			int lac;	/* SMONI: Location Area Code */
+			int ci;		/* SMONI: Cell ID */
+		} umts;
+		struct {
+			int euarfcn;	/* SMONI: E-UTRA Absolute Radio Frequency Channel Number */
+			int rsrp;	/* SMONI: Reference Signal Received Power */
+			int rsrq;	/* SMONI: Reference Signal Received Quality */
+		} lte;
+	} t;
+};
+
+static inline struct req_cb_data *req_cb_data_new0(void *cb, void *data,
+							void *user)
+{
+	struct req_cb_data *ret =3D g_new0(struct req_cb_data, 1);
+
+	ret->ref_count =3D 1;
+	ret->netmon =3D user;
+	ret->data =3D data;
+	ret->cb =3D cb;
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
+	struct req_cb_data *cbd =3D user_data;
+	gboolean is_zero;
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
+static gboolean gemalto_delayed_register(gpointer user_data)
+{
+	struct ofono_netmon *netmon =3D user_data;
+
+	ofono_netmon_register(netmon);
+
+	return FALSE;
+}
+
+static int gemalto_parse_smoni_gsm(GAtResultIter *iter,
+					struct req_cb_data *cbd)
+{
+	/*
+	 * ME is camping on a GSM (2G) cell:
+	 * ^SMONI: ACT,ARFCN,BCCH,MCC,MNC,LAC,cell,C1,C2,NCC,BCC,GPRS,Conn_state
+	 * ^SMONI: 2G,71,-61,262,02,0143,83BA,33,33,3,6,G,NOCONN
+	 *
+	 * ME is searching and could not (yet) find a suitable GSM (2G) cell:
+	 * ^SMONI: ACT,ARFCN,BCCH,MCC,MNC,LAC,cell,C1,C2,NCC,BCC,GPRS,ARFCN,TS,ti=
mAdv,dBm,Q,ChMod
+	 * ^SMONI: 2G,SEARCH,SEARCH
+	 *
+	 * ME is camping on a GSM cell but not registered to the network (only em=
ergency call allowed):
+	 * ^SMONI: ACT,ARFCN,BCCH,MCC,MNC,LAC,cell,C1,C2,NCC,BCC,GPRS,PWR,RXLev,A=
RFCN,TS,timAdv,dBm,Q,ChMod
+	 * ^SMONI: 2G,673,-89,262,07,4EED,A500,16,16,7,4,G,5,-107,LIMSRV
+	 *
+	 * ME has a dedicated channel (for example call in progress):
+	 * ^SMONI: ACT,ARFCN,BCCH,MCC,MNC,LAC,cell,C1,C2,NCC,BCC,GPRS,ARFCN,TS,ti=
mAdv,dBm,Q,ChMod
+	 * ^SMONI: 2G,673,-80,262,07,4EED,A500,35,35,7,4,G,643,4,0,-80,0,S_FR
+	 */
+
+	enum smoni_gsm_field {
+		SMONI_GSM_ARFCN,
+		SMONI_GSM_BCCH,
+		SMONI_GSM_MCC,
+		SMONI_GSM_MNC,
+		SMONI_GSM_LAC,
+		SMONI_GSM_CI,
+		SMONI_GSM_MAX,
+	};
+
+	const char *str;
+	int number;
+	int idx;
+
+	cbd->t.gsm.arfcn =3D -1;
+	cbd->t.gsm.bcch =3D -1;
+	cbd->t.gsm.lac =3D -1;
+	cbd->t.gsm.ci =3D -1;
+
+	for (idx =3D 0; idx < SMONI_GSM_MAX; idx++) {
+		switch (idx) {
+		case SMONI_GSM_ARFCN:
+			if (g_at_result_iter_next_number(iter, &number))
+				cbd->t.gsm.arfcn =3D number;
+			break;
+		case SMONI_GSM_BCCH:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%d", &number) =3D=3D 1)
+					cbd->t.gsm.bcch =3D number;
+			}
+			break;
+		case SMONI_GSM_MCC:
+			if (g_at_result_iter_next_number(iter, &number))
+				snprintf(cbd->op.mcc, 4, "%d", number);
+			break;
+		case SMONI_GSM_MNC:
+			if (g_at_result_iter_next_number(iter, &number))
+				snprintf(cbd->op.mnc, 4, "%d", number);
+			break;
+		case SMONI_GSM_LAC:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%x", &number) =3D=3D 1)
+					cbd->t.gsm.lac =3D number;
+			}
+			break;
+		case SMONI_GSM_CI:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%x", &number) =3D=3D 1)
+					cbd->t.gsm.ci =3D number;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	DBG(" %-15s %s", "GSM.MCC", cbd->op.mcc);
+	DBG(" %-15s %s", "GSM.MNC", cbd->op.mnc);
+	DBG(" %-15s %d", "GSM.ARFCN", cbd->t.gsm.arfcn);
+	DBG(" %-15s %d", "GSM.BCCH", cbd->t.gsm.bcch);
+	DBG(" %-15s %d", "GSM.LAC", cbd->t.gsm.lac);
+	DBG(" %-15s %d", "GSM.CELL", cbd->t.gsm.ci);
+
+	return 0;
+}
+
+static int gemalto_parse_smoni_umts(GAtResultIter *iter,
+					struct req_cb_data *cbd)
+{
+	/*
+	 * ME is camping on a UMTS (3G) cell:
+	 * ^SMONI: ACT,UARFCN,PSC,EC/n0,RSCP,MCC,MNC,LAC,cell,SQual,SRxLev,,Conn_=
state
+	 * ^SMONI: 3G,10564,296,-7.5,-79,262,02,0143,00228FF,-92,-78,NOCONN
+	 *
+	 * ME is searching and could not (yet) find a suitable UMTS (3G) cell:
+	 * ^SMONI: ACT,UARFCN,PSC,EC/n0,RSCP,MCC,MNC,LAC,cell,SQual,SRxLev,PhysCh=
, SF,Slot,EC/n0,RSCP,ComMod,HSUPA,HSDPA
+	 * ^SMONI: 3G,SEARCH,SEARCH
+	 *
+	 * ME is camping on a UMTS cell but not registered to the network (only e=
mergency call allowed):
+	 * ^SMONI: ACT,UARFCN,PSC,EC/n0,RSCP,MCC,MNC,LAC,cell,SQual,SRxLev,PhysCh=
, SF,Slot,EC/n0,RSCP,ComMod,HSUPA,HSDPA
+	 * ^SMONI: 3G,10564,96,-7.5,-79,262,02,0143,00228FF,-92,-78,LIMSRV
+	 *
+	 * ME has a dedicated channel (for example call in progress):
+	 * ^SMONI: ACT,UARFCN,PSC,EC/n0,RSCP,MCC,MNC,LAC,cell,SQual,SRxLev,PhysCh=
, SF,Slot,EC/n0,RSCP,ComMod,HSUPA,HSDPA
+	 * ^SMONI: 3G,10737,131,-5,-93,260,01,7D3D,C80BC9A,--,--,----,---,-,-5,-9=
3,0,01,06
+	 */
+
+	enum smoni_umts_field {
+		SMONI_UMTS_UARFCN,
+		SMONI_UMTS_PSC,
+		SMONI_UMTS_ECN0,
+		SMONI_UMTS_RSCP,
+		SMONI_UMTS_MCC,
+		SMONI_UMTS_MNC,
+		SMONI_UMTS_LAC,
+		SMONI_UMTS_CI,
+		SMONI_UMTS_MAX,
+	};
+
+	const char *str;
+	float fnumber;
+	int number;
+	int idx;
+
+	cbd->t.umts.uarfcn =3D -1;
+	cbd->t.umts.psc =3D -1;
+	cbd->t.umts.ecn0 =3D -1;
+	cbd->t.umts.rscp =3D -1;
+	cbd->t.umts.lac =3D -1;
+	cbd->t.umts.ci =3D -1;
+
+	for (idx =3D 0; idx < SMONI_UMTS_MAX; idx++) {
+		switch (idx) {
+		case SMONI_UMTS_UARFCN:
+			if (g_at_result_iter_next_number(iter, &number))
+				cbd->t.umts.uarfcn =3D number;
+			break;
+		case SMONI_UMTS_PSC:
+			if (g_at_result_iter_next_number(iter, &number))
+				cbd->t.umts.psc =3D number;
+			break;
+		case SMONI_UMTS_ECN0:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%f", &fnumber) =3D=3D 1)
+					cbd->t.umts.ecn0 =3D (int)fnumber;
+			}
+			break;
+		case SMONI_UMTS_RSCP:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%d", &number) =3D=3D 1)
+					cbd->t.umts.rscp =3D number;
+			}
+			break;
+		case SMONI_UMTS_MCC:
+			if (g_at_result_iter_next_number(iter, &number))
+				snprintf(cbd->op.mcc, 4, "%d", number);
+			break;
+		case SMONI_UMTS_MNC:
+			if (g_at_result_iter_next_number(iter, &number))
+				snprintf(cbd->op.mnc, 4, "%d", number);
+			break;
+		case SMONI_UMTS_LAC:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%x", &number) =3D=3D 1)
+					cbd->t.umts.lac =3D number;
+			}
+			break;
+		case SMONI_UMTS_CI:
+			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+				if (sscanf(str, "%x", &number) =3D=3D 1)
+					cbd->t.umts.ci =3D number;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	DBG(" %-15s %s", "UMTS.MCC", cbd->op.mcc);
+	DBG(" %-15s %s", "UMTS.MNC", cbd->op.mnc);
+	DBG(" %-15s %d", "UMTS.UARFCN", cbd->t.umts.uarfcn);
+	DBG(" %-15s %d", "UMTS.PSC", cbd->t.umts.psc);
+	DBG(" %-15s %d", "UMTS.ECN0", cbd->t.umts.ecn0);
+	DBG(" %-15s %d", "UMTS.RSCP", cbd->t.umts.rscp);
+	DBG(" %-15s %d", "UMTS.LAC", cbd->t.umts.lac);
+	DBG(" %-15s %d", "UMTS.CELL", cbd->t.umts.ci);
+
+	return 0;
+}
+
+static int gemalto_parse_smoni_lte(GAtResultIter *iter,
+					struct req_cb_data *cbd)
+{
+	/*
+	 * ME is camping on a LTE (4G) cell:
+	 * ^SMONI: ACT,EARFCN,Band,DL bandwidth,UL bandwidth,Mode,MCC,MNC,TAC,Glo=
bal Cell ID,Phys-ical Cell ID,Srxlev,RSRP,RSRQ,Conn_state
+	 * ^SMONI: 4G,6300,20,10,10,FDD,262,02,BF75,0345103,350,33,-94,-7,NOCONN
+	 *
+	 * ME is searching and could not (yet) find a suitable LTE (4G) cell:
+	 * ^SMONI: ACT,EARFCN,Band,DL bandwidth,UL bandwidth,Mode,MCC,MNC,TAC,Glo=
bal Cell ID,Phys-ical Cell ID,Srxlev,RSRP,RSRQ,Conn_state
+	 * ^SMONI: 4G,SEARCH
+	 *
+	 * ME is camping on a LTE (4G) cell but not registered to the network (on=
ly emergency call allowed):
+	 * ^SMONI: ACT,EARFCN,Band,DL bandwidth,UL bandwidth,Mode,MCC,MNC,TAC,Glo=
bal Cell ID,Phys-ical Cell ID,Srxlev,RSRP,RSRQ,Conn_state
+	 * ^SMONI: 4G,6300,20,10,10,FDD,262,02,BF75,0345103,350,33,-94,-7,LIMSRV
+	 *
+	 * ME has a dedicated channel (for example call in progress):
+	 * ^SMONI: ACT,EARFCN,Band,DL bandwidth,UL bandwidth,Mode,MCC,MNC,TAC,Glo=
bal Cell ID,Phys-ical Cell ID,TX_power,RSRP,RSRQ,Conn_state
+	 * ^SMONI: 4G,6300,20,10,10,FDD,262,02,BF75,0345103,350,90,-94,-7,CONN
+	 */
+
+	const char *str;
+	int number;
+
+	cbd->t.lte.euarfcn =3D -1;
+	cbd->t.lte.rsrp =3D -1;
+	cbd->t.lte.rsrq =3D -1;
+
+	if (g_at_result_iter_next_number(iter, &number))
+		cbd->t.lte.euarfcn =3D number;
+
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+
+	if (g_at_result_iter_next_number(iter, &number))
+		snprintf(cbd->op.mcc, 4, "%d", number);
+
+	if (g_at_result_iter_next_number(iter, &number))
+		snprintf(cbd->op.mnc, 4, "%d", number);
+
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+	g_at_result_iter_skip_next(iter);
+
+	if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+		if (sscanf(str, "%d", &number) =3D=3D 1)
+			cbd->t.lte.rsrp =3D number;
+	}
+
+	if (g_at_result_iter_next_unquoted_string(iter, &str)) {
+		if (sscanf(str, "%d", &number) =3D=3D 1)
+			cbd->t.lte.rsrq =3D number;
+	}
+
+	DBG(" %-15s %s", "LTE.MCC", cbd->op.mcc);
+	DBG(" %-15s %s", "LTE.MNC", cbd->op.mnc);
+	DBG(" %-15s %d", "LTE.EUARFCN", cbd->t.lte.euarfcn);
+	DBG(" %-15s %d", "LTE.RSRP", cbd->t.lte.rsrp);
+	DBG(" %-15s %d", "LTE.RSRQ", cbd->t.lte.rsrq);
+
+	return 0;
+}
+
+static void gemalto_netmon_finish_success(struct req_cb_data *cbd)
+{
+	struct ofono_netmon *nm =3D cbd->netmon;
+
+	switch (cbd->op.tech) {
+	case OFONO_NETMON_CELL_TYPE_LTE:
+		ofono_netmon_serving_cell_notify(nm, cbd->op.tech,
+					OFONO_NETMON_INFO_MCC, cbd->op.mcc,
+					OFONO_NETMON_INFO_MNC, cbd->op.mnc,
+					OFONO_NETMON_INFO_RSSI, cbd->rssi,
+					OFONO_NETMON_INFO_EARFCN, cbd->t.lte.euarfcn,
+					OFONO_NETMON_INFO_RSRP, cbd->t.lte.rsrp,
+					OFONO_NETMON_INFO_RSRQ, cbd->t.lte.rsrq,
+					OFONO_NETMON_INFO_INVALID);
+		break;
+	case OFONO_NETMON_CELL_TYPE_UMTS:
+		ofono_netmon_serving_cell_notify(nm, cbd->op.tech,
+					OFONO_NETMON_INFO_MCC, cbd->op.mcc,
+					OFONO_NETMON_INFO_MNC, cbd->op.mnc,
+					OFONO_NETMON_INFO_RSSI, cbd->rssi,
+					OFONO_NETMON_INFO_ARFCN, cbd->t.umts.uarfcn,
+					OFONO_NETMON_INFO_PSC, cbd->t.umts.psc,
+					OFONO_NETMON_INFO_ECN0, cbd->t.umts.ecn0,
+					OFONO_NETMON_INFO_RSCP, cbd->t.umts.rscp,
+					OFONO_NETMON_INFO_LAC, cbd->t.umts.lac,
+					OFONO_NETMON_INFO_CI, cbd->t.umts.ci,
+					OFONO_NETMON_INFO_INVALID);
+		break;
+	case OFONO_NETMON_CELL_TYPE_GSM:
+		ofono_netmon_serving_cell_notify(nm, cbd->op.tech,
+					OFONO_NETMON_INFO_MCC, cbd->op.mcc,
+					OFONO_NETMON_INFO_MNC, cbd->op.mnc,
+					OFONO_NETMON_INFO_RSSI, cbd->rssi,
+					OFONO_NETMON_INFO_ARFCN, cbd->t.gsm.arfcn,
+					OFONO_NETMON_INFO_LAC, cbd->t.gsm.lac,
+					OFONO_NETMON_INFO_CI, cbd->t.gsm.ci,
+					OFONO_NETMON_INFO_INVALID);
+		break;
+	default:
+		break;
+	}
+
+	CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+}
+
+static void csq_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int rssi;
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
+	if (!g_at_result_iter_next(&iter, "+CSQ: ")) {
+		cbd->rssi =3D -1;
+		goto out;
+	}
+
+	if (!g_at_result_iter_next_number(&iter, &rssi) || rssi =3D=3D 99)
+		cbd->rssi =3D -1;
+	else
+		cbd->rssi =3D (rssi * 100) / 31;
+
+	DBG(" RSSI %d ", cbd->rssi);
+
+out:
+	gemalto_netmon_finish_success(cbd);
+}
+
+static void smoni_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_netmon *nm =3D cbd->netmon;
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(nm);
+	struct ofono_error error;
+	const char *technology;
+	GAtResultIter iter;
+	int ret;
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
+	/* do not fail */
+
+	if (!g_at_result_iter_next(&iter, "^SMONI: ")) {
+		CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+		return;
+	}
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &technology)) {
+		DBG("^SMONI: failed to parse technology");
+		CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+		return;
+	}
+
+	if (strcmp(technology, "2G") =3D=3D 0) {
+		cbd->op.tech =3D OFONO_NETMON_CELL_TYPE_GSM;
+	} else if (strcmp(technology, "3G") =3D=3D 0) {
+		cbd->op.tech =3D OFONO_NETMON_CELL_TYPE_UMTS;
+	} else if (strcmp(technology, "4G") =3D=3D 0) {
+		cbd->op.tech =3D OFONO_NETMON_CELL_TYPE_LTE;
+	} else {
+		/* fall-back to GSM by default */
+		DBG("^SMONI: unexpected technology: %s", technology);
+		cbd->op.tech =3D OFONO_NETMON_CELL_TYPE_GSM;
+	}
+
+	switch (cbd->op.tech) {
+	case OFONO_NETMON_CELL_TYPE_LTE:
+		ret =3D gemalto_parse_smoni_lte(&iter, cbd);
+		break;
+	case OFONO_NETMON_CELL_TYPE_UMTS:
+		ret =3D gemalto_parse_smoni_umts(&iter, cbd);
+		break;
+	case OFONO_NETMON_CELL_TYPE_GSM:
+		ret =3D gemalto_parse_smoni_gsm(&iter, cbd);
+		break;
+	default:
+		break;
+	}
+
+	if (ret) {
+		CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
+		return;
+	}
+
+	cbd =3D req_cb_data_ref(cbd);
+	if (g_at_chat_send(nmd->chat, "AT+CSQ", csq_prefix,
+				csq_cb, cbd, req_cb_data_unref))
+		return;
+
+	req_cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+}
+
+static void gemalto_netmon_request_update(struct ofono_netmon *netmon,
+						ofono_netmon_cb_t cb,
+						void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct req_cb_data *cbd;
+
+	DBG("gemalto netmon request update");
+
+	cbd =3D req_cb_data_new0(cb, data, netmon);
+
+	if (g_at_chat_send(nmd->chat, "AT^SMONI", smoni_prefix,
+				smoni_cb, cbd, req_cb_data_unref))
+		return;
+
+	req_cb_data_unref(cbd);
+	CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+}
+
+static int gemalto_netmon_probe(struct ofono_netmon *netmon,
+					unsigned int vendor, void *user)
+{
+	GAtChat *chat =3D user;
+	struct netmon_driver_data *nmd;
+
+	DBG("gemalto netmon probe");
+
+	nmd =3D g_try_new0(struct netmon_driver_data, 1);
+	if (nmd =3D=3D NULL)
+		return -ENOMEM;
+
+	nmd->chat =3D g_at_chat_clone(chat);
+
+	ofono_netmon_set_data(netmon, nmd);
+
+	g_idle_add(gemalto_delayed_register, netmon);
+
+	return 0;
+}
+
+static void gemalto_netmon_remove(struct ofono_netmon *netmon)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+
+	DBG("gemalto netmon remove");
+
+	g_at_chat_unref(nmd->chat);
+
+	ofono_netmon_set_data(netmon, NULL);
+
+	g_free(nmd);
+}
+
+static const struct ofono_netmon_driver driver =3D {
+	.name			=3D "gemaltomodem",
+	.probe			=3D gemalto_netmon_probe,
+	.remove			=3D gemalto_netmon_remove,
+	.request_update		=3D gemalto_netmon_request_update,
+};
+
+void gemalto_netmon_init(void)
+{
+	ofono_netmon_driver_register(&driver);
+}
+
+void gemalto_netmon_exit(void)
+{
+	ofono_netmon_driver_unregister(&driver);
+}
--===============3646943206281436447==--

