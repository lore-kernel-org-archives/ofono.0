Content-Type: multipart/mixed; boundary="===============8573242644849593248=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 08/11] mbmmodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:41 -0800
Message-ID: <1296308084-3726-9-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8573242644849593248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/mbmmodem/gprs-context.c |    7 -------
 drivers/mbmmodem/stk.c          |    4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mbmmodem/gprs-context.c b/drivers/mbmmodem/gprs-contex=
t.c
index b9b4574..322f96d 100644
--- a/drivers/mbmmodem/gprs-context.c
+++ b/drivers/mbmmodem/gprs-context.c
@@ -364,9 +364,6 @@ static void mbm_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 =

 	DBG("cid %u", ctx->cid);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	gcd->active_context =3D ctx->cid;
 =

 	cbd->user =3D gc;
@@ -408,16 +405,12 @@ static void mbm_gprs_deactivate_primary(struct ofono_=
gprs_context *gc,
 =

 	DBG("cid %u", cid);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D gc;
 =

 	if (g_at_chat_send(gcd->chat, "AT*ENAP=3D0", none_prefix,
 				at_enap_down_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/mbmmodem/stk.c b/drivers/mbmmodem/stk.c
index d0a9f3b..99c08c2 100644
--- a/drivers/mbmmodem/stk.c
+++ b/drivers/mbmmodem/stk.c
@@ -88,7 +88,7 @@ static void mbm_stk_envelope(struct ofono_stk *stk, int l=
ength,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT*STKE=3D\"");
@@ -134,7 +134,7 @@ static void mbm_stk_terminal_response(struct ofono_stk =
*stk, int length,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT*STKR=3D\"");
-- =

1.7.0.4


--===============8573242644849593248==--

