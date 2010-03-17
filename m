Content-Type: multipart/mixed; boundary="===============7494916912499612446=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/11] Add framework of server parser
Date: Wed, 17 Mar 2010 22:30:32 +0800
Message-ID: <1268836241-4834-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7494916912499612446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

a. The parser fetch and parse one command per loop. The prefix is
the command prefix without parameter. For example, the prefix of
"AT+CLIP=3D1" is "+CLIP".

b. Search registered notification node in command_list. Invoke the
callback if found.

c. Termiate the execution if the result is an error. Otherwise,
parse next command.
---
 gatchat/gatserver.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 46fa423..fb82ad4 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -173,8 +173,103 @@ static void g_at_server_send_final(GAtServer *server,=
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
+static gboolean is_basic_command_prefix(const char *buf)
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
+static GAtServerResult at_command_notify(GAtServer *server, char *command,
+						char *prefix)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+
+	return res;
+}
+
+static char *parse_extended_command(GAtServer *server, const char *buf,
+					char *prefix)
+{
+	return NULL;
+}
+
+static char *parse_basic_command(GAtServer *server, const char *buf,
+					char *prefix)
+{
+	return NULL;
+}
+
+static char *parse_next_command(GAtServer *server, const char *buf,
+					char *prefix)
+{
+	char *command =3D NULL;
+	char c =3D *buf;
+
+	/* fetch one command and get its prefix */
+	if (is_extended_command_prefix(c))
+		command =3D parse_extended_command(server, buf, prefix);
+	else if (is_basic_command_prefix(buf))
+		command =3D parse_basic_command(server, buf, prefix);
+
+	return command;
+}
+
 static void server_parse_line(GAtServer *server, char *line)
 {
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	char *buf =3D line;
+	char *command =3D NULL;
+	char prefix[20];
+
+	while (buf) {
+		char c =3D *buf;
+
+		/* skip semicolon */
+		if (c =3D=3D ';')
+			c =3D *(++buf);
+
+		if (c =3D=3D '\0') {
+			res =3D G_AT_SERVER_RESULT_OK;
+			break;
+		}
+
+		command =3D parse_next_command(server, buf, prefix);
+		if (!command) {
+			res =3D G_AT_SERVER_RESULT_ERROR;
+			break;
+		}
+
+		res =3D at_command_notify(server, command, prefix);
+		if (res !=3D G_AT_SERVER_RESULT_OK) {
+			g_free(command);
+			break;
+		}
+
+		buf +=3D strlen(command);
+
+		g_free(command);
+	}
+
+	g_at_server_send_final(server, res);
+
 	g_free(line);
 }
 =

-- =

1.6.6.1


--===============7494916912499612446==--

