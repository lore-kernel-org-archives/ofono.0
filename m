Content-Type: multipart/mixed; boundary="===============1185338030244282445=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 6/7] Add test implementation to support SMS
Date: Wed, 31 Mar 2010 17:50:39 +0800
Message-ID: <1270029040-21077-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1270029040-21077-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1185338030244282445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |  177 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 425e353..916198b 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -192,6 +192,175 @@ error:
 	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
 }
 =

+static void cpin_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_info(server, "+CPIN: READY", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cimi_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		g_at_server_send_info(server, "246813579", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void csms_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_info(server, "+CSMS: 0,1,1,1", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_info(server, "+CSMS: (0)", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cmgf_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_info(server, "+CMGF: 0", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_info(server, "+CMGF: (0,1)", TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cpms_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+	char buf[2048];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		sprintf(buf, "+CPMS: (\"SM\",\"ME\"),(\"SM\",\"ME\"),(\"SM\")");
+		g_at_server_send_info(server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cnmi_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+	char buf[2048];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		sprintf(buf, "+CNMI: (0,1,2,3),(0,1),(0,1,2),(0),(0,1)");
+		g_at_server_send_info(server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cscs_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+	char buf[2048];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		sprintf(buf, "+CSCS: \"GSM\",\"IRA\",\"UCS2\"");
+		g_at_server_send_info(server, buf, TRUE);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void cmgl_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
er)
+{
+	GAtServer *server =3D user;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void add_handler(GAtServer *server)
 {
 	g_at_server_set_debug(server, server_debug, "Server");
@@ -200,6 +369,14 @@ static void add_handler(GAtServer *server)
 	g_at_server_register(server, "+CGMR", cgmr_cb, server, NULL);
 	g_at_server_register(server, "+CGSN", cgsn_cb, server, NULL);
 	g_at_server_register(server, "+CFUN", cfun_cb, server, NULL);
+	g_at_server_register(server, "+CPIN", cpin_cb, server, NULL);
+	g_at_server_register(server, "+CIMI", cimi_cb, server, NULL);
+	g_at_server_register(server, "+CSMS", csms_cb, server, NULL);
+	g_at_server_register(server, "+CMGF", cmgf_cb, server, NULL);
+	g_at_server_register(server, "+CPMS", cpms_cb, server, NULL);
+	g_at_server_register(server, "+CNMI", cnmi_cb, server, NULL);
+	g_at_server_register(server, "+CSCS", cscs_cb, server, NULL);
+	g_at_server_register(server, "+CMGL", cmgl_cb, server, NULL);
 }
 =

 static void server_destroy(gpointer user)
-- =

1.6.6.1


--===============1185338030244282445==--

