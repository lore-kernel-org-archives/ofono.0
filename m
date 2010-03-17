Content-Type: multipart/mixed; boundary="===============4867421278648132787=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/6] Add register S5 basic command callback
Date: Wed, 17 Mar 2010 22:44:07 +0800
Message-ID: <1268837051-5032-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268837051-5032-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4867421278648132787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 80e6d45..1a8ac58 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -280,6 +280,53 @@ done:
 	return res;
 }
 =

+static GAtServerResult at_s5_cb(GAtServerRequestType type, GAtResult *resu=
lt,
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
+		if (!g_at_result_iter_next(&iter, "S5=3D"))
+			goto done;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto done;
+
+		if (val < 0 || val > 127)
+			goto done;
+
+		server->v250.s5 =3D val;
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_QUERY) {
+		sprintf(buf, "%03d", server->v250.s5);
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		sprintf(buf, "S5: (0-127)");
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
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
@@ -939,6 +986,7 @@ static void at_notify_node_destroy(gpointer data)
 static void basic_command_register(GAtServer *server)
 {
 	g_at_server_register(server, "S3", at_s3_cb, server, NULL);
+	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.6.6.1


--===============4867421278648132787==--

