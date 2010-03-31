Content-Type: multipart/mixed; boundary="===============0184214614857181753=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/7] Add implementation for ATE and other basic command
Date: Wed, 31 Mar 2010 17:50:36 +0800
Message-ID: <1270029040-21077-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1270029040-21077-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0184214614857181753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 158 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 7d5c3c7..5206a12 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -260,10 +260,10 @@ static gboolean get_result_value(GAtServer *server, G=
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

@@ -376,6 +376,154 @@ static void at_s5_cb(GAtServerRequestType type, GAtRe=
sult *result,
 	s_template_cb(type, result, user_data, "S5", 0, 127);
 }
 =

+static void set_v250_value(GAtServer *server, const char *prefix, int val)
+{
+	if (prefix[0] =3D=3D '&') {
+		switch (prefix[1]) {
+		case 'C':
+			server->v250.c109 =3D val;
+			break;
+		case 'D':
+			server->v250.c108 =3D val;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (prefix[0]) {
+		case 'E':
+			server->v250.echo =3D val;
+			break;
+		case 'Q':
+			server->v250.quiet =3D val;
+			break;
+		case 'V':
+			server->v250.is_v1 =3D val;
+			break;
+		case 'X':
+			server->v250.res_format =3D val;
+			break;
+		}
+	}
+}
+
+static int get_v250_value(GAtServer *server, const char *prefix)
+{
+	int val =3D 0;
+
+	if (prefix[0] =3D=3D '&') {
+		switch (prefix[1]) {
+		case 'C':
+			val =3D server->v250.c109;
+			break;
+		case 'D':
+			val =3D server->v250.c108;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (prefix[0]) {
+		case 'E':
+			val =3D server->v250.echo;
+			break;
+		case 'Q':
+			val =3D server->v250.quiet;
+			break;
+		case 'V':
+			val =3D server->v250.is_v1;
+			break;
+		case 'X':
+			val =3D server->v250.res_format;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return val;
+}
+
+static void at_template_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data, const char *prefix,
+					int min, int max, int deftval)
+{
+	GAtServer *server =3D user_data;
+	char buf[20];
+	int val;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (!get_result_value(server, result, prefix, min, max, &val)) {
+			g_at_server_send_final(server,
+						G_AT_SERVER_RESULT_ERROR);
+			return;
+		}
+
+		set_v250_value(server, prefix, val);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		val =3D get_v250_value(server, prefix);
+		sprintf(buf, "%s: %d", prefix, val);
+		g_at_server_send_info(server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		sprintf(buf, "%s: (%d-%d)", prefix, min, max);
+		g_at_server_send_info(server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		set_v250_value(server, prefix, deftval);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void at_e_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "E", 0, 1, 1);
+}
+
+static void at_q_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "Q", 0, 1, 0);
+}
+
+static void at_v_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "V", 0, 1, 1);
+}
+
+static void at_x_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "X", 0, 4, 4);
+}
+
+static void at_c109_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "&C", 0, 1, 1);
+}
+
+static void at_c108_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	at_template_cb(type, result, user_data, "&D", 0, 2, 2);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1076,6 +1224,12 @@ static void basic_command_register(GAtServer *server)
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


--===============0184214614857181753==--

