Content-Type: multipart/mixed; boundary="===============8440923281295706921=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Rename buf to read_buf in GAtServer
Date: Tue, 09 Feb 2010 22:59:27 +0800
Message-ID: <1265727570-6021-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8440923281295706921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because we may introduce write_buf for sever response buffer.
---
 gatchat/gatserver.c |   54 +++++++++++++++++++++++++----------------------=
---
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index a01ded6..16c976d 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -95,7 +95,7 @@ struct _GAtServer {
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
 	gpointer debug_data;			/* Data to pass to debug func */
-	struct ring_buffer *buf;		/* Current read buffer */
+	struct ring_buffer *read_buf;		/* Current read buffer */
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 };
@@ -257,9 +257,9 @@ out:
 =

 static char *extract_line(GAtServer *p)
 {
-	unsigned int wrap =3D ring_buffer_len_no_wrap(p->buf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
 	unsigned int pos =3D 0;
-	unsigned char *buf =3D ring_buffer_read_ptr(p->buf, pos);
+	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, pos);
 	int strip_front =3D 0;
 	int line_length =3D 0;
 	gboolean in_string =3D FALSE;
@@ -280,7 +280,7 @@ static char *extract_line(GAtServer *p)
 		pos +=3D 1;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_read_ptr(p->buf, pos);
+			buf =3D ring_buffer_read_ptr(p->read_buf, pos);
 	}
 =

 	/* We will strip AT and \r */
@@ -289,17 +289,17 @@ static char *extract_line(GAtServer *p)
 	line =3D g_try_new(char, line_length + 1);
 =

 	if (!line) {
-		ring_buffer_drain(p->buf, p->read_so_far);
+		ring_buffer_drain(p->read_buf, p->read_so_far);
 		return NULL;
 	}
 =

 	/* Strip leading whitespace + AT */
-	ring_buffer_drain(p->buf, strip_front + 2);
+	ring_buffer_drain(p->read_buf, strip_front + 2);
 =

 	pos =3D 0;
 	i =3D 0;
-	wrap =3D ring_buffer_len_no_wrap(p->buf);
-	buf =3D ring_buffer_read_ptr(p->buf, pos);
+	wrap =3D ring_buffer_len_no_wrap(p->read_buf);
+	buf =3D ring_buffer_read_ptr(p->read_buf, pos);
 =

 	while (pos < (p->read_so_far - strip_front - 2)) {
 		if (*buf =3D=3D '"')
@@ -314,11 +314,11 @@ static char *extract_line(GAtServer *p)
 		pos +=3D 1;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_read_ptr(p->buf, pos);
+			buf =3D ring_buffer_read_ptr(p->read_buf, pos);
 	}
 =

 	/* Strip \r */
-	ring_buffer_drain(p->buf, p->read_so_far - strip_front - 2);
+	ring_buffer_drain(p->read_buf, p->read_so_far - strip_front - 2);
 =

 	line[i] =3D '\0';
 =

@@ -327,9 +327,9 @@ static char *extract_line(GAtServer *p)
 =

 static void new_bytes(GAtServer *p)
 {
-	unsigned int len =3D ring_buffer_len(p->buf);
-	unsigned int wrap =3D ring_buffer_len_no_wrap(p->buf);
-	unsigned char *buf =3D ring_buffer_read_ptr(p->buf, p->read_so_far);
+	unsigned int len =3D ring_buffer_len(p->read_buf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
+	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserState result;
 =

 	while (p->server_io && (p->read_so_far < len)) {
@@ -340,7 +340,7 @@ static void new_bytes(GAtServer *p)
 		p->read_so_far +=3D rbytes;
 =

 		if (p->read_so_far =3D=3D wrap) {
-			buf =3D ring_buffer_read_ptr(p->buf, p->read_so_far);
+			buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 			wrap =3D len;
 		}
 =

@@ -354,7 +354,7 @@ static void new_bytes(GAtServer *p)
 			 * Empty commands must be OK by the DCE
 			 */
 			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);
-			ring_buffer_drain(p->buf, p->read_so_far);
+			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

 		case PARSER_RESULT_COMMAND:
@@ -364,11 +364,11 @@ static void new_bytes(GAtServer *p)
 		case PARSER_RESULT_REPEAT_LAST:
 			/* TODO */
 			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);
-			ring_buffer_drain(p->buf, p->read_so_far);
+			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

 		default:
-			ring_buffer_drain(p->buf, p->read_so_far);
+			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 		}
 =

@@ -378,7 +378,7 @@ static void new_bytes(GAtServer *p)
 	}
 =

 	/* We're overflowing the buffer, shutdown the socket */
-	if (p->buf && ring_buffer_avail(p->buf) =3D=3D 0)
+	if (p->read_buf && ring_buffer_avail(p->read_buf) =3D=3D 0)
 		g_source_remove(p->server_watch);
 }
 =

@@ -397,13 +397,13 @@ static gboolean received_data(GIOChannel *channel, GI=
OCondition cond,
 		return FALSE;
 =

 	do {
-		toread =3D ring_buffer_avail_no_wrap(server->buf);
+		toread =3D ring_buffer_avail_no_wrap(server->read_buf);
 =

 		if (toread =3D=3D 0)
 			break;
 =

 		rbytes =3D 0;
-		buf =3D ring_buffer_write_ptr(server->buf);
+		buf =3D ring_buffer_write_ptr(server->read_buf);
 =

 		err =3D g_io_channel_read(channel, (char *) buf, toread, &rbytes);
 		g_at_util_debug_chat(TRUE, (char *)buf, rbytes,
@@ -414,7 +414,7 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 		total_read +=3D rbytes;
 =

 		if (rbytes > 0)
-			ring_buffer_write_advance(server->buf, rbytes);
+			ring_buffer_write_advance(server->read_buf, rbytes);
 	} while (err =3D=3D G_IO_ERROR_NONE && rbytes > 0 &&
 					read_count < server->max_read_attempts);
 =

@@ -434,8 +434,8 @@ static void server_watcher_destroy_notify(GAtServer *se=
rver)
 {
 	server->server_watch =3D 0;
 =

-	ring_buffer_free(server->buf);
-	server->buf =3D NULL;
+	ring_buffer_free(server->read_buf);
+	server->read_buf =3D NULL;
 =

 	server->server_io =3D NULL;
 =

@@ -470,10 +470,10 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->server_io =3D io;
-	server->buf =3D ring_buffer_new(4096);
+	server->read_buf =3D ring_buffer_new(4096);
 	server->max_read_attempts =3D 3;
 =

-	if (!server->buf)
+	if (!server->read_buf)
 		goto error;
 =

 	if (!g_at_util_setup_io(server->server_io, G_IO_FLAG_NONBLOCK))
@@ -487,8 +487,8 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	return server;
 =

 error:
-	if (server->buf)
-		ring_buffer_free(server->buf);
+	if (server->read_buf)
+		ring_buffer_free(server->read_buf);
 =

 	if (server)
 		g_free(server);
-- =

1.6.6.1


--===============8440923281295706921==--

