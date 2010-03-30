Content-Type: multipart/mixed; boundary="===============3728372160807356335=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Add flag to parse one command line at once
Date: Tue, 30 Mar 2010 21:38:57 +0800
Message-ID: <1269956337-26575-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269956337-26575-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3728372160807356335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 5f21766..ce78857 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -119,6 +119,7 @@ struct _GAtServer {
 	GAtServerResult last_result;		/* Last command's result code */
 	gboolean final_called;			/* Is send_final called */
 	gboolean wait_final;			/* Wait for final result code */
+	gboolean parse_ready;			/* Ready to parse next line */
 };
 =

 static void g_at_server_wakeup_writer(GAtServer *server);
@@ -199,6 +200,8 @@ static void g_at_server_send_flush(GAtServer *server, G=
AtServerResult result)
 		sprintf(buf, "%u", (unsigned int)result);
 =

 	send_result_common(server, buf);
+
+	server->parse_ready =3D TRUE;
 }
 =

 void g_at_server_send_final(GAtServer *server, GAtServerResult result)
@@ -223,6 +226,7 @@ void g_at_server_send_ext_final(GAtServer *server, cons=
t char *result)
 =

 	server->final_called =3D TRUE;
 	server->wait_final =3D FALSE;
+	server->parse_ready =3D TRUE;
 }
 =

 void g_at_server_send_intermediate(GAtServer *server, const char *result)
@@ -721,6 +725,7 @@ static void new_bytes(GAtServer *p)
 			p->last_line =3D extract_line(p);
 			if (p->last_line) {
 				p->cur_pos =3D 0;
+				p->parse_ready =3D FALSE;
 =

 				server_parse_line(p);
 			} else
@@ -777,6 +782,10 @@ static gboolean received_data(GIOChannel *channel, GIO=
Condition cond,
 		g_at_util_debug_chat(TRUE, (char *)buf, rbytes,
 					server->debugf, server->debug_data);
 =

+		/* Ignore incoming bytes when processing a command line */
+		if (!server->parse_ready)
+			continue;
+
 		read_count++;
 =

 		total_read +=3D rbytes;
@@ -963,6 +972,7 @@ GAtServer *g_at_server_new(GIOChannel *io)
 	server->ref_count =3D 1;
 	v250_settings_create(&server->v250);
 	server->channel =3D io;
+	server->parse_ready =3D TRUE;
 	server->command_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free,
 							at_notify_node_destroy);
-- =

1.6.6.1


--===============3728372160807356335==--

