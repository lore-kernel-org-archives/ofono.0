Content-Type: multipart/mixed; boundary="===============0099669569328204577=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 05/11] hsomodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:38 -0800
Message-ID: <1296308084-3726-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0099669569328204577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hsomodem/gprs-context.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/hsomodem/gprs-context.c b/drivers/hsomodem/gprs-contex=
t.c
index d140d2e..c132846 100644
--- a/drivers/hsomodem/gprs-context.c
+++ b/drivers/hsomodem/gprs-context.c
@@ -156,9 +156,6 @@ static void hso_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	char buf[AUTH_BUF_LENGTH];
 	int len;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	gcd->active_context =3D ctx->cid;
 =

 	cbd->user =3D gc;
@@ -200,9 +197,6 @@ static void hso_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[128];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D gc;
 =

 	snprintf(buf, sizeof(buf), "AT_OWANCALL=3D%u,0,1", cid);
@@ -211,7 +205,6 @@ static void hso_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 				at_owancall_down_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4


--===============0099669569328204577==--

