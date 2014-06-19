Content-Type: multipart/mixed; boundary="===============1796502555105457670=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 3/5] atmodem: set the PPP authentication method to use
Date: Thu, 19 Jun 2014 12:07:07 +0200
Message-ID: <1403172429-26289-4-git-send-email-philip@paeps.cx>
In-Reply-To: <1403172429-26289-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1796502555105457670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs-context.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 2217097..be44443 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -59,6 +59,7 @@ enum state {
 struct gprs_context_data {
 	GAtChat *chat;
 	unsigned int active_context;
+	GAtPPPAuthMethod auth_method;
 	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
 	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
 	GAtPPP *ppp;
@@ -154,6 +155,7 @@ static gboolean setup_ppp(struct ofono_gprs_context *gc)
 	if (getenv("OFONO_PPP_DEBUG"))
 		g_at_ppp_set_debug(gcd->ppp, ppp_debug, "PPP");
 =

+	g_at_ppp_set_auth_method(gcd->ppp, gcd->auth_method);
 	g_at_ppp_set_credentials(gcd->ppp, gcd->username, gcd->password);
 =

 	/* set connect and disconnect callbacks */
@@ -243,6 +245,18 @@ static void at_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
 	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
 =

+	/* We only support CHAP and PAP */
+	switch (ctx->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_CHAP;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		gcd->auth_method =3D G_AT_PPP_AUTH_METHOD_PAP;
+		break;
+	default:
+		goto error;
+	}
+
 	gcd->state =3D STATE_ENABLING;
 =

 	if (gcd->vendor =3D=3D OFONO_VENDOR_ZTE) {
-- =

1.7.10.4


--===============1796502555105457670==--

