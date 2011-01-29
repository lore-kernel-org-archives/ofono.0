Content-Type: multipart/mixed; boundary="===============0842105019366193299=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 09/11] stemodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:42 -0800
Message-ID: <1296308084-3726-10-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0842105019366193299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/gprs-context.c |    6 ------
 drivers/stemodem/voicecall.c    |    7 -------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 0be4238..e247f35 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -383,9 +383,6 @@ static void ste_gprs_activate_primary(struct ofono_gprs=
_context *gc,
 	GSList *l;
 	struct conn_info *conn;
 =

-	if (cbd =3D=3D NULL)
-		goto error_no_device;
-
 	gcd->active_context =3D ctx->cid;
 	cbd->user =3D gc;
 =

@@ -448,9 +445,6 @@ static void ste_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 	char buf[64];
 	GSList *l;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	gcd->active_context =3D id;
 	cbd->user =3D gc;
 =

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 5210483..1c7c0bd 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -187,9 +187,6 @@ static void ste_dial(struct ofono_voicecall *vc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[256];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vc;
 =

 	if (ph->type =3D=3D 145)
@@ -214,7 +211,6 @@ static void ste_dial(struct ofono_voicecall *vc,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -370,9 +366,6 @@ static void ste_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 	int s;
 	char *buf;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	/* strlen("AT+VTS=3D) =3D 7 + NULL */
 	buf =3D g_try_new(char, strlen(dtmf) + 8);
 	if (buf =3D=3D NULL)
-- =

1.7.0.4


--===============0842105019366193299==--

