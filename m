Content-Type: multipart/mixed; boundary="===============0113578502114744138=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/6] Add register ATQ basic command callback
Date: Wed, 17 Mar 2010 22:44:09 +0800
Message-ID: <1268837051-5032-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268837051-5032-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0113578502114744138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 6427ed3..e9b1cf4 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -377,6 +377,56 @@ done:
 	return res;
 }
 =

+static GAtServerResult at_q_cb(GAtServerRequestType type, GAtResult *resul=
t,
+					gpointer user_data)
+{
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtServer *server =3D user_data;
+	GSList *text =3D NULL;
+	char buf[20];
+
+	if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SET) {
+		GAtResultIter iter;
+		int val;
+
+		g_at_result_iter_init(&iter, result);
+
+		if (!g_at_result_iter_next(&iter, "Q"))
+			goto done;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto done;
+
+		if (val < 0 || val > 1)
+			goto done;
+
+		server->v250.quiet =3D val;
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_QUERY) {
+		sprintf(buf, "Q: %u", server->v250.quiet);
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		sprintf(buf, "Q: (0-1)");
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY) {
+		server->v250.quiet =3D 0;
+		res =3D G_AT_SERVER_RESULT_OK;
+	}
+
+	if (text)
+		g_slist_free(text);
+
+done:
+	return res;
+}
+
 static inline gboolean is_extended_command_prefix(const char c)
 {
 	switch (c) {
@@ -1038,6 +1088,7 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
 	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
 	g_at_server_register(server, "E", at_e_cb, server, NULL);
+	g_at_server_register(server, "Q", at_q_cb, server, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.6.6.1


--===============0113578502114744138==--

