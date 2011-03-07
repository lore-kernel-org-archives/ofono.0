Content-Type: multipart/mixed; boundary="===============7345752772904671486=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND 3 PATCH 11/13] ifxmodem: update to new gprs context interface
Date: Mon, 07 Mar 2011 16:02:37 +0200
Message-ID: <1299506559-32365-12-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1299506559-32365-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7345752772904671486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/gprs-context.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 2c68b44..91dee8c 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -67,10 +67,7 @@ struct gprs_context_data {
 	char address[32];
 	char dns1[32];
 	char dns2[32];
-	union {
-		ofono_gprs_context_cb_t down_cb;        /* Down callback */
-		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
-	};
+	ofono_gprs_context_cb_t cb;
 	void *cb_data;                                  /* Callback data */
 };
 =

@@ -123,13 +120,12 @@ static void failed_setup(struct ofono_gprs_context *g=
c,
 	gcd->state =3D STATE_IDLE;
 =

 	if (result =3D=3D NULL) {
-		CALLBACK_WITH_FAILURE(gcd->up_cb, NULL, 0, NULL, NULL,
-						NULL, NULL, gcd->cb_data);
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
 		return;
 	}
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	gcd->up_cb(&error, NULL, 0, NULL, NULL, NULL, NULL, gcd->cb_data);
+	gcd->cb(&error, gcd->cb_data);
 }
 =

 static void session_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -157,10 +153,15 @@ static void session_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (interface =3D=3D NULL)
 		interface =3D "invalid";
 =

-	CALLBACK_WITH_SUCCESS(gcd->up_cb, interface, TRUE, gcd->address,
-				STATIC_IP_NETMASK, NULL, dns, gcd->cb_data);
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, gcd->address);
+	ofono_gprs_context_set_ip_netmask(gc, STATIC_IP_NETMASK);
+	ofono_gprs_context_set_dns_servers(gc, dns);
 =

-	gcd->up_cb =3D NULL;
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+
+	gcd->cb =3D NULL;
 	gcd->cb_data =3D NULL;
 }
 =

@@ -316,16 +317,20 @@ error:
 =

 static void ifx_gprs_activate_primary(struct ofono_gprs_context *gc,
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
@@ -342,7 +347,8 @@ static void ifx_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 				setup_cb, gc, NULL) > 0)
 		return;
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void deactivate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
@@ -360,7 +366,7 @@ static void deactivate_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 =

 	g_at_chat_resume(gcd->chat);
 =

-	CALLBACK_WITH_SUCCESS(gcd->down_cb, gcd->cb_data);
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
 }
 =

 static void ifx_gprs_deactivate_primary(struct ofono_gprs_context *gc,
@@ -374,7 +380,7 @@ static void ifx_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	DBG("cid %u", cid);
 =

 	gcd->state =3D STATE_DISABLING;
-	gcd->down_cb =3D cb;
+	gcd->cb =3D cb;
 	gcd->cb_data =3D data;
 =

 	g_at_rawip_shutdown(gcd->rawip);
-- =

1.7.1


--===============7345752772904671486==--

