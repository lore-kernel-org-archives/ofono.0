Content-Type: multipart/mixed; boundary="===============7375819424452201157=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND PATCH 08/13] huaweimodem: update to new gprs context interface
Date: Mon, 14 Feb 2011 13:50:40 +0200
Message-ID: <1297684245-9737-9-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7375819424452201157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/gprs-context.c |   43 +++++++++++++++++++++-----------=
----
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index bbc9c96..67d933e 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -53,10 +53,7 @@ struct gprs_context_data {
 	unsigned int dhcp_source;
 	unsigned int dhcp_count;
 	guint ndis_watch;
-	union {
-		ofono_gprs_context_cb_t down_cb;	/* Down callback */
-		ofono_gprs_context_up_cb_t up_cb;	/* Up callback */
-	};
+	ofono_gprs_context_cb_t cb;
 	void *cb_data;					/* Callback data */
 };
 =

@@ -68,8 +65,7 @@ static gboolean dhcp_poll(gpointer user_data)
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 =

 	if (gcd->dhcp_count > 20)
-		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 	else
 		check_dhcp(gc);
 =

@@ -192,9 +188,15 @@ static void dhcp_query_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	interface =3D "invalid";
 =

-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, ip,
-					netmask, gateway, dns, gcd->cb_data);
-	gcd->up_cb =3D NULL;
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, ip);
+	ofono_gprs_context_set_ip_netmask(gc, netmask);
+	ofono_gprs_context_set_ip_gateway(gc, gateway);
+	ofono_gprs_context_set_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+	gcd->cb =3D NULL;
 	gcd->cb_data =3D NULL;
 =

 	g_free(ip);
@@ -224,7 +226,7 @@ static void at_ndisdup_down_cb(gboolean ok, GAtResult *=
result,
 	DBG("ok %d", ok);
 =

 	if (ok) {
-		gcd->down_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 =

 		if (gcd->ndis_watch > 0) {
@@ -241,7 +243,7 @@ static void at_ndisdup_up_cb(gboolean ok, GAtResult *re=
sult,
 						gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_error error;
@@ -249,7 +251,7 @@ static void at_ndisdup_up_cb(gboolean ok, GAtResult *re=
sult,
 	DBG("ok %d", ok);
 =

 	if (ok) {
-		gcd->up_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 =

 		gcd->dhcp_count =3D 0;
@@ -261,13 +263,13 @@ static void at_ndisdup_up_cb(gboolean ok, GAtResult *=
result,
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, cbd->data);
 }
 =

 static void at_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd;
@@ -281,7 +283,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -297,18 +299,22 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void huawei_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[64];
 	int len;
 =

+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
 	DBG("cid %u", ctx->cid);
 =

 	gcd->active_context =3D ctx->cid;
@@ -325,9 +331,10 @@ static void huawei_gprs_activate_primary(struct ofono_=
gprs_context *gc,
 				at_cgdcont_cb, cbd, g_free) > 0)
 		return;
 =

+error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void huawei_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============7375819424452201157==--

