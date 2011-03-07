Content-Type: multipart/mixed; boundary="===============4480641027366465746=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND 3 PATCH 13/13] phonesim: add IPv6 support
Date: Mon, 07 Mar 2011 16:02:39 +0200
Message-ID: <1299506559-32365-14-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1299506559-32365-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4480641027366465746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/phonesim.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 2b36fe0..2634d23 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -83,14 +83,17 @@ struct gprs_context_data {
 static void at_cgact_up_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
 {
 	struct cb_data *cbd =3D user_data;
-	ofono_gprs_context_up_cb_t cb =3D cbd->cb;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
 	struct ofono_gprs_context *gc =3D cbd->user;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_error error;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
-	cb(&error, ok ? gcd->interface : NULL, FALSE,
-			NULL, NULL, NULL, NULL, cbd->data);
+
+	if (ok)
+		ofono_gprs_context_set_interface(gc, gcd->interface);
+
+	cb(&error, cbd->data);
 }
 =

 static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
@@ -105,16 +108,31 @@ static void at_cgact_down_cb(gboolean ok, GAtResult *=
result, gpointer user_data)
 =

 static void phonesim_activate_primary(struct ofono_gprs_context *gc,
 				const struct ofono_gprs_primary_context *ctx,
-				ofono_gprs_context_up_cb_t cb, void *data)
+				ofono_gprs_context_cb_t cb, void *data)
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
-	int len;
+	int len =3D 0;
 =

 	cbd->user =3D gc;
 =

-	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
+	switch (ctx->proto) {
+	case OFONO_GPRS_PROTO_IP:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
+				ctx->cid);
+		break;
+
+	case OFONO_GPRS_PROTO_IPV6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
+				ctx->cid);
+		break;
+
+	case OFONO_GPRS_PROTO_IPV4V6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
+				ctx->cid);
+		break;
+	}
 =

 	if (ctx->apn)
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
@@ -132,7 +150,7 @@ static void phonesim_activate_primary(struct ofono_gprs=
_context *gc,
 error:
 	g_free(cbd);
 =

-	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

 static void phonesim_deactivate_primary(struct ofono_gprs_context *gc,
-- =

1.7.1


--===============4480641027366465746==--

