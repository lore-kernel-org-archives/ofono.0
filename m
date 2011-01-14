Content-Type: multipart/mixed; boundary="===============3311793398121511856=="
MIME-Version: 1.0
From: Helen Clemson <clemson.helen@gmail.com>
Subject: [PATCH v2 2/2] hfpmodem: Incorrect string length in dtmf buf.
Date: Fri, 14 Jan 2011 12:14:24 +0100
Message-ID: <1295003664-11096-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3311793398121511856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Helen Clemson <helen.clemson@stericsson.com>

Strlen includes a NULL character.
---
 drivers/hfpmodem/voicecall.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 4c8ee37..d4d370e 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -590,9 +590,8 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc, c=
onst char *dtmf,
 	req->data =3D data;
 	req->affected_types =3D 0;
 =

-	/* strlen("AT+VTS=3D") =3D 7 */
-	buf =3D g_try_new(char, strlen(dtmf) + 7);
-
+	/* strlen("AT+VTS=3D) =3D 7 + NULL */
+	buf =3D g_try_new(char, strlen(dtmf) + 8);
 	if (buf =3D=3D NULL)
 		goto error;
 =

-- =

1.7.1


--===============3311793398121511856==--

