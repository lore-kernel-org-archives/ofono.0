Content-Type: multipart/mixed; boundary="===============8579634414634798902=="
MIME-Version: 1.0
From: Patrick Porlan <patrick.porlan@linux.intel.com>
Subject: [PATCH] PPP: Switch ringbuffer.c to g_slice allocator
Date: Wed, 16 Mar 2011 10:24:23 +0100
Message-ID: <1300267463-4980-1-git-send-email-patrick.porlan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8579634414634798902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This should allow for more efficient handling of equally sized
buffers, in terms of alignment and recycling.
---
 gatchat/ringbuffer.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gatchat/ringbuffer.c b/gatchat/ringbuffer.c
index 27be3a8..775498c 100644
--- a/gatchat/ringbuffer.c
+++ b/gatchat/ringbuffer.c
@@ -51,11 +51,11 @@ struct ring_buffer *ring_buffer_new(unsigned int size)
 	if (real_size > MAX_SIZE)
 		return NULL;
 =

-	buffer =3D g_try_new(struct ring_buffer, 1);
+	buffer =3D g_slice_new(struct ring_buffer);
 	if (buffer =3D=3D NULL)
 		return NULL;
 =

-	buffer->buffer =3D g_try_new(unsigned char, real_size);
+	buffer->buffer =3D g_slice_alloc(real_size);
 	if (buffer->buffer =3D=3D NULL) {
 		g_free(buffer);
 		return NULL;
@@ -202,6 +202,6 @@ void ring_buffer_free(struct ring_buffer *buf)
 	if (buf =3D=3D NULL)
 		return;
 =

-	g_free(buf->buffer);
-	g_free(buf);
+	g_slice_free1(buf->size, buf->buffer);
+	g_slice_free1(sizeof(struct ring_buffer), buf);
 }
-- =

1.7.1


--===============8579634414634798902==--

