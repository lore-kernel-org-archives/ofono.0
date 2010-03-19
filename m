Content-Type: multipart/mixed; boundary="===============3103048248327804935=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 02/10] Add basic command parsing
Date: Fri, 19 Mar 2010 17:44:40 +0800
Message-ID: <1268991888-17279-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3103048248327804935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to V.250 5.3.1, the basic command is either a single
character or the '&' followed by a single character.
---
 gatchat/gatserver.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 8e7955c..2c53d84 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -197,16 +197,111 @@ static gboolean is_basic_command_prefix(const char *=
buf)
 	return FALSE;
 }
 =

+static gboolean at_command_notify(GAtServer *server, char *command,
+						char *prefix)
+{
+	return FALSE;
+}
+
 static void parse_extended_command(GAtServer *server, char *buf,
 					unsigned int *len)
 {
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

-static void parse_basic_command(GAtServer *server, char *buf,
+static gboolean get_basic_prefix(const char *buf, char *prefix)
+{
+	char c =3D *buf;
+
+	if (!g_ascii_isalpha(c) && c !=3D '&')
+		return FALSE;
+
+	if (g_ascii_isalpha(c)) {
+		c =3D g_ascii_toupper(c);
+		if (c =3D=3D 'S') {
+			int i =3D 0;
+
+			prefix[0] =3D 'S';
+
+			/* V.250 5.3.2 'S' command follows with
+			 * a parameter number.
+			 */
+			while (g_ascii_isdigit(buf[++i]))
+				prefix[i] =3D buf[i];
+
+			prefix[i] =3D '\0';
+		} else {
+			prefix[0] =3D c;
+			prefix[1] =3D '\0';
+		}
+	}
+
+	if (c =3D=3D '&') {
+		prefix[0] =3D '&';
+		prefix[1] =3D g_ascii_toupper(buf[1]);
+		prefix[2] =3D '\0';
+	}
+
+	return TRUE;
+}
+
+static unsigned int get_basic_length(const char *buf, char *prefix, char t)
+{
+	unsigned int i;
+
+	i =3D strlen(prefix);
+
+	if (*buf =3D=3D 'D' || *buf =3D=3D 'd') {
+		/* All following characters are the part of the call */
+		while (buf[i] && buf[i] !=3D t)
+			i++;
+	} else {
+		/* Match '?', '=3D', '=3D?' or '=3D123' */
+		if (buf[i] =3D=3D '=3D')
+			i++;
+
+		if (buf[i] =3D=3D '?')
+			i++;
+		else {
+			/* V.250 5.3.1 The subparameter are all digits */
+			while (g_ascii_isdigit(buf[i]))
+				i++;
+		}
+	}
+
+	return i;
+}
+
+static void parse_basic_command(GAtServer *server, const char *buf,
 					unsigned int *len)
 {
-	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	char *command =3D NULL;
+	char prefix[20];
+	unsigned int i =3D 0;
+
+	if (!get_basic_prefix(buf, prefix))
+		goto done;
+
+	i =3D get_basic_length(buf, prefix, server->v250.s3);
+
+	command =3D g_strndup(buf, i);
+
+	if (!at_command_notify(server, command, prefix)) {
+		i =3D 0;
+		goto done;
+	}
+
+	/* Commands like ATA, ATD, ATZ cause the remainder line
+	 * to be ignored.
+	 */
+	if (*prefix =3D=3D 'A' || *prefix =3D=3D 'D' || *prefix =3D=3D 'Z')
+		i =3D 0;
+
+done:
+	if (command)
+		g_free(command);
+
+	*len =3D i;
 }
 =

 static void server_parse_line(GAtServer *server, char *line)
-- =

1.6.6.1


--===============3103048248327804935==--

