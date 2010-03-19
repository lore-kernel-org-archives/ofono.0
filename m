Content-Type: multipart/mixed; boundary="===============5803791068509021027=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/10] Add framework of server parser
Date: Fri, 19 Mar 2010 17:44:39 +0800
Message-ID: <1268991888-17279-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5803791068509021027==
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
 gatchat/gatserver.c |   46 ++++++++++++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 4df3f06..8e7955c 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -197,42 +197,48 @@ static gboolean is_basic_command_prefix(const char *b=
uf)
 	return FALSE;
 }
 =

-static void parse_extended_command(GAtServer *server, char *buf)
+static void parse_extended_command(GAtServer *server, char *buf,
+					unsigned int *len)
 {
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

-static void parse_basic_command(GAtServer *server, char *buf)
+static void parse_basic_command(GAtServer *server, char *buf,
+					unsigned int *len)
 {
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

 static void server_parse_line(GAtServer *server, char *line)
 {
-	gsize i =3D 0;
-	char c;
-
-	if (line =3D=3D NULL) {
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
-		goto done;
-	}
+	char *buf =3D line;
 =

-	if (line[0] =3D=3D '\0') {
+	if (*buf =3D=3D '\0') {
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 		goto done;
 	}
 =

-	c =3D line[i];
-	/* skip semicolon */
-	if (c =3D=3D ';')
-		c =3D line[++i];
+	while (*buf) {
+		unsigned int len =3D 0;
+		char c =3D *buf;
 =

-	if (is_extended_command_prefix(c))
-		parse_extended_command(server, line + i);
-	else if (is_basic_command_prefix(line + i))
-		parse_basic_command(server, line + i);
-	else
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		/* skip semicolon */
+		if (c =3D=3D ';')
+			c =3D *(++buf);
+
+		if (c =3D=3D '\0')
+			break;
+
+		if (is_extended_command_prefix(c))
+			parse_extended_command(server, buf, &len);
+		else if (is_basic_command_prefix(buf))
+			parse_basic_command(server, buf, &len);
+
+		if (len =3D=3D 0)
+			break;
+
+		buf +=3D len;
+	}
 =

 done:
 	g_free(line);
-- =

1.6.6.1


--===============5803791068509021027==--

