Content-Type: multipart/mixed; boundary="===============4022497547810335288=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] rilmodem: update call direction from the isMT value
Date: Sun, 05 Apr 2020 20:26:13 +0900
Message-ID: <20200405112613.40239-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4022497547810335288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

oFono cannot determines the call of direction when the voicecall
is triggered in rilmodem
---
 drivers/rilmodem/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 13dc5071..6c169166 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -177,7 +177,7 @@ static void clcc_poll_cb(struct ril_msg *message, gpoin=
ter user_data)
 		call->id =3D parcel_r_int32(&rilp);
 		call->phone_number.type =3D parcel_r_int32(&rilp);
 		parcel_r_int32(&rilp); /* isMpty */
-		parcel_r_int32(&rilp); /* isMT */
+		call->direction =3D parcel_r_int32(&rilp); /* isMT */
 		parcel_r_int32(&rilp); /* als */
 		call->type =3D parcel_r_int32(&rilp); /* isVoice */
 		parcel_r_int32(&rilp); /* isVoicePrivacy */
-- =

2.17.1

--===============4022497547810335288==--

