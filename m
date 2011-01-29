Content-Type: multipart/mixed; boundary="===============9161163865583121130=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 07/11] ifxmodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:40 -0800
Message-ID: <1296308084-3726-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9161163865583121130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/ctm.c       |    8 --------
 drivers/ifxmodem/stk.c       |    4 ++--
 drivers/ifxmodem/voicecall.c |    7 -------
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
index b70fe09..7b23a9b 100644
--- a/drivers/ifxmodem/ctm.c
+++ b/drivers/ifxmodem/ctm.c
@@ -88,14 +88,10 @@ static void ifx_query_tty(struct ofono_ctm *ctm, ofono_=
ctm_query_cb_t cb,
 	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(ctmd->chat, "AT+XCTMS?", xctms_prefix,
 				xctms_query_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, -1, data);
@@ -121,9 +117,6 @@ static void ifx_set_tty(struct ofono_ctm *ctm, ofono_bo=
ol_t enable,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[20];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	/* Only FULL TTY mode enabled/disabled */
 	snprintf(buf, sizeof(buf), "AT+XCTMS=3D%i", enable ? 1 : 0);
 =

@@ -131,7 +124,6 @@ static void ifx_set_tty(struct ofono_ctm *ctm, ofono_bo=
ol_t enable,
 				xctms_modify_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
diff --git a/drivers/ifxmodem/stk.c b/drivers/ifxmodem/stk.c
index 5951149..f08cf47 100644
--- a/drivers/ifxmodem/stk.c
+++ b/drivers/ifxmodem/stk.c
@@ -104,7 +104,7 @@ static void ifx_stk_envelope(struct ofono_stk *stk, int=
 length,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+SATE=3D\"");
@@ -150,7 +150,7 @@ static void ifx_stk_terminal_response(struct ofono_stk =
*stk, int length,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+SATR=3D\"");
diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index fcd0c7e..716652c 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -305,9 +305,6 @@ static void ifx_dial(struct ofono_voicecall *vc,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 	char buf[256];
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	cbd->user =3D vc;
 =

 	if (ph->type =3D=3D 145)
@@ -332,7 +329,6 @@ static void ifx_dial(struct ofono_voicecall *vc,
 				atd_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
@@ -504,9 +500,6 @@ static void ifx_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 	int i;
 	char *buf;
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	/* strlen("+VTS=3DT\;") =3D 7 + initial AT + null */
 	buf =3D g_try_new(char, len * 7 + 3);
 	if (buf =3D=3D NULL)
-- =

1.7.0.4


--===============9161163865583121130==--

