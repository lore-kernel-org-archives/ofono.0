Content-Type: multipart/mixed; boundary="===============0651175293675138233=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: add v250 ATL and ATM commands
Date: Thu, 24 Mar 2011 12:02:49 +0100
Message-ID: <1300964569-6164-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0651175293675138233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 8266ead..0381723 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -94,6 +94,8 @@ struct v250_settings {
 	int res_format;			/* set by X<val> */
 	int c109;			/* set by &C<val> */
 	int c108;			/* set by &D<val> */
+	char l;				/* set by L<val> */
+	char m;				/* set by M<val> */
 };
 =

 /* AT command set that server supported */
@@ -296,6 +298,8 @@ static void v250_settings_create(struct v250_settings *=
v250)
 	v250->res_format =3D 0;
 	v250->c109 =3D 1;
 	v250->c108 =3D 0;
+	v250->l =3D 0;
+	v250->m =3D 1;
 }
 =

 static void s_template_cb(GAtServerRequestType type, GAtResult *result,
@@ -360,6 +364,18 @@ static void at_s5_cb(GAtServer *server, GAtServerReque=
stType type,
 	s_template_cb(type, result, server, &server->v250.s5, "S5", 0, 127);
 }
 =

+static void at_l_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	s_template_cb(type, result, server, &server->v250.s5, "L", 0, 3);
+}
+
+static void at_m_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
+	s_template_cb(type, result, server, &server->v250.m, "M", 0, 2);
+}
+
 static void at_template_cb(GAtServerRequestType type, GAtResult *result,
 					GAtServer *server, int *value,
 					const char *prefix,
@@ -1159,6 +1175,8 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "&D", at_c108_cb, NULL, NULL);
 	g_at_server_register(server, "Z", at_z_cb, NULL, NULL);
 	g_at_server_register(server, "&F", at_f_cb, NULL, NULL);
+	g_at_server_register(server, "L", at_l_cb, NULL, NULL);
+	g_at_server_register(server, "M", at_m_cb, NULL, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.7.1


--===============0651175293675138233==--

