Content-Type: multipart/mixed; boundary="===============5594950505106883536=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH 1/1] gatserver: Add send raw data function
Date: Fri, 11 Feb 2011 17:03:03 +0100
Message-ID: <1297440183-4384-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5594950505106883536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   14 ++++++++++++++
 gatchat/gatserver.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 25b7ba4..f2ee34d 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -252,6 +252,20 @@ void g_at_server_send_info(GAtServer *server, const ch=
ar *line, gboolean last)
 	send_common(server, buf, len);
 }
 =

+void g_at_server_send_data(GAtServer *server, const char *format, ...)
+{
+	char buf[MAX_TEXT_SIZE + 1];
+	unsigned int len;
+
+	va_list ap;
+
+	va_start(ap, format);
+	len =3D vsnprintf(buf, MAX_TEXT_SIZE, format, ap);
+	va_end(ap);
+
+	send_common(server, buf, len);
+}
+
 static gboolean get_result_value(GAtServer *server, GAtResult *result,
 						const char *command,
 						int min, int max, int *value)
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index f0c19da..911f20d 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -112,6 +112,7 @@ void g_at_server_send_unsolicited(GAtServer *server, co=
nst char *result);
  * responses.
  */
 void g_at_server_send_info(GAtServer *server, const char *line, gboolean l=
ast);
+void g_at_server_send_data(GAtServer *server, const char *format, ...);
 =

 #ifdef __cplusplus
 }
-- =

1.7.1


--===============5594950505106883536==--

