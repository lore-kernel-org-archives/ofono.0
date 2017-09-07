Content-Type: multipart/mixed; boundary="===============7885587809332908251=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 6/7] rilmodem: driver changes for netmon agent
Date: Thu, 07 Sep 2017 09:53:19 +0530
Message-ID: <1504758200-18624-6-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7885587809332908251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rilmodem driver updated to handle enabling
and disabling periodic serving cell updates
---
 drivers/rilmodem/netmon.c | 98 +++++++++++++++++++++++++++++++++++++++++--=
----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index f7f7c28..a1e5f6c 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -61,6 +61,9 @@
 /* size of RIL_CellInfoTdscdma */
 #define NETMON_RIL_CELLINFO_SIZE_TDSCDMA	24
 =

+#define MSECS_RATE_INVALID	(0x7fffffff)
+#define SECS_TO_MSECS(x)	((x) * 1000)
+
 struct netmon_data {
 	GRil *ril;
 };
@@ -96,11 +99,9 @@ static int ril_cell_type_to_size(int cell_type)
 	return 0;
 }
 =

-static void ril_netmon_update_cb(struct ril_msg *message, gpointer user_da=
ta)
+static int process_cellinfo_list(struct ril_msg *message,
+					struct ofono_netmon *netmon)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_netmon_cb_t cb =3D cbd->cb;
-	struct ofono_netmon *netmon =3D cbd->data;
 	struct parcel rilp;
 	int skip_len;
 	int cell_info_cnt;
@@ -114,7 +115,7 @@ static void ril_netmon_update_cb(struct ril_msg *messag=
e, gpointer user_data)
 	int i, j;
 =

 	if (message->error !=3D RIL_E_SUCCESS)
-		goto error;
+		return OFONO_ERROR_TYPE_FAILURE;
 =

 	g_ril_init_parcel(message, &rilp);
 =

@@ -146,7 +147,7 @@ static void ril_netmon_update_cb(struct ril_msg *messag=
e, gpointer user_data)
 	}
 =

 	if (!registered)
-		goto error;
+		return OFONO_ERROR_TYPE_FAILURE;
 =

 	if (cell_type =3D=3D NETMON_RIL_CELLINFO_TYPE_GSM) {
 		mcc =3D parcel_r_int32(&rilp);
@@ -216,17 +217,53 @@ static void ril_netmon_update_cb(struct ril_msg *mess=
age, gpointer user_data)
 				OFONO_NETMON_INFO_BER, ber,
 				OFONO_NETMON_INFO_INVALID);
 =

-	} else {
-		goto error;
 	}
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	return;
+	return OFONO_ERROR_TYPE_NO_ERROR;
+}
+
+static void ril_netmon_update_cb(struct ril_msg *message, gpointer user_da=
ta)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netmon_cb_t cb =3D cbd->cb;
+	struct ofono_netmon *netmon =3D cbd->data;
+
+	if (process_cellinfo_list(message, netmon) =3D=3D
+			OFONO_ERROR_TYPE_NO_ERROR) {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		return;
+	}
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

+static void ril_cellinfo_notify(struct ril_msg *message, gpointer user_dat=
a)
+{
+	struct ofono_netmon *netmon =3D user_data;
+
+	process_cellinfo_list(message, netmon);
+}
+
+static void setup_cell_info_notify(struct ofono_netmon *netmon)
+{
+	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct parcel rilp;
+
+	parcel_init(&rilp);
+
+	parcel_w_int32(&rilp, 1);	/* Number of elements */
+
+	parcel_w_int32(&rilp, MSECS_RATE_INVALID);
+
+	if (g_ril_send(nmd->ril, RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE,
+			&rilp, NULL, NULL, NULL) =3D=3D 0)
+		ofono_error("%s: setup failed\n", __func__);
+
+	if (g_ril_register(nmd->ril, RIL_UNSOL_CELL_INFO_LIST,
+				ril_cellinfo_notify, netmon) =3D=3D 0)
+		ofono_error("%s: setup failed\n", __func__);
+}
+
 static int ril_netmon_probe(struct ofono_netmon *netmon,
 		unsigned int vendor, void *user)
 {
@@ -237,6 +274,8 @@ static int ril_netmon_probe(struct ofono_netmon *netmon,
 =

 	ofono_netmon_set_data(netmon, ud);
 =

+	setup_cell_info_notify(netmon);
+
 	g_idle_add(ril_delayed_register, netmon);
 =

 	return 0;
@@ -264,11 +303,48 @@ static void ril_netmon_request_update(struct ofono_ne=
tmon *netmon,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static void periodic_update_cb(struct ril_msg *message, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_netmon_cb_t cb =3D cbd->cb;
+
+	if (message->error !=3D RIL_E_SUCCESS)
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void ril_netmon_periodic_update(struct ofono_netmon *netmon,
+			unsigned int enable, unsigned int period,
+			ofono_netmon_cb_t cb, void *data)
+{
+	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
+	struct cb_data *cbd =3D cb_data_new(cb, data, nmd);
+	struct parcel rilp;
+
+	parcel_init(&rilp);
+
+	parcel_w_int32(&rilp, 1);	/* Number of elements */
+
+	if (enable)
+		parcel_w_int32(&rilp, SECS_TO_MSECS(period));
+	else
+		parcel_w_int32(&rilp, MSECS_RATE_INVALID);
+
+	if (g_ril_send(nmd->ril, RIL_REQUEST_SET_UNSOL_CELL_INFO_LIST_RATE,
+			&rilp, periodic_update_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
 static struct ofono_netmon_driver driver =3D {
 	.name			=3D RILMODEM,
 	.probe			=3D ril_netmon_probe,
 	.remove			=3D ril_netmon_remove,
 	.request_update		=3D ril_netmon_request_update,
+	.enable_periodic_update	=3D ril_netmon_periodic_update,
 };
 =

 void ril_netmon_init(void)
-- =

1.9.1


--===============7885587809332908251==--

