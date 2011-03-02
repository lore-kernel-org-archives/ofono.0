Content-Type: multipart/mixed; boundary="===============5807727826658439155=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: [PATCH] Replace modulo operations in ringbuffer.c by masking
 operations.
Date: Wed, 02 Mar 2011 11:15:35 +0100
Message-ID: <1299060935-12999-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5807727826658439155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That's possible because the size of the ring buffers is always
a power of two, and yields a small performance improvement.

The improvement should be mostly visible on processors that implement
division in microcode (Atom) or lack a division instruction (ARM).
---
 gatchat/ringbuffer.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

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


--===============5807727826658439155==--

