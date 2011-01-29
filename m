Content-Type: multipart/mixed; boundary="===============2287159564833499939=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 03/11] calypsomodem: remove NULL check
Date: Sat, 29 Jan 2011 05:34:36 -0800
Message-ID: <1296308084-3726-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1296308084-3726-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2287159564833499939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/calypsomodem/stk.c       |    4 ++--
 drivers/calypsomodem/voicecall.c |    4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/calypsomodem/stk.c b/drivers/calypsomodem/stk.c
index 196b9e3..83287f9 100644
--- a/drivers/calypsomodem/stk.c
+++ b/drivers/calypsomodem/stk.c
@@ -101,7 +101,7 @@ static void calypso_stk_envelope(struct ofono_stk *stk,=
 int length,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT%%SATE=3D\"");
@@ -148,7 +148,7 @@ static void calypso_stk_terminal_response(struct ofono_=
stk *stk, int length,
 =

 	DBG("");
 =

-	if (cbd =3D=3D NULL || buf =3D=3D NULL)
+	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT%%SATR=3D\"");
diff --git a/drivers/calypsomodem/voicecall.c b/drivers/calypsomodem/voicec=
all.c
index 204ed14..01be990 100644
--- a/drivers/calypsomodem/voicecall.c
+++ b/drivers/calypsomodem/voicecall.c
@@ -64,14 +64,10 @@ static void calypso_template(struct ofono_voicecall *vc=
, const char *cmd,
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

-	if (cbd =3D=3D NULL)
-		goto error;
-
 	if (g_at_chat_send(vd->chat, cmd, none_prefix,
 				calypso_generic_cb, cbd, g_free) > 0)
 		return;
 =

-error:
 	g_free(cbd);
 =

 	CALLBACK_WITH_FAILURE(cb, data);
-- =

1.7.0.4


--===============2287159564833499939==--

