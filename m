Content-Type: multipart/mixed; boundary="===============5898941774219091778=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Rename server_io to channel
Date: Tue, 09 Feb 2010 22:59:29 +0800
Message-ID: <1265727570-6021-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1265727570-6021-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5898941774219091778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To make it consistent with GAtChat.
---
 gatchat/gatserver.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index ad6afb9..d131b0c 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -88,7 +88,7 @@ struct v250_settings {
 struct _GAtServer {
 	gint ref_count;				/* Ref count */
 	struct v250_settings v250;		/* V.250 command setting */
-	GIOChannel *server_io;			/* Server IO */
+	GIOChannel *channel;			/* Server IO */
 	int server_watch;			/* Watch for server IO */
 	guint read_so_far;			/* Number of bytes processed */
 	GAtDisconnectFunc user_disconnect;	/* User disconnect func */
@@ -124,7 +124,7 @@ static void g_at_server_send_result(GAtServer *server, =
GAtServerResult result)
 	g_at_util_debug_chat(FALSE, buf, strlen(buf),
 				server->debugf, server->debug_data);
 =

-	g_io_channel_write(server->server_io, (char *) buf, strlen(buf),
+	g_io_channel_write(server->channel, (char *) buf, strlen(buf),
 							&wbuf);
 }
 =

@@ -333,7 +333,7 @@ static void new_bytes(GAtServer *p)
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserState result;
 =

-	while (p->server_io && (p->read_so_far < len)) {
+	while (p->channel && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D server_feed(p, (char *)buf, &rbytes);
 =

@@ -438,7 +438,7 @@ static void server_watcher_destroy_notify(GAtServer *se=
rver)
 	ring_buffer_free(server->read_buf);
 	server->read_buf =3D NULL;
 =

-	server->server_io =3D NULL;
+	server->channel =3D NULL;
 =

 	if (server->user_disconnect)
 		server->user_disconnect(server->user_disconnect_data);
@@ -470,14 +470,14 @@ GAtServer *g_at_server_new(GIOChannel *io)
 =

 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
-	server->server_io =3D io;
+	server->channel =3D io;
 	server->read_buf =3D ring_buffer_new(4096);
 	server->max_read_attempts =3D 3;
 =

 	if (!server->read_buf)
 		goto error;
 =

-	if (!g_at_util_setup_io(server->server_io, G_IO_FLAG_NONBLOCK))
+	if (!g_at_util_setup_io(server->channel, G_IO_FLAG_NONBLOCK))
 		goto error;
 =

 	server->server_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
-- =

1.6.6.1


--===============5898941774219091778==--

