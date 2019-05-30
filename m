Content-Type: multipart/mixed; boundary="===============1673427833712034478=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 4/4] xmm7modem: adding netmon changes for reporting
 neighbouring cell
Date: Thu, 30 May 2019 14:53:00 +0530
Message-ID: <1559208180-3654-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1673427833712034478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added netmon changes for xmm7modem driver to fetch neighbouring
cell information.
---
 drivers/xmm7modem/netmon.c | 160 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
index ba70e2b..b9aac3e 100644
--- a/drivers/xmm7modem/netmon.c
+++ b/drivers/xmm7modem/netmon.c
@@ -205,6 +205,165 @@ static void xmm7modem_netmon_request_update(struct of=
ono_netmon *netmon,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void xmci_neighbouring_cell_cb
+		(gboolean ok, GAtResult *result, gpointer user_data)
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
+	int mcc =3D -1;
+	int mnc =3D -1;
+	int ci =3D -1;
+	GList *list =3D NULL;
+	struct ofono_netmon_neighbouring_cell *cell;
+	int list_size =3D 0;
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
+
+		tech =3D xmm7modem_map_radio_access_technology(number);
+
+		switch (number) {
+		case XMCI_GSM_NEIGH_CELL:
+			/* skip <MCC>,<MNC>,<LAC>,<CI>,<BSIC> */
+			g_at_result_iter_next_number(&iter, &mcc);
+			g_at_result_iter_next_number(&iter, &mnc);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_number(&iter, &ci);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			rxlev =3D number !=3D 99 ? number : rxlev;
+
+			g_at_result_iter_next_number(&iter, &number);
+			ber =3D number !=3D 99 ? number : ber;
+
+			cell =3D g_new0(struct ofono_netmon_neighbouring_cell,
+					1);
+			cell->cell_type =3D tech;
+			cell->mcc =3D mcc;
+			cell->mnc =3D mnc;
+			cell->cell_id =3D ci;
+			cell->cell_meas.gsm.rssi =3D rxlev;
+			cell->cell_meas.gsm.ber =3D ber;
+
+			list =3D g_list_append(list, cell);
+			break;
+		case XMCI_UMTS_NEIGH_CELL:
+			/*
+			 * skip <MCC>,<MNC>,<LAC>,<CI><PSC>,<DLUARFNC>,
+			 * <ULUARFCN>,<PATHLOSS>,<RSSI>
+			 */
+			g_at_result_iter_next_number(&iter, &mcc);
+			g_at_result_iter_next_number(&iter, &mnc);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_number(&iter, &ci);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			rscp =3D number !=3D 255 ? number : rscp;
+
+			g_at_result_iter_next_number(&iter, &number);
+			ecn0 =3D number !=3D 255 ? number : ecn0;
+
+			cell =3D g_new0(struct ofono_netmon_neighbouring_cell,
+					1);
+			cell->cell_type =3D tech;
+			cell->mcc =3D mcc;
+			cell->mnc =3D mnc;
+			cell->cell_id =3D ci;
+			cell->cell_meas.umts.rscp =3D rscp;
+			cell->cell_meas.umts.ecno =3D ecn0;
+
+			list =3D g_list_append(list, cell);
+			break;
+		case XMCI_LTE_NEIGH_CELL:
+			/*
+			 * skip <MCC>,<MNC>,<TAC>,<CI>,<PCI>,<DLUARFNC>,
+			 * <ULUARFCN>,<PATHLOSS_LTE>
+			 */
+			g_at_result_iter_next_number(&iter, &mcc);
+			g_at_result_iter_next_number(&iter, &mnc);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_number(&iter, &ci);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_skip_next(&iter);
+
+			g_at_result_iter_next_number(&iter, &number);
+			rsrq =3D number !=3D 255 ? number : rsrq;
+
+			g_at_result_iter_next_number(&iter, &number);
+			rsrp =3D number !=3D 255 ? number : rsrp;
+
+			cell =3D g_new0(struct ofono_netmon_neighbouring_cell,
+					1);
+			cell->cell_type =3D tech;
+			cell->mcc =3D mcc;
+			cell->mnc =3D mnc;
+			cell->cell_id =3D ci;
+			cell->cell_meas.lte.rsrq =3D rsrq;
+			cell->cell_meas.lte.rsrp =3D rsrp;
+
+			list =3D g_list_append(list, cell);
+			break;
+		default:
+			break;
+		}
+	}
+
+	list_size =3D g_list_length(list);
+
+	if(list_size)
+		ofono_netmon_neighbouring_cell_notify(netmon, list);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	g_list_free(list);
+}
+
+static void xmm7modem_neighbouring_cell_update(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("xmm7modem netmon request neighbouring cell update");
+
+	if (g_at_chat_send(nmd->chat, "AT+XMCI=3D0", xmci_prefix,
+			xmci_neighbouring_cell_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static gboolean ril_delayed_register(gpointer user_data)
 {
 	struct ofono_netmon *netmon =3D user_data;
@@ -250,6 +409,7 @@ static const struct ofono_netmon_driver driver =3D {
 	.probe			=3D xmm7modem_netmon_probe,
 	.remove			=3D xmm7modem_netmon_remove,
 	.request_update		=3D xmm7modem_netmon_request_update,
+	.neighbouring_cell_update =3D xmm7modem_neighbouring_cell_update,
 };
 =

 void xmm_netmon_init(void)
-- =

1.9.1


--===============1673427833712034478==--

