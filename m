Content-Type: multipart/mixed; boundary="===============3615105111914132323=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/5] Add register ATE and other basic command callbacks
Date: Thu, 25 Mar 2010 21:48:21 +0800
Message-ID: <1269524901-1745-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1269524901-1745-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3615105111914132323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  195 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 191 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 9d4d221..06b5751 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -302,10 +302,10 @@ static gboolean get_result_value(GAtServer *server, G=
AtResult *result,
 	int val;
 	char prefix[10];
 =

-	if (command[0] !=3D 'S')
-		return FALSE;
-
-	sprintf(prefix, "%s=3D", command);
+	if (command[0] =3D=3D 'S')
+		sprintf(prefix, "%s=3D", command);
+	else
+		strcpy(prefix, command);
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -447,6 +447,187 @@ static void at_s5_cb(GAtServerRequestType type, GAtRe=
sult *result,
 	s_template_cb(type, result, user_data, "S5", 0, 127, cb, cb_data);
 }
 =

+static void set_v250_value(GAtServer *server, const char *prefix, int val)
+{
+	char c =3D prefix[0];
+
+	if (c =3D=3D '&') {
+		c =3D prefix[1];
+		switch (c) {
+		case 'C':
+			server->v250.c109 =3D val;
+			break;
+
+		case 'D':
+			server->v250.c108 =3D val;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (c) {
+		case 'E':
+			server->v250.echo =3D val;
+			break;
+
+		case 'Q':
+			server->v250.quiet =3D val;
+			break;
+
+		case 'V':
+			server->v250.is_v1 =3D val;
+			break;
+
+		case 'X':
+			server->v250.res_format =3D val;
+			break;
+		}
+	}
+}
+
+static int get_v250_value(GAtServer *server, const char *prefix)
+{
+	char c =3D prefix[0];
+	int val =3D 0;
+
+	if (c =3D=3D '&') {
+		c =3D prefix[1];
+
+		switch (c) {
+		case 'C':
+			val =3D server->v250.c109;
+			break;
+
+		case 'D':
+			val =3D server->v250.c108;
+			break;
+
+		default:
+			break;
+		}
+	} else {
+		switch (c) {
+		case 'E':
+			val =3D server->v250.echo;
+			break;
+
+		case 'Q':
+			val =3D server->v250.quiet;
+			break;
+
+		case 'V':
+			val =3D server->v250.is_v1;
+			break;
+
+		case 'X':
+			val =3D server->v250.res_format;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	return val;
+}
+
+static void at_template_cb(GAtServerRequestType type,
+					GAtResult *result, gpointer user_data,
+					const char *prefix,
+					int min, int max, int deftval,
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
+		set_v250_value(server, prefix, val);
+		res =3D G_AT_SERVER_RESULT_OK;
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		val =3D get_v250_value(server, prefix);
+		sprintf(buf, "%s: %d", prefix, val);
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
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		set_v250_value(server, prefix, deftval);
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
+static void at_e_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "E", 0, 1, 1, cb, cb_data);
+}
+
+static void at_q_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "Q", 0, 1, 0, cb, cb_data);
+}
+
+static void at_v_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "V", 0, 1, 1, cb, cb_data);
+}
+
+static void at_x_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "X", 0, 4, 4, cb, cb_data);
+}
+
+static void at_c109_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "&C", 0, 1, 1, cb, cb_data);
+}
+
+static void at_c108_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data,
+					GAtServerNotifyCallback cb,
+					gpointer cb_data)
+{
+	at_template_cb(type, result, user_data, "&D", 0, 2, 2, cb, cb_data);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1166,6 +1347,12 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
 	g_at_server_register(server, "S4", at_s4_cb, server, NULL);
 	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
+	g_at_server_register(server, "E", at_e_cb, server, NULL);
+	g_at_server_register(server, "Q", at_q_cb, server, NULL);
+	g_at_server_register(server, "V", at_v_cb, server, NULL);
+	g_at_server_register(server, "X", at_x_cb, server, NULL);
+	g_at_server_register(server, "&C", at_c109_cb, server, NULL);
+	g_at_server_register(server, "&D", at_c108_cb, server, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.6.6.1


--===============3615105111914132323==--

