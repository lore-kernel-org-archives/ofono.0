Content-Type: multipart/mixed; boundary="===============7091252549466633537=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 4/5] gemalto: gprs: support different gprs protocols
Date: Mon, 21 Dec 2020 23:01:32 +0300
Message-ID: <20201221200133.522933-5-geomatsi@gmail.com>
In-Reply-To: <20201221200133.522933-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7091252549466633537==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergey Matyukevich <matyukevich@arrival.com>

Add support for IPv6 and dual mode gprs contexts.
---
 drivers/gemaltomodem/gprs-context.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gpr=
s-context.c
index 680f01ab..bb09f0b0 100644
--- a/drivers/gemaltomodem/gprs-context.c
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -46,6 +46,7 @@ static const char *none_prefix[] =3D { NULL };
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
+	enum ofono_gprs_proto proto;
 	ofono_gprs_context_cb_t cb;
 	void *cb_data;
 };
@@ -118,15 +119,25 @@ static void gemalto_gprs_activate_primary(struct ofon=
o_gprs_context *gc,
 =

 	DBG("cid %u", ctx->cid);
 =

-	/* IPv6 support not implemented */
-	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
-		goto error;
-
 	gcd->active_context =3D ctx->cid;
 	gcd->cb_data =3D data;
 	gcd->cb =3D cb;
 =

-	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
+
+	switch (ctx->proto) {
+	case OFONO_GPRS_PROTO_IP:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
+				ctx->cid);
+		break;
+	case OFONO_GPRS_PROTO_IPV6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
+				ctx->cid);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
+				ctx->cid);
+		break;
+	}
 =

 	if (ctx->apn)
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", ctx->apn);
@@ -135,7 +146,6 @@ static void gemalto_gprs_activate_primary(struct ofono_=
gprs_context *gc,
 				cgdcont_enable_cb, gc, NULL))
 		return;
 =

-error:
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-- =

2.29.2

--===============7091252549466633537==--

