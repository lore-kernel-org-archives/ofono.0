Content-Type: multipart/mixed; boundary="===============4912553775758531253=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/4] Add write server response into non-blocking IO
Date: Fri, 26 Feb 2010 17:56:32 +0800
Message-ID: <1267178192-21396-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267178192-21396-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4912553775758531253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Write server response into non-blocking GIOChannel when we have
G_IO_OUT signal.
---
 gatchat/gatserver.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index a136a6f..5b5e2f7 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -33,6 +33,7 @@
 #include "gatserver.h"
 =

 #define BUF_SIZE 4096
+/* #define WRITE_SCHEDULER_DEBUG 1 */
 =

 enum ParserState {
 	PARSER_STATE_IDLE,
@@ -473,6 +474,71 @@ static gboolean received_data(GIOChannel *channel, GIO=
Condition cond,
 static gboolean can_write_data(GIOChannel *channel, GIOCondition cond,
 				gpointer data)
 {
+	GAtServer *server =3D data;
+	GIOError err;
+	gsize bytes_written;
+	gsize towrite;
+	struct ring_buffer *write_buf;
+	unsigned char *buf;
+	gboolean write_again =3D FALSE;
+#ifdef WRITE_SCHEDULER_DEBUG
+	int limiter;
+#endif
+
+	if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR))
+		return FALSE;
+
+	if (!server->write_queue)
+		return FALSE;
+
+	/* Write data out from the head of the queue */
+	write_buf =3D g_queue_peek_head(server->write_queue);
+
+	buf =3D ring_buffer_read_ptr(write_buf, 0);
+
+	towrite =3D ring_buffer_len_no_wrap(write_buf);
+	if (towrite < (gsize)ring_buffer_len(write_buf))
+		write_again =3D TRUE;
+
+#ifdef WRITE_SCHEDULER_DEBUG
+	limiter =3D towrite;
+
+	if (limiter > 5)
+		limiter =3D 5;
+#endif
+
+	err =3D g_io_channel_write(server->channel,
+			(char *)buf,
+#ifdef WRITE_SCHEDULER_DEBUG
+			limiter,
+#else
+			towrite,
+#endif
+			&bytes_written);
+
+	if (err !=3D G_IO_ERROR_NONE) {
+		g_source_remove(server->read_watch);
+		return FALSE;
+	}
+
+	g_at_util_debug_chat(FALSE, (char *)buf, bytes_written, server->debugf,
+				server->debug_data);
+
+	ring_buffer_drain(write_buf, bytes_written);
+
+	/* All data in current buffer is written, free it
+	 * unless it's the last buffer in the queue.
+	 */
+	if ((ring_buffer_len(write_buf) =3D=3D 0) &&
+			(g_queue_get_length(server->write_queue) !=3D 1)) {
+		write_buf =3D g_queue_pop_head(server->write_queue);
+		ring_buffer_free(write_buf);
+		return TRUE;
+	}
+
+	if (bytes_written < towrite || write_again =3D=3D TRUE)
+		return TRUE;
+
 	return FALSE;
 }
 =

-- =

1.6.6.1


--===============4912553775758531253==--

