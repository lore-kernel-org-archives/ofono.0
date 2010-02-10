Content-Type: multipart/mixed; boundary="===============8575671956011814615=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Add handle the case when write buffer is full
Date: Wed, 10 Feb 2010 16:13:41 +0800
Message-ID: <1265789623-30146-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1265789623-30146-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8575671956011814615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If current write_buf is fulled, put it into the full list and fetch
a new ring buffer from the free list.
---
 gatchat/gatserver.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 6b40084..b5ac91e 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -130,13 +130,70 @@ static gboolean alloc_free_list(GAtServer *server)
 	return TRUE;
 }
 =

+static gboolean replace_write_buf(GAtServer *server)
+{
+	struct ring_buffer *free_buf;
+
+	/* Add current buffer into full list and replace current buffer
+	 * by a new free buffer */
+	server->full_list =3D g_slist_append(server->full_list,
+						server->write_buf);
+
+	/* All free lists are exhausted. Allocate more free lists */
+	if (!server->free_list) {
+		if (!alloc_free_list(server)) {
+			/* Failed so shutdown the socket */
+			g_at_server_shutdown(server);
+
+			return FALSE;
+		}
+	}
+
+	free_buf =3D server->free_list->data;
+
+	server->free_list =3D g_slist_remove(server->free_list, free_buf);
+
+	server->write_buf =3D free_buf;
+
+	return TRUE;
+}
+
 static void send_common(GAtServer *server, const char *buf)
 {
 	gsize avail =3D ring_buffer_avail(server->write_buf);
-	gsize len =3D strlen(buf);
+	gsize towrite =3D strlen(buf);
+	gsize bytes_written;
+	gsize offset =3D 0;
+
+	if (avail > towrite) {
+		ring_buffer_write(server->write_buf, buf, towrite);
 =

-	if (avail >=3D len)
-		ring_buffer_write(server->write_buf, buf, len);
+		g_at_server_wakeup_writer(server);
+
+		return;
+	}
+
+	/* Write as much as we can */
+	bytes_written =3D ring_buffer_write(server->write_buf, buf, avail);
+	towrite -=3D bytes_written;
+	offset =3D bytes_written;
+
+	/* If current write buf is full, replace it with next free buffer */
+	if (!replace_write_buf(server))
+		return;
+
+	bytes_written =3D ring_buffer_write(server->write_buf, buf + offset,
+						towrite);
+	while (bytes_written < towrite) {
+		/* The next free buf is full, replace with next free one */
+		if (!replace_write_buf(server))
+			return;
+
+		towrite -=3D bytes_written;
+		offset +=3D bytes_written;
+		bytes_written =3D ring_buffer_write(server->write_buf,
+							buf + offset, towrite);
+	}
 =

 	g_at_server_wakeup_writer(server);
 }
-- =

1.6.6.1


--===============8575671956011814615==--

