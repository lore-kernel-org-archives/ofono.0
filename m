Content-Type: multipart/mixed; boundary="===============6808249717571819026=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gatserver: add AT&F command
Date: Thu, 24 Mar 2011 11:03:14 +0100
Message-ID: <1300960994-5130-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6808249717571819026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 57cc58e..8266ead 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -274,7 +274,8 @@ static gboolean get_result_value(GAtServer *server, GAt=
Result *result,
 	if (val < min || val > max)
 		return FALSE;
 =

-	*value =3D val;
+	if (value)
+		*value =3D val;
 =

 	return TRUE;
 }
@@ -464,10 +465,33 @@ static void at_c108_cb(GAtServer *server, GAtServerRe=
questType type,
 	at_template_cb(type, result, server, &server->v250.c108, "&D", 0, 2, 2);
 }
 =

-static void at_z_cb(GAtServer *server, GAtServerRequestType type,
+static void at_f_cb(GAtServer *server, GAtServerRequestType type,
 			GAtResult *result, gpointer user_data)
 {
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		if (!get_result_value(server, result, 0, 0, NULL)) {
+			g_at_server_send_final(server,
+						G_AT_SERVER_RESULT_ERROR);
+			return;
+		}
+		/* intentional fallback here */
 =

+	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
+		/* default behavior on AT&F same as ATZ */
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
+static void at_z_cb(GAtServer *server, GAtServerRequestType type,
+			GAtResult *result, gpointer user_data)
+{
 	switch (type) {
 	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
 		v250_settings_create(&server->v250);
@@ -1134,6 +1158,7 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "&C", at_c109_cb, NULL, NULL);
 	g_at_server_register(server, "&D", at_c108_cb, NULL, NULL);
 	g_at_server_register(server, "Z", at_z_cb, NULL, NULL);
+	g_at_server_register(server, "&F", at_f_cb, NULL, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.7.1


--===============6808249717571819026==--

