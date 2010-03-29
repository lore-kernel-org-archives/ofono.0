Content-Type: multipart/mixed; boundary="===============1547983156889128219=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/3] Add flag to parse one command line at once
Date: Mon, 29 Mar 2010 21:50:04 +0800
Message-ID: <1269870604-28896-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269870604-28896-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1547983156889128219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index cad9d91..251c3b8 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -116,6 +116,7 @@ struct _GAtServer {
 	gboolean destroyed;			/* Re-entrancy guard */
 	char *read_line;			/* Current read line */
 	unsigned int read_pos;			/* Current read offset */
+	gboolean parse_ready;			/* Ready to parse command */
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
@@ -196,6 +197,8 @@ static void g_at_server_send_result(GAtServer *server, =
GAtServerResult result)
 		sprintf(buf, "%u", (unsigned int)result);
 =

 	send_result_common(server, buf);
+
+	server->parse_ready =3D TRUE;
 }
 =

 void g_at_server_send_final(GAtServer *server, GAtServerResult result)
@@ -216,6 +219,8 @@ void g_at_server_send_final(GAtServer *server, GAtServe=
rResult result)
 void g_at_server_send_ext_final(GAtServer *server, const char *result)
 {
 	send_result_common(server, result);
+
+	server->parse_ready =3D TRUE;
 }
 =

 void g_at_server_send_intermediate(GAtServer *server, const char *result)
@@ -671,7 +676,7 @@ static void new_bytes(GAtServer *p)
 	unsigned char *buf =3D ring_buffer_read_ptr(p->read_buf, p->read_so_far);
 	enum ParserResult result;
 =

-	while (p->channel && (p->read_so_far < len)) {
+	while (p->channel && p->parse_ready && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D server_feed(p, (char *)buf, &rbytes);
 =

@@ -703,6 +708,7 @@ static void new_bytes(GAtServer *p)
 			p->read_line =3D extract_line(p);
 			if (p->read_line) {
 				p->read_pos =3D 0;
+				p->parse_ready =3D FALSE;
 =

 				server_parse_line(p);
 			} else
@@ -945,6 +951,7 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
+	server->parse_ready =3D TRUE;
 	server->command_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free,
 							at_notify_node_destroy);
-- =

1.6.6.1


--===============1547983156889128219==--

