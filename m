Content-Type: multipart/mixed; boundary="===============0595072621764964281=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 2/3] G1: Add a G1 syntax for parsing
Date: Sun, 30 Aug 2009 00:07:08 -0400
Message-ID: <20090830040708.GA28068@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0595072621764964281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
index 70e4914..b0208bc 100644
--- a/plugins/g1.c
+++ b/plugins/g1.c
@@ -33,7 +33,6 @@
 =

 #include <glib.h>
 #include <gatchat.h>
-#include <gatsyntax.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -62,6 +61,90 @@ struct g1_data {
 	GIOChannel *io;
 };
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
 static void connect_destroy(gpointer user)
 {
 	struct ofono_modem *modem =3D user;
@@ -102,7 +185,7 @@ static gboolean connect_cb(GIOChannel *io, GIOCondition=
 cond, gpointer user)
 	if (success =3D=3D FALSE)
 		goto error;
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	syntax =3D g_at_syntax_new_full(g1_feed, g1_hint, G1_STATE_IDLE);
 	d->chat =3D g_at_chat_new(io, syntax);
 	g_at_syntax_unref(syntax);
 =

-- =

1.6.3.3

--===============0595072621764964281==--

