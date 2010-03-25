Content-Type: multipart/mixed; boundary="===============2352511348318972617=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/5] Add server send final result code
Date: Thu, 25 Mar 2010 21:48:18 +0800
Message-ID: <1269524901-1745-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269524901-1745-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2352511348318972617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   93 ++++++++++++++++++++++++++++++++++++++++++++++-=
---
 gatchat/gatserver.h |   20 +++++++++++
 2 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 74c765d..fdc4180 100644
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
@@ -198,11 +200,10 @@ static void send_common(GAtServer *server, const char=
 *buf, unsigned int len)
 	g_at_server_wakeup_writer(server);
 }
 =

-static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+static void send_result_common(GAtServer *server, const char *result)
 {
 	struct v250_settings v250 =3D server->v250;
-	const char *result_str =3D server_result_to_string(result);
-	char buf[1024];
+	char buf[MAX_TEXT_SIZE];
 	char t =3D v250.s3;
 	char r =3D v250.s4;
 	unsigned int len;
@@ -210,19 +211,86 @@ static void g_at_server_send_final(GAtServer *server,=
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

+static void g_at_server_send_flush(GAtServer *server)
+{
+	GAtServerResult result =3D server->last_result;
+	char buf[1024];
+
+	/* Do not emit error if extended error has already been emitted */
+	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
+		return;
+
+	if (server->v250.is_v1)
+		sprintf(buf, "%s", server_result_to_string(result));
+	else
+		sprintf(buf, "%u", (unsigned int)result);
+
+	send_result_common(server, buf);
+}
+
+inline void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+{
+	/* Cache the result until the whole command line is parsed */
+	server->last_result =3D result;
+}
+
+void g_at_server_send_ext_final(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+
+	server->last_result =3D G_AT_SERVER_RESULT_EXT_ERROR;
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
+	GSList *l =3D text;
+	char *line;
+
+	if (!text)
+		return;
+
+	while (l) {
+		line =3D l->data;
+		if (!line)
+			return;
+
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s", t, r, line);
+		send_common(server, buf, MIN(len, sizeof(buf)-1));
+
+		l =3D l->next;
+	}
+
+	len =3D snprintf(buf, sizeof(buf), "%c%c", t, r);
+	send_common(server, buf, len);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -247,6 +315,7 @@ static gboolean at_command_notify(gpointer user_data)
 =

 	if (node =3D=3D NULL) {
 		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		g_at_server_send_flush(server);
 		return FALSE;
 	}
 =

@@ -496,8 +565,10 @@ static void server_parse_line(gpointer user_data)
 	unsigned int len =3D strlen(line);
 =

 	/* If we have a non-OK result or no further commands, then stop now */
-	if (server->last_result !=3D G_AT_SERVER_RESULT_OK || pos >=3D len)
+	if (server->last_result !=3D G_AT_SERVER_RESULT_OK || pos >=3D len) {
+		g_at_server_send_flush(server);
 		return;
+	}
 =

 	if (is_extended_command_prefix(line[pos]))
 		parse_extended_command(server, line + pos);
@@ -679,6 +750,7 @@ static void new_bytes(GAtServer *p)
 			 * Empty commands must be OK by the DCE
 			 */
 			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

@@ -693,15 +765,20 @@ static void new_bytes(GAtServer *p)
 				p->last_result =3D G_AT_SERVER_RESULT_OK;
 =

 				server_parse_line(p);
-			} else
+			} else {
 				g_at_server_send_final(p,
 						G_AT_SERVER_RESULT_ERROR);
+
+				g_at_server_send_flush(p);
+			}
+
 			break;
 		}
 =

 		case PARSER_RESULT_REPEAT_LAST:
 			/* TODO */
 			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 4383a58..7112e90 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -92,6 +92,26 @@ gboolean g_at_server_register(GAtServer *server, char *p=
refix,
 					GDestroyNotify destroy_notify);
 gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
 =

+/* Send a final result code. E.g. NO DIALTONE */
+void g_at_server_send_final(GAtServer *server, GAtServerResult result);
+
+/* Send an extended final result code. E.g. +CME ERROR: SIM failure.
+ * In this case, callback should return G_AT_SERVER_RESULT_EXT_ERROR as
+ * result so that server will not send final result code again.
+ */
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


--===============2352511348318972617==--

