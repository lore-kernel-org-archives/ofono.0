Content-Type: multipart/mixed; boundary="===============2557816379233309920=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Subject: [PATCH] handsfree-audio: Fix parsing of Register() CODECs
Date: Fri, 12 Apr 2013 19:25:53 -0300
Message-ID: <1365805553-11587-1-git-send-email-jprvita@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2557816379233309920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this patch the mSBC CODEC is always enabled, even when the
CODECs array in the Register() message from the agent contains only
entry for the CVSD (0x01) CODEC.
---
 src/handsfree-audio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 1a1cbff..3b0814f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -682,9 +682,10 @@ static DBusMessage *am_agent_register(DBusConnection *=
conn,
 		return __ofono_error_invalid_args(msg);
 =

 	for (i =3D 0; i < length; i++) {
-		if (codecs[i] =3D=3D HFP_CODEC_CVSD)
+		if (codecs[i] =3D=3D HFP_CODEC_CVSD) {
 			has_cvsd =3D TRUE;
-		else if (codecs[i] !=3D HFP_CODEC_MSBC)
+			continue;
+		} else if (codecs[i] !=3D HFP_CODEC_MSBC)
 			return __ofono_error_invalid_args(msg);
 =

 		if (defer_setup)
-- =

1.7.11.7


--===============2557816379233309920==--

