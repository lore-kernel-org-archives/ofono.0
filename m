Content-Type: multipart/mixed; boundary="===============6803888479696207911=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/7] Add framework of server parser
Date: Wed, 03 Mar 2010 22:56:47 +0800
Message-ID: <1267628212-14079-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267628212-14079-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6803888479696207911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

1. The parser fetches one basic or extended command per iteration.
The prefix is the command prefix without parameter. For example, in
command "AT+CLIP=3D1", prefix is "+CLIP".
2. Search registered notification node in command_list. If found,
get command type and invoke callback, and then return result.
3. Termiate the execution if the result in an error. Otherwise,
fetch next command.
---
 gatchat/gatserver.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 94 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 4175112..c54170e 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -173,9 +173,99 @@ static void g_at_server_send_result(GAtServer *server,=
 GAtServerResult result)
 	send_common(server, buf, MIN(len, sizeof(buf)-1));
 }
 =

+static inline gboolean is_extended_command_prefix(const char c)
+{
+	switch (c) {
+	case '+':
+	case '*':
+	case '!':
+	case '%':
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
+static gboolean is_basic_command_prefix(char *buf)
+{
+	if (g_ascii_isalpha(buf[0]))
+		return TRUE;
+
+	if (buf[0] =3D=3D '&' && g_ascii_isalpha(buf[1]))
+		return TRUE;
+
+	return FALSE;
+}
+
+static GAtServerResult at_notify_callback(GAtServer *server, char *command,
+					char *prefix)
+{
+	int res =3D G_AT_SERVER_RESULT_ERROR;
+
+	return res;
+}
+
+static char *parse_extended_command(GAtServer *server, char *buf,
+					char *prefix)
+{
+	return NULL;
+}
+
+static char *parse_basic_command(GAtServer *server, char *buf, char *prefi=
x)
+{
+	return NULL;
+}
+
+static char *server_parse_next_command(GAtServer *server, char *buf,
+					char *prefix)
+{
+	char *command =3D NULL;
+
+	if (is_extended_command_prefix(*buf))
+		command =3D parse_extended_command(server, buf, prefix);
+	else if (is_basic_command_prefix(buf))
+		command =3D parse_basic_command(server, buf, prefix);
+
+	return command;
+}
+
 static GAtServerResult server_parse_line(GAtServer *server, char *line)
 {
 	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	char *command =3D NULL;
+	char prefix[20];
+
+	while (line) {
+		if (*line =3D=3D '\0') {
+			res =3D G_AT_SERVER_RESULT_OK;
+			break;
+		}
+
+		/* skip semicolon */
+		if (*line =3D=3D ';')
+			line++;
+
+		memset(prefix, 0, sizeof(prefix));
+
+		command =3D server_parse_next_command(server, line, prefix);
+		if (!command) {
+			res =3D G_AT_SERVER_RESULT_ERROR;
+			break;
+		}
+
+		res =3D at_notify_callback(server, command, prefix);
+		/* Termiate the execution if command result in an error */
+		if (res !=3D G_AT_SERVER_RESULT_OK)
+			break;
+
+		line +=3D strlen(command);
+
+		g_free(command);
+		command =3D NULL;
+	}
+
+	if (command)
+		g_free(command);
 =

 	return res;
 }
@@ -331,6 +421,7 @@ static void new_bytes(GAtServer *p)
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserState state;
 	GAtServerResult result;
+	char *line;
 =

 	while (p->channel && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
@@ -361,8 +452,10 @@ static void new_bytes(GAtServer *p)
 			break;
 =

 		case PARSER_RESULT_COMMAND:
-			result =3D server_parse_line(p, extract_line(p));
+			line =3D extract_line(p);
+			result =3D server_parse_line(p, line);
 			g_at_server_send_result(p, result);
+			g_free(line);
 			break;
 =

 		case PARSER_RESULT_REPEAT_LAST:
-- =

1.6.6.1


--===============6803888479696207911==--

