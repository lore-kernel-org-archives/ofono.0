Content-Type: multipart/mixed; boundary="===============0317974815339195041=="
MIME-Version: 1.0
From: Carlos Pargada <carlos.pargada@intel.com>
Subject: [RFC] Fix Uplink data transfer in RawIP mode
Date: Wed, 02 Feb 2011 12:46:21 +0100
Message-ID: <1296647181-2322-1-git-send-email-carlos.pargada@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0317974815339195041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix Uplink Data transfer in RawIP mode with IFW Modem

Change Data flow from stream mode to PAcket mode between GatRawIP and GatMu=
x.


---
 gatchat/gatio.c    |   98 ++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 gatchat/gatio.h    |    1 +
 gatchat/gatrawip.c |   75 ++++++++++++++++++++++++++++++---------
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/gatchat/gatio.c b/gatchat/gatio.c
index 9d44a78..5ad640d 100644
--- a/gatchat/gatio.c
+++ b/gatchat/gatio.c
@@ -77,7 +77,7 @@ static void read_watcher_destroy_notify(gpointer user_dat=
a)
 		io->user_disconnect(io->user_disconnect_data);
 }
 =

-static gboolean received_data(GIOChannel *channel, GIOCondition cond,
+static gboolean stream_received_data(GIOChannel *channel, GIOCondition con=
d,
 				gpointer data)
 {
 	unsigned char *buf;
@@ -132,6 +132,51 @@ static gboolean received_data(GIOChannel *channel, GIO=
Condition cond,
 	return TRUE;
 }
 =

+static gboolean packet_received_data(GIOChannel *channel, GIOCondition con=
d,
+				gpointer data)
+{
+	unsigned char *buf;
+	GAtIO *io =3D data;
+	GIOStatus status;
+	gsize rbytes;
+	gsize toread;		=

+
+				=

+	if (cond & G_IO_NVAL)
+		return FALSE;
+		=

+	toread=3D 3000;
+	rbytes =3D 0;
+		=

+	ring_buffer_reset(io->buf);
+	buf =3D ring_buffer_write_ptr(io->buf, 0);
+		=

+	if (buf =3D=3D NULL)
+		return FALSE;
+
+	status =3D g_io_channel_read_chars(channel, (char *) buf,
+						toread, &rbytes, NULL);
+	=

+	if (status =3D=3D G_IO_STATUS_ERROR)
+		return FALSE;
+	=

+	if (rbytes > 0)
+		ring_buffer_write_advance(io->buf, rbytes);
+
+
+	=

+	if (rbytes > 0 && io->read_handler)
+		io->read_handler(io->buf, io->read_data);	=

+	=

+	if (cond & (G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	if (rbytes =3D=3D 0 && status !=3D G_IO_STATUS_AGAIN)
+		return FALSE;	=

+	=

+	return TRUE;
+}
+				=

 gsize g_at_io_write(GAtIO *io, const gchar *data, gsize count)
 {
 	GIOStatus status;
@@ -175,6 +220,50 @@ static gboolean can_write_data(GIOChannel *channel, GI=
OCondition cond,
 =

 }
 =

+static GAtIO *create_packet_io(GIOChannel *channel, GIOFlags flags)
+{
+	GAtIO *io;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	io =3D g_try_new0(GAtIO, 1);
+	=

+	if (io =3D=3D NULL)
+		return io;
+		=

+	io->ref_count =3D 1;
+	io->debugf =3D NULL;
+	=

+	=

+	io->max_read_attempts =3D 1;
+	io->use_write_watch =3D TRUE;
+			=

+	io->buf =3D ring_buffer_new(3000);
+
+	if (!io->buf)
+		goto error;
+
+	if (!g_at_util_setup_io(channel, flags))
+		goto error;	=

+	=

+	io->channel =3D channel;
+	io->read_watch =3D g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				packet_received_data, io,
+				read_watcher_destroy_notify);
+	=

+	return io;
+
+error:
+	if (io->buf)
+		ring_buffer_free(io->buf);
+
+	g_free(io);
+
+	return NULL;							=

+}
+
 static GAtIO *create_io(GIOChannel *channel, GIOFlags flags)
 {
 	GAtIO *io;
@@ -208,7 +297,7 @@ static GAtIO *create_io(GIOChannel *channel, GIOFlags f=
lags)
 	io->channel =3D channel;
 	io->read_watch =3D g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				received_data, io,
+				stream_received_data, io,
 				read_watcher_destroy_notify);
 =

 	return io;
@@ -222,6 +311,11 @@ error:
 	return NULL;
 }
 =

+GAtIO *g_raw_io_new(GIOChannel *channel)
+{
+	return create_packet_io(channel, G_IO_FLAG_NONBLOCK);
+}
+
 GAtIO *g_at_io_new(GIOChannel *channel)
 {
 	return create_io(channel, G_IO_FLAG_NONBLOCK);
diff --git a/gatchat/gatio.h b/gatchat/gatio.h
index 5a9f9f9..4b8bc00 100644
--- a/gatchat/gatio.h
+++ b/gatchat/gatio.h
@@ -37,6 +37,7 @@ struct ring_buffer;
 typedef void (*GAtIOReadFunc)(struct ring_buffer *buffer, gpointer user_da=
ta);
 typedef gboolean (*GAtIOWriteFunc)(gpointer user_data);
 =

+GAtIO *g_raw_io_new(GIOChannel *channel);
 GAtIO *g_at_io_new(GIOChannel *channel);
 GAtIO *g_at_io_new_blocking(GIOChannel *channel);
 =

diff --git a/gatchat/gatrawip.c b/gatchat/gatrawip.c
index 539f71f..ab72035 100644
--- a/gatchat/gatrawip.c
+++ b/gatchat/gatrawip.c
@@ -42,10 +42,17 @@ struct _GAtRawIP {
 	char *ifname;
 	struct ring_buffer *write_buffer;
 	struct ring_buffer *tun_write_buffer;
+	GQueue *packet_queue;
 	GAtDebugFunc debugf;
 	gpointer debug_data;
 };
 =

+struct PacketRaw {
+	unsigned char *buf;
+	int len;
+};
+
+
 GAtRawIP *g_at_rawip_new(GIOChannel *channel)
 {
 	GAtRawIP *rawip;
@@ -112,24 +119,22 @@ void g_at_rawip_unref(GAtRawIP *rawip)
 static gboolean can_write_data(gpointer data)
 {
 	GAtRawIP *rawip =3D data;
-	unsigned int len;
-	unsigned char *buf;
-	gsize bytes_written;
+ 	gsize bytes_written;
+	struct PacketRaw *packetbuf;
 =

-	if (rawip->write_buffer =3D=3D NULL)
+	if (rawip->packet_queue =3D=3D NULL)
 		return FALSE;
+	=

+	while(g_queue_is_empty(rawip->packet_queue)!=3D TRUE)
+	{
+		packetbuf=3D g_queue_pop_head(rawip->packet_queue);
+		bytes_written =3D g_at_io_write(rawip->io, (gchar *) packetbuf->buf, pac=
ketbuf->len);
+		=

+		g_free(packetbuf->buf);
+		g_free(packetbuf);
 =

-	len =3D ring_buffer_len_no_wrap(rawip->write_buffer);
-	buf =3D ring_buffer_read_ptr(rawip->write_buffer, 0);
-
-	bytes_written =3D g_at_io_write(rawip->io, (gchar *) buf, len);
-	ring_buffer_drain(rawip->write_buffer, bytes_written);
-
-	if (ring_buffer_len(rawip->write_buffer) > 0)
-		return TRUE;
-
-	rawip->write_buffer =3D NULL;
-
+	}
+	return TRUE;
 	return FALSE;
 }
 =

@@ -169,9 +174,22 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 static void tun_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	GAtRawIP *rawip =3D user_data;
+	struct PacketRaw *packetbuf;
+
 =

-	rawip->write_buffer =3D rbuf;
+	packetbuf=3D g_try_new0(struct PacketRaw, 1);
+	if (packetbuf =3D=3D NULL)
+		return;
+
+	packetbuf-> len=3D ring_buffer_len_no_wrap(rbuf);
 =

+	packetbuf->buf=3D g_try_malloc(packetbuf-> len);
+	if (packetbuf->buf =3D=3D NULL)
+		return;
+	=

+	ring_buffer_read(rbuf, packetbuf->buf, 3000);
+
+	g_queue_push_head(rawip->packet_queue, packetbuf);
 	g_at_io_set_write_handler(rawip->io, can_write_data, rawip);
 }
 =

@@ -203,7 +221,11 @@ static void create_tun(GAtRawIP *rawip)
 		return;
 	}
 =

-	rawip->tun_io =3D g_at_io_new(channel);
+	rawip->tun_io =3D g_raw_io_new(channel);
+
+	rawip->packet_queue =3D g_queue_new();
+	if (rawip->packet_queue =3D=3D NULL)
+		return;
 =

 	g_io_channel_unref(channel);
 }
@@ -224,6 +246,8 @@ void g_at_rawip_open(GAtRawIP *rawip)
 =

 void g_at_rawip_shutdown(GAtRawIP *rawip)
 {
+	struct PacketRaw *packetbuf;
+	=

 	if (rawip =3D=3D NULL)
 		return;
 =

@@ -238,6 +262,23 @@ void g_at_rawip_shutdown(GAtRawIP *rawip)
 =

 	g_at_io_unref(rawip->tun_io);
 	rawip->tun_io =3D NULL;
+	=

+	if(rawip->packet_queue =3D=3D NULL)
+		return;
+	=

+	while(g_queue_is_empty(rawip->packet_queue)!=3D TRUE)
+	{
+		packetbuf=3D g_queue_pop_head(rawip->packet_queue);
+		if(packetbuf->buf !=3D NULL)
+			g_free(packetbuf->buf);
+		=

+		g_free(packetbuf);
+	}
+	=

+	g_queue_free(rawip->packet_queue);
+	rawip->packet_queue=3D NULL;
+	=

+	=

 }
 =

 const char *g_at_rawip_get_interface(GAtRawIP *rawip)
-- =

1.6.6.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============0317974815339195041==--

