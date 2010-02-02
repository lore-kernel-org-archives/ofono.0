Content-Type: multipart/mixed; boundary="===============8503021439293182878=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix change state immediately when meet the slash
Date: Tue, 02 Feb 2010 21:23:22 +0800
Message-ID: <1265117002-11006-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8503021439293182878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to V.250 spec section 5.2.4 Repeating a command line, if
the prefix "A/" or "a/" is received, we should execute the last
command immediately. No need to meet \r.
---
 gatchat/gatserver.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index fe5c3a8..eb33605 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -35,7 +35,6 @@
 enum ParserState {
 	PARSER_STATE_IDLE,
 	PARSER_STATE_A,
-	PARSER_STATE_SLASH,
 	PARSER_STATE_COMMAND,
 	PARSER_STATE_GARBAGE,
 };
@@ -214,22 +213,14 @@ static enum ParserResult server_feed(GAtServer *serve=
r,
 				i +=3D 1;
 				res =3D PARSER_RESULT_GARBAGE;
 				goto out;
-			} else if (byte =3D=3D '/')
-				server->parser_state =3D PARSER_STATE_SLASH;
-			else if (byte =3D=3D 'T' || byte =3D=3D 't')
+			} else if (byte =3D=3D '/') {
 				server->parser_state =3D PARSER_STATE_COMMAND;
-			else
-				server->parser_state =3D PARSER_STATE_GARBAGE;
-
-			break;
-
-		case PARSER_STATE_SLASH:
-			if (byte =3D=3D s3) {
-				server->parser_state =3D PARSER_STATE_IDLE;
-				i+=3D 1;
+				i +=3D 1;
 				res =3D PARSER_RESULT_REPEAT_LAST;
 				goto out;
-			} else if (byte !=3D ' ' && byte !=3D '\t')
+			} else if (byte =3D=3D 'T' || byte =3D=3D 't')
+				server->parser_state =3D PARSER_STATE_COMMAND;
+			else
 				server->parser_state =3D PARSER_STATE_GARBAGE;
 =

 			break;
@@ -246,7 +237,6 @@ static enum ParserResult server_feed(GAtServer *server,
 		case PARSER_STATE_GARBAGE:
 			if (byte =3D=3D s3) {
 				server->parser_state =3D PARSER_STATE_IDLE;
-
 				i +=3D 1;
 				res =3D PARSER_RESULT_GARBAGE;
 				goto out;
-- =

1.6.6.1


--===============8503021439293182878==--

