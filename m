Content-Type: multipart/mixed; boundary="===============5944065644087161448=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: Add various ATSx handlers
Date: Tue, 22 Feb 2011 15:54:45 +0100
Message-ID: <1298386485-5066-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5944065644087161448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b092a68..cd86781 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -80,10 +80,14 @@ static const char *server_result_to_string(GAtServerRes=
ult result)
 =

 /* Basic command setting for V.250 */
 struct v250_settings {
+	char s0;			/* set by S0=3D<val> */
 	char s3;			/* set by S3=3D<val> */
 	char s4;			/* set by S4=3D<val> */
 	char s5;			/* set by S5=3D<val> */
 	int s6;				/* set by S6=3D<val> */
+	int s7;				/* set by S7=3D<val> */
+	int s8;				/* set by S8=3D<val> */
+	int s10;			/* set by S10=3D<val> */
 	gboolean echo;			/* set by E<val> */
 	gboolean quiet;			/* set by Q<val> */
 	gboolean is_v1;			/* set by V<val>, v0 or v1 */
@@ -319,6 +323,12 @@ static void s_template_cb(GAtServerRequestType type, G=
AtResult *result,
 	}
 }
 =

+static void at_s0_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	s_template_cb(type, result, server, &server->v250.s0, "S0", 0, 7);
+}
+
 static void at_s3_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -412,6 +422,24 @@ static void at_s6_cb(GAtServer *server, GAtServerReque=
stType type,
 	at_template_cb(type, result, server, &server->v250.s6, "S6", 0, 1, 1);
 }
 =

+static void at_s7_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	at_template_cb(type, result, server, &server->v250.s7, "S7", 1, 255, 50);
+}
+
+static void at_s8_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	at_template_cb(type, result, server, &server->v250.s8, "S8", 1, 255, 2);
+}
+
+static void at_s10_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	at_template_cb(type, result, server, &server->v250.s10, "S10", 1, 254, 2);
+}
+
 static void at_c109_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
@@ -1044,10 +1072,14 @@ static void server_wakeup_writer(GAtServer *server)
 =

 static void v250_settings_create(struct v250_settings *v250)
 {
+	v250->s0 =3D 0;
 	v250->s3 =3D '\r';
 	v250->s4 =3D '\n';
 	v250->s5 =3D '\b';
 	v250->s6 =3D 2;
+	v250->s7 =3D 50;
+	v250->s8 =3D 2;
+	v250->s10 =3D 2;
 	v250->echo =3D TRUE;
 	v250->quiet =3D FALSE;
 	v250->is_v1 =3D TRUE;
@@ -1068,6 +1100,7 @@ static void at_notify_node_destroy(gpointer data)
 =

 static void basic_command_register(GAtServer *server)
 {
+	g_at_server_register(server, "S0", at_s0_cb, NULL, NULL);
 	g_at_server_register(server, "S3", at_s3_cb, NULL, NULL);
 	g_at_server_register(server, "S4", at_s4_cb, NULL, NULL);
 	g_at_server_register(server, "S5", at_s5_cb, NULL, NULL);
@@ -1076,6 +1109,9 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "V", at_v_cb, NULL, NULL);
 	g_at_server_register(server, "X", at_x_cb, NULL, NULL);
 	g_at_server_register(server, "S6", at_s6_cb, NULL, NULL);
+	g_at_server_register(server, "S7", at_s7_cb, NULL, NULL);
+	g_at_server_register(server, "S8", at_s8_cb, NULL, NULL);
+	g_at_server_register(server, "S10", at_s10_cb, NULL, NULL);
 	g_at_server_register(server, "&C", at_c109_cb, NULL, NULL);
 	g_at_server_register(server, "&D", at_c108_cb, NULL, NULL);
 }
-- =

1.7.1


--===============5944065644087161448==--

