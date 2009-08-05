Content-Type: multipart/mixed; boundary="===============2160493576555839347=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 2/2] gatchat: add a GARBAGE state to handle random crud from a
 terminal adapter
Date: Wed, 05 Aug 2009 17:51:31 -0400
Message-ID: <20090805175131.2054657b@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2160493576555839347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've got a version of this that works w/ denkenz's new parser stuff;
let me know if I should send that instead.



From d6e942c2e0e2f51c5391e61aa7b5ac7326de28ea Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Tue, 4 Aug 2009 21:33:09 -0400
Subject: [PATCH 2/2] gatchat: add a GARBAGE state to handle random crud fro=
m a terminal adapter

When the TA sends random crap, oFono's parser gets confused and doesn't
process the next few results (which causes oFono not to send further comman=
ds,
and thus initialization never finishes).  This is less than ideal.

This patch adds a new state; when the parser gets something that doesn't
look like a proper response, it will simply ignore the entire line.  This
allows initialization to continue when the TA does send spurious lines.
---
 gatchat/gatchat.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 15cc934..8f00862 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -55,7 +55,8 @@ enum chat_state {
 	PARSER_STATE_PDU_CR,
 	PARSER_STATE_PDU_COMPLETE,
 	PARSER_STATE_PROMPT,
-	PARSER_STATE_PROMPT_COMPLETE
+	PARSER_STATE_PROMPT_COMPLETE,
+	PARSER_STATE_GARBAGE,
 };
 =

 struct at_command {
@@ -555,7 +556,9 @@ static inline void parse_char(GAtChat *chat, char byte)
 				chat->state =3D PARSER_STATE_PROMPT;
 			else
 				chat->state =3D PARSER_STATE_RESPONSE;
-		}
+		} else
+			/* TA sent something we don't understand; ignore it */
+			chat->state =3D PARSER_STATE_GARBAGE;
 		break;
 =

 	case PARSER_STATE_INITIAL_CR:
@@ -623,6 +626,11 @@ static inline void parse_char(GAtChat *chat, char byte)
 			chat->state =3D PARSER_STATE_RESPONSE;
 		break;
 =

+	case PARSER_STATE_GARBAGE:
+		if (byte =3D=3D '\n')
+			chat->state =3D PARSER_STATE_IDLE;
+		break;
+
 	case PARSER_STATE_RESPONSE_COMPLETE:
 	case PARSER_STATE_PDU_COMPLETE:
 	case PARSER_STATE_MULTILINE_COMPLETE:
-- =

1.6.3.3


--===============2160493576555839347==--

