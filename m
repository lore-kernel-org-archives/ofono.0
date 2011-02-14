Content-Type: multipart/mixed; boundary="===============7544983762474286243=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND PATCH 12/13] stemodem: update to new gprs context interface
Date: Mon, 14 Feb 2011 13:50:44 +0200
Message-ID: <1297684245-9737-13-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7544983762474286243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/gprs-context.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index e247f35..7266810 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -246,7 +246,7 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 static void ste_eppsd_up_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct conn_info *conn;
@@ -276,7 +276,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		conn->cid =3D 0;
 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -305,9 +305,13 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	CALLBACK_WITH_SUCCESS(cb, conn->interface, TRUE, rsp.ip_address,
-				rsp.subnet_mask, NULL,
-				dns, cbd->data);
+	ofono_gprs_context_set_interface(gc, conn->interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, rsp.ip_address);
+	ofono_gprs_context_set_ip_netmask(gc, rsp.subnet_mask);
+	ofono_gprs_context_set_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 	return;
 =

 error:
@@ -320,13 +324,13 @@ error:
 error_no_device:
 	DBG("ste_eppsd_up_cb error");
 	gcd->active_context =3D 0;
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void ste_cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *ncbd;
@@ -351,7 +355,7 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 		conn->cid =3D 0;
 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -368,13 +372,12 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 error_no_device:
 	gcd->active_context =3D 0;
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL,
-				NULL, NULL, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
 }
 =

 static void ste_gprs_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
@@ -383,6 +386,10 @@ static void ste_gprs_activate_primary(struct ofono_gpr=
s_context *gc,
 	GSList *l;
 	struct conn_info *conn;
 =

+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error_no_device;
+
 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

@@ -432,7 +439,7 @@ error_no_device:
 	gcd->active_context =3D 0;
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void ste_gprs_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============7544983762474286243==--

