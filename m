Content-Type: multipart/mixed; boundary="===============5723219846053920616=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] Add write server response into non-blocking IO
Date: Mon, 22 Feb 2010 13:48:07 +0800
Message-ID: <1266817687-28847-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1266817687-28847-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5723219846053920616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Write server response into non-blocking GIOChannel when we have
G_IO_OUT signal.
---
 gatchat/gatserver.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 7e11359..a9e0341 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -498,6 +498,74 @@ static gboolean received_data(GIOChannel *channel, GIO=
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
+	if (!server->full_list)
+		return FALSE;
+
+	/* Write data out from the head of full buffer */
+	write_buf =3D server->full_list->data;
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
+	/* All data in current full buffer is written, free it
+	 * unless it's the tail of the list.
+	 */
+	if ((ring_buffer_len(write_buf) =3D=3D 0) &&
+			(g_slist_length(server->full_list) > 1)) {
+		server->full_list =3D g_slist_remove(server->full_list,
+							write_buf);
+
+		ring_buffer_free(write_buf);
+
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


--===============5723219846053920616==--

