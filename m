Content-Type: multipart/mixed; boundary="===============6251616165297493118=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 6/6] atmodem: set the auth method for u-blox modems
Date: Thu, 26 Jun 2014 20:28:18 +0200
Message-ID: <1403807298-14588-7-git-send-email-philip@paeps.cx>
In-Reply-To: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6251616165297493118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index be44443..f6e6c2e 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -282,9 +282,34 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 =

 	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

-	if (ctx->apn)
-		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
-				ctx->apn);
+	if (ctx->apn) {
+		switch (gcd->vendor) {
+		case OFONO_VENDOR_UBLOX:
+			/*
+			 * U-blox modems require a magic prefix to the APN to
+			 * specify the authentication method to use in the
+			 * network.  See UBX-13002752 - R21.
+			 *
+			 * As the response of the read command omits this magic
+			 * prefix, this is the least invasive place to set it.
+			 */
+			switch (ctx->auth_method) {
+			case OFONO_GPRS_AUTH_METHOD_CHAP:
+				snprintf(buf + len, sizeof(buf) - len - 3,
+						",\"CHAP:%s\"", ctx->apn);
+				break;
+			case OFONO_GPRS_AUTH_METHOD_PAP:
+				snprintf(buf + len, sizeof(buf) - len - 3,
+						",\"PAP:%s\"", ctx->apn);
+				break;
+			}
+			break;
+		default:
+			snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
+					ctx->apn);
+			break;
+		}
+	}
 =

 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				at_cgdcont_cb, gc, NULL) > 0)
-- =

1.7.10.4


--===============6251616165297493118==--

