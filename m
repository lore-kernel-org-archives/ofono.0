Content-Type: multipart/mixed; boundary="===============5548920473856986558=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 2/2] G1: Add a G1 syntax for parsing
Date: Wed, 02 Sep 2009 19:03:36 -0400
Message-ID: <20090902190336.67cc9648@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5548920473856986558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From 93780606b576bf528e5d5e7be892ced1681cd7a0 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Tue, 25 Aug 2009 18:07:28 -0400
Subject: [PATCH 2/2] G1: Add a G1 syntax for parsing

This is based on the generic_at parser, with unnecessary stuff removed.

The G1 routinely screws up CRLFs, so the parser needs to account for
that.  This parser ignores leading CRLFs (which is what reference-ril
does as well), as well as trailing LFs (which are sometimes left out).
CRs are used as end-of-message indicators.  Since we're not bothering
tracking CRLFs, there's also no need for a GARBAGE state, or MULTILINE
stuff.
---
 plugins/g1.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/plugins/g1.c b/plugins/g1.c
index ab88e1c..30b9f94 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -28,7 +28,6 @@
 =

 #include <glib.h>
 #include <gatchat.h>
-#include <gatsyntax.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -48,6 +47,90 @@
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
 =

+/* Supply our own syntax parser */
+
+enum G1_STATE_ {
+	G1_STATE_IDLE =3D 0,
+	G1_STATE_RESPONSE,
+	G1_STATE_GUESS_PDU,
+	G1_STATE_PDU,
+	G1_STATE_PROMPT,
+};
+
+static void g1_hint(GAtSyntax *syntax, GAtSyntaxExpectHint hint)
+{
+	if (hint =3D=3D G_AT_SYNTAX_EXPECT_PDU)
+		syntax->state =3D G1_STATE_GUESS_PDU;
+}
+
+static GAtSyntaxResult g1_feed(GAtSyntax *syntax,
+		const char *bytes, gsize *len)
+{
+	gsize i =3D 0;
+	GAtSyntaxResult res =3D G_AT_SYNTAX_RESULT_UNSURE;
+
+	while (i < *len) {
+		char byte =3D bytes[i];
+
+		switch (syntax->state) {
+		case G1_STATE_IDLE:
+			if (byte =3D=3D '\r' || byte =3D=3D '\n')
+				/* ignore */;
+			else if (byte =3D=3D '>')
+				syntax->state =3D G1_STATE_PROMPT;
+			else
+				syntax->state =3D G1_STATE_RESPONSE;
+			break;
+
+		case G1_STATE_RESPONSE:
+			if (byte =3D=3D '\r') {
+				syntax->state =3D G1_STATE_IDLE;
+
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_LINE;
+				goto out;
+			}
+			break;
+
+		case G1_STATE_GUESS_PDU:
+			/* keep going until we find a LF that leads the PDU */
+			if (byte =3D=3D '\n')
+				syntax->state =3D G1_STATE_PDU;
+			break;
+
+		case G1_STATE_PDU:
+			if (byte =3D=3D '\r') {
+				syntax->state =3D G1_STATE_IDLE;
+
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PDU;
+				goto out;
+			}
+			break;
+
+		case G1_STATE_PROMPT:
+			if (byte =3D=3D ' ') {
+				syntax->state =3D G1_STATE_IDLE;
+				i +=3D 1;
+				res =3D G_AT_SYNTAX_RESULT_PROMPT;
+				goto out;
+			}
+
+			syntax->state =3D G1_STATE_RESPONSE;
+			return G_AT_SYNTAX_RESULT_UNSURE;
+
+		default:
+			break;
+		};
+
+		i +=3D 1;
+	}
+
+out:
+	*len =3D i;
+	return res;
+}
+
 static void g1_debug(const char *str, void *data)
 {
 	DBG("%s", str);
@@ -61,7 +144,7 @@ static int g1_probe(struct ofono_modem *modem)
 =

 	DBG("");
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	syntax =3D g_at_syntax_new_full(g1_feed, g1_hint, G1_STATE_IDLE);
 	chat =3D g_at_chat_new_from_tty("/dev/smd0", syntax);
 	g_at_syntax_unref(syntax);
 =

-- =

1.6.3.3


--===============5548920473856986558==--

