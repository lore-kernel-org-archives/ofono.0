Content-Type: multipart/mixed; boundary="===============8198808855254480523=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: add ATZ command
Date: Wed, 23 Mar 2011 17:31:24 +0100
Message-ID: <1300897884-27073-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8198808855254480523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   53 +++++++++++++++++++++++++++++++++--------------=
---
 1 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 4a211ad..57cc58e 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -279,6 +279,24 @@ static gboolean get_result_value(GAtServer *server, GA=
tResult *result,
 	return TRUE;
 }
 =

+static void v250_settings_create(struct v250_settings *v250)
+{
+	v250->s0 =3D 0;
+	v250->s3 =3D '\r';
+	v250->s4 =3D '\n';
+	v250->s5 =3D '\b';
+	v250->s6 =3D 2;
+	v250->s7 =3D 50;
+	v250->s8 =3D 2;
+	v250->s10 =3D 2;
+	v250->echo =3D TRUE;
+	v250->quiet =3D FALSE;
+	v250->is_v1 =3D TRUE;
+	v250->res_format =3D 0;
+	v250->c109 =3D 1;
+	v250->c108 =3D 0;
+}
+
 static void s_template_cb(GAtServerRequestType type, GAtResult *result,
 					GAtServer *server, char *sreg,
 					const char *prefix, int min, int max)
@@ -446,6 +464,22 @@ static void at_c108_cb(GAtServer *server, GAtServerReq=
uestType type,
 	at_template_cb(type, result, server, &server->v250.c108, "&D", 0, 2, 2);
 }
 =

+static void at_z_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		v250_settings_create(&server->v250);
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
+		break;
+
+	default:
+		g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+		break;
+	}
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1073,24 +1107,6 @@ static void server_resume(GAtServer *server)
 	g_at_io_set_read_handler(server->io, new_bytes, server);
 }
 =

-static void v250_settings_create(struct v250_settings *v250)
-{
-	v250->s0 =3D 0;
-	v250->s3 =3D '\r';
-	v250->s4 =3D '\n';
-	v250->s5 =3D '\b';
-	v250->s6 =3D 2;
-	v250->s7 =3D 50;
-	v250->s8 =3D 2;
-	v250->s10 =3D 2;
-	v250->echo =3D TRUE;
-	v250->quiet =3D FALSE;
-	v250->is_v1 =3D TRUE;
-	v250->res_format =3D 0;
-	v250->c109 =3D 1;
-	v250->c108 =3D 0;
-}
-
 static void at_notify_node_destroy(gpointer data)
 {
 	struct at_command *node =3D data;
@@ -1117,6 +1133,7 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "S10", at_s10_cb, NULL, NULL);
 	g_at_server_register(server, "&C", at_c109_cb, NULL, NULL);
 	g_at_server_register(server, "&D", at_c108_cb, NULL, NULL);
+	g_at_server_register(server, "Z", at_z_cb, NULL, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.7.1


--===============8198808855254480523==--

