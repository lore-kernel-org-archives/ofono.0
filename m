Content-Type: multipart/mixed; boundary="===============3715880434988917552=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Fix server only return the final parser result
Date: Tue, 02 Mar 2010 18:21:39 +0800
Message-ID: <1267525299-5740-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267525299-5740-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3715880434988917552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case we meet compound commands in single line, AtServer should
only return the parser result of last command according to spec.
So we return the parser result in the parse iteration.
---
 gatchat/gatserver.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index df3c8bf..c9256e2 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -186,28 +186,27 @@ static inline gboolean is_at_command_prefix(const cha=
r c)
 	}
 }
 =

-static void parse_at_command(GAtServer *server, char *buf)
+static GAtServerResult parse_at_command(GAtServer *server, char *buf)
 {
-	g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);
+	return G_AT_SERVER_RESULT_ERROR;
 }
 =

-static void parse_v250_settings(GAtServer *server, char *buf)
+static GAtServerResult parse_v250_settings(GAtServer *server, char *buf)
 {
-	g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);
+	return G_AT_SERVER_RESULT_ERROR;
 }
 =

-static void server_parse_line(GAtServer *server, char *line)
+static GAtServerResult server_parse_line(GAtServer *server, char *line)
 {
 	gsize i =3D 0;
 	char c;
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
 =

-	if (line =3D=3D NULL) {
-		g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);
+	if (line =3D=3D NULL)
 		goto done;
-	}
 =

 	if (line[0] =3D=3D '\0') {
-		g_at_server_send_result(server, G_AT_SERVER_RESULT_OK);
+		res =3D G_AT_SERVER_RESULT_OK;
 		goto done;
 	}
 =

@@ -217,14 +216,13 @@ static void server_parse_line(GAtServer *server, char=
 *line)
 		c =3D line[++i];
 =

 	if (is_at_command_prefix(c))
-		parse_at_command(server, line + i);
+		res =3D parse_at_command(server, line + i);
 	else if (g_ascii_isalpha(c) || c =3D=3D '&')
-		parse_v250_settings(server, line + i);
-	else
-		g_at_server_send_result(server, G_AT_SERVER_RESULT_ERROR);
+		res =3D parse_v250_settings(server, line + i);
 =

 done:
 	g_free(line);
+	return res;
 }
 =

 static enum ParserResult server_feed(GAtServer *server,
@@ -377,6 +375,7 @@ static void new_bytes(GAtServer *p)
 	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserState state;
+	GAtServerResult result;
 =

 	while (p->channel && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
@@ -407,7 +406,8 @@ static void new_bytes(GAtServer *p)
 			break;
 =

 		case PARSER_RESULT_COMMAND:
-			server_parse_line(p, extract_line(p));
+			result =3D server_parse_line(p, extract_line(p));
+			g_at_server_send_result(p, result);
 			break;
 =

 		case PARSER_RESULT_REPEAT_LAST:
-- =

1.6.6.1


--===============3715880434988917552==--

