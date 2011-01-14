Content-Type: multipart/mixed; boundary="===============0354421128556480438=="
MIME-Version: 1.0
From: Helen Clemson <clemson.helen@gmail.com>
Subject: [PATCH v2 1/2] stemodem: Incorrect string length in dtmf buf.
Date: Fri, 14 Jan 2011 12:13:19 +0100
Message-ID: <1295003599-11050-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0354421128556480438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Helen Clemson <helen.clemson@stericsson.com>

Strlen includes a NULL character.
---
 drivers/stemodem/voicecall.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 6f948f7..423f63e 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -375,16 +375,14 @@ static void ste_send_dtmf(struct ofono_voicecall *vc,=
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
-
+	/* strlen("AT+VTS=3D) =3D 7 + NULL */
+	buf =3D g_try_new(char, strlen(dtmf) + 8);
 	if (buf =3D=3D NULL)
 		goto error;
 =

-- =

1.7.1


--===============0354421128556480438==--

