Content-Type: multipart/mixed; boundary="===============1217598450103921709=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: add tone and pulse dialing AT commands
Date: Mon, 28 Mar 2011 12:23:17 +0200
Message-ID: <1301307797-5905-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1217598450103921709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 35f126f..3a996cb 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -96,6 +96,7 @@ struct v250_settings {
 	int c108;			/* set by &D<val> */
 	char l;				/* set by L<val> */
 	char m;				/* set by M<val> */
+	char dial_mode;			/* set by P or T */
 };
 =

 /* AT command set that server supported */
@@ -300,6 +301,7 @@ static void v250_settings_create(struct v250_settings *=
v250)
 	v250->c108 =3D 0;
 	v250->l =3D 0;
 	v250->m =3D 1;
+	v250->dial_mode =3D 'T';
 }
 =

 static void s_template_cb(GAtServerRequestType type, GAtResult *result,
@@ -481,6 +483,40 @@ static void at_c108_cb(GAtServer *server, GAtServerReq=
uestType type,
 	at_template_cb(type, result, server, &server->v250.c108, "&D", 0, 2, 2);
 }
 =

+/* According to ITU V.250 6.3.2 and 6.3.3: "Implementation of this command
+ * is mandatory; however, if DTMF or pulse dialling is not implemented,
+ * this command will have no effect"
+ */
+static void at_t_cb(GAtServer *server, GAtServerRequestType type,
+					GAtResult *result, gpointer user_data)
+{
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		server->v250.dial_mode =3D 'T';
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
+static void at_p_cb(GAtServer *server, GAtServerRequestType type,
+					GAtResult *result, gpointer user_data)
+{
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		server->v250.dial_mode =3D 'P';
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static void at_f_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -1177,6 +1213,8 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "&F", at_f_cb, NULL, NULL);
 	g_at_server_register(server, "L", at_l_cb, NULL, NULL);
 	g_at_server_register(server, "M", at_m_cb, NULL, NULL);
+	g_at_server_register(server, "T", at_t_cb, NULL, NULL);
+	g_at_server_register(server, "P", at_p_cb, NULL, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.7.1


--===============1217598450103921709==--

