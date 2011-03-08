Content-Type: multipart/mixed; boundary="===============5605378746429342221=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: [PATCH] PPP: Optimize write buffer management
Date: Tue, 08 Mar 2011 16:58:17 +0100
Message-ID: <1299599897-2592-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5605378746429342221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the write buffer handling in gathdlc.c to minimize stalling and
process switching during large PPP transfers. The single write buffer
is replaced by a queue of buffers, allowing for much larger emission
windows without hugely impacting memory consumption. This reduces the
time required to send 50 MB between a couple of local PPP interfaces on
my laptop from ~53s to ~3s.
---
 gatchat/gathdlc.c |   95 ++++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 6c39e6c..893e061 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -37,7 +37,9 @@
 #include "gatio.h"
 #include "gathdlc.h"
 =

-#define BUFFER_SIZE 2048
+#define BUFFER_SIZE	(2 * 2048)
+#define MAX_BUFFERS	64	/* Maximum number of in-flight write buffers */
+#define HDLC_OVERHEAD	256	/* Rough estimate of HDLC protocol overhead */
 =

 #define HDLC_FLAG	0x7e	/* Flag sequence */
 #define HDLC_ESCAPE	0x7d	/* Asynchronous control escape */
@@ -51,7 +53,7 @@
 struct _GAtHDLC {
 	gint ref_count;
 	GAtIO *io;
-	struct ring_buffer *write_buffer;
+	GQueue *write_queue;	/* Write buffer queue */
 	unsigned char *decode_buffer;
 	guint decode_offset;
 	guint16 decode_fcs;
@@ -201,6 +203,7 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 {
 	GAtHDLC *hdlc;
 	unsigned char *buf;
+	struct ring_buffer* write_buffer;
 =

 	if (io =3D=3D NULL)
 		return NULL;
@@ -218,16 +221,22 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	hdlc->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
 	hdlc->recv_accm =3D ~0U;
 =

-	hdlc->write_buffer =3D ring_buffer_new(BUFFER_SIZE * 2);
-	if (!hdlc->write_buffer)
+	write_buffer =3D ring_buffer_new(BUFFER_SIZE);
+	if (!write_buffer)
+		goto error;
+
+	hdlc->write_queue =3D g_queue_new();
+	if (!hdlc->write_queue)
 		goto error;
 =

+	g_queue_push_tail(hdlc->write_queue, write_buffer);
+
 	/* Write an initial 0x7e as wakeup character */
-	buf =3D ring_buffer_write_ptr(hdlc->write_buffer, 0);
+	buf =3D ring_buffer_write_ptr(write_buffer, 0);
 	*buf =3D HDLC_FLAG;
-	ring_buffer_write_advance(hdlc->write_buffer, 1);
+	ring_buffer_write_advance(write_buffer, 1);
 =

-	hdlc->decode_buffer =3D g_try_malloc(BUFFER_SIZE * 2);
+	hdlc->decode_buffer =3D g_try_malloc(BUFFER_SIZE);
 	if (!hdlc->decode_buffer)
 		goto error;
 =

@@ -239,8 +248,11 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	return hdlc;
 =

 error:
-	if (hdlc->write_buffer)
-		ring_buffer_free(hdlc->write_buffer);
+	if (hdlc->write_queue)
+		g_queue_free(hdlc->write_queue);
+
+	if (write_buffer)
+		ring_buffer_free(write_buffer);
 =

 	if (hdlc->decode_buffer)
 		g_free(hdlc->decode_buffer);
@@ -277,6 +289,8 @@ GAtHDLC *g_at_hdlc_ref(GAtHDLC *hdlc)
 =

 void g_at_hdlc_unref(GAtHDLC *hdlc)
 {
+	struct ring_buffer *write_buffer;
+
 	if (hdlc =3D=3D NULL)
 		return;
 =

@@ -294,7 +308,11 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
 	g_at_io_unref(hdlc->io);
 	hdlc->io =3D NULL;
 =

-	ring_buffer_free(hdlc->write_buffer);
+	while ((write_buffer =3D g_queue_pop_head(hdlc->write_queue)))
+		ring_buffer_free(write_buffer);
+
+	g_queue_free(hdlc->write_queue);
+
 	g_free(hdlc->decode_buffer);
 =

 	if (hdlc->in_read_handler)
@@ -328,15 +346,32 @@ static gboolean can_write_data(gpointer data)
 	unsigned int len;
 	unsigned char *buf;
 	gsize bytes_written;
+	struct ring_buffer* write_buffer;
 =

-	len =3D ring_buffer_len_no_wrap(hdlc->write_buffer);
-	buf =3D ring_buffer_read_ptr(hdlc->write_buffer, 0);
+	/* Write data out from the head of the queue */
+	write_buffer =3D g_queue_peek_head(hdlc->write_queue);
+
+	len =3D ring_buffer_len_no_wrap(write_buffer);
+	buf =3D ring_buffer_read_ptr(write_buffer, 0);
 =

 	bytes_written =3D g_at_io_write(hdlc->io, (gchar *) buf, len);
 	hdlc_record(hdlc->record_fd, FALSE, buf, bytes_written);
-	ring_buffer_drain(hdlc->write_buffer, bytes_written);
+	ring_buffer_drain(write_buffer, bytes_written);
 =

-	if (ring_buffer_len(hdlc->write_buffer) > 0)
+	if (ring_buffer_len(write_buffer) > 0)
+		return TRUE;
+
+	/* All data in current buffer is written, free it
+	 * unless it's the last buffer in the queue.
+	 */
+	if ((ring_buffer_len(write_buffer) =3D=3D 0) &&
+			(g_queue_get_length(hdlc->write_queue) > 1)) {
+		write_buffer =3D g_queue_pop_head(hdlc->write_queue);
+		ring_buffer_free(write_buffer);
+		write_buffer =3D g_queue_peek_head(hdlc->write_queue);
+	}
+
+	if (ring_buffer_len(write_buffer) > 0)
 		return TRUE;
 =

 	return FALSE;
@@ -370,19 +405,35 @@ GAtIO *g_at_hdlc_get_io(GAtHDLC *hdlc)
 =

 gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned char *data, gsize si=
ze)
 {
-	unsigned int avail =3D ring_buffer_avail(hdlc->write_buffer);
-	unsigned int wrap =3D ring_buffer_avail_no_wrap(hdlc->write_buffer);
-	unsigned char *buf =3D ring_buffer_write_ptr(hdlc->write_buffer, 0);
+	struct ring_buffer* write_buffer =3D g_queue_peek_tail(hdlc->write_queue);
+
+	unsigned int avail =3D ring_buffer_avail(write_buffer);
+	unsigned int wrap =3D ring_buffer_avail_no_wrap(write_buffer);
+	unsigned char *buf;
 	unsigned char tail[2];
 	unsigned int i =3D 0;
 	guint16 fcs =3D HDLC_INITFCS;
 	gboolean escape =3D FALSE;
 	gsize pos =3D 0;
 =

-	if (avail < size)
-		return FALSE;
+	if (avail < size + HDLC_OVERHEAD) {
+
+		if (g_queue_get_length(hdlc->write_queue) > MAX_BUFFERS)
+			return FALSE;	/* Too many pending buffers */
+
+		write_buffer =3D ring_buffer_new(BUFFER_SIZE);
+
+		if (!write_buffer)
+			return FALSE;
+
+		g_queue_push_tail(hdlc->write_queue, write_buffer);
+
+		avail =3D ring_buffer_avail(write_buffer);
+		wrap =3D ring_buffer_avail_no_wrap(write_buffer);
+	}
 =

 	i =3D 0;
+	buf =3D ring_buffer_write_ptr(write_buffer, 0);
 =

 	while (pos < avail && i < size) {
 		if (escape =3D=3D TRUE) {
@@ -401,7 +452,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 		pos++;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_write_ptr(hdlc->write_buffer, pos);
+			buf =3D ring_buffer_write_ptr(write_buffer, pos);
 	}
 =

 	if (i < size)
@@ -428,7 +479,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 		pos++;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_write_ptr(hdlc->write_buffer, pos);
+		    buf =3D ring_buffer_write_ptr(write_buffer, pos);
 	}
 =

 	if (i < sizeof(tail))
@@ -440,7 +491,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 	*buf =3D HDLC_FLAG;
 	pos++;
 =

-	ring_buffer_write_advance(hdlc->write_buffer, pos);
+	ring_buffer_write_advance(write_buffer, pos);
 =

 	g_at_io_set_write_handler(hdlc->io, can_write_data, hdlc);
 =

-- =

1.7.1


--===============5605378746429342221==--

