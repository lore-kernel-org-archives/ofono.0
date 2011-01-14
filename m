Content-Type: multipart/mixed; boundary="===============8306058558778774101=="
MIME-Version: 1.0
From: Marit Henriksen <maritsofie.henriksen8@gmail.com>
Subject: [PATCH] stemodem: Use macro for clip validity.
Date: Fri, 14 Jan 2011 12:19:17 +0100
Message-ID: <1295003957-11313-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8306058558778774101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marit Henriksen <marit.henriksen@stericsson.com>

---
 drivers/stemodem/voicecall.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 8f3533d..961b750 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -116,7 +116,7 @@ static struct ofono_call *create_call(struct ofono_voic=
ecall *vc, int type,
 	call->direction =3D direction;
 	call->status =3D status;
 =

-	if (clip !=3D 2) {
+	if (clip !=3D CLIP_VALIDITY_NOT_AVAILABLE) {
 		strncpy(call->phone_number.number, num,
 			OFONO_MAX_PHONE_NUMBER_LENGTH);
 		call->phone_number.type =3D num_type;
-- =

1.7.1


--===============8306058558778774101==--

