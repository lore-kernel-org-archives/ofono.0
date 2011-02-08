Content-Type: multipart/mixed; boundary="===============0733616893031237899=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 07/13] atmodem: update to new gprs context interface
Date: Tue, 08 Feb 2011 17:22:20 +0200
Message-ID: <1297178546-9371-8-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297178546-9371-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0733616893031237899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   41 ++++++++++++++++++++----------------=
---
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 56d65d4..2c4797b 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -62,10 +62,7 @@ struct gprs_context_data {
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtPPP *ppp;
 	enum state state;
-	union {
-		ofono_gprs_context_cb_t down_cb;        /* Down callback */
-		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
-	};
+	ofono_gprs_context_cb_t cb;
 	void *cb_data;                                  /* Callback data */
 };
 =

@@ -93,9 +90,12 @@ static void ppp_connect(const char *interface, const cha=
r *local,
 	ofono_info("DNS: %s, %s", dns1, dns2);
 =

 	gcd->state =3D STATE_ACTIVE;
-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, local,
-					STATIC_IP_NETMASK, NULL,
-					dns, gcd->cb_data);
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, local);
+	ofono_gprs_context_set_ip_netmask(gc, STATIC_IP_NETMASK);
+	ofono_gprs_context_set_dns_servers(gc, dns);
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
@@ -110,11 +110,10 @@ static void ppp_disconnect(GAtPPPDisconnectReason rea=
son, gpointer user_data)
 =

 	switch (gcd->state) {
 	case STATE_ENABLING:
-		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, FALSE, NULL,
-					NULL, NULL, NULL, gcd->cb_data);
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 		break;
 	case STATE_DISABLING:
-		CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
+		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 		break;
 	default:
 		ofono_gprs_context_deactivated(gc, gcd->active_context);
@@ -181,8 +180,7 @@ static void at_cgdata_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		gcd->state =3D STATE_IDLE;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL,
-				gcd->cb_data);
+		gcd->cb(&error, gcd->cb_data);
 		return;
 	}
 =

@@ -204,8 +202,7 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 		gcd->state =3D STATE_IDLE;
 =

 		decode_at_error(&error, g_at_result_final_response(result));
-		gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL,
-				gcd->cb_data);
+		gcd->cb(&error, gcd->cb_data);
 		return;
 	}
 =

@@ -217,22 +214,25 @@ static void at_cgdcont_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	gcd->active_context =3D 0;
 	gcd->state =3D STATE_IDLE;
 =

-	CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL, NULL, NULL,
-				gcd->cb_data);
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 }
 =

 static void at_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
 	int len;
 =

+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
 	DBG("cid %u", ctx->cid);
 =

 	gcd->active_context =3D ctx->cid;
-	gcd->up_cb =3D cb;
+	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
@@ -249,7 +249,8 @@ static void at_gprs_activate_primary(struct ofono_gprs_=
context *gc,
 				at_cgdcont_cb, gc, NULL) > 0)
 		return;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void at_gprs_deactivate_primary(struct ofono_gprs_context *gc,
@@ -261,7 +262,7 @@ static void at_gprs_deactivate_primary(struct ofono_gpr=
s_context *gc,
 	DBG("cid %u", cid);
 =

 	gcd->state =3D STATE_DISABLING;
-	gcd->down_cb =3D cb;
+	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
 =

 	g_at_ppp_shutdown(gcd->ppp);
-- =

1.7.1


--===============0733616893031237899==--

