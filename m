Content-Type: multipart/mixed; boundary="===============0857789818653075627=="
MIME-Version: 1.0
From: jun.wei@intel.com
Subject: [RFC 1/3] ifxmodem: Add modem driver to support Neighbor Cell Info
Date: Tue, 23 Nov 2010 13:12:05 +0800
Message-ID: <1290489125-11876-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0857789818653075627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jun Wei <jun.wei@intel.com>

---
 drivers/ifxmodem/cell-info.c |  398 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 398 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ifxmodem/cell-info.c

diff --git a/drivers/ifxmodem/cell-info.c b/drivers/ifxmodem/cell-info.c
new file mode 100644
index 0000000..471d248
--- /dev/null
+++ b/drivers/ifxmodem/cell-info.c
@@ -0,0 +1,398 @@
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
+#define OFONO_MAX_NEIGHBOUR_CELL_NUMBER 15
+
+static const char *none_prefix[] =3D { NULL };
+static const char *xcellinfo_prefix[] =3D { "+XCELLINFO:", NULL };
+
+struct cell_info_data {
+	GAtChat *chat;
+};
+
+static gboolean handle_gsm_servingcell_info(GAtResultIter *iter,
+		struct ofono_cell_info_results *sc)
+{
+	int mcc, mnc, lac, ci, rxlev, bsic, bcch_car, true_freq, t_advance;
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
+	sc->geran.serving_cell.lac =3D lac;
+	sc->geran.serving_cell.ci =3D ci;
+	sc->geran.serving_cell.arfcn =3D bcch_car;
+	sc->geran.serving_cell.bsic =3D bsic;
+	sc->geran.serving_cell.rxlev =3D rxlev;
+	sc->geran.serving_cell.ta =3D t_advance;
+	sc->geran.serving_cell.true_freq =3D true_freq;
+
+	snprintf(sc->mcc, sizeof(sc->mcc), "%d", mcc);
+	snprintf(sc->mnc, sizeof(sc->mnc), "%d", mnc);
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
+	nc->geran.nmr[index].lac =3D lac;
+	nc->geran.nmr[index].ci =3D ci;
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
+		return FALSE;
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
+	sc->utra_fdd.serving_cell.lac =3D lac;
+	sc->utra_fdd.serving_cell.uc =3D uci;
+	sc->utra_fdd.serving_cell.scrambling_code =3D scrambling_code;
+	sc->utra_fdd.serving_cell.dl_frequency =3D dl_freq;
+	sc->utra_fdd.serving_cell.ul_frequency =3D ul_freq;
+
+	snprintf(sc->mcc, sizeof(sc->mcc), "%d", mcc);
+	snprintf(sc->mnc, sizeof(sc->mnc), "%d", mnc);
+
+	return TRUE;
+}
+
+static void xcellinfo_query_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_cell_info_query_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+	GAtResultIter iter;
+	struct ofono_cell_info_results cellinfo;
+	gboolean gsm_servingcell_found =3D FALSE;
+	gboolean umts_fdd_servingcell_found =3D FALSE;
+	int num =3D 0;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, cellinfo, cbd->data);
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
+			if (gsm_servingcell_found) {
+				ofono_warn("More than 1 GSM serving cell found!");
+				continue;
+			}
+
+			gsm_servingcell_found =3D TRUE;
+			cellinfo.rat =3D OFONO_CELL_INFO_GERAN;
+
+			if (!handle_gsm_servingcell_info(&iter, &cellinfo)) {
+				ofono_warn("Wrong GSM serving cell info");
+				continue;
+			}
+
+			break;
+		case 1:
+			/* GSM neighbour cell */
+			num++;
+
+			if (num > OFONO_MAX_NEIGHBOUR_CELL_NUMBER) {
+				ofono_error("Wrong number of GSM neighbour cell");
+				continue;
+			}
+
+			cellinfo.rat =3D OFONO_CELL_INFO_GERAN;
+
+			if (!handle_gsm_neighbourcell_info(&iter, &cellinfo, (num - 1))) {
+				ofono_warn("Wrong GSM neighbour cell info");
+				continue;
+			}
+
+			cellinfo.geran.no_cells =3D num;
+
+			break;
+		case 2:
+			/* UMTS FDD serving cell */
+			if (umts_fdd_servingcell_found) {
+				ofono_warn("More than 1 UMTS FDD serving cell found!");
+				continue;
+			}
+
+			umts_fdd_servingcell_found =3D TRUE;
+			cellinfo.rat =3D OFONO_CELL_INFO_UTRA_FDD;
+
+			if (!handle_umts_fdd_servingcell_info(&iter, &cellinfo)) {
+				ofono_warn("Wrong UMTS FDD serving cell info");
+				continue;
+			}
+
+			break;
+		case 3:
+			/* UMTS FDD neighbour cell */
+			cellinfo.rat =3D OFONO_CELL_INFO_UTRA_FDD;
+
+			/*
+			* TODO: wait for the clarification from modem vendor
+			* on the neighbour cell info of UMTS FDD network
+			* handle_umts_fdd_neighbourcell_info(&iter, &cellinfo);
+			*/
+
+			ofono_warn("UMTS FDD NBR cell is not supported");
+			continue;
+
+		default:
+			/* Other types are not supported */
+			ofono_error("Cell type %d is not supported", type);
+			CALLBACK_WITH_FAILURE(cb, cellinfo, cbd->data);
+			return;
+		}
+
+	}
+
+	cb(&error, cellinfo, cbd->data);
+}
+
+static void ifx_cell_info_query(struct ofono_cell_info *ci,
+			 ofono_cell_info_query_cb_t cb,
+			 void *data)
+{
+	struct cell_info_data *cid =3D ofono_cell_info_get_data(ci);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct ofono_cell_info_results cellinfo;
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
+	CALLBACK_WITH_FAILURE(cb, cellinfo, data);
+
+}
+
+static void xcellinfo_support_cb(gboolean ok, GAtResult *result, gpointer =
user_data)
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


--===============0857789818653075627==--

