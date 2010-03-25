Content-Type: multipart/mixed; boundary="===============1307843797686524331=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/5] Add register S3-S5 basic command callbacks
Date: Thu, 25 Mar 2010 21:48:20 +0800
Message-ID: <1269524901-1745-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269524901-1745-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1307843797686524331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 162 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 5d2a036..9d4d221 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -294,6 +294,159 @@ void g_at_server_send_info_text(GAtServer *server, GS=
List *text)
 	send_common(server, buf, len);
 }
 =

+static gboolean get_result_value(GAtServer *server, GAtResult *result,
+						const char *command,
+						int min, int max, int *value)
+{
+	GAtResultIter iter;
+	int val;
+	char prefix[10];
+
+	if (command[0] !=3D 'S')
+		return FALSE;
+
+	sprintf(prefix, "%s=3D", command);
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, prefix))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, &val))
+		return FALSE;
+
+	if (val < min || val > max)
+		return FALSE;
+
+	*value =3D val;
+
+	return TRUE;
+}
+
+static void send_info_text(GAtServer *server, char *buf)
+{
+	GSList *text =3D NULL;
+
+	text =3D g_slist_append(NULL, buf);
+	g_at_server_send_info_text(server, text);
+	g_slist_free(text);
+}
+
+static void set_s_value(GAtServer *server, const char *prefix, int val)
+{
+	char c =3D prefix[1];
+
+	switch (c) {
+	case '3':
+		server->v250.s3 =3D val;
+		break;
+
+	case '4':
+		server->v250.s4 =3D val;
+		break;
+
+	case '5':
+		server->v250.s5 =3D val;
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int get_s_value(GAtServer *server, const char *prefix)
+{
+	char c =3D prefix[1];
+	int val =3D 0;
+
+	switch (c) {
+	case '3':
+		val =3D server->v250.s3;
+		break;
+
+	case '4':
+		val =3D server->v250.s4;
+		break;
+
+	case '5':
+		val =3D server->v250.s5;
+		break;
+
+	default:
+		break;
+	}
+
+	return val;
+}
+
+static void s_template_cb(GAtServerRequestType type,
+					GAtResult *result, gpointer user_data,
+					const char *prefix,
+					int min, int max,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtServer *server =3D user_data;
+	char buf[20];
+	int val;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (!get_result_value(server, result, prefix, min, max, &val))
+			goto done;
+
+		set_s_value(server, prefix, val);
+		res =3D G_AT_SERVER_RESULT_OK;
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		val =3D get_s_value(server, prefix);
+		sprintf(buf, "%03d", val);
+		send_info_text(server, buf);
+		res =3D G_AT_SERVER_RESULT_OK;
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		sprintf(buf, "%s: (%d-%d)", prefix, min, max);
+		send_info_text(server, buf);
+		res =3D G_AT_SERVER_RESULT_OK;
+		break;
+
+	default:
+		break;
+	}
+
+done:
+	g_at_server_send_final(server, res);
+
+	cb(cb_data);
+}
+
+static void at_s3_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	s_template_cb(type, result, user_data, "S3", 0, 127, cb, cb_data);
+}
+
+static void at_s4_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	s_template_cb(type, result, user_data, "S4", 0, 127, cb, cb_data);
+}
+
+static void at_s5_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	s_template_cb(type, result, user_data, "S5", 0, 127, cb, cb_data);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1008,6 +1161,13 @@ static void at_notify_node_destroy(gpointer data)
 	g_free(node);
 }
 =

+static void basic_command_register(GAtServer *server)
+{
+	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
+	g_at_server_register(server, "S4", at_s4_cb, server, NULL);
+	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
+}
+
 GAtServer *g_at_server_new(GIOChannel *io)
 {
 	GAtServer *server;
@@ -1047,6 +1207,8 @@ GAtServer *g_at_server_new(GIOChannel *io)
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


--===============1307843797686524331==--

