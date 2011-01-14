Content-Type: multipart/mixed; boundary="===============8154731558591955408=="
MIME-Version: 1.0
From: Helen Clemson <clemson.helen@gmail.com>
Subject: [PATCH] stemodem: Incorrect string length in dtmf buf.
Date: Fri, 14 Jan 2011 11:04:05 +0100
Message-ID: <1294999445-10274-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8154731558591955408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Helen Clemson <helen.clemson@stericsson.com>

Strlen includes a NULL character. This change affects both stemodem and hfp=
modem.
---
 drivers/hfpmodem/voicecall.c |    4 ++--
 drivers/stemodem/voicecall.c |    5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 4c8ee37..1aefc53 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -590,8 +590,8 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 	req->data =3D data;
 	req->affected_types =3D 0;
 =

-	/* strlen("AT+VTS=3D") =3D 7 */
-	buf =3D g_try_new(char, strlen(dtmf) + 7);
+	/* strlen("AT+VTS=3D) =3D 7 + NULL */
+	buf =3D g_try_new(char, strlen(dtmf) + 8);
 =

 	if (buf =3D=3D NULL)
 		goto error;
diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 8f3533d..ea3d48f 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -375,15 +375,14 @@ static void ste_send_dtmf(struct ofono_voicecall *vc,=
 const char *dtmf,
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	int len =3D strlen(dtmf);
 	int s;
 	char *buf;
 =

 	if (cbd =3D=3D NULL)
 		goto error;
 =

-	/* strlen("AT+VTS=3D) =3D 7 */
-	buf =3D g_try_new(char, len + 7);
+	/* strlen("AT+VTS=3D) =3D 7 + NULL */
+	buf =3D g_try_new(char, strlen(dtmf) + 8);
 =

 	if (buf =3D=3D NULL)
 		goto error;
-- =

1.7.1


--===============8154731558591955408==--

