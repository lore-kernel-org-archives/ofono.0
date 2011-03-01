Content-Type: multipart/mixed; boundary="===============2881651614897960877=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: [PATCH] PPP: Optimize write buffer management
Date: Tue, 01 Mar 2011 16:07:36 +0100
Message-ID: <1298992056-3542-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2881651614897960877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace modulo operations in ringbuffer.c by masking operations.
That's possible because the size of the ring buffers is always
a power of two, and yields a small performance improvement.

More importantly, extend the write buffer handling in gathdlc.c
to minimize stalling and process switching during large PPP transfers.
The single write buffer is replaced by a circular queue of buffers,
allowing for much larger emission windows without hugely impacting
memory consumption. This reduces the time required to send 50 MB
between a couple of local PPP interfaces on my laptop from 53s to 2.6s.
---
 gatchat/gathdlc.c    |   85 +++++++++++++++++++++++++++++++++++++---------=
----
 gatchat/ringbuffer.c |   14 +++++---
 2 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index dd11043..9cc6a74 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -37,7 +37,9 @@
 #include "gatio.h"
 #include "gathdlc.h"
 =

-#define BUFFER_SIZE 2048
+#define BUFFER_SIZE	4096
+#define MAX_BUFFERS	64	/* Maximum number of in-flight write buffers: this =
needs to be a power of 2 */
+#define HDLC_OVERHEAD	256	/* Rough estimate of HDLC protocol overhead for =
a frame */
 =

 #define HDLC_FLAG	0x7e	/* Flag sequence */
 #define HDLC_ESCAPE	0x7d	/* Asynchronous control escape */
@@ -51,7 +53,9 @@
 struct _GAtHDLC {
 	gint ref_count;
 	GAtIO *io;
-	struct ring_buffer *write_buffer;
+	struct ring_buffer *wbuf_ring[MAX_BUFFERS]; /* Array of pointers to circu=
lar write buffers - itself managed as a ring */
+	gint wbuf_head; /* First unsent buffer index */
+	gint wbuf_tail; /* Last unsent buffer index */
 	unsigned char *decode_buffer;
 	guint decode_offset;
 	guint16 decode_fcs;
@@ -190,6 +194,7 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 {
 	GAtHDLC *hdlc;
 	unsigned char *buf;
+	struct ring_buffer* write_buffer;
 =

 	if (io =3D=3D NULL)
 		return NULL;
@@ -207,16 +212,19 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	hdlc->xmit_accm[3] =3D 0x60000000; /* 0x7d, 0x7e */
 	hdlc->recv_accm =3D ~0U;
 =

-	hdlc->write_buffer =3D ring_buffer_new(BUFFER_SIZE * 2);
-	if (!hdlc->write_buffer)
+	write_buffer =3D ring_buffer_new(BUFFER_SIZE);
+	if (!write_buffer)
 		goto error;
 =

+	hdlc->wbuf_head =3D hdlc->wbuf_tail =3D 0;
+	hdlc->wbuf_ring[0] =3D write_buffer;
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

@@ -228,8 +236,8 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	return hdlc;
 =

 error:
-	if (hdlc->write_buffer)
-		ring_buffer_free(hdlc->write_buffer);
+	if (write_buffer)
+	    ring_buffer_free(write_buffer);
 =

 	if (hdlc->decode_buffer)
 		g_free(hdlc->decode_buffer);
@@ -266,6 +274,8 @@ GAtHDLC *g_at_hdlc_ref(GAtHDLC *hdlc)
 =

 void g_at_hdlc_unref(GAtHDLC *hdlc)
 {
+	int i;
+
 	if (hdlc =3D=3D NULL)
 		return;
 =

@@ -280,7 +290,11 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
 	g_at_io_unref(hdlc->io);
 	hdlc->io =3D NULL;
 =

-	ring_buffer_free(hdlc->write_buffer);
+	for (i =3D hdlc->wbuf_head; i !=3D hdlc->wbuf_tail; i =3D (i+1) % MAX_BUF=
FERS)
+	    ring_buffer_free(hdlc->wbuf_ring[i]);
+
+	ring_buffer_free(hdlc->wbuf_ring[i]);
+
 	g_free(hdlc->decode_buffer);
 =

 	if (hdlc->in_read_handler)
@@ -314,17 +328,26 @@ static gboolean can_write_data(gpointer data)
 	unsigned int len;
 	unsigned char *buf;
 	gsize bytes_written;
+	struct ring_buffer* write_buffer =3D hdlc->wbuf_ring[hdlc->wbuf_head];
 =

-	len =3D ring_buffer_len_no_wrap(hdlc->write_buffer);
-	buf =3D ring_buffer_read_ptr(hdlc->write_buffer, 0);
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
 		return TRUE;
 =

+	/* We're done with this buffer : adjust head if there is at least another=
 buffer in flight */
+	if (hdlc->wbuf_head !=3D hdlc->wbuf_tail) {
+		ring_buffer_free(write_buffer);
+		hdlc->wbuf_head =3D (hdlc->wbuf_head + 1) % MAX_BUFFERS;
+
+		return TRUE;
+	}
+
 	return FALSE;
 }
 =

@@ -356,19 +379,37 @@ GAtIO *g_at_hdlc_get_io(GAtHDLC *hdlc)
 =

 gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned char *data, gsize si=
ze)
 {
-	unsigned int avail =3D ring_buffer_avail(hdlc->write_buffer);
-	unsigned int wrap =3D ring_buffer_avail_no_wrap(hdlc->write_buffer);
-	unsigned char *buf =3D ring_buffer_write_ptr(hdlc->write_buffer, 0);
+	struct ring_buffer* write_buffer =3D hdlc->wbuf_ring[hdlc->wbuf_tail];
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
+		/* Switch to a new buffer */
+
+		if ((hdlc->wbuf_tail + 1) % MAX_BUFFERS =3D=3D hdlc->wbuf_head)
+			return FALSE;	/* Ring full */
+
+		write_buffer =3D ring_buffer_new(BUFFER_SIZE);
+
+		if (!write_buffer)
+			return FALSE;
+
+		hdlc->wbuf_tail =3D (hdlc->wbuf_tail + 1) % MAX_BUFFERS;
+		hdlc->wbuf_ring[hdlc->wbuf_tail] =3D write_buffer;
+
+		avail =3D ring_buffer_avail(write_buffer);
+		wrap =3D ring_buffer_avail_no_wrap(write_buffer);
+		buf =3D ring_buffer_write_ptr(write_buffer, 0);
+	}
 =

 	i =3D 0;
+	buf =3D ring_buffer_write_ptr(write_buffer, 0);
 =

 	while (pos < avail && i < size) {
 		if (escape =3D=3D TRUE) {
@@ -387,7 +428,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 		pos++;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_write_ptr(hdlc->write_buffer, pos);
+			buf =3D ring_buffer_write_ptr(write_buffer, pos);
 	}
 =

 	if (i < size)
@@ -414,7 +455,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 		pos++;
 =

 		if (pos =3D=3D wrap)
-			buf =3D ring_buffer_write_ptr(hdlc->write_buffer, pos);
+		    buf =3D ring_buffer_write_ptr(write_buffer, pos);
 	}
 =

 	if (i < sizeof(tail))
@@ -426,7 +467,7 @@ gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned c=
har *data, gsize size)
 	*buf =3D HDLC_FLAG;
 	pos++;
 =

-	ring_buffer_write_advance(hdlc->write_buffer, pos);
+	ring_buffer_write_advance(write_buffer, pos);
 =

 	g_at_io_set_write_handler(hdlc->io, can_write_data, hdlc);
 =

diff --git a/gatchat/ringbuffer.c b/gatchat/ringbuffer.c
index becd3f8..27be3a8 100644
--- a/gatchat/ringbuffer.c
+++ b/gatchat/ringbuffer.c
@@ -34,6 +34,7 @@
 struct ring_buffer {
 	unsigned char *buffer;
 	unsigned int size;
+	unsigned int mask;
 	unsigned int in;
 	unsigned int out;
 };
@@ -61,6 +62,7 @@ struct ring_buffer *ring_buffer_new(unsigned int size)
 	}
 =

 	buffer->size =3D real_size;
+	buffer->mask =3D real_size - 1;
 	buffer->in =3D 0;
 	buffer->out =3D 0;
 =

@@ -78,7 +80,7 @@ int ring_buffer_write(struct ring_buffer *buf, const void=
 *data,
 	len =3D MIN(len, buf->size - buf->in + buf->out);
 =

 	/* Determine how much to write before wrapping */
-	offset =3D buf->in % buf->size;
+	offset =3D buf->in & buf->mask;
 	end =3D MIN(len, buf->size - offset);
 	memcpy(buf->buffer+offset, d, end);
 =

@@ -93,12 +95,12 @@ int ring_buffer_write(struct ring_buffer *buf, const vo=
id *data,
 unsigned char *ring_buffer_write_ptr(struct ring_buffer *buf,
 					unsigned int offset)
 {
-	return buf->buffer + (buf->in + offset) % buf->size;
+	return buf->buffer + ((buf->in + offset) & buf->mask);
 }
 =

 int ring_buffer_avail_no_wrap(struct ring_buffer *buf)
 {
-	unsigned int offset =3D buf->in % buf->size;
+	unsigned int offset =3D buf->in & buf->mask;
 	unsigned int len =3D buf->size - buf->in + buf->out;
 =

 	return MIN(len, buf->size - offset);
@@ -121,7 +123,7 @@ int ring_buffer_read(struct ring_buffer *buf, void *dat=
a, unsigned int len)
 	len =3D MIN(len, buf->in - buf->out);
 =

 	/* Grab data from buffer starting at offset until the end */
-	offset =3D buf->out % buf->size;
+	offset =3D buf->out & buf->mask;
 	end =3D MIN(len, buf->size - offset);
 	memcpy(d, buf->buffer + offset, end);
 =

@@ -150,7 +152,7 @@ int ring_buffer_drain(struct ring_buffer *buf, unsigned=
 int len)
 =

 int ring_buffer_len_no_wrap(struct ring_buffer *buf)
 {
-	unsigned int offset =3D buf->out % buf->size;
+	unsigned int offset =3D buf->out & buf->mask;
 	unsigned int len =3D buf->in - buf->out;
 =

 	return MIN(len, buf->size - offset);
@@ -159,7 +161,7 @@ int ring_buffer_len_no_wrap(struct ring_buffer *buf)
 unsigned char *ring_buffer_read_ptr(struct ring_buffer *buf,
 					unsigned int offset)
 {
-	return buf->buffer + (buf->out + offset) % buf->size;
+	return buf->buffer + ((buf->out + offset) & buf->mask);
 }
 =

 int ring_buffer_len(struct ring_buffer *buf)
-- =

1.7.1


--===============2881651614897960877==--

