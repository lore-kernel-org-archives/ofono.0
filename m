Content-Type: multipart/mixed; boundary="===============8322605611029885775=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/6] Add register ATV basic command callback
Date: Wed, 17 Mar 2010 22:44:10 +0800
Message-ID: <1268837051-5032-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268837051-5032-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8322605611029885775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index e9b1cf4..5a234d6 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -427,6 +427,56 @@ done:
 	return res;
 }
 =

+static GAtServerResult at_v_cb(GAtServerRequestType type, GAtResult *resul=
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
+		if (!g_at_result_iter_next(&iter, "V"))
+			goto done;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto done;
+
+		if (val < 0 || val > 1)
+			goto done;
+
+		server->v250.is_v1 =3D val;
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_QUERY) {
+		sprintf(buf, "V: %u", server->v250.is_v1);
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_SUPPORT) {
+		sprintf(buf, "V: (0-1)");
+		text =3D g_slist_append(NULL, buf);
+		g_at_server_send_info_text(server, text);
+
+		res =3D G_AT_SERVER_RESULT_OK;
+	} else if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY) {
+		server->v250.is_v1 =3D 1;
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
@@ -1089,6 +1139,7 @@ static void basic_command_register(GAtServer *server)
 	g_at_server_register(server, "S5", at_s5_cb, server, NULL);
 	g_at_server_register(server, "E", at_e_cb, server, NULL);
 	g_at_server_register(server, "Q", at_q_cb, server, NULL);
+	g_at_server_register(server, "V", at_v_cb, server, NULL);
 }
 =

 GAtServer *g_at_server_new(GIOChannel *io)
-- =

1.6.6.1


--===============8322605611029885775==--

