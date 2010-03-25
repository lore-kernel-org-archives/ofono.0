Content-Type: multipart/mixed; boundary="===============4743787644750788458=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/5] Add set server to offline mode during parse line
Date: Thu, 25 Mar 2010 21:48:19 +0800
Message-ID: <1269524901-1745-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269524901-1745-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4743787644750788458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index fdc4180..5d2a036 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -118,6 +118,7 @@ struct _GAtServer {
 	unsigned int read_pos;			/* Current read offset */
 	int notify_source;			/* Source of notify callback */
 	GAtServerResult last_result;		/* Result of last command */
+	gboolean is_online;			/* Online or offline mode */
 };
 =

 struct at_notify_node {
@@ -239,6 +240,8 @@ static void g_at_server_send_flush(GAtServer *server)
 		sprintf(buf, "%u", (unsigned int)result);
 =

 	send_result_common(server, buf);
+
+	server->is_online =3D TRUE;
 }
 =

 inline void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
@@ -728,7 +731,7 @@ static void new_bytes(GAtServer *p)
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserResult result;
 =

-	while (p->channel && (p->read_so_far < len)) {
+	while (p->channel && p->is_online && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D server_feed(p, (char *)buf, &rbytes);
 =

@@ -764,6 +767,12 @@ static void new_bytes(GAtServer *p)
 				p->read_pos =3D 0;
 				p->last_result =3D G_AT_SERVER_RESULT_OK;
 =

+				/* Set offline mode so that server won't feed
+				 * the next command line until current line is
+				 * processed and final result code is flushed.
+				 */
+				p->is_online =3D FALSE;
+
 				server_parse_line(p);
 			} else {
 				g_at_server_send_final(p,
@@ -1013,6 +1022,7 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
+	server->is_online =3D TRUE;
 	server->command_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free,
 							at_notify_node_destroy);
-- =

1.6.6.1


--===============4743787644750788458==--

