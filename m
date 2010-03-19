Content-Type: multipart/mixed; boundary="===============1110313523624269623=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/10] Add utilities to send server response
Date: Fri, 19 Mar 2010 17:44:48 +0800
Message-ID: <1268991888-17279-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-10-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1110313523624269623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The server response could be either result code or information text.

Result code types: final, intermediate and unsolicited.
Information text: one or multiple lines of text.
---
 gatchat/gatserver.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatserver.h |   17 +++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b4f7563..1072230 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -205,6 +205,48 @@ static inline void g_at_server_send_final(GAtServer *s=
erver,
 	server->last_result =3D result;
 }
 =

+void g_at_server_send_ext_final(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+}
+
+void g_at_server_send_intermediate(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+}
+
+void g_at_server_send_unsolicited(GAtServer *server, const char *result)
+{
+	send_result_common(server, result);
+}
+
+void g_at_server_send_info_text(GAtServer *server, GSList *text)
+{
+	char buf[MAX_TEXT_SIZE];
+	char t =3D server->v250.s3;
+	char r =3D server->v250.s4;
+	unsigned int len;
+	GSList *l =3D text;
+	char *line;
+
+	if (!text)
+		return;
+
+	while (l) {
+		line =3D l->data;
+		if (!line)
+			return;
+
+		len =3D snprintf(buf, sizeof(buf), "%c%c%s", t, r, line);
+		send_common(server, buf, MIN(len, sizeof(buf)-1));
+
+		l =3D l->next;
+	}
+
+	len =3D snprintf(buf, sizeof(buf), "%c%c", t, r);
+	send_common(server, buf, len);
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index 6fb78bd..fc82e3b 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -88,6 +88,23 @@ gboolean g_at_server_register(GAtServer *server, char *p=
refix,
 					GDestroyNotify destroy_notify);
 gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
 =

+/* Send an extended final result code. E.g. +CME ERROR: SIM failure.
+ * In this case, callback should return G_AT_SERVER_RESULT_EXT_ERROR as
+ * result so that server will not send final result code again.
+ */
+void g_at_server_send_ext_final(GAtServer *server, const char *result);
+
+/* Send an intermediate result code to report the progress. E.g. CONNECT */
+void g_at_server_send_intermediate(GAtServer *server, const char *result);
+
+/* Send an unsolicited result code. E.g. RING */
+void g_at_server_send_unsolicited(GAtServer *server, const char *result);
+
+/* Send an information text. The text could contain multiple lines. Each
+ * line, including line terminators, should not exceed 2048 characters.
+ */
+void g_at_server_send_info_text(GAtServer *server, GSList *text);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.6.1


--===============1110313523624269623==--

