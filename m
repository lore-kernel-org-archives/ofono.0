Content-Type: multipart/mixed; boundary="===============0266853413001644719=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 08/12] gatchat: fix gatsyntax to support +CPOS
Date: Fri, 11 Mar 2011 14:23:05 +0200
Message-ID: <1299846189-15132-9-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299846189-15132-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0266853413001644719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index 2fc70b8..f1d896b 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -64,6 +64,9 @@ static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxExpect=
Hint hint)
 	case G_AT_SYNTAX_EXPECT_MULTILINE:
 		syntax->state =3D GSMV1_STATE_GUESS_MULTILINE_RESPONSE;
 		break;
+	case G_AT_SYNTAX_EXPECT_SHORT_PROMPT:
+		syntax->state =3D GSMV1_STATE_PROMPT;
+		break;
 	default:
 		break;
 	};
@@ -195,6 +198,13 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *syntax,
 				i +=3D 1;
 				res =3D G_AT_SYNTAX_RESULT_PROMPT;
 				goto out;
+			} else if (byte =3D=3D '\r')
+				break;
+			else if (byte =3D=3D '\n') {
+				syntax->state =3D GSMV1_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+				goto out;
 			}
 =

 			syntax->state =3D GSMV1_STATE_RESPONSE;
@@ -239,6 +249,8 @@ static void gsm_permissive_hint(GAtSyntax *syntax, GAtS=
yntaxExpectHint hint)
 {
 	if (hint =3D=3D G_AT_SYNTAX_EXPECT_PDU)
 		syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_PDU;
+	else if (hint =3D=3D G_AT_SYNTAX_EXPECT_SHORT_PROMPT)
+		syntax->state =3D GSM_PERMISSIVE_STATE_PROMPT;
 }
 =

 static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *syntax,
@@ -298,6 +310,13 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *=
syntax,
 				i +=3D 1;
 				res =3D G_AT_SYNTAX_RESULT_PROMPT;
 				goto out;
+			} else if (byte =3D=3D '\r')
+				break;
+			else if (byte =3D=3D '\n') {
+				syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+				goto out;
 			}
 =

 			syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
-- =

1.7.0.4


--===============0266853413001644719==--

