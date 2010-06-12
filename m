Content-Type: multipart/mixed; boundary="===============8669616513708362356=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/11] gatserver: Suspend/resume GAtServer with GAtIO
Date: Sat, 12 Jun 2010 13:50:40 +0800
Message-ID: <1276321850-13307-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8669616513708362356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support g_at_server_suspend and g_at_server_resume operation by using
GAtIO to handle IO related function.
---
 gatchat/gatserver.c |  259 +++++++++++++++++++++--------------------------=
---
 gatchat/gatserver.h |    5 +
 2 files changed, 114 insertions(+), 150 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 148754a..6bb9244 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -31,6 +31,7 @@
 =

 #include "ringbuffer.h"
 #include "gatserver.h"
+#include "gatio.h"
 =

 #define BUF_SIZE 4096
 /* <cr><lf> + the max length of information text + <cr><lf> */
@@ -100,16 +101,13 @@ struct at_command {
 struct _GAtServer {
 	gint ref_count;				/* Ref count */
 	struct v250_settings v250;		/* V.250 command setting */
-	GIOChannel *channel;			/* Server IO */
-	guint read_watch;			/* GSource read id, 0 if none */
-	guint write_watch;			/* GSource write id, 0 if none */
+	GAtIO *io;				/* Server IO */
 	guint read_so_far;			/* Number of bytes processed */
 	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
 	gpointer debug_data;			/* Data to pass to debug func */
 	GHashTable *command_list;		/* List of AT commands */
-	struct ring_buffer *read_buf;		/* Current read buffer */
 	GQueue *write_queue;			/* Write buffer queue */
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
@@ -117,12 +115,13 @@ struct _GAtServer {
 	char *last_line;			/* Last read line */
 	unsigned int cur_pos;			/* Where we are on the line */
 	GAtServerResult last_result;
-	gboolean processing_cmdline;
+	gboolean suspended;
 	gboolean final_sent;
 	gboolean final_async;
+	gboolean in_read_handler;
 };
 =

-static void g_at_server_wakeup_writer(GAtServer *server);
+static void server_wakeup_writer(GAtServer *server);
 static void server_parse_line(GAtServer *server);
 =

 static struct ring_buffer *allocate_next(GAtServer *server)
@@ -162,7 +161,7 @@ static void send_common(GAtServer *server, const char *=
buf, unsigned int len)
 			write_buf =3D allocate_next(server);
 	}
 =

-	g_at_server_wakeup_writer(server);
+	server_wakeup_writer(server);
 }
 =

 static void send_result_common(GAtServer *server, const char *result)
@@ -198,14 +197,14 @@ void g_at_server_send_final(GAtServer *server, GAtSer=
verResult result)
 	server->final_sent =3D TRUE;
 	server->last_result =3D result;
 =

-	if (result =3D=3D G_AT_SERVER_RESULT_OK && server->processing_cmdline) {
+	if (result =3D=3D G_AT_SERVER_RESULT_OK && server->suspended) {
 		if (server->final_async)
 			server_parse_line(server);
 =

 		return;
 	}
 =

-	server->processing_cmdline =3D FALSE;
+	g_at_server_resume(server);
 =

 	if (server->v250.is_v1)
 		sprintf(buf, "%s", server_result_to_string(result));
@@ -219,7 +218,7 @@ void g_at_server_send_ext_final(GAtServer *server, cons=
t char *result)
 {
 	server->final_sent =3D TRUE;
 	server->last_result =3D G_AT_SERVER_RESULT_EXT_ERROR;
-	server->processing_cmdline =3D FALSE;
+	g_at_server_resume(server);
 =

 	send_result_common(server, result);
 }
@@ -668,7 +667,7 @@ static void server_parse_line(GAtServer *server)
 	server->final_async =3D FALSE;
 =

 	if (pos =3D=3D 0)
-		server->processing_cmdline =3D TRUE;
+		g_at_server_suspend(server);
 =

 	while (pos < len) {
 		unsigned int consumed;
@@ -702,7 +701,7 @@ static void server_parse_line(GAtServer *server)
 			return;
 	}
 =

-	server->processing_cmdline =3D FALSE;
+	g_at_server_resume(server);
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
 }
 =

@@ -780,11 +779,11 @@ out:
 	return res;
 }
 =

-static char *extract_line(GAtServer *p)
+static char *extract_line(GAtServer *p, struct ring_buffer *rbuf)
 {
-	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
 	unsigned int pos =3D 0;
-	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, pos);
+	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, pos);
 	int strip_front =3D 0;
 	int line_length =3D 0;
 	gboolean in_string =3D FALSE;
@@ -806,7 +805,7 @@ static char *extract_line(GAtServer *p)
 		pos +=3D 1;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_read_ptr(p->read_buf, pos);
+			buf =3D ring_buffer_read_ptr(rbuf, pos);
 	}
 =

 	/* We will strip AT and S3 */
@@ -814,17 +813,17 @@ static char *extract_line(GAtServer *p)
 =

 	line =3D g_try_new(char, line_length + 1);
 	if (!line) {
-		ring_buffer_drain(p->read_buf, p->read_so_far);
+		ring_buffer_drain(rbuf, p->read_so_far);
 		return NULL;
 	}
 =

 	/* Strip leading whitespace + AT */
-	ring_buffer_drain(p->read_buf, strip_front + 2);
+	ring_buffer_drain(rbuf, strip_front + 2);
 =

 	pos =3D 0;
 	i =3D 0;
-	wrap =3D ring_buffer_len_no_wrap(p->read_buf);
-	buf =3D ring_buffer_read_ptr(p->read_buf, pos);
+	wrap =3D ring_buffer_len_no_wrap(rbuf);
+	buf =3D ring_buffer_read_ptr(rbuf, pos);
 =

 	while (pos < (p->read_so_far - strip_front - 2)) {
 		if (*buf =3D=3D '"')
@@ -839,33 +838,39 @@ static char *extract_line(GAtServer *p)
 		pos +=3D 1;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_read_ptr(p->read_buf, pos);
+			buf =3D ring_buffer_read_ptr(rbuf, pos);
 	}
 =

 	/* Strip S3 */
-	ring_buffer_drain(p->read_buf, p->read_so_far - strip_front - 2);
+	ring_buffer_drain(rbuf, p->read_so_far - strip_front - 2);
 =

 	line[i] =3D '\0';
 =

 	return line;
 }
 =

-static void new_bytes(GAtServer *p)
+static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
-	unsigned int len =3D ring_buffer_len(p->read_buf);
-	unsigned int wrap =3D ring_buffer_len_no_wrap(p->read_buf);
-	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
+	GAtServer *p =3D user_data;
+	unsigned int len =3D ring_buffer_len(rbuf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
+	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
 	enum ParserResult result;
 =

-	while (p->channel && (p->read_so_far < len)) {
+	p->in_read_handler =3D TRUE;
+
+	while (p->io && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D server_feed(p, (char *)buf, &rbytes);
 =

+		if (p->v250.echo)
+			send_common(p, (char *)buf, rbytes);
+
 		buf +=3D rbytes;
 		p->read_so_far +=3D rbytes;
 =

 		if (p->read_so_far =3D=3D wrap) {
-			buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
+			buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
 			wrap =3D len;
 		}
 =

@@ -879,14 +884,14 @@ static void new_bytes(GAtServer *p)
 			 * Empty commands must be OK by the DCE
 			 */
 			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
-			ring_buffer_drain(p->read_buf, p->read_so_far);
+			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
 =

 		case PARSER_RESULT_COMMAND:
 		{
 			g_free(p->last_line);
 =

-			p->last_line =3D extract_line(p);
+			p->last_line =3D extract_line(p, rbuf);
 			p->cur_pos =3D 0;
 =

 			if (p->last_line)
@@ -905,11 +910,11 @@ static void new_bytes(GAtServer *p)
 			else
 				g_at_server_send_final(p,
 						G_AT_SERVER_RESULT_OK);
-			ring_buffer_drain(p->read_buf, p->read_so_far);
+			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
 =

 		default:
-			ring_buffer_drain(p->read_buf, p->read_so_far);
+			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
 		}
 =

@@ -918,72 +923,15 @@ static void new_bytes(GAtServer *p)
 		p->read_so_far =3D 0;
 	}
 =

-	/* We're overflowing the buffer, shutdown the socket */
-	if (p->read_buf && ring_buffer_avail(p->read_buf) =3D=3D 0)
-		g_source_remove(p->read_watch);
-}
-
-static gboolean received_data(GIOChannel *channel, GIOCondition cond,
-				gpointer data)
-{
-	unsigned char *buf;
-	GAtServer *server =3D data;
-	GIOError err;
-	gsize rbytes;
-	gsize toread;
-	guint total_read =3D 0;
-	guint read_count =3D 0;
-
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	do {
-		toread =3D ring_buffer_avail_no_wrap(server->read_buf);
-
-		if (toread =3D=3D 0)
-			break;
-
-		rbytes =3D 0;
-		buf =3D ring_buffer_write_ptr(server->read_buf, 0);
-
-		err =3D g_io_channel_read(channel, (char *) buf, toread, &rbytes);
-		g_at_util_debug_chat(TRUE, (char *)buf, rbytes,
-					server->debugf, server->debug_data);
-
-		read_count++;
-
-		if (rbytes =3D=3D 0)
-			break;
-
-		if (server->v250.echo)
-			send_common(server, (char *)buf, rbytes);
-
-		/* Ignore incoming bytes when processing a command line */
-		if (server->processing_cmdline)
-			continue;
+	p->in_read_handler =3D FALSE;
 =

-		total_read +=3D rbytes;
-		ring_buffer_write_advance(server->read_buf, rbytes);
-	} while (err =3D=3D G_IO_ERROR_NONE &&
-					read_count < server->max_read_attempts);
-
-	if (total_read > 0)
-		new_bytes(server);
-
-	if (cond & (G_IO_HUP | G_IO_ERR))
-		return FALSE;
-
-	if (read_count > 0 && rbytes =3D=3D 0 && err !=3D G_IO_ERROR_AGAIN)
-		return FALSE;
-
-	return TRUE;
+	if (p->destroyed)
+		g_free(p);
 }
 =

-static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
-				gpointer data)
+static gboolean can_write_data(gpointer data)
 {
 	GAtServer *server =3D data;
-	GIOError err;
 	gsize bytes_written;
 	gsize towrite;
 	struct ring_buffer *write_buf;
@@ -992,9 +940,6 @@ static gboolean can_write_data(GIOChannel *channel, GIO=
Condition cond,
 	int limiter;
 #endif
 =

-	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
-		return FALSE;
-
 	if (!server->write_queue)
 		return FALSE;
 =

@@ -1012,22 +957,17 @@ static gboolean can_write_data(GIOChannel *channel, =
GIOCondition cond,
 		limiter =3D 5;
 #endif
 =

-	err =3D g_io_channel_write(server->channel,
+	bytes_written =3D g_at_io_write(server->io,
 			(char *)buf,
 #ifdef WRITE_SCHEDULER_DEBUG
-			limiter,
+			limiter
 #else
-			towrite,
+			towrite
 #endif
-			&bytes_written);
+			);
 =

-	if (err !=3D G_IO_ERROR_NONE) {
-		g_source_remove(server->read_watch);
+	if (bytes_written =3D=3D 0)
 		return FALSE;
-	}
-
-	g_at_util_debug_chat(FALSE, (char *)buf, bytes_written, server->debugf,
-				server->debug_data);
 =

 	ring_buffer_drain(write_buf, bytes_written);
 =

@@ -1059,10 +999,6 @@ static void write_queue_free(GQueue *write_queue)
 =

 static void g_at_server_cleanup(GAtServer *server)
 {
-	/* Cleanup all received data */
-	ring_buffer_free(server->read_buf);
-	server->read_buf =3D NULL;
-
 	/* Cleanup pending data to write */
 	write_queue_free(server->write_queue);
 =

@@ -1071,15 +1007,15 @@ static void g_at_server_cleanup(GAtServer *server)
 =

 	g_free(server->last_line);
 =

-	server->channel =3D NULL;
+	g_at_io_unref(server->io);
+	server->io =3D NULL;
 }
 =

-static void read_watcher_destroy_notify(gpointer user_data)
+static void io_disconnect(gpointer user_data)
 {
 	GAtServer *server =3D user_data;
 =

 	g_at_server_cleanup(server);
-	server->read_watch =3D 0;
 =

 	if (server->user_disconnect)
 		server->user_disconnect(server->user_disconnect_data);
@@ -1088,23 +1024,9 @@ static void read_watcher_destroy_notify(gpointer use=
r_data)
 		g_free(server);
 }
 =

-static void write_watcher_destroy_notify(gpointer user_data)
+static void server_wakeup_writer(GAtServer *server)
 {
-	GAtServer *server =3D user_data;
-
-	server->write_watch =3D 0;
-}
-
-static void g_at_server_wakeup_writer(GAtServer *server)
-{
-	if (server->write_watch !=3D 0)
-		return;
-
-	server->write_watch =3D g_io_add_watch_full(server->channel,
-			G_PRIORITY_DEFAULT,
-			G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-			can_write_data, server,
-			write_watcher_destroy_notify);
+	g_at_io_set_write_handler(server->io, can_write_data, server);
 }
 =

 static void v250_settings_create(struct v250_settings *v250)
@@ -1156,13 +1078,15 @@ GAtServer *g_at_server_new(GIOChannel *io)
 =

 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
-	server->channel =3D io;
+	server->io =3D g_at_io_new(io);
+	if (!server->io)
+		goto error;
+
+	g_at_io_set_disconnect_function(server->io, io_disconnect, server);
+
 	server->command_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free,
 							at_notify_node_destroy);
-	server->read_buf =3D ring_buffer_new(BUF_SIZE);
-	if (!server->read_buf)
-		goto error;
 =

 	server->write_queue =3D g_queue_new();
 	if (!server->write_queue)
@@ -1173,25 +1097,18 @@ GAtServer *g_at_server_new(GIOChannel *io)
 =

 	server->max_read_attempts =3D 3;
 =

-	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
-		goto error;
-
-	server->read_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
-				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				received_data, server,
-				read_watcher_destroy_notify);
+	g_at_io_set_read_handler(server->io, new_bytes, server);
 =

 	basic_command_register(server);
 =

 	return server;
 =

 error:
+	g_at_io_unref(server->io);
+
 	if (server->command_list)
 		g_hash_table_destroy(server->command_list);
 =

-	if (server->read_buf)
-		ring_buffer_free(server->read_buf);
-
 	if (server->write_queue)
 		write_queue_free(server->write_queue);
 =

@@ -1201,6 +1118,22 @@ error:
 	return NULL;
 }
 =

+GIOChannel *g_at_server_get_channel(GAtServer *server)
+{
+	if (server =3D=3D NULL || server->io =3D=3D NULL)
+		return NULL;
+
+	return g_at_io_get_channel(server->io);
+}
+
+GAtIO *g_at_server_get_io(GAtServer *server)
+{
+	if (server =3D=3D NULL)
+		return NULL;
+
+	return server->io;
+}
+
 GAtServer *g_at_server_ref(GAtServer *server)
 {
 	if (server =3D=3D NULL)
@@ -1211,6 +1144,33 @@ GAtServer *g_at_server_ref(GAtServer *server)
 	return server;
 }
 =

+void g_at_server_suspend(GAtServer *server)
+{
+	if (server =3D=3D NULL)
+		return;
+
+	server->suspended =3D TRUE;
+
+	g_at_io_set_write_handler(server->io, NULL, NULL);
+	g_at_io_set_read_handler(server->io, NULL, NULL);
+
+	g_at_io_set_debug(server->io, NULL, NULL);
+}
+
+void g_at_server_resume(GAtServer *server)
+{
+	if (server =3D=3D NULL)
+		return;
+
+	server->suspended =3D FALSE;
+
+	g_at_io_set_debug(server->io, server->debugf, server->debug_data);
+	g_at_io_set_read_handler(server->io, new_bytes, server);
+
+	if (g_queue_get_length(server->write_queue) > 0)
+		server_wakeup_writer(server);
+}
+
 void g_at_server_unref(GAtServer *server)
 {
 	gboolean is_zero;
@@ -1223,6 +1183,11 @@ void g_at_server_unref(GAtServer *server)
 	if (is_zero =3D=3D FALSE)
 		return;
 =

+	if (server->io) {
+		g_at_server_suspend(server);
+		g_at_server_cleanup(server);
+	}
+
 	g_at_server_shutdown(server);
 =

 	/* glib delays the destruction of the watcher until it exits, this
@@ -1230,7 +1195,7 @@ void g_at_server_unref(GAtServer *server)
 	 * destroyed already.  We have to wait until the read_watcher
 	 * destroy function gets called
 	 */
-	if (server->read_watch !=3D 0)
+	if (server->in_read_handler)
 		server->destroyed =3D TRUE;
 	else
 		g_free(server);
@@ -1245,12 +1210,6 @@ gboolean g_at_server_shutdown(GAtServer *server)
 	server->user_disconnect =3D NULL;
 	server->user_disconnect_data =3D NULL;
 =

-	if (server->write_watch)
-		g_source_remove(server->write_watch);
-
-	if (server->read_watch)
-		g_source_remove(server->read_watch);
-
 	return TRUE;
 }
 =

diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index b604c37..f0c19da 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 #include "gatresult.h"
 #include "gatutil.h"
+#include "gatio.h"
 =

 struct _GAtServer;
 =

@@ -68,8 +69,12 @@ typedef void (*GAtServerNotifyFunc)(GAtServerRequestType=
 type,
 					GAtResult *result, gpointer user_data);
 =

 GAtServer *g_at_server_new(GIOChannel *io);
+GIOChannel *g_at_server_get_channel(GAtServer *server);
+GAtIO *g_at_server_get_io(GAtServer *server);
 =

 GAtServer *g_at_server_ref(GAtServer *server);
+void g_at_server_suspend(GAtServer *server);
+void g_at_server_resume(GAtServer *server);
 void g_at_server_unref(GAtServer *server);
 =

 gboolean g_at_server_shutdown(GAtServer *server);
-- =

1.6.3.3


--===============8669616513708362356==--

