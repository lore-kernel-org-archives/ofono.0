Content-Type: multipart/mixed; boundary="===============2895882579315317823=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/11] Refactor g_at_server_send_final
Date: Wed, 17 Mar 2010 22:30:40 +0800
Message-ID: <1268836241-4834-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2895882579315317823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b0138d6..7ac6d34 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -33,6 +33,8 @@
 #include "gatserver.h"
 =

 #define BUF_SIZE 4096
+/* <cr><lf> + the max length of information text + <cr><lf> */
+#define MAX_TEXT_SIZE 2048+4
 /* #define WRITE_SCHEDULER_DEBUG 1 */
 =

 enum ParserState {
@@ -156,35 +158,44 @@ static void send_common(GAtServer *server, const char=
 *buf, unsigned int len)
 	g_at_server_wakeup_writer(server);
 }
 =

-static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+static void send_result_common(GAtServer *server, const char *result)
 {
-	struct v250_settings v250 =3D server->v250;
-	const char *result_str =3D server_result_to_string(result);
-	char buf[1024];
-	char t =3D v250.s3;
-	char r =3D v250.s4;
+	char buf[MAX_TEXT_SIZE];
+	char t =3D server->v250.s3;
+	char r =3D server->v250.s4;
 	unsigned int len;
 =

-	/* Do not emit error if extended error has already been emitted */
-	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
-		return;
-
-	if (v250.quiet)
+	if (server->v250.quiet)
 		return;
 =

-	if (result_str =3D=3D NULL)
+	if (result =3D=3D NULL)
 		return;
 =

-	if (v250.is_v1)
-		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result_str,
+	if (server->v250.is_v1)
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s%c%c", t, r, result,
 				t, r);
 	else
-		len =3D snprintf(buf, sizeof(buf), "%u%c", (unsigned int) result,
-				t);
+		len =3D snprintf(buf, sizeof(buf), "%s%c", result, t);
 =

 	send_common(server, buf, MIN(len, sizeof(buf)-1));
 }
 =

+static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
+{
+	char buf[1024];
+
+	/* Do not emit error if extended error has already been emitted */
+	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
+		return;
+
+	if (server->v250.is_v1)
+		sprintf(buf, "%s", server_result_to_string(result));
+	else
+		sprintf(buf, "%u", (unsigned int)result);
+
+	send_result_common(server, buf);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
-- =

1.6.6.1


--===============2895882579315317823==--

