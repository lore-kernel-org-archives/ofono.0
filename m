Content-Type: multipart/mixed; boundary="===============1982268563820643995=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND 2 PATCH 12/13] stemodem: update to new gprs context interface
Date: Tue, 22 Feb 2011 15:19:08 +0200
Message-ID: <1298380749-11040-13-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1298380749-11040-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1982268563820643995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/gprs-context.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 48ae476..98abeec 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -176,7 +176,7 @@ static void ste_eppsd_down_cb(gboolean ok, GAtResult *r=
esult,
 static void ste_eppsd_up_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	GAtResultIter iter;
@@ -192,7 +192,7 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 =

 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -221,9 +221,13 @@ static void ste_eppsd_up_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	dns[1] =3D rsp.dns_server2;
 	dns[2] =3D NULL;
 =

-	CALLBACK_WITH_SUCCESS(cb, gcd->interface, TRUE, rsp.ip_address,
-				rsp.subnet_mask, NULL,
-				dns, cbd->data);
+	ofono_gprs_context_set_interface(gc, gcd->interface);
+	ofono_gprs_context_set_ip_addrconf(gc, OFONO_GPRS_ADDRCONF_STATIC);
+	ofono_gprs_context_set_ip_address(gc, rsp.ip_address);
+	ofono_gprs_context_set_ip_netmask(gc, rsp.subnet_mask);
+	ofono_gprs_context_set_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 	return;
 =

 error:
@@ -233,13 +237,13 @@ error:
 		g_markup_parse_context_free(context);
 =

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
@@ -250,7 +254,7 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 		gcd->active_context =3D 0;
 		decode_at_error(&error, g_at_result_final_response(result));
-		cb(&error, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
+		cb(&error, cbd->data);
 		return;
 	}
 =

@@ -265,18 +269,22 @@ static void ste_cgdcont_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 =

 	g_free(ncbd);
 	gcd->active_context =3D 0;
-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, cbd->data);
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
 	char buf[AUTH_BUF_LENGTH];
 	int len;
 =

+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

@@ -311,7 +319,7 @@ error:
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


--===============1982268563820643995==--

