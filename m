Content-Type: multipart/mixed; boundary="===============4421058617320045796=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 6/9] gatchat: fix gatsyntax to support +CPOS
Date: Tue, 08 Mar 2011 13:00:48 +0200
Message-ID: <1299582051-32701-7-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299582051-32701-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4421058617320045796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatsyntax.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatsyntax.c b/gatchat/gatsyntax.c
index 2fc70b8..a85bc66 100644
--- a/gatchat/gatsyntax.c
+++ b/gatchat/gatsyntax.c
@@ -90,7 +90,11 @@ static GAtSyntaxResult gsmv1_feed(GAtSyntax *syntax,
 =

 		case GSMV1_STATE_INITIAL_CR:
 			if (byte =3D=3D '\n')
-				syntax->state =3D GSMV1_STATE_INITIAL_LF;
+				if (*len =3D=3D 2) {
+					res =3D G_AT_SYNTAX_RESULT_PROMPT;
+					syntax->state =3D GSMV1_STATE_IDLE;
+				} else
+					syntax->state =3D GSMV1_STATE_INITIAL_LF;
 			else
 				syntax->state =3D GSMV1_STATE_ECHO;
 			break;
@@ -252,7 +256,9 @@ static GAtSyntaxResult gsm_permissive_feed(GAtSyntax *s=
yntax,
 =

 		switch (syntax->state) {
 		case GSM_PERMISSIVE_STATE_IDLE:
-			if (byte =3D=3D '\r' || byte =3D=3D '\n')
+			if (byte =3D=3D '\n' && *len =3D=3D 2)
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+			else if (byte =3D=3D '\r' || byte =3D=3D '\n')
 				/* ignore */;
 			else if (byte =3D=3D '>')
 				syntax->state =3D GSM_PERMISSIVE_STATE_PROMPT;
-- =

1.7.0.4


--===============4421058617320045796==--

