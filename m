Content-Type: multipart/mixed; boundary="===============6331848174198247863=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: [PATCH v2 1/4] ifxmodem: Add modem driver to support Neighbor cell
 info
Date: Sun, 09 Jan 2011 22:05:30 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231DCEE43@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294490393-26493-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6331848174198247863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Wei, Jun =

Sent: Saturday, January 08, 2011 8:40 PM
To: ofono(a)ofono.org
Cc: Wei, Jun
Subject: [PATCH v2 1/4] ifxmodem: Add modem driver to support Neighbor cell=
 info

From: Jun Wei <jun.wei@intel.com>

---
 drivers/ifxmodem/cell-info.c |  506 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 506 insertions(+), 0 deletions(-)
 create mode 100755 drivers/ifxmodem/cell-info.c

diff --git a/drivers/ifxmodem/cell-info.c b/drivers/ifxmodem/cell-info.c
new file mode 100755
index 0000000..5eeab8f
--- /dev/null
+++ b/drivers/ifxmodem/cell-info.c
@@ -0,0 +1,506 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <ofono/cell-info.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "ifxmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *xcellinfo_prefix[] =3D { "+XCELLINFO:", NULL };
+
+struct cell_info_data {
+	GAtChat *chat;
+};
+
+static gboolean handle_gsm_servingcell_info(GAtResultIter *iter,
+		struct ofono_cell_info_results *sc, int index)
+{
+	int mcc, mnc, lac, ci, rxlev, bsic, bcch_car, true_freq, t_advance;
+
+	DBG("");
+
+	if (index >=3D OFONO_MAX_NMR_COUNT) {
+		ofono_error("Wrong number of GSM cells");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &mcc)) {
+		ofono_error("Fail to parse mcc");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &mnc)) {
+		ofono_error("Fail to parse mnc");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &lac)) {
+		ofono_error("Fail to parse lac");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &ci)) {
+		ofono_error("Fail to parse ci");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &rxlev)) {
+		ofono_error("Fail to parse rxlev");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &bsic)) {
+		ofono_error("Fail to parse bsic");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &bcch_car)) {
+		ofono_error("Fail to parse bcch_car");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &true_freq)) {
+		ofono_error("Fail to parse true_freq");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &t_advance)) {
+		ofono_error("Fail to parse t_advance");
+		return FALSE;
+	}
+
+	sc->mnc =3D mnc;
+	sc->mcc =3D mcc;
+
+	sc->geran.lac =3D lac;
+	sc->geran.ci =3D ci;
+	sc->geran.ta =3D t_advance;
+	sc->geran.nmr[index].arfcn =3D bcch_car;
+	sc->geran.nmr[index].bsic =3D bsic;
+	sc->geran.nmr[index].rxlev =3D rxlev;
+
+
+	return TRUE;
+}
+
+static gboolean handle_gsm_neighbourcell_info(GAtResultIter *iter,
+		struct ofono_cell_info_results *nc, int index)
+{
+	int lac, ci, rxlev, bsic, bcch_car;
+
+	DBG("");
+
+	if (index >=3D OFONO_MAX_NMR_COUNT) {
+		ofono_error("Wrong number of GSM neighbour cells");
+		return FALSE;
+	}
+
+
+	if (!g_at_result_iter_next_number(iter, &lac)) {
+		ofono_error("Fail to parse lac");
+		/* So far LAC is reported but not used */
+	}
+
+	if (!g_at_result_iter_next_number(iter, &ci)) {
+		ofono_error("Fail to parse ci");
+		/* So far CI is reported but not used */
+	}
+
+	if (!g_at_result_iter_next_number(iter, &rxlev)) {
+		ofono_error("Fail to parse rxlev");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &bsic)) {
+		ofono_error("Fail to parse bsic");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &bcch_car)) {
+		ofono_error("Fail to parse bcch_car");
+		return FALSE;
+	}
+
+	nc->geran.nmr[index].arfcn =3D bcch_car;
+	nc->geran.nmr[index].bsic =3D bsic;
+	nc->geran.nmr[index].rxlev =3D rxlev;
+
+	return TRUE;
+}
+
+static gboolean handle_umts_fdd_servingcell_info(GAtResultIter *iter,
+				struct ofono_cell_info_results  *sc)
+{
+	int mcc, mnc, lac, uci, dl_freq, ul_freq, scrambling_code;
+
+	DBG("");
+
+	if (!g_at_result_iter_next_number(iter, &mcc)) {
+		ofono_error("Fail to parse mcc");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &mnc)) {
+		ofono_error("Fail to parse mnc");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &lac)) {
+		ofono_error("Fail to parse lac");
+		/* So far LAC is reported but not used */
+	}
+
+	if (!g_at_result_iter_next_number(iter, &uci)) {
+		ofono_error("Fail to parse uci");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &scrambling_code)) {
+		ofono_error("Fail to parse scrambling code");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &dl_freq)) {
+		ofono_error("Fail to parse dl freq");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &ul_freq)) {
+		ofono_error("Fail to parse ul freq");
+		return FALSE;
+	}
+
+	sc->mcc =3D mcc;
+	sc->mnc =3D mnc;
+
+	sc->utran.ucid =3D uci;
+	sc->utran.dl_freq =3D dl_freq;
+	sc->utran.ul_freq =3D ul_freq;
+	sc->utran.sc =3D scrambling_code;
+
+	return TRUE;
+}
+
+static void fill_utran_mrl(struct measured_results_list *mrl, int dl_freq,
+	int rssi, int scrambling_code, int ecn0, int rscp, int pathloss)
+{
+	mrl->dl_freq =3D dl_freq;
+	mrl->rssi =3D rssi;
+	mrl->no_cells++;
+	mrl->cmr[0].sc =3D scrambling_code;
+	mrl->cmr[0].ecn0 =3D ecn0;
+	mrl->cmr[0].rscp =3D rscp;
+	mrl->cmr[0].pathloss =3D pathloss;
+}
+
+static void fill_utran_cmr(struct cell_measured_results *cmr,
+	int scrambling_code, int ecn0, int rscp, int pathloss)
+{
+	cmr->sc =3D scrambling_code;
+	cmr->ecn0 =3D ecn0;
+	cmr->rscp =3D rscp;
+	cmr->pathloss =3D pathloss;
+}
+
+static gboolean handle_umts_fdd_neighbourcell_info(GAtResultIter *iter,
+				struct ofono_cell_info_results  *nc)
+{
+	int scrambling_code, dl_freq, rssi, rscp, ecn0, pathloss;
+	gboolean same_freq_found =3D FALSE;
+	int i, j;
+
+	DBG("");
+
+	if (!g_at_result_iter_next_number(iter, &scrambling_code)) {
+		ofono_error("Fail to parse scramble code");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &dl_freq)) {
+		ofono_error("Fail to parse dl freq");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &rssi)) {
+		ofono_error("Fail to parse rssi");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &rscp)) {
+		ofono_error("Fail to parse rscp");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &ecn0)) {
+		ofono_error("Fail to parse ecn0");
+		return FALSE;
+	}
+
+	if (!g_at_result_iter_next_number(iter, &pathloss)) {
+		ofono_error("Fail to parse path loss");
+		return FALSE;
+	}
+
+	if (nc->utran.no_freq =3D=3D 0) {
+		fill_utran_mrl(&(nc->utran.mrl[nc->utran.no_freq++]),
+			dl_freq, rssi, scrambling_code, ecn0, rscp, pathloss);
+		return TRUE;
+	}
+
+	for (i =3D 0; i < nc->utran.no_freq && i < OFONO_MAX_MEAS_RES_LIST_COUNT;=
 i++) {
+		if (nc->utran.mrl[i].dl_freq =3D=3D dl_freq) {
+			same_freq_found =3D TRUE;
+
+			for (j =3D 0; j < nc->utran.mrl[i].no_cells && j < OFONO_MAX_MEASURED_C=
ELL_COUNT; j++) {
+				if (nc->utran.mrl[i].cmr[j].sc =3D=3D scrambling_code) {
+					/* same frequency + same scramble code -> same cell */
+					ofono_warn("same cell info has been reported");
+					return TRUE;
+				}
+			}
+
+			/* same frequency + different scramble code ->  NEW cell */
+			fill_utran_cmr(&(nc->utran.mrl[i].cmr[j]),
+					scrambling_code, ecn0, rscp, pathloss);
+			nc->utran.mrl[i].no_cells++;
+			DBG("no_cell: %d", nc->utran.mrl[i].no_cells);
+		} else {
+			continue;
+		}
+	}
+
+	/* different frequency ->  NEW cell */
+	if (!same_freq_found) {
+		DBG("no_freq: %d", nc->utran.no_freq);
+
+		if (nc->utran.no_freq >=3D OFONO_MAX_MEAS_RES_LIST_COUNT)
+			return FALSE;
+
+		fill_utran_mrl(&(nc->utran.mrl[nc->utran.no_freq++]),
+				dl_freq, rssi, scrambling_code, ecn0, rscp, pathloss);
+	}
+
+	return TRUE;
+}
+
+
+static void xcellinfo_query_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cell_info_query_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	struct ofono_cell_info_results cellinfo;
+	gboolean gsm_sc_found =3D FALSE;
+	gboolean umts_fdd_sc_found =3D FALSE;
+	int num =3D 0;
+
+	DBG("");
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+    memset(&cellinfo, 0, sizeof(cellinfo));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+XCELLINFO:")) {
+		int type;
+
+		if (!g_at_result_iter_next_number(&iter, &type)) {
+			ofono_warn("Fail to parse cell type info");
+			continue;
+		}
+
+		switch (type) {
+		case 0:
+			/* GSM serving cell */
+			if (umts_fdd_sc_found || gsm_sc_found)
+				continue;
+
+			gsm_sc_found =3D TRUE;
+			cellinfo.rat =3D OFONO_CELL_TYPE_GERAN;
+
+			if (!handle_gsm_servingcell_info(&iter, &cellinfo, num)) {
+				ofono_warn("Wrong GSM serving cell info");
+				continue;
+			}
+
+			cellinfo.geran.no_cells =3D ++num;
+
+			break;
+		case 1:
+			/* GSM neighbour cell */
+			if (umts_fdd_sc_found)
+				continue;
+
+			cellinfo.rat =3D OFONO_CELL_TYPE_GERAN;
+
+			if (!handle_gsm_neighbourcell_info(&iter, &cellinfo, num)) {
+				ofono_warn("Wrong GSM neighbour cell info");
+				continue;
+			}
+
+			cellinfo.geran.no_cells =3D ++num;
+
+			break;
+		case 2:
+			if (gsm_sc_found || umts_fdd_sc_found)
+				continue;
+
+			umts_fdd_sc_found =3D TRUE;
+			cellinfo.rat =3D OFONO_CELL_TYPE_UTRAN_FDD;
+
+			if (!handle_umts_fdd_servingcell_info(&iter, &cellinfo)) {
+				ofono_warn("Wrong UMTS FDD serving cell info");
+				continue;
+			}
+
+			break;
+		case 3:
+			/* UMTS FDD neighbour cell */
+			if (gsm_sc_found)
+				continue;
+
+			cellinfo.rat =3D OFONO_CELL_TYPE_UTRAN_FDD;
+
+			if (!handle_umts_fdd_neighbourcell_info(&iter, &cellinfo)) {
+				ofono_warn("Wrong UMTS FDD neighbour cell info");
+				continue;
+			}
+
+			break;
+		default:
+			/* Other types are not supported */
+			ofono_error("Cell type %d is not supported", type);
+			CALLBACK_WITH_FAILURE(cb, &cellinfo, cbd->data);
+			return;
+		}
+
+	}
+
+	cb(&error, &cellinfo, cbd->data);
+}
+
+static void ifx_cell_info_query(struct ofono_cell_info *ci,
+			 ofono_cell_info_query_cb_t cb,
+			 void *data)
+{
+	struct cell_info_data *cid =3D ofono_cell_info_get_data(ci);
+	struct cb_data *cbd =3D cb_data_new(cb, ci);
+
+	DBG("");
+
+	if (!cbd)
+		goto error;
+
+	if (g_at_chat_send(cid->chat, "AT+XCELLINFO?", xcellinfo_prefix,
+		xcellinfo_query_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
+
+}
+
+static void xcellinfo_support_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+{
+	struct ofono_cell_info *ci =3D user_data;
+
+	if (!ok)
+		return;
+
+	ofono_cell_info_register(ci);
+}
+
+static int ifx_cell_info_probe(struct ofono_cell_info *ci,
+			unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct cell_info_data *cid;
+
+	DBG("");
+
+	cid =3D g_try_new0(struct cell_info_data, 1);
+
+	if (!cid)
+		return -ENOMEM;
+
+	cid->chat =3D g_at_chat_clone(chat);
+
+	ofono_cell_info_set_data(ci, cid);
+
+	g_at_chat_send(cid->chat, "AT+XCELLINFO=3D?", none_prefix,
+			xcellinfo_support_cb, ci, NULL);
+
+	return 0;
+}
+
+static void ifx_cell_info_remove(struct ofono_cell_info *ci)
+{
+	struct cell_info_data *cid =3D ofono_cell_info_get_data(ci);
+
+	ofono_cell_info_set_data(ci, NULL);
+
+	g_at_chat_unref(cid->chat);
+	g_free(cid);
+}
+
+static struct ofono_cell_info_driver driver =3D {
+	.name		=3D "ifxmodem",
+	.probe		=3D ifx_cell_info_probe,
+	.remove		=3D ifx_cell_info_remove,
+	.query		=3D ifx_cell_info_query,
+};
+
+void ifx_cell_info_init()
+{
+	ofono_cell_info_driver_register(&driver);
+}
+
+void ifx_cell_info_exit()
+{
+	ofono_cell_info_driver_unregister(&driver);
+}
-- =

1.7.2.3


--===============6331848174198247863==--

