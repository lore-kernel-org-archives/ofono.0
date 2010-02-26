Content-Type: multipart/mixed; boundary="===============1390902234602147558=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Add write buffer queue for non-blocking write
Date: Fri, 26 Feb 2010 17:56:31 +0800
Message-ID: <1267178192-21396-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267178192-21396-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1390902234602147558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The head of the queue is the data to be written, the tail is the
free buffer to cache data into.

If the tail of queue is full, allocate a new free buffer and
append it at the tail.
---
 gatchat/gatserver.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 15bbbff..a136a6f 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -92,17 +92,56 @@ struct _GAtServer {
 	struct v250_settings v250;		/* V.250 command setting */
 	GIOChannel *channel;			/* Server IO */
 	guint read_watch;			/* GSource read id, 0 if none */
+	guint write_watch;			/* GSource write id, 0 if none */
 	guint read_so_far;			/* Number of bytes processed */
 	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
 	gpointer debug_data;			/* Data to pass to debug func */
 	struct ring_buffer *read_buf;		/* Current read buffer */
+	GQueue *write_queue;			/* Write buffer queue */
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
 	gboolean destroyed;			/* Re-entrancy guard */
 };
 =

+static void g_at_server_wakeup_writer(GAtServer *server);
+
+static struct ring_buffer *allocate_next(GAtServer *server)
+{
+	struct ring_buffer *buf =3D ring_buffer_new(BUF_SIZE);
+
+	if (!buf)
+		return NULL;
+
+	g_queue_push_tail(server->write_queue, buf);
+
+	return buf;
+}
+
+static void send_common(GAtServer *server, const char *buf, unsigned int l=
en)
+{
+	gsize towrite =3D len;
+	gsize bytes_written =3D 0;
+	struct ring_buffer *write_buf;
+
+	write_buf =3D g_queue_peek_tail(server->write_queue);
+
+	while (bytes_written < towrite) {
+		gsize wbytes =3D MIN((gsize)ring_buffer_avail(write_buf),
+						towrite - bytes_written);
+
+		bytes_written +=3D ring_buffer_write(write_buf,
+							buf + bytes_written,
+							wbytes);
+
+		if (ring_buffer_avail(write_buf) =3D=3D 0)
+			write_buf =3D allocate_next(server);
+	}
+
+	g_at_server_wakeup_writer(server);
+}
+
 static void g_at_server_send_result(GAtServer *server, GAtServerResult res=
ult)
 {
 	struct v250_settings v250 =3D server->v250;
@@ -110,7 +149,7 @@ static void g_at_server_send_result(GAtServer *server, =
GAtServerResult result)
 	char buf[1024];
 	char t =3D v250.s3;
 	char r =3D v250.s4;
-	gsize wbuf;
+	unsigned int len;
 =

 	if (v250.quiet)
 		return;
@@ -119,16 +158,13 @@ static void g_at_server_send_result(GAtServer *server=
, GAtServerResult result)
 		return;
 =

 	if (v250.is_v1)
-		snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
 				t, r);
 	else
-		snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result, t);
-
-	g_at_util_debug_chat(FALSE, buf, strlen(buf),
-				server->debugf, server->debug_data);
+		len =3D snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result,
+				t);
 =

-	g_io_channel_write(server->channel, (char *) buf, strlen(buf),
-							&wbuf);
+	send_common(server, buf, MIN(len, sizeof(buf)-1));
 }
 =

 static inline gboolean is_at_command_prefix(const char c)
@@ -434,12 +470,31 @@ static gboolean received_data(GIOChannel *channel, GI=
OCondition cond,
 	return TRUE;
 }
 =

+static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
+				gpointer data)
+{
+	return FALSE;
+}
+
+static void write_queue_free(GQueue *write_queue)
+{
+	struct ring_buffer *write_buf;
+
+	while ((write_buf =3D g_queue_pop_head(write_queue)))
+		ring_buffer_free(write_buf);
+
+	g_queue_free(write_queue);
+}
+
 static void g_at_server_cleanup(GAtServer *server)
 {
 	/* Cleanup all received data */
 	ring_buffer_free(server->read_buf);
 	server->read_buf =3D NULL;
 =

+	/* Cleanup pending data to write */
+	write_queue_free(server->write_queue);
+
 	server->channel =3D NULL;
 }
 =

@@ -455,6 +510,23 @@ static void read_watcher_destroy_notify(GAtServer *ser=
ver)
 		g_free(server);
 }
 =

+static void write_watcher_destroy_notify(GAtServer *server)
+{
+	server->write_watch =3D 0;
+}
+
+static void g_at_server_wakeup_writer(GAtServer *server)
+{
+	if (server->write_watch !=3D 0)
+		return;
+
+	server->write_watch =3D g_io_add_watch_full(server->channel,
+			G_PRIORITY_DEFAULT,
+			G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+			can_write_data, server,
+			(GDestroyNotify)write_watcher_destroy_notify);
+}
+
 static void v250_settings_create(struct v250_settings *v250)
 {
 	v250->s3 =3D '\r';
@@ -483,11 +555,18 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
 	server->read_buf =3D ring_buffer_new(BUF_SIZE);
-	server->max_read_attempts =3D 3;
-
 	if (!server->read_buf)
 		goto error;
 =

+	server->write_queue =3D g_queue_new();
+	if (!server->write_queue)
+		goto error;
+
+	if (!allocate_next(server))
+		goto error;
+
+	server->max_read_attempts =3D 3;
+
 	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
 		goto error;
 =

@@ -502,6 +581,9 @@ error:
 	if (server->read_buf)
 		ring_buffer_free(server->read_buf);
 =

+	if (server->write_queue)
+		write_queue_free(server->write_queue);
+
 	if (server)
 		g_free(server);
 =

@@ -552,6 +634,9 @@ gboolean g_at_server_shutdown(GAtServer *server)
 	server->user_disconnect =3D NULL;
 	server->user_disconnect_data =3D NULL;
 =

+	if (server->write_watch)
+		g_source_remove(server->write_watch);
+
 	if (server->read_watch)
 		g_source_remove(server->read_watch);
 =

-- =

1.6.6.1


--===============1390902234602147558==--

