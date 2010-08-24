Content-Type: multipart/mixed; boundary="===============5522760637055389974=="
MIME-Version: 1.0
From: Yong Su <yong.su@windriver.com>
Subject: [PATCH 3/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 14:35:52 +0800
Message-ID: <1282631752-15904-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5522760637055389974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index 040a9a5..8fa8db4 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -276,8 +276,20 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *=
syntax,
 			break;
 =

 		case GSM_PERMISSIVE_STATE_GUESS_PDU:
-			if (byte !=3D '\r' && byte !=3D '\n')
+
+			/**
+			 * Modify for SMS text mode, check except message length
+			 * If >=3D 0, skip expect_msg_len bytes
+			 * If =3D=3D -1, keep original design
+			 * TODO current GSMV1 syntax can't support
+			 */
+			if (syntax->expect_msg_len =3D=3D -1) {
+				if (byte !=3D '\r' && byte !=3D '\n')
+					syntax->state =3D GSM_PERMISSIVE_STATE_PDU;
+			} else {
+				i +=3D syntax->expect_msg_len;
 				syntax->state =3D GSM_PERMISSIVE_STATE_PDU;
+			}
 			break;
 =

 		case GSM_PERMISSIVE_STATE_PDU:
-- =

1.6.3.3


--===============5522760637055389974==--

