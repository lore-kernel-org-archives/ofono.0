Content-Type: multipart/mixed; boundary="===============3070785170550550948=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/10] Refactor g_at_server_send_final
Date: Fri, 19 Mar 2010 17:44:47 +0800
Message-ID: <1268991888-17279-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3070785170550550948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Cache the result code as last_result from at command callback. And
flush out the last result code when the whole command line is parsed,
except the last result is an extended error code, like +CMS ERROR or
+CME ERROR.
---
 gatchat/gatserver.c |   55 ++++++++++++++++++++++++++++++++++++-----------=
---
 1 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 9683fa3..b4f7563 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -33,6 +33,8 @@
 #include "gatserver.h"
 =

 #define BUF_SIZE 4096
+/* <cr><lf> + the max length of information text + <cr><lf> */
+#define MAX_TEXT_SIZE 2048+4
 /* #define WRITE_SCHEDULER_DEBUG 1 */
 =

 enum ParserState {
@@ -112,6 +114,7 @@ struct _GAtServer {
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 	gboolean destroyed;			/* Re-entrancy guard */
+	GAtServerResult last_result;		/* Result of last command */
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
@@ -156,35 +159,52 @@ static void send_common(GAtServer *server, const char=
 *buf, unsigned int len)
 	g_at_server_wakeup_writer(server);
 }
 =

-static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+static void send_result_common(GAtServer *server, const char *result)
 {
-	struct v250_settings v250 =3D server->v250;
-	const char *result_str =3D server_result_to_string(result);
-	char buf[1024];
-	char t =3D v250.s3;
-	char r =3D v250.s4;
+	char buf[MAX_TEXT_SIZE];
+	char t =3D server->v250.s3;
+	char r =3D server->v250.s4;
 	unsigned int len;
 =

-	/* Do not emit error if extended error has already been emitted */
-	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
-		return;
-
-	if (v250.quiet)
+	if (server->v250.quiet)
 		return;
 =

-	if (result_str =3D=3D NULL)
+	if (result =3D=3D NULL)
 		return;
 =

-	if (v250.is_v1)
-		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
+	if (server->v250.is_v1)
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result,
 				t, r);
 	else
-		len =3D snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result,
-				t);
+		len =3D snprintf(buf, sizeof(buf), "%s%c", result, t);
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
+static inline void g_at_server_send_final(GAtServer *server,
+						GAtServerResult result)
+{
+	/* Cache the result until the whole command line is parsed */
+	server->last_result =3D result;
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -633,16 +653,19 @@ static void new_bytes(GAtServer *p)
 			 * Empty commands must be OK by the DCE
 			 */
 			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

 		case PARSER_RESULT_COMMAND:
 			server_parse_line(p, extract_line(p));
+			g_at_server_send_flush(p);
 			break;
 =

 		case PARSER_RESULT_REPEAT_LAST:
 			/* TODO */
 			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_flush(p);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

-- =

1.6.6.1


--===============3070785170550550948==--

