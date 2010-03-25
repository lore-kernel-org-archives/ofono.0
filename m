Content-Type: multipart/mixed; boundary="===============2725381226991898390=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/5] Refactor the command parsing framework
Date: Thu, 25 Mar 2010 21:48:17 +0800
Message-ID: <1269524901-1745-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269524901-1745-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2725381226991898390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  182 +++++++++++++++++++++++++++++++++++------------=
---
 gatchat/gatserver.h |    7 ++-
 2 files changed, 133 insertions(+), 56 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c75fbf5..74c765d 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -112,9 +112,51 @@ struct _GAtServer {
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 	gboolean destroyed;			/* Re-entrancy guard */
+	char *read_line;			/* Current read line */
+	unsigned int read_pos;			/* Current read offset */
+	int notify_source;			/* Source of notify callback */
+	GAtServerResult last_result;		/* Result of last command */
+};
+
+struct at_notify_node {
+	GAtServer *server;
+	char *command;
+	char *prefix;
+	GAtServerRequestType type;
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
+static void server_parse_line(gpointer user_data);
+
+static struct at_notify_node *at_node_new(GAtServer *server,
+						char *buf, char *prefix,
+						GAtServerRequestType type)
+{
+	struct at_notify_node *ret;
+
+	ret =3D g_try_new0(struct at_notify_node, 1);
+
+	if (!ret)
+		return ret;
+
+	ret->server =3D server;
+	ret->command =3D g_strdup(buf);
+	ret->prefix =3D g_strdup(prefix);
+	ret->type =3D type;
+
+	return ret;
+}
+
+static void at_notify_destroy(gpointer user_data)
+{
+	struct at_notify_node *notify =3D user_data;
+
+	notify->server->notify_source =3D 0;
+
+	g_free(notify->command);
+	g_free(notify->prefix);
+	g_free(notify);
+}
 =

 static struct ring_buffer *allocate_next(GAtServer *server)
 {
@@ -194,28 +236,32 @@ static inline gboolean is_extended_command_prefix(con=
st char c)
 	}
 }
 =

-static void at_command_notify(GAtServer *server, char *command,
-				char *prefix, GAtServerRequestType type)
+static gboolean at_command_notify(gpointer user_data)
 {
+	struct at_notify_node *notify =3D user_data;
+	GAtServer *server =3D notify->server;
 	struct at_command *node;
 	GAtResult result;
 =

-	node =3D g_hash_table_lookup(server->command_list, prefix);
+	node =3D g_hash_table_lookup(server->command_list, notify->prefix);
 =

 	if (node =3D=3D NULL) {
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
-		return;
+		return FALSE;
 	}
 =

-	result.lines =3D g_slist_prepend(NULL, command);
+	result.lines =3D g_slist_prepend(NULL, notify->command);
 	result.final_or_pdu =3D 0;
 =

-	node->notify(type, &result, node->user_data);
+	node->notify(notify->type, &result, node->user_data,
+			server_parse_line, server);
 =

 	g_slist_free(result.lines);
+
+	return FALSE;
 }
 =

-static unsigned int parse_extended_command(GAtServer *server, char *buf)
+static void parse_extended_command(GAtServer *server, char *buf)
 {
 	const char *valid_extended_chars =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 						"0123456789!%-./:_";
@@ -226,11 +272,12 @@ static unsigned int parse_extended_command(GAtServer =
*server, char *buf)
 	gboolean seen_equals =3D FALSE;
 	char prefix[18]; /* According to V250, 5.4.1 */
 	GAtServerRequestType type;
+	struct at_notify_node *notify =3D NULL;
 =

 	prefix_len =3D strcspn(buf, separators);
 =

 	if (prefix_len > 17 || prefix_len < 2)
-		return 0;
+		goto error;
 =

 	/* Convert to upper case, we will always use upper case naming */
 	for (i =3D 0; i < prefix_len; i++)
@@ -239,17 +286,17 @@ static unsigned int parse_extended_command(GAtServer =
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

@@ -265,16 +312,16 @@ static unsigned int parse_extended_command(GAtServer =
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

@@ -291,10 +338,22 @@ next:
 	/* We can scratch in this buffer, so mark ';' as null */
 	buf[i] =3D '\0';
 =

-	at_command_notify(server, buf, prefix, type);
+	notify =3D at_node_new(server, buf, prefix, type);
+	if (!notify)
+		goto error;
 =

 	/* Also consume the terminating null */
-	return i + 1;
+	server->read_pos +=3D i + 1;
+	server->notify_source =3D g_idle_add_full(G_PRIORITY_DEFAULT,
+						at_command_notify,
+						notify, g_free);
+
+	return;
+
+error:
+	g_free(notify);
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

 static int get_basic_prefix_size(const char *buf)
@@ -336,16 +395,17 @@ static int get_basic_prefix_size(const char *buf)
 	return 0;
 }
 =

-static unsigned int parse_basic_command(GAtServer *server, char *buf)
+static void parse_basic_command(GAtServer *server, char *buf)
 {
 	gboolean seen_equals =3D FALSE;
 	char prefix[4], tmp;
 	unsigned int i, prefix_size;
 	GAtServerRequestType type;
+	struct at_notify_node *notify =3D NULL;
 =

 	prefix_size =3D get_basic_prefix_size(buf);
 	if (prefix_size =3D=3D 0)
-		return 0;
+		goto error;
 =

 	i =3D prefix_size;
 	prefix[0] =3D g_ascii_toupper(buf[0]);
@@ -390,56 +450,59 @@ static unsigned int parse_basic_command(GAtServer *se=
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
+	if (prefix_size > 3)
+		goto error;
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
+	memcpy(prefix + 1, buf + 1, prefix_size - 1);
+	prefix[prefix_size] =3D '\0';
+
+	tmp =3D buf[i];
+	buf[i] =3D '\0';
+
+	notify =3D at_node_new(server, buf, prefix, type);
+	if (!notify)
+		goto error;
+
+	buf[i] =3D tmp;
+
+	server->read_pos +=3D i;
+	server->notify_source =3D g_idle_add_full(G_PRIORITY_DEFAULT,
+						at_command_notify,
+						notify, at_notify_destroy);
+
+	return;
+
+error:
+	g_free(notify);
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

-static void server_parse_line(GAtServer *server, char *line)
+static void server_parse_line(gpointer user_data)
 {
-	unsigned int pos =3D 0;
+	GAtServer *server =3D user_data;
+	char *line =3D server->read_line;
+	unsigned int pos =3D server->read_pos;
 	unsigned int len =3D strlen(line);
 =

-	if (len =3D=3D 0) {
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+	/* If we have a non-OK result or no further commands, then stop now */
+	if (server->last_result !=3D G_AT_SERVER_RESULT_OK || pos >=3D len)
 		return;
-	}
-
-	while (pos < len) {
-		unsigned int consumed;
 =

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
@@ -621,11 +684,15 @@ static void new_bytes(GAtServer *p)
 =

 		case PARSER_RESULT_COMMAND:
 		{
-			char *line =3D extract_line(p);
+			g_free(p->read_line);
 =

-			if (line) {
-				server_parse_line(p, line);
-				g_free(line);
+			/* Save current line as last line */
+			p->read_line =3D extract_line(p);
+			if (p->read_line) {
+				p->read_pos =3D 0;
+				p->last_result =3D G_AT_SERVER_RESULT_OK;
+
+				server_parse_line(p);
 			} else
 				g_at_server_send_final(p,
 						G_AT_SERVER_RESULT_ERROR);
@@ -795,6 +862,11 @@ static void g_at_server_cleanup(GAtServer *server)
 	g_hash_table_destroy(server->command_list);
 	server->command_list =3D NULL;
 =

+	g_free(server->read_line);
+
+	if (server->notify_source)
+		g_source_remove(server->notify_source);
+
 	server->channel =3D NULL;
 }
 =

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 2ae19ca..4383a58 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -64,8 +64,13 @@ enum _GAtServerRequestType {
 =

 typedef enum _GAtServerRequestType GAtServerRequestType;
 =

+typedef void (*GAtServerNotifyCallback)(gpointer user_data);
+
 typedef void (*GAtServerNotifyFunc)(GAtServerRequestType type,
-					GAtResult *result, gpointer user_data);
+					GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data);
 =

 GAtServer *g_at_server_new(GIOChannel *io);
 =

-- =

1.6.6.1


--===============2725381226991898390==--

