Content-Type: multipart/mixed; boundary="===============5794770394012975345=="
MIME-Version: 1.0
From: Sergio Checa Blanco <sergio.checa@oss.bmw-carit.de>
Subject: [PATCH] hfpmodem: Split AT+VTS command into multiple +VTS
Date: Fri, 20 Jun 2014 10:03:51 +0200
Message-ID: <1403251431-17518-1-git-send-email-sergio.checa@oss.bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5794770394012975345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sergio Checa Blanco <sergio.checa@bmw-carit.de>

According to the standard "3GPP 27.007 v6.8.0" Appendix C.2.11,
when sending multiple DTMF characters, these must go in individual
+VTS commands for each tone. This adopts the AT modem approach.

Before: AT+VTS=3D1234\r
After:  AT+VTS=3D1;+VTS=3D2;+VTS=3D3;+VTS=3D4\r
---
 drivers/hfpmodem/voicecall.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index e958fe0..f16282c 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -654,8 +654,10 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc, =
const char *dtmf,
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	struct change_state_req *req =3D g_try_new0(struct change_state_req, 1);
+	int len =3D strlen(dtmf);
 	char *buf;
 	int s;
+	int i;
 =

 	if (req =3D=3D NULL)
 		goto error;
@@ -665,12 +667,15 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc,=
 const char *dtmf,
 	req->data =3D data;
 	req->affected_types =3D 0;
 =

-	/* strlen("AT+VTS=3D) =3D 7 + NULL */
-	buf =3D g_try_new(char, strlen(dtmf) + 8);
+	/* strlen("AT") + (n-1) * strlen("+VTS=3DT;") + strlen(+VTS=3DT) + null */
+	buf =3D g_try_new(char, len * 7 + 2);
 	if (buf =3D=3D NULL)
 		goto error;
 =

-	sprintf(buf, "AT+VTS=3D%s", dtmf);
+	s =3D sprintf(buf, "AT+VTS=3D%c", dtmf[0]);
+
+	for (i =3D 1; i < len; i++)
+		s +=3D sprintf(buf + s, ";+VTS=3D%c", dtmf[i]);
 =

 	s =3D g_at_chat_send(vd->chat, buf, none_prefix,
 				generic_cb, req, g_free);
-- =

2.0.0


--===============5794770394012975345==--

