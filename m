Content-Type: multipart/mixed; boundary="===============4618101496746215045=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 7/7] Add test implementation for CPBS
Date: Wed, 31 Mar 2010 17:50:40 +0800
Message-ID: <1270029040-21077-7-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1270029040-21077-6-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4618101496746215045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 916198b..f170d88 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -361,6 +361,29 @@ static void cmgl_cb(GAtServerRequestType type, GAtResu=
lt *cmd, gpointer user)
 	}
 }
 =

+static void cpbs_cb(GAtServerRequestType type, GAtResult *cmd, gpointer us=
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
+		sprintf(buf, "+CPBS: (\"FD\",\"SM\",\"SN\")");
+		g_at_server_send_info(server, buf, TRUE);
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
@@ -377,6 +400,7 @@ static void add_handler(GAtServer *server)
 	g_at_server_register(server, "+CNMI", cnmi_cb, server, NULL);
 	g_at_server_register(server, "+CSCS", cscs_cb, server, NULL);
 	g_at_server_register(server, "+CMGL", cmgl_cb, server, NULL);
+	g_at_server_register(server, "+CPBS", cpbs_cb, server, NULL);
 }
 =

 static void server_destroy(gpointer user)
-- =

1.6.6.1


--===============4618101496746215045==--

