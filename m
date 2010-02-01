Content-Type: multipart/mixed; boundary="===============7086306568191125889=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 1/2] Fix: Username and Password must be set after context is
 created.
Date: Mon, 01 Feb 2010 16:50:23 +0100
Message-ID: <1265039424-1961-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7086306568191125889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/gprs-context.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 6743aba..c178fb6 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -416,7 +416,7 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 {
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char buf[AUTH_BUF_LENGTH];
+	char buf[2*AUTH_BUF_LENGTH];
 	int len;
 =

 	if (!cbd)
@@ -425,19 +425,17 @@ static void ste_gprs_activate_primary(struct ofono_gp=
rs_context *gc,
 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

-	/* Set username and password */
-	sprintf(buf, "AT*EIAAUW=3D%d,1,\"%s\",\"%s\"", ctx->cid,
-		ctx->username, ctx->password);
-
-	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=3D =
0)
-		goto error;
-
 	len =3D sprintf(buf, "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
 =

 	if (ctx->apn)
 		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
 				ctx->apn);
 =

+	/* Set username and password. Must be done after context creation */
+	len =3D strlen(buf);
+	sprintf(buf+len, ";*EIAAUW=3D%d,1,\"%s\",\"%s\"", ctx->cid,
+		ctx->username, ctx->password);
+
 	if (g_at_chat_send(gcd->chat, buf, none_prefix,
 				ste_cgdcont_cb, cbd, g_free) > 0)
 		return;
-- =

1.6.3.3


--===============7086306568191125889==--

