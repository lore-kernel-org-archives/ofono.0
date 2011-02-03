Content-Type: multipart/mixed; boundary="===============3634515336918415111=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 09/12] hsomodem: update to new gprs context interface
Date: Thu, 03 Feb 2011 11:03:26 +0200
Message-ID: <1296723809-32676-10-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296723809-32676-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3634515336918415111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hsomodem/gprs-context.c |   48 ++++++++++++++++++++++-------------=
----
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index c132846..f9f1696 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -62,10 +62,7 @@ struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;			/* Currently active */
 	enum hso_state hso_state;			/* Are we in req ? */
-	union {
-		ofono_gprs_context_cb_t down_cb;	/* Down callback */
-		ofono_gprs_context_up_cb_t up_cb;	/* Up callback */
-	};
+	ofono_gprs_context_cb_t cb;
 	void *cb_data;					/* Callback data */
 	int owancall;					/* State of the call */
 };
@@ -82,7 +79,7 @@ static void at_owancall_down_cb(gboolean ok, GAtResult *r=
esult,
 	/* Now we have to wait for the unsolicited notification to arrive */
 	if (ok && gcd->owancall !=3D 0) {
 		gcd->hso_state =3D HSO_DISABLING;
-		gcd->down_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 		return;
 	}
@@ -95,14 +92,14 @@ static void at_owancall_up_cb(gboolean ok, GAtResult *r=
esult,
 				gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_error error;
 =

 	if (ok) {
 		gcd->hso_state =3D HSO_ENABLING;
-		gcd->up_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 		return;
 	}
@@ -110,13 +107,13 @@ static void at_owancall_up_cb(gboolean ok, GAtResult =
*result,
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, cbd->data);
 }
 =

 static void hso_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd;
@@ -128,7 +125,7 @@ static void hso_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -144,18 +141,22 @@ static void hso_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void hso_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[AUTH_BUF_LENGTH];
 	int len;
 =

+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
 	gcd->active_context =3D ctx->cid;
 =

 	cbd->user =3D gc;
@@ -186,7 +187,7 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void hso_gprs_deactivate_primary(struct ofono_gprs_context *gc,
@@ -265,11 +266,17 @@ static void owandata_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	ofono_info("IP: %s, Gateway: %s", ip, gateway);
 	ofono_info("DNS: %s, %s", dns1, dns2);
 =

-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, ip,
-				STATIC_IP_NETMASK, gateway, dns, gcd->cb_data);
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, ip);
+	ofono_gprs_context_set_ip_netmask(gc, STATIC_IP_NETMASK);
+	ofono_gprs_context_set_ip_gateway(gc, gateway);
+	ofono_gprs_context_set_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 =

 	gcd->hso_state =3D HSO_NONE;
-	gcd->up_cb =3D NULL;
+	gcd->cb =3D NULL;
 	gcd->cb_data =3D NULL;
 }
 =

@@ -300,9 +307,9 @@ static void owancall_notifier(GAtResult *result, gpoint=
er user_data)
 		DBG("HSO Context: disconnected");
 =

 		if (gcd->hso_state =3D=3D HSO_DISABLING) {
-			CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
+			CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 			gcd->hso_state =3D HSO_NONE;
-			gcd->down_cb =3D NULL;
+			gcd->cb =3D NULL;
 			gcd->cb_data =3D NULL;
 		} else {
 			ofono_gprs_context_deactivated(gc, gcd->active_context);
@@ -330,10 +337,9 @@ static void owancall_notifier(GAtResult *result, gpoin=
ter user_data)
 		DBG("HSO Context: failed");
 =

 		if (gcd->hso_state =3D=3D HSO_ENABLING) {
-			CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL,
-						NULL, NULL, NULL, gcd->cb_data);
+			CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 			gcd->hso_state =3D HSO_NONE;
-			gcd->up_cb =3D NULL;
+			gcd->cb =3D NULL;
 			gcd->cb_data =3D NULL;
 		}
 =

-- =

1.7.1


--===============3634515336918415111==--

