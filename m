Content-Type: multipart/mixed; boundary="===============2387739212667935278=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 06/11] huaweimodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:39 -0800
Message-ID: <1296308084-3726-7-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2387739212667935278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/gprs-context.c |    8 --------
 drivers/huaweimodem/voicecall.c    |    4 ----
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/huaweimodem/gprs-context.c b/drivers/huaweimodem/gprs-=
context.c
index 30f423b..bbc9c96 100644
--- a/drivers/huaweimodem/gprs-context.c
+++ b/drivers/huaweimodem/gprs-context.c
@@ -311,9 +311,6 @@ static void huawei_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 =

 	DBG("cid %u", ctx->cid);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	gcd->active_context =3D ctx->cid;
 =

 	cbd->user =3D gc;
@@ -328,7 +325,6 @@ static void huawei_gprs_activate_primary(struct ofono_g=
prs_context *gc,
 				at_cgdcont_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, NULL, 0, NULL, NULL, NULL, NULL, data);
@@ -344,9 +340,6 @@ static void huawei_gprs_deactivate_primary(struct ofono=
_gprs_context *gc,
 =

 	DBG("cid %u", cid);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D gc;
 =

 	snprintf(buf, sizeof(buf), "AT^NDISDUP=3D%u,0", cid);
@@ -355,7 +348,6 @@ static void huawei_gprs_deactivate_primary(struct ofono=
_gprs_context *gc,
 				at_ndisdup_down_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index aef2a11..a30513a 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -99,14 +99,10 @@ static void huawei_template(struct ofono_voicecall *vc,=
 const char *cmd,
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(vd->chat, cmd, none_prefix,
 				huawei_generic_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4


--===============2387739212667935278==--

