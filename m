Content-Type: multipart/mixed; boundary="===============2786432592601067983=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/11] Add utilities to send server response
Date: Wed, 17 Mar 2010 22:30:41 +0800
Message-ID: <1268836241-4834-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-10-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2786432592601067983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The server response could be either result code or information text.

Result code types: final, intermediate and unsolicited.
Information text: one or multiple lines of text.
---
 gatchat/gatserver.c |   37 +++++++++++++++++++++++++++++++++++++
 gatchat/gatserver.h |   11 +++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 7ac6d34..06ea912 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -196,6 +196,43 @@ static void g_at_server_send_final(GAtServer *server, =
GAtServerResult result)
 	send_result_common(server, buf);
 }
 =

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
+	while(l) {
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
index 6fb78bd..19d7cb5 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -88,6 +88,17 @@ gboolean g_at_server_register(GAtServer *server, char *p=
refix,
 					GDestroyNotify destroy_notify);
 gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
 =

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


--===============2786432592601067983==--

