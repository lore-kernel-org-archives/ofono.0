Content-Type: multipart/mixed; boundary="===============0502398506049502298=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND PATCH 09/13] mbmmodem: update to new gprs context interface
Date: Mon, 14 Feb 2011 13:50:41 +0200
Message-ID: <1297684245-9737-10-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0502398506049502298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/gprs-context.c |   65 ++++++++++++++++++++++++-----------=
----
 1 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index 322f96d..972b35e 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -70,10 +70,7 @@ struct gprs_context_data {
 	gboolean have_e2ipcfg;
 	unsigned int enap_source;
 	enum mbm_state mbm_state;
-	union {
-		ofono_gprs_context_cb_t down_cb;        /* Down callback */
-		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
-	};
+	ofono_gprs_context_cb_t cb;
 	void *cb_data;                                  /* Callback data */
 	int enap;                                   /* State of the call */
 };
@@ -141,11 +138,23 @@ out:
 	ofono_info("IP: %s  Gateway: %s", ip, gateway);
 	ofono_info("DNS: %s, %s", dns[0], dns[1]);
 =

-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, success, ip,
-					STATIC_IP_NETMASK, gateway,
-					success ? dns : NULL, gcd->cb_data);
+	ofono_gprs_context_set_interface(gc, interface);
+
+	if (success) {
+		ofono_gprs_context_set_ip_addrconf(gc,
+						OFONO_GPRS_ADDRCONF_STATIC);
+		ofono_gprs_context_set_ip_address(gc, ip);
+		ofono_gprs_context_set_ip_netmask(gc, STATIC_IP_NETMASK);
+		ofono_gprs_context_set_dns_servers(gc, dns);
+	} else {
+		ofono_gprs_context_set_ip_addrconf(gc,
+						OFONO_GPRS_ADDRCONF_DHCP);
+	}
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
 	gcd->mbm_state =3D MBM_NONE;
-	gcd->up_cb =3D NULL;
+	gcd->cb =3D NULL;
 	gcd->cb_data =3D NULL;
 }
 =

@@ -169,11 +178,14 @@ static void mbm_get_ip_details(struct ofono_gprs_cont=
ext *gc)
 =

 	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, FALSE, NULL, NULL,
-			NULL, NULL, gcd->cb_data);
+
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_DHCP);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 =

 	gcd->mbm_state =3D MBM_NONE;
-	gcd->up_cb =3D NULL;
+	gcd->cb =3D NULL;
 	gcd->cb_data =3D NULL;
 }
 =

@@ -191,12 +203,11 @@ static void mbm_state_changed(struct ofono_gprs_conte=
xt *gc, int state)
 		DBG("disconnected");
 =

 		if (gcd->mbm_state =3D=3D MBM_DISABLING) {
-			CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
-			gcd->down_cb =3D NULL;
+			CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+			gcd->cb =3D NULL;
 		} else if (gcd->mbm_state =3D=3D MBM_ENABLING) {
-			CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
-			gcd->up_cb =3D NULL;
+			CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+			gcd->cb =3D NULL;
 		} else {
 			ofono_gprs_context_deactivated(gc, gcd->active_context);
 		}
@@ -275,7 +286,7 @@ static void at_enap_down_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	/* Now we have to wait for the unsolicited notification to arrive */
 	if (ok && gcd->enap !=3D 0) {
 		gcd->mbm_state =3D MBM_DISABLING;
-		gcd->down_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 =

 		if (gcd->have_e2nap =3D=3D FALSE)
@@ -292,7 +303,7 @@ static void at_enap_down_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 static void mbm_enap_up_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_error error;
@@ -301,7 +312,7 @@ static void mbm_enap_up_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	if (ok) {
 		gcd->mbm_state =3D MBM_ENABLING;
-		gcd->up_cb =3D cb;
+		gcd->cb =3D cb;
 		gcd->cb_data =3D cbd->data;
 =

 		if (gcd->have_e2nap =3D=3D FALSE)
@@ -314,13 +325,13 @@ static void mbm_enap_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	gcd->active_context =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, NULL, FALSE, NULL, NULL, NULL, NULL, cbd->data);
+	cb(&error, cbd->data);
 }
 =

 static void mbm_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd;
@@ -334,7 +345,7 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		gcd->active_context =3D 0;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -350,18 +361,22 @@ static void mbm_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	gcd->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void mbm_gprs_activate_primary(struct ofono_gprs_context *gc,
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
 	DBG("cid %u", ctx->cid);
 =

 	gcd->active_context =3D ctx->cid;
@@ -393,7 +408,7 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void mbm_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============0502398506049502298==--

