Content-Type: multipart/mixed; boundary="===============1144843435322597922=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Add server send result code
Date: Tue, 30 Mar 2010 21:38:56 +0800
Message-ID: <1269956337-26575-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269956337-26575-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1144843435322597922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  141 +++++++++++++++++++++++++++++++++++++++++++----=
----
 gatchat/gatserver.h |   17 ++++++
 2 files changed, 137 insertions(+), 21 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c75fbf5..5f21766 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -33,6 +33,8 @@
 #include "gatserver.h"
 =

 #define BUF_SIZE 4096
+/* <cr><lf> + the max length of information text + <cr><lf> */
+#define MAX_TEXT_SIZE 2052
 /* #define WRITE_SCHEDULER_DEBUG 1 */
 =

 enum ParserState {
@@ -112,9 +114,15 @@ struct _GAtServer {
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 	gboolean destroyed;			/* Re-entrancy guard */
+	char *last_line;			/* Last read line */
+	unsigned int cur_pos;			/* Read offset of last_line */
+	GAtServerResult last_result;		/* Last command's result code */
+	gboolean final_called;			/* Is send_final called */
+	gboolean wait_final;			/* Wait for final result code */
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
+static void server_parse_line(GAtServer *server);
 =

 static struct ring_buffer *allocate_next(GAtServer *server)
 {
@@ -156,11 +164,11 @@ static void send_common(GAtServer *server, const char=
 *buf, unsigned int len)
 	g_at_server_wakeup_writer(server);
 }
 =

-static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+static void send_result_common(GAtServer *server, const char *result)
+
 {
 	struct v250_settings v250 =3D server->v250;
-	const char *result_str =3D server_result_to_string(result);
-	char buf[1024];
+	char buf[MAX_TEXT_SIZE];
 	char t =3D v250.s3;
 	char r =3D v250.s4;
 	unsigned int len;
@@ -168,19 +176,89 @@ static void g_at_server_send_final(GAtServer *server,=
 GAtServerResult result)
 	if (v250.quiet)
 		return;
 =

-	if (result_str =3D=3D NULL)
+	if (result =3D=3D NULL)
 		return;
 =

 	if (v250.is_v1)
-		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result,
 				t, r);
 	else
-		len =3D snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result,
+		len =3D snprintf(buf, sizeof(buf), "%s%c", result,
 				t);
 =

 	send_common(server, buf, MIN(len, sizeof(buf)-1));
 }
 =

+static void g_at_server_send_flush(GAtServer *server, GAtServerResult resu=
lt)
+{
+	char buf[1024];
+
+	if (server->v250.is_v1)
+		sprintf(buf, "%s", server_result_to_string(result));
+	else
+		sprintf(buf, "%u", (unsigned int)result);
+
+	send_result_common(server, buf);
+}
+
+void g_at_server_send_final(GAtServer *server, GAtServerResult result)
+{
+	server->final_called =3D TRUE;
+	server->last_result =3D result;
+
+	/* Continue to process next command */
+	if (result =3D=3D G_AT_SERVER_RESULT_OK && !server->wait_final)
+		return;
+
+	if (result !=3D G_AT_SERVER_RESULT_OK)
+		/* Emit the final result of a command line */
+		g_at_server_send_flush(server, result);
+	else
+		server_parse_line(server);
+}
+
+void g_at_server_send_ext_final(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+
+	server->final_called =3D TRUE;
+	server->wait_final =3D FALSE;
+}
+
+void g_at_server_send_intermediate(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+}
+
+void g_at_server_send_unsolicited(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+}
+
+void g_at_server_send_info_text(GAtServer *server, GSList *text)
+{
+	char buf[MAX_TEXT_SIZE];
+	char t =3D server->v250.s3;
+	char r =3D server->v250.s4;
+	unsigned int len;
+	GSList *l;
+
+	if (!text)
+		return;
+
+	for (l =3D text; l; l =3D l->next) {
+		char *line =3D l->data;
+		if (!line)
+			return;
+
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s", t, r, line);
+		send_common(server, buf, MIN(len, sizeof(buf)-1));
+	}
+
+	len =3D snprintf(buf, sizeof(buf), "%c%c", t, r);
+	send_common(server, buf, len);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -203,7 +281,7 @@ static void at_command_notify(GAtServer *server, char *=
command,
 	node =3D g_hash_table_lookup(server->command_list, prefix);
 =

 	if (node =3D=3D NULL) {
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		g_at_server_send_flush(server, G_AT_SERVER_RESULT_ERROR);
 		return;
 	}
 =

@@ -414,32 +492,49 @@ done:
 	return i;
 }
 =

-static void server_parse_line(GAtServer *server, char *line)
+static void server_parse_line(GAtServer *server)
 {
-	unsigned int pos =3D 0;
+	char *line =3D server->last_line;
+	unsigned int pos =3D server->cur_pos;
 	unsigned int len =3D strlen(line);
 =

-	if (len =3D=3D 0) {
-		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
-		return;
-	}
+	if (len =3D=3D 0)
+		goto done;
 =

 	while (pos < len) {
 		unsigned int consumed;
 =

+		server->final_called =3D FALSE;
+		server->wait_final =3D FALSE;
+
 		if (is_extended_command_prefix(line[pos]))
 			consumed =3D parse_extended_command(server, line + pos);
 		else
 			consumed =3D parse_basic_command(server, line + pos);
 =

 		if (consumed =3D=3D 0) {
-			g_at_server_send_final(server,
+			g_at_server_send_flush(server,
 						G_AT_SERVER_RESULT_ERROR);
 			break;
 		}
 =

 		pos +=3D consumed;
+		server->cur_pos =3D pos;
+
+		/* We wait the callback until it finished processing
+		 * the command and called the send_final.
+		 */
+		if (server->final_called =3D=3D FALSE) {
+			server->wait_final =3D TRUE;
+			return;
+		}
+
+		if (server->last_result !=3D G_AT_SERVER_RESULT_OK)
+			return;
 	}
+
+done:
+	g_at_server_send_flush(server, G_AT_SERVER_RESULT_OK);
 }
 =

 static enum ParserResult server_feed(GAtServer *server,
@@ -615,26 +710,28 @@ static void new_bytes(GAtServer *p)
 			 * According to section 5.2.4 and 5.6 of V250,
 			 * Empty commands must be OK by the DCE
 			 */
-			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p, G_AT_SERVER_RESULT_OK);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

 		case PARSER_RESULT_COMMAND:
 		{
-			char *line =3D extract_line(p);
+			g_free(p->last_line);
+
+			p->last_line =3D extract_line(p);
+			if (p->last_line) {
+				p->cur_pos =3D 0;
 =

-			if (line) {
-				server_parse_line(p, line);
-				g_free(line);
+				server_parse_line(p);
 			} else
-				g_at_server_send_final(p,
+				g_at_server_send_flush(p,
 						G_AT_SERVER_RESULT_ERROR);
 			break;
 		}
 =

 		case PARSER_RESULT_REPEAT_LAST:
 			/* TODO */
-			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p, G_AT_SERVER_RESULT_OK);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

@@ -795,6 +892,8 @@ static void g_at_server_cleanup(GAtServer *server)
 	g_hash_table_destroy(server->command_list);
 	server->command_list =3D NULL;
 =

+	g_free(server->last_line);
+
 	server->channel =3D NULL;
 }
 =

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 2ae19ca..a508be6 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -87,6 +87,23 @@ gboolean g_at_server_register(GAtServer *server, char *p=
refix,
 					GDestroyNotify destroy_notify);
 gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
 =

+/* Send a final result code. E.g. G_AT_SERVER_RESULT_NO_DIALTONE */
+void g_at_server_send_final(GAtServer *server, GAtServerResult result);
+
+/* Send an extended final result code. E.g. +CME ERROR: SIM failure. */
+void g_at_server_send_ext_final(GAtServer *server, const char *result);
+
+/* Send an intermediate result code to report the progress. E.g. CONNECT */
+void g_at_server_send_intermediate(GAtServer *server, const char *result);
+
+/* Send an unsolicited result code. E.g. RING */
+void g_at_server_send_unsolicited(GAtServer *server, const char *result);
+
+/* Send an information text. The text could contain multiple lines. Each
+ * line, including line terminators, should not exceed 2048 characters.
+ */
+void g_at_server_send_info_text(GAtServer *server, GSList *text);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.6.1


--===============1144843435322597922==--

