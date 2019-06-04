Content-Type: multipart/mixed; boundary="===============3790621899620870726=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 3/3] xmm7modem: adding netmon changes for reporting
 neighbouring cell
Date: Tue, 04 Jun 2019 17:08:58 +0530
Message-ID: <1559648338-18787-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3790621899620870726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added netmon changes for xmm7modem driver to fetch neighbouring
cell information.
---
 drivers/xmm7modem/netmon.c | 95 ++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/xmm7modem/netmon.c b/drivers/xmm7modem/netmon.c
index ba70e2b..3ca0936 100644
--- a/drivers/xmm7modem/netmon.c
+++ b/drivers/xmm7modem/netmon.c
@@ -47,6 +47,7 @@ static const char *xmci_prefix[] =3D { "+XMCI:", NULL };
 =

 struct netmon_driver_data {
 	GAtChat *chat;
+	int xmci_mode;
 };
 =

 enum xmci_ofono_type_info {
@@ -85,6 +86,7 @@ static void xmci_cb(gboolean ok, GAtResult *result, gpoin=
ter user_data)
 {
 	struct cb_data *cbd =3D user_data;
 	struct ofono_netmon *netmon =3D cbd->data;
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
 	ofono_netmon_cb_t cb =3D cbd->cb;
 	struct ofono_error error;
 	GAtResultIter iter;
@@ -96,6 +98,10 @@ static void xmci_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	int ecn0 =3D -1;
 	int rsrq =3D -1;
 	int tech =3D -1;
+	int type =3D -1;
+	const char *cell_id;
+	char mcc[3];
+	char mnc[3];
 =

 	DBG("ok %d", ok);
 =

@@ -109,18 +115,21 @@ static void xmci_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	g_at_result_iter_init(&iter, result);
 =

 	while (g_at_result_iter_next(&iter, "+XMCI:")) {
-		if (!g_at_result_iter_next_number(&iter, &number))
+		if (!g_at_result_iter_next_number(&iter, &type))
 			break;
 =

-		tech =3D xmm7modem_map_radio_access_technology(number);
+		tech =3D xmm7modem_map_radio_access_technology(type);
 =

-		switch (number) {
+		switch (type) {
+		case XMCI_GSM_NEIGH_CELL:
 		case XMCI_GSM_SERV_CELL:
-			/* skip <MCC>,<MNC>,<LAC>,<CI>,<BSIC> */
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
+			/* <MCC>,<MNC>,<LAC>,<CI>,<BSIC> */
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mcc, 3, "%d", number);
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mnc, 3, "%d", number);
 			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_string(&iter, &cell_id);
 			g_at_result_iter_skip_next(&iter);
 =

 			g_at_result_iter_next_number(&iter, &number);
@@ -129,15 +138,18 @@ static void xmci_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 			g_at_result_iter_next_number(&iter, &number);
 			ber =3D number !=3D 99 ? number : ber;
 			break;
+		case XMCI_UMTS_NEIGH_CELL:
 		case XMCI_UMTS_SERV_CELL:
 			/*
-			 * skip <MCC>,<MNC>,<LAC>,<CI><PSC>,<DLUARFNC>,
+			 * <MCC>,<MNC>,<LAC>,<CI><PSC>,<DLUARFNC>,
 			 * <ULUARFCN>,<PATHLOSS>,<RSSI>
 			 */
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mcc, 3, "%d", number);
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mnc, 3, "%d", number);
 			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_string(&iter, &cell_id);
 			g_at_result_iter_skip_next(&iter);
 			g_at_result_iter_skip_next(&iter);
 			g_at_result_iter_skip_next(&iter);
@@ -150,15 +162,18 @@ static void xmci_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 			g_at_result_iter_next_number(&iter, &number);
 			ecn0 =3D number !=3D 255 ? number : ecn0;
 			break;
+		case XMCI_LTE_NEIGH_CELL:
 		case XMCI_LTE_SERV_CELL:
 			/*
-			 * skip <MCC>,<MNC>,<TAC>,<CI>,<PCI>,<DLUARFNC>,
+			 * <MCC>,<MNC>,<TAC>,<CI>,<PCI>,<DLUARFNC>,
 			 * <ULUARFCN>,<PATHLOSS_LTE>
 			 */
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mcc, 3, "%d", number);
+			g_at_result_iter_next_number(&iter, &number);
+			snprintf(mnc, 3, "%d", number);
 			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
-			g_at_result_iter_skip_next(&iter);
+			g_at_result_iter_next_string(&iter, &cell_id);
 			g_at_result_iter_skip_next(&iter);
 			g_at_result_iter_skip_next(&iter);
 			g_at_result_iter_skip_next(&iter);
@@ -174,8 +189,15 @@ static void xmci_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 			break;
 		}
 =

-		ofono_netmon_serving_cell_notify(netmon,
+		if ((nmd->xmci_mode =3D=3D 0) &&
+				(type =3D=3D XMCI_GSM_NEIGH_CELL ||
+				type =3D=3D XMCI_UMTS_NEIGH_CELL ||
+				type =3D=3D XMCI_LTE_NEIGH_CELL)) {
+			ofono_netmon_neighbouring_cell_notify(netmon,
 						tech,
+						OFONO_NETMON_INFO_MCC, mcc,
+						OFONO_NETMON_INFO_MNC, mnc,
+						OFONO_NETMON_INFO_CI, cell_id,
 						OFONO_NETMON_INFO_RXLEV, rxlev,
 						OFONO_NETMON_INFO_BER, ber,
 						OFONO_NETMON_INFO_RSCP, rscp,
@@ -183,10 +205,25 @@ static void xmci_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 						OFONO_NETMON_INFO_RSRQ, rsrq,
 						OFONO_NETMON_INFO_RSRP, rsrp,
 						OFONO_NETMON_INFO_INVALID);
-
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-		break;
+		} else if ((nmd->xmci_mode =3D=3D 1) &&
+				(type =3D=3D XMCI_GSM_SERV_CELL ||
+				type =3D=3D XMCI_UMTS_SERV_CELL ||
+				type =3D=3D XMCI_LTE_SERV_CELL)) {
+			ofono_netmon_serving_cell_notify(netmon,
+						tech,
+						OFONO_NETMON_INFO_RXLEV, rxlev,
+						OFONO_NETMON_INFO_BER, ber,
+						OFONO_NETMON_INFO_RSCP, rscp,
+						OFONO_NETMON_INFO_ECN0, ecn0,
+						OFONO_NETMON_INFO_RSRQ, rsrq,
+						OFONO_NETMON_INFO_RSRP, rsrp,
+						OFONO_NETMON_INFO_INVALID);
+			break;
+		}
 	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	nmd->xmci_mode =3D -1;
 }
 =

 static void xmm7modem_netmon_request_update(struct ofono_netmon *netmon,
@@ -194,6 +231,7 @@ static void xmm7modem_netmon_request_update(struct ofon=
o_netmon *netmon,
 {
 	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
+	nmd->xmci_mode =3D 1;
 =

 	DBG("xmm7modem netmon request update");
 =

@@ -205,6 +243,23 @@ static void xmm7modem_netmon_request_update(struct ofo=
no_netmon *netmon,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void xmm7modem_neighbouring_cell_update(struct ofono_netmon *netmon,
+					ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	nmd->xmci_mode =3D 0;
+
+	DBG("xmm7modem netmon request neighbouring cell update");
+
+	if (g_at_chat_send(nmd->chat, "AT+XMCI=3D0", xmci_prefix,
+			xmci_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
 static gboolean ril_delayed_register(gpointer user_data)
 {
 	struct ofono_netmon *netmon =3D user_data;
@@ -224,6 +279,7 @@ static int xmm7modem_netmon_probe(struct ofono_netmon *=
netmon,
 =

 	nmd =3D g_new0(struct netmon_driver_data, 1);
 	nmd->chat =3D g_at_chat_clone(chat);
+	nmd->xmci_mode =3D -1;
 =

 	ofono_netmon_set_data(netmon, nmd);
 =

@@ -250,6 +306,7 @@ static const struct ofono_netmon_driver driver =3D {
 	.probe			=3D xmm7modem_netmon_probe,
 	.remove			=3D xmm7modem_netmon_remove,
 	.request_update		=3D xmm7modem_netmon_request_update,
+	.neighbouring_cell_update =3D xmm7modem_neighbouring_cell_update,
 };
 =

 void xmm_netmon_init(void)
-- =

1.9.1


--===============3790621899620870726==--

