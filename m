Content-Type: multipart/mixed; boundary="===============8078710970267703634=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/4] Add ring_buffer_read_advance for partial write
Date: Wed, 10 Feb 2010 16:13:42 +0800
Message-ID: <1265789623-30146-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1265789623-30146-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8078710970267703634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These two patches are for server side partial write.

When server writes data into non-blocking IO, we first get the
read pointer of write_buf and write data as much as we can. Then
we advance the read_ptr according to the real bytes written.
---
 gatchat/ringbuffer.c |    8 ++++++++
 gatchat/ringbuffer.h |    7 +++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gatchat/ringbuffer.c b/gatchat/ringbuffer.c
index 42d5b68..e17c1fa 100644
--- a/gatchat/ringbuffer.c
+++ b/gatchat/ringbuffer.c
@@ -130,6 +130,14 @@ int ring_buffer_read(struct ring_buffer *buf, void *da=
ta, unsigned int len)
 	return len;
 }
 =

+int ring_buffer_read_advance(struct ring_buffer *buf, unsigned int len)
+{
+	len =3D MIN(len, buf->in - buf->out);
+	buf->out +=3D len;
+
+	return len;
+}
+
 int ring_buffer_drain(struct ring_buffer *buf, unsigned int len)
 {
 	len =3D MIN(len, buf->in - buf->out);
diff --git a/gatchat/ringbuffer.h b/gatchat/ringbuffer.h
index 826f9aa..aa4f570 100644
--- a/gatchat/ringbuffer.h
+++ b/gatchat/ringbuffer.h
@@ -93,6 +93,13 @@ int ring_buffer_read(struct ring_buffer *buf, void *data,
 			unsigned int len);
 =

 /*!
+ * Advances the read counter by len, this is meant to be used with
+ * the ring_buffer_read_ptr function.  Returns the number of bytes
+ * actually advanced (the capacity of the buffer)
+ */
+int ring_buffer_read_advance(struct ring_buffer *buf, unsigned int len);
+
+/*!
  * Returns the read pointer with read offset specified by offset.  No boun=
ds
  * checking is performed.  Be careful not to read past the end of the buff=
er.
  * Use the ring_buffer_len_no_wrap function, and ring_buffer_drain.
-- =

1.6.6.1


--===============8078710970267703634==--

