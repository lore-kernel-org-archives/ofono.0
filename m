Content-Type: multipart/mixed; boundary="===============6989200461118454944=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/16] emulator: Add handler for dial command
Date: Thu, 13 May 2010 18:02:33 +0800
Message-ID: <1273744959-3711-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273744959-3711-10-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6989200461118454944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It's used to either dial voicecall or GPRS dial up.
---
 src/emulator.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h    |    8 ++++++
 2 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index e66e9ca..1063b0c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -115,6 +115,80 @@ static const char *emulator_build_path(const struct of=
ono_emulator *oe,
 	return path;
 }
 =

+static void dial_common_cb(GAtServerResult res, void *user_data)
+{
+	struct emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+
+	g_at_server_send_final(server, res);
+
+	e->status =3D OFONO_EMULATOR_STATUS_IDLE;
+
+	notify_status_watches(e, NULL);
+}
+
+static gboolean dial_call(struct emulator *e, const char *dial_str)
+{
+	struct ofono_emulator_dial_req *req =3D NULL;
+
+	DBG("dial call %s", dial_str);
+
+	req =3D g_try_new0(struct ofono_emulator_dial_req, 1);
+	if (!req)
+		return FALSE;
+
+	req->dial_str =3D dial_str;
+	req->cb =3D dial_common_cb;
+	req->data =3D e;
+
+	if (dial_str[0] =3D=3D '*' || dial_str[0] =3D=3D '#') {
+		/* Supplementary service request */
+		g_at_server_send_intermediate(e->server, "CONNECT");
+
+		e->status =3D OFONO_EMULATOR_STATUS_GPRS_CONNECT;
+
+		notify_status_watches(e, req);
+	} else {
+		e->status =3D OFONO_EMULATOR_STATUS_DIAL_VOICECALL;
+
+		notify_status_watches(e, req);
+	}
+
+	g_free(req);
+
+	return TRUE;
+}
+
+static void dial_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	GAtResultIter iter;
+	const char *dial_str;
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto error;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto error;
+
+	if (!dial_call(e, dial_str))
+		goto error;
+
+	return;
+
+error:
+	g_at_server_send_final(server, res);
+}
+
 static void emulator_remove(void *data)
 {
 	struct emulator *e =3D data;
@@ -128,6 +202,8 @@ static void emulator_remove(void *data)
 	oe->emulator_list =3D g_slist_remove(oe->emulator_list, e);
 	emulator_release_id(oe, e->id);
 =

+	g_at_server_unregister(server, "D");
+
 	g_at_server_shutdown(server);
 	g_at_server_unref(server);
 	server =3D NULL;
@@ -163,6 +239,8 @@ static struct emulator *emulator_create(struct ofono_em=
ulator *oe,
 	e->server =3D server;
 	e->status =3D OFONO_EMULATOR_STATUS_CREATE;
 =

+	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+
 	oe->emulator_list =3D g_slist_prepend(oe->emulator_list, e);
 =

 	notify_status_watches(e, NULL);
diff --git a/src/ofono.h b/src/ofono.h
index 047260c..e1d272e 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -287,6 +287,14 @@ enum ofono_emulator_type {
 	OFONO_EMULATOR_TYPE_SPP,
 };
 =

+typedef void (*ofono_emulator_cb_t)(enum _GAtServerResult res, void *data);
+
+struct ofono_emulator_dial_req {
+	const char *dial_str;
+	ofono_emulator_cb_t cb;
+	void *data;
+};
+
 typedef void (*ofono_emulator_status_notify_cb_t)(struct emulator *e,
 					enum ofono_emulator_status status,
 					void *data, void *user_data);
-- =

1.6.3.3


--===============6989200461118454944==--

