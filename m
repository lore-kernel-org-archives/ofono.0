Content-Type: multipart/mixed; boundary="===============5210863094617961060=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: Add ATS6 command handler.
Date: Fri, 14 Jan 2011 12:28:43 +0100
Message-ID: <1295004523-12485-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5210863094617961060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 11eaac6..906cf26 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -83,6 +83,7 @@ struct v250_settings {
 	char s3;			/* set by S3=3D<val> */
 	char s4;			/* set by S4=3D<val> */
 	char s5;			/* set by S5=3D<val> */
+	int s6;				/* set by S6=3D<val> */
 	gboolean echo;			/* set by E<val> */
 	gboolean quiet;			/* set by Q<val> */
 	gboolean is_v1;			/* set by V<val>, v0 or v1 */
@@ -426,6 +427,14 @@ static void at_c108_cb(GAtServerRequestType type, GAtR=
esult *result,
 	at_template_cb(type, result, server, &server->v250.c108, "&D", 0, 2, 2);
 }
 =

+static void at_s6_cb(GAtServerRequestType type, GAtResult *result,
+			gpointer user_data)
+{
+	GAtServer *server =3D user_data;
+	at_template_cb(type, result, server, &server->v250.s6, "S6", 0, 255, 2);
+
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1031,6 +1040,7 @@ static void v250_settings_create(struct v250_settings=
 *v250)
 	v250->s3 =3D '\r';
 	v250->s4 =3D '\n';
 	v250->s5 =3D '\b';
+	v250->s6 =3D 2;
 	v250->echo =3D TRUE;
 	v250->quiet =3D FALSE;
 	v250->is_v1 =3D TRUE;
@@ -1054,6 +1064,7 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
 	g_at_server_register(server, "S4", at_s4_cb, server, NULL);
 	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
+	g_at_server_register(server, "S6", at_s6_cb, server, NULL);
 	g_at_server_register(server, "E", at_e_cb, server, NULL);
 	g_at_server_register(server, "Q", at_q_cb, server, NULL);
 	g_at_server_register(server, "V", at_v_cb, server, NULL);
-- =

1.7.1


--===============5210863094617961060==--

