Content-Type: multipart/mixed; boundary="===============6132833442059964645=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 08/12] gatchat: fix gatsyntax to support +CPOS
Date: Thu, 24 Mar 2011 15:46:32 +0200
Message-ID: <1300974396-15801-9-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6132833442059964645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index 2fc70b8..469ffc3 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -44,6 +44,7 @@ enum GSMV1_STATE {
 	GSMV1_STATE_PROMPT,
 	GSMV1_STATE_ECHO,
 	GSMV1_PPP_DATA,
+	GSMV1_STATE_SHORT_PROMPT,
 };
 =

 enum GSM_PERMISSIVE_STATE {
@@ -53,6 +54,7 @@ enum GSM_PERMISSIVE_STATE {
 	GSM_PERMISSIVE_STATE_GUESS_PDU,
 	GSM_PERMISSIVE_STATE_PDU,
 	GSM_PERMISSIVE_STATE_PROMPT,
+	GSM_PERMISSIVE_STATE_SHORT_PROMPT,
 };
 =

 static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxExpectHint hint)
@@ -64,6 +66,9 @@ static void gsmv1_hint(GAtSyntax *syntax, GAtSyntaxExpect=
Hint hint)
 	case G_AT_SYNTAX_EXPECT_MULTILINE:
 		syntax->state =3D GSMV1_STATE_GUESS_MULTILINE_RESPONSE;
 		break;
+	case G_AT_SYNTAX_EXPECT_SHORT_PROMPT:
+		syntax->state =3D GSMV1_STATE_SHORT_PROMPT;
+		break;
 	default:
 		break;
 	};
@@ -200,6 +205,16 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *syntax,
 			syntax->state =3D GSMV1_STATE_RESPONSE;
 			return G_AT_SYNTAX_RESULT_UNSURE;
 =

+		case GSMV1_STATE_SHORT_PROMPT:
+			if (byte =3D=3D '\r')
+				break;
+			else if (byte =3D=3D '\n') {
+				syntax->state =3D GSMV1_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+				goto out;
+			}
+
 		case GSMV1_STATE_ECHO:
 			/* This handles the case of echo of the PDU terminated
 			 * by CtrlZ character
@@ -239,6 +254,8 @@ static void gsm_permissive_hint(GAtSyntax *syntax, GAtS=
yntaxExpectHint hint)
 {
 	if (hint =3D=3D G_AT_SYNTAX_EXPECT_PDU)
 		syntax->state =3D GSM_PERMISSIVE_STATE_GUESS_PDU;
+	else if (hint =3D=3D G_AT_SYNTAX_EXPECT_SHORT_PROMPT)
+		syntax->state =3D GSM_PERMISSIVE_STATE_SHORT_PROMPT;
 }
 =

 static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *syntax,
@@ -303,6 +320,16 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *=
syntax,
 			syntax->state =3D GSM_PERMISSIVE_STATE_RESPONSE;
 			return G_AT_SYNTAX_RESULT_UNSURE;
 =

+		case GSM_PERMISSIVE_STATE_SHORT_PROMPT:
+			if (byte =3D=3D '\r')
+				break;
+			else if (byte =3D=3D '\n') {
+				syntax->state =3D GSM_PERMISSIVE_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+				goto out;
+			}
+
 		default:
 			break;
 		};
-- =

1.7.0.4


--===============6132833442059964645==--

