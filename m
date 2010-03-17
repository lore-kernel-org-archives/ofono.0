Content-Type: multipart/mixed; boundary="===============6561762406745225709=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/6] Add register S3 basic command callback
Date: Wed, 17 Mar 2010 22:44:06 +0800
Message-ID: <1268837051-5032-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268837051-5032-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6561762406745225709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 06ea912..80e6d45 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -233,6 +233,53 @@ void g_at_server_send_info_text(GAtServer *server, GSL=
ist *text)
 	send_common(server, buf, len);
 }
 =

+static GAtServerResult at_s3_cb(GAtServerRequestType type, GAtResult *resu=
lt,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtServer *server =3D user_data;
+	GSList *text =3D NULL;
+	char buf[20];
+
+	if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SET) {
+		GAtResultIter iter;
+		int val =3D 13;
+
+		g_at_result_iter_init(&iter, result);
+
+		if (!g_at_result_iter_next(&iter, "S3=3D"))
+			goto done;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto done;
+
+		if (val < 0 || val > 127)
+			goto done;
+
+		server->v250.s3 =3D val;
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_QUERY) {
+		sprintf(buf, "%03d", server->v250.s3);
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		sprintf(buf, "S3: (0-127)");
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	}
+
+	if (text)
+		g_slist_free(text);
+
+done:
+	return res;
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -889,6 +936,11 @@ static void at_notify_node_destroy(gpointer data)
 	g_free(node);
 }
 =

+static void basic_command_register(GAtServer *server)
+{
+	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
+}
+
 GAtServer *g_at_server_new(GIOChannel *io)
 {
 	GAtServer *server;
@@ -927,6 +979,8 @@ GAtServer *g_at_server_new(GIOChannel *io)
 				received_data, server,
 				(GDestroyNotify)read_watcher_destroy_notify);
 =

+	basic_command_register(server);
+
 	return server;
 =

 error:
-- =

1.6.6.1


--===============6561762406745225709==--

