Content-Type: multipart/mixed; boundary="===============8838397497020912235=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/3] Refactor the command parsing
Date: Mon, 29 Mar 2010 21:50:02 +0800
Message-ID: <1269870604-28896-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269870604-28896-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8838397497020912235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  103 +++++++++++++++++++++++++++--------------------=
---
 1 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c75fbf5..07999a8 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -112,6 +112,8 @@ struct _GAtServer {
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 	gboolean destroyed;			/* Re-entrancy guard */
+	char *read_line;			/* Current read line */
+	unsigned int read_pos;			/* Current read offset */
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
@@ -215,7 +217,7 @@ static void at_command_notify(GAtServer *server, char *=
command,
 	g_slist_free(result.lines);
 }
 =

-static unsigned int parse_extended_command(GAtServer *server, char *buf)
+static void parse_extended_command(GAtServer *server, char *buf)
 {
 	const char *valid_extended_chars =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 						"0123456789!%-./:_";
@@ -230,7 +232,7 @@ static unsigned int parse_extended_command(GAtServer *s=
erver, char *buf)
 	prefix_len =3D strcspn(buf, separators);
 =

 	if (prefix_len > 17 || prefix_len < 2)
-		return 0;
+		goto error;
 =

 	/* Convert to upper case, we will always use upper case naming */
 	for (i =3D 0; i < prefix_len; i++)
@@ -239,17 +241,17 @@ static unsigned int parse_extended_command(GAtServer =
*server, char *buf)
 	prefix[prefix_len] =3D '\0';
 =

 	if (strspn(prefix + 1, valid_extended_chars) !=3D (prefix_len - 1))
-		return 0;
+		goto error;
 =

 	/*
 	 * V.250 Section 5.4.1: "The first character following "+" shall be
 	 * an alphabetic character in the range "A" through "Z".
 	 */
 	if (prefix[1] <=3D 'A' || prefix[1] >=3D 'Z')
-		return 0;
+		goto error;
 =

 	if (buf[i] !=3D '\0' && buf[i] !=3D ';' && buf[i] !=3D '?' && buf[i] !=3D=
 '=3D')
-		return 0;
+		goto error;
 =

 	type =3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY;
 =

@@ -265,16 +267,16 @@ static unsigned int parse_extended_command(GAtServer =
*server, char *buf)
 =

 		if (buf[i] =3D=3D '?') {
 			if (seen_question || seen_equals)
-				return 0;
+				goto error;
 =

 			if (buf[i + 1] !=3D '\0' && buf[i + 1] !=3D ';')
-				return 0;
+				goto error;
 =

 			seen_question =3D TRUE;
 			type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
 		} else if (buf[i] =3D=3D '=3D') {
 			if (seen_equals || seen_question)
-				return 0;
+				goto error;
 =

 			seen_equals =3D TRUE;
 =

@@ -291,10 +293,15 @@ next:
 	/* We can scratch in this buffer, so mark ';' as null */
 	buf[i] =3D '\0';
 =

+	/* Also consume the terminating null */
+	server->read_pos +=3D i + 1;
+
 	at_command_notify(server, buf, prefix, type);
 =

-	/* Also consume the terminating null */
-	return i + 1;
+	return;
+
+error:
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

 static int get_basic_prefix_size(const char *buf)
@@ -336,16 +343,20 @@ static int get_basic_prefix_size(const char *buf)
 	return 0;
 }
 =

-static unsigned int parse_basic_command(GAtServer *server, char *buf)
+static void parse_basic_command(GAtServer *server, char *buf)
 {
 	gboolean seen_equals =3D FALSE;
 	char prefix[4], tmp;
-	unsigned int i, prefix_size;
+	unsigned int i, prefix_size, end;
 	GAtServerRequestType type;
 =

 	prefix_size =3D get_basic_prefix_size(buf);
 	if (prefix_size =3D=3D 0)
-		return 0;
+		goto error;
+
+	/* Handle S-parameter with 100+ */
+	if (prefix_size > 3)
+		goto error;
 =

 	i =3D prefix_size;
 	prefix[0] =3D g_ascii_toupper(buf[0]);
@@ -390,33 +401,39 @@ static unsigned int parse_basic_command(GAtServer *se=
rver, char *buf)
 	}
 =

 done:
-	if (prefix_size <=3D 3) {
-		memcpy(prefix + 1, buf + 1, prefix_size - 1);
-		prefix[prefix_size] =3D '\0';
-
-		tmp =3D buf[i];
-		buf[i] =3D '\0';
-		at_command_notify(server, buf, prefix, type);
-		buf[i] =3D tmp;
-	} else /* Handle S-parameter with 100+ */
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	end =3D i;
 =

 	/* Commands like ATA, ATZ cause the remainder line
 	 * to be ignored.
 	 */
 	if (prefix[0] =3D=3D 'A' || prefix[0] =3D=3D 'Z')
-		return strlen(buf);
+		i =3D strlen(buf);
 =

 	/* Consume the seperator ';' */
 	if (buf[i] =3D=3D ';')
 		i +=3D 1;
 =

-	return i;
+	/* Update read offset before notify the callback */
+	server->read_pos +=3D i;
+
+	memcpy(prefix + 1, buf + 1, prefix_size - 1);
+	prefix[prefix_size] =3D '\0';
+
+	tmp =3D buf[end];
+	buf[end] =3D '\0';
+	at_command_notify(server, buf, prefix, type);
+	buf[end] =3D tmp;
+
+	return;
+
+error:
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

-static void server_parse_line(GAtServer *server, char *line)
+static void server_parse_line(GAtServer *server)
 {
-	unsigned int pos =3D 0;
+	char *line =3D server->read_line;
+	unsigned int pos =3D server->read_pos;
 	unsigned int len =3D strlen(line);
 =

 	if (len =3D=3D 0) {
@@ -424,22 +441,10 @@ static void server_parse_line(GAtServer *server, char=
 *line)
 		return;
 	}
 =

-	while (pos < len) {
-		unsigned int consumed;
-
-		if (is_extended_command_prefix(line[pos]))
-			consumed =3D parse_extended_command(server, line + pos);
-		else
-			consumed =3D parse_basic_command(server, line + pos);
-
-		if (consumed =3D=3D 0) {
-			g_at_server_send_final(server,
-						G_AT_SERVER_RESULT_ERROR);
-			break;
-		}
-
-		pos +=3D consumed;
-	}
+	if (is_extended_command_prefix(line[pos]))
+		parse_extended_command(server, line + pos);
+	else
+		parse_basic_command(server, line + pos);
 }
 =

 static enum ParserResult server_feed(GAtServer *server,
@@ -621,11 +626,13 @@ static void new_bytes(GAtServer *p)
 =

 		case PARSER_RESULT_COMMAND:
 		{
-			char *line =3D extract_line(p);
+			g_free(p->read_line);
 =

-			if (line) {
-				server_parse_line(p, line);
-				g_free(line);
+			p->read_line =3D extract_line(p);
+			if (p->read_line) {
+				p->read_pos =3D 0;
+
+				server_parse_line(p);
 			} else
 				g_at_server_send_final(p,
 						G_AT_SERVER_RESULT_ERROR);
@@ -795,6 +802,8 @@ static void g_at_server_cleanup(GAtServer *server)
 	g_hash_table_destroy(server->command_list);
 	server->command_list =3D NULL;
 =

+	g_free(server->read_line);
+
 	server->channel =3D NULL;
 }
 =

-- =

1.6.6.1


--===============8838397497020912235==--

