Content-Type: multipart/mixed; boundary="===============1451953689569285184=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 2/5] isimodem: Driver implementation
Date: Mon, 07 Mar 2011 12:24:31 +0200
Message-ID: <1299493474-12982-3-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1451953689569285184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/cell-info.c |  375 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 375 insertions(+), 0 deletions(-)
 create mode 100644 drivers/isimodem/cell-info.c

diff --git a/drivers/isimodem/cell-info.c b/drivers/isimodem/cell-info.c
new file mode 100644
index 0000000..0420327
--- /dev/null
+++ b/drivers/isimodem/cell-info.c
@@ -0,0 +1,375 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gisi/client.h>
+#include <gisi/iter.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cell-info.h>
+
+#include "util.h"
+
+#include "isimodem.h"
+#include "isiutil.h"
+#include "sim.h"
+#include "debug.h"
+
+struct ci_data {
+	GIsiClient *client;
+};
+
+struct ci_container {
+	GIsiClient *client;
+	struct ofono_cell_info *ci;
+};
+
+static void mnc_to_string(uint16_t s, char *t)
+{
+	int i;
+
+	for (i =3D OFONO_MAX_MNC_LENGTH-1; i >=3D 0; i--) {
+		t[i] =3D '0' + (char) (s % 10);
+		s /=3D 10;
+	}
+
+	t[OFONO_MAX_MNC_LENGTH] =3D '\0';
+}
+
+static void mcc_to_string(uint16_t s, char *t)
+{
+	int i;
+
+	for (i =3D OFONO_MAX_MCC_LENGTH-1; i >=3D 0; i--) {
+		t[i] =3D '0' + (char) (s % 10);
+		s /=3D 10;
+	}
+
+	t[OFONO_MAX_MCC_LENGTH] =3D '\0';
+}
+
+static gboolean check_response_status(const GIsiMessage *msg, uint8_t msgi=
d)
+{
+	DBG("");
+
+	if (g_isi_msg_error(msg) < 0) {
+		DBG("Error: %s", strerror(-g_isi_msg_error(msg)));
+		return FALSE;
+	}
+
+	if (g_isi_msg_id(msg) !=3D msgid) {
+		DBG("Unexpected msg: %s",
+			ss_message_id_name(g_isi_msg_id(msg)));
+		return FALSE;
+	}
+	return TRUE;
+
+}
+
+static gboolean decode_geran_info(GIsiSubBlockIter *iter,
+		struct ofono_cell_info_results *cir)
+{
+	int i;
+	uint16_t mcc, mnc;
+
+	DBG("");
+
+	if (!g_isi_sb_iter_eat_word(iter, &mcc) ||
+			!g_isi_sb_iter_eat_word(iter, &mnc) ||
+			!g_isi_sb_iter_eat_word(iter, &cir->geran.lac) ||
+			!g_isi_sb_iter_eat_word(iter, &cir->geran.ci) ||
+			!g_isi_sb_iter_eat_byte(iter, &cir->geran.ta) ||
+			!g_isi_sb_iter_eat_byte(iter, &cir->geran.no_cells))
+		return FALSE;
+
+	mcc_to_string(mcc, cir->mcc);
+	mnc_to_string(mnc, cir->mnc);
+
+	DBG("geran.no_cells %d", cir->geran.no_cells);
+
+	for (i =3D 0; i < cir->geran.no_cells; ++i) {
+
+		if (!g_isi_sb_iter_eat_word(iter, &cir->geran.nmr[i].arfcn) ||
+				!g_isi_sb_iter_eat_byte(iter,
+					&cir->geran.nmr[i].bsic) ||
+				!g_isi_sb_iter_eat_byte(iter,
+					&cir->geran.nmr[i].rxlev))
+			return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean decode_utra_info(GIsiSubBlockIter *iter,
+				struct ofono_cell_info_results *cir)
+{
+	int i, j;
+	uint16_t mcc, mnc;
+	struct measured_results_list *l;
+
+	DBG("");
+
+	if (!g_isi_sb_iter_eat_dword(iter, &cir->utran.ucid) ||
+			!g_isi_sb_iter_eat_word(iter, &mcc) ||
+			!g_isi_sb_iter_eat_word(iter, &mnc) ||
+			!g_isi_sb_iter_eat_word(iter, &cir->utran.sc) ||
+			!g_isi_sb_iter_eat_word(iter, &cir->utran.dl_freq) ||
+			!g_isi_sb_iter_eat_byte(iter, &cir->utran.no_freq))
+		return FALSE;
+
+	mcc_to_string(mcc, cir->mcc);
+	mnc_to_string(mnc, cir->mnc);
+
+	DBG("utran.no_freq: %d", cir->utran.no_freq);
+
+	cir->utran.ul_freq =3D OFONO_CI_FIELD_FREQ_UNDEFINED;
+	iter->cursor +=3D 3;
+
+	for (i =3D 0; i < cir->utran.no_freq; ++i) {
+		l =3D cir->utran.mrl + i;
+
+		if (!g_isi_sb_iter_eat_word(iter, &l->dl_freq) ||
+				!g_isi_sb_iter_eat_byte(iter, &l->rssi) ||
+				!g_isi_sb_iter_eat_byte(iter, &l->no_cells))
+			return FALSE;
+
+		l->ul_freq =3D OFONO_CI_FIELD_FREQ_UNDEFINED;
+
+		DBG("l->no_cells: %d", l->no_cells);
+
+		for (j =3D 0; j < l->no_cells; ++j) {
+
+			if (!g_isi_sb_iter_eat_dword(iter, &l->cmr[j].ucid) ||
+					!g_isi_sb_iter_eat_word(iter,
+						&l->cmr[j].sc) ||
+					!g_isi_sb_iter_eat_byte(iter,
+						&l->cmr[j].ecn0) ||
+					!g_isi_sb_iter_eat_byte(iter,
+						(uint8_t *)&l->cmr[j].rscp) ||
+					!g_isi_sb_iter_eat_byte(iter,
+						&l->cmr[j].pathloss))
+				return FALSE;
+
+			iter->cursor +=3D 3;
+		}
+	}
+
+	return TRUE;
+}
+
+static void query_resp_cb(const GIsiMessage *msg, void* data)
+{
+	struct isi_cb_data *cbd =3D data;
+	struct ofono_cell_info *ci =3D cbd->user;
+	struct ofono_cell_info_results results;
+	ofono_cell_info_query_cb_t cb =3D cbd->cb;
+	GIsiSubBlockIter iter;
+
+	uint8_t succ_code, sb_count, sb_id;
+
+	DBG("");
+
+	g_isi_msg_data_get_byte(msg, 0, &succ_code);
+	g_isi_msg_data_get_byte(msg, 1, &sb_count);
+
+
+	if (!check_response_status(msg, NET_NEIGHBOUR_CELLS_RESP))
+		goto error;
+
+	if (succ_code !=3D NET_CAUSE_OK)
+		goto error;
+
+	if (sb_count > 0) {
+
+		g_isi_msg_data_get_byte(msg, 2, &sb_id);
+
+		switch (sb_id) {
+
+		case NET_ECID_GERAN_INFO:
+			results.has_geran_cells =3D TRUE;
+			g_isi_sb_iter_init_full(&iter, msg, 2, FALSE,
+					sb_count);
+
+			if (decode_geran_info(&iter, &results))
+				goto success;
+			else
+				goto error;
+
+		case NET_ECID_UTRAN_FDD_INFO:
+			results.has_utran_cells =3D TRUE;
+			g_isi_sb_iter_init_full(&iter, msg, 2, TRUE, sb_count);
+
+			if (decode_utra_info(&iter, &results))
+				goto success;
+			else
+				goto error;
+
+		}
+	}
+
+success:
+	DBG("Cell info decoding successful for isi modem");
+	CALLBACK_WITH_SUCCESS(cb, &results, ci);
+	g_free(cbd);
+	return;
+
+error:
+	ofono_error("Cell info decoding failed for isi modem");
+	CALLBACK_WITH_FAILURE(cb, &results, ci);
+	g_free(cbd);
+	return;
+
+}
+
+static void isi_cell_info_query(struct ofono_cell_info *ci,
+			ofono_cell_info_query_cb_t cb, void *data)
+{
+	struct ci_data *cid =3D data;
+	struct isi_cb_data *cbd =3D isi_cb_data_new(ci, cb, data);
+
+	const uint8_t msg[] =3D {
+		NET_NEIGHBOUR_CELLS_REQ,
+		NET_ECID_INFORMATION
+	};
+
+	DBG("ci_data: %p", cid);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	if (g_isi_client_send(cid->client, msg, sizeof(msg),
+			query_resp_cb, cbd, NULL) =3D=3D TRUE)
+		return;
+
+error:
+	DBG("Error");
+	CALLBACK_WITH_FAILURE(cb, NULL, ci);
+	g_free(cbd);
+
+
+}
+
+static void reachable_cb(const GIsiMessage *msg, void *data)
+{
+	struct ci_container *con =3D data;
+	struct ci_data *cid;
+
+	DBG("");
+
+	if (g_isi_msg_error(msg) < 0) {
+		g_free(con);
+		return;
+	}
+
+	cid =3D g_try_new(struct ci_data, 1);
+	cid->client =3D con->client;
+
+	ofono_cell_info_set_data(con->ci, cid);
+
+	ISI_VERSION_DBG(msg);
+	ofono_cell_info_register(con->ci);
+	g_free(con);
+}
+
+
+static int isi_cell_info_probe(struct ofono_cell_info *ci,
+			unsigned int vendor, void *data)
+{
+	GIsiModem *modem =3D data;
+	struct ci_container *c1, *c2;
+
+	DBG("");
+
+	if (data =3D=3D NULL)
+		return -ENOMEM;
+
+	c1 =3D g_try_new0(struct ci_container, 1);
+	c2 =3D g_try_new0(struct ci_container, 1);
+
+	c1->ci =3D c2->ci =3D ci;
+
+	c1->client =3D g_isi_client_create(modem, PN_MODEM_NETWORK);
+	c2->client =3D g_isi_client_create(modem, PN_NETWORK);
+
+	if (c1->client =3D=3D NULL && c1->client =3D=3D NULL)
+		return -ENOMEM;
+
+	if (c1->client =3D=3D NULL) {
+		ofono_error("Client creation failed, client: %p", c1);
+		g_free(c1);
+	} else
+		g_isi_client_verify(c1->client, reachable_cb, c1, NULL);
+
+	if (c2->client =3D=3D NULL) {
+		ofono_error("Client creation failed, client: %p", c2);
+		g_free(c2);
+
+	} else
+		g_isi_client_verify(c2->client, reachable_cb, c2, NULL);
+
+	return 0;
+
+}
+
+static void isi_cell_info_remove(struct ofono_cell_info *ci)
+{
+	struct ci_data *data =3D ofono_cell_info_get_data(ci);
+
+	DBG("");
+
+	ofono_cell_info_set_data(ci, NULL);
+
+	if (data =3D=3D NULL)
+		return;
+
+	g_isi_client_destroy(data->client);
+	g_free(data);
+}
+
+
+
+static struct ofono_cell_info_driver driver =3D {
+	.name	=3D "isimodem",
+	.probe	=3D isi_cell_info_probe,
+	.remove	=3D isi_cell_info_remove,
+	.query	=3D isi_cell_info_query,
+};
+
+void isi_cell_info_init()
+{
+	DBG("");
+	ofono_cell_info_driver_register(&driver);
+}
+
+void isi_cell_info_exit()
+{
+	DBG("");
+	ofono_cell_info_driver_unregister(&driver);
+}
+
-- =

1.7.1


--===============1451953689569285184==--

