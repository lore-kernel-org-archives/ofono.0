Content-Type: multipart/mixed; boundary="===============6027251351309484567=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Do not trigger user disconnect at g_at_shutdown
Date: Fri, 26 Feb 2010 17:56:29 +0800
Message-ID: <1267178192-21396-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6027251351309484567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to gatchat, introduce read_watcher_destroy_notify and do
not trigger user disconnect at g_at_shutdown. Delay destroy of
gatserver until read_watcher is destroyed.
---
 gatchat/gatserver.c |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index d131b0c..95a9e8f 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -89,7 +89,7 @@ struct _GAtServer {
 	gint ref_count;				/* Ref count */
 	struct v250_settings v250;		/* V.250 command setting */
 	GIOChannel *channel;			/* Server IO */
-	int server_watch;			/* Watch for server IO */
+	guint read_watch;			/* GSource read id, 0 if none */
 	guint read_so_far;			/* Number of bytes processed */
 	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
 	gpointer user_disconnect_data;		/* User disconnect data */
@@ -98,6 +98,7 @@ struct _GAtServer {
 	struct ring_buffer *read_buf;		/* Current read buffer */
 	guint max_read_attempts;		/* Max reads per select */
 	enum ParserState parser_state;
+	gboolean destroyed;			/* Re-entrancy guard */
 };
 =

 static void g_at_server_send_result(GAtServer *server, GAtServerResult res=
ult)
@@ -380,7 +381,7 @@ static void new_bytes(GAtServer *p)
 =

 	/* We're overflowing the buffer, shutdown the socket */
 	if (p->read_buf && ring_buffer_avail(p->read_buf) =3D=3D 0)
-		g_source_remove(p->server_watch);
+		g_source_remove(p->read_watch);
 }
 =

 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
@@ -431,17 +432,25 @@ static gboolean received_data(GIOChannel *channel, GI=
OCondition cond,
 	return TRUE;
 }
 =

-static void server_watcher_destroy_notify(GAtServer *server)
+static void g_at_server_cleanup(GAtServer *server)
 {
-	server->server_watch =3D 0;
-
+	/* Cleanup all received data */
 	ring_buffer_free(server->read_buf);
 	server->read_buf =3D NULL;
 =

 	server->channel =3D NULL;
+}
+
+static void read_watcher_destroy_notify(GAtServer *server)
+{
+	g_at_server_cleanup(server);
+	server->read_watch =3D 0;
 =

 	if (server->user_disconnect)
 		server->user_disconnect(server->user_disconnect_data);
+
+	if (server->destroyed)
+		g_free(server);
 }
 =

 static void v250_settings_create(struct v250_settings *v250)
@@ -480,10 +489,10 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
 		goto error;
 =

-	server->server_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+	server->read_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				received_data, server,
-				(GDestroyNotify)server_watcher_destroy_notify);
+				(GDestroyNotify)read_watcher_destroy_notify);
 =

 	return server;
 =

@@ -520,6 +529,16 @@ void g_at_server_unref(GAtServer *server)
 		return;
 =

 	g_at_server_shutdown(server);
+
+	/* glib delays the destruction of the watcher until it exits, this
+	 * means we can't free the data just yet, even though we've been
+	 * destroyed already.  We have to wait until the read_watcher
+	 * destroy function gets called
+	 */
+	if (server->read_watch !=3D 0)
+		server->destroyed =3D TRUE;
+	else
+		g_free(server);
 }
 =

 gboolean g_at_server_shutdown(GAtServer *server)
@@ -531,13 +550,8 @@ gboolean g_at_server_shutdown(GAtServer *server)
 	server->user_disconnect =3D NULL;
 	server->user_disconnect_data =3D NULL;
 =

-	if (server->server_watch) {
-		g_source_remove(server->server_watch);
-		server->server_watch =3D 0;
-	}
-
-	g_free(server);
-	server =3D NULL;
+	if (server->read_watch)
+		g_source_remove(server->read_watch);
 =

 	return TRUE;
 }
-- =

1.6.6.1


--===============6027251351309484567==--

