Content-Type: multipart/mixed; boundary="===============8883310285695261724=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Wed, 07 Jul 2010 18:01:48 +0800
Message-ID: <1278496912-13777-12-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-11-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8883310285695261724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Register serveral AT command handlers for DUN server.
---
 include/emulator.h |    2 +
 src/emulator.c     |  377 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 379 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index b8fb0d5..487f347 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -38,6 +38,8 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_DUN_CONNECTING,
 	OFONO_EMULATOR_STATUS_DUN_CONNECTED,
 	OFONO_EMULATOR_STATUS_DUN_DISCONNECTED,
+	OFONO_EMULATOR_STATUS_SET_CGATT,
+	OFONO_EMULATOR_STATUS_SET_CGDCONT,
 };
 =

 enum ofono_emulator_type {
diff --git a/src/emulator.c b/src/emulator.c
index dda74a1..546a48b 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -57,6 +57,17 @@ struct ofono_emulator {
 	enum ofono_emulator_status status;
 	struct ofono_watchlist *status_watches;
 	struct context_info *info;
+
+	int modem_mode;
+	int modem_creg;
+	int modem_cgreg;
+	int modem_cops;
+	int modem_attached;
+	int modem_context;
+	int netreg_status;
+	int netreg_lac;
+	int netreg_ci;
+	int gprs_status;
 };
 =

 static GSList *emulator_list;
@@ -179,6 +190,33 @@ static void notify_status_watches(struct ofono_emulato=
r *e, void *data)
 	}
 }
 =

+static struct ofono_emulator_req *ofono_emulator_req_new(void *cb,
+							void *cb_data)
+{
+	struct ofono_emulator_req *req;
+
+	req =3D g_try_new0(struct ofono_emulator_req, 1);
+	if (!req)
+		return req;
+
+	req->cb =3D cb;
+	req->cb_data =3D cb_data;
+
+	return req;
+}
+
+static void generic_cb(GAtServerResult res, void *user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+
+	g_at_server_send_final(server, res);
+
+	e->status =3D OFONO_EMULATOR_STATUS_IDLE;
+
+	notify_status_watches(e, NULL);
+}
+
 static void ppp_connect_cb(GAtServerResult res, void *user_data)
 {
 	struct ofono_emulator *e =3D user_data;
@@ -383,6 +421,338 @@ error:
 	g_at_server_send_final(server, res);
 }
 =

+static gboolean send_ok(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+
+	return FALSE;
+}
+
+static void cfun_cb(GAtServerRequestType type, GAtResult *cmd,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	char buf[50];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_info(e, "+CFUN: (0-1)", TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CFUN: %d", e->modem_mode);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int mode;
+
+		g_at_result_iter_init(&iter, cmd);
+		g_at_result_iter_next(&iter, "+CFUN=3D");
+
+		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+			goto error;
+
+		if (mode !=3D 0 && mode !=3D 1)
+			goto error;
+
+		DBG("set CFUN to %d", mode);
+
+		e->modem_mode =3D mode;
+		g_timeout_add_seconds(1, send_ok, e);
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void cpin_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+		/* not implement yet*/
+	default:
+		goto error;
+	};
+
+	return;
+
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void creg_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	char buf[256];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CREG: %d, %x, %x, %x",
+					e->modem_creg, e->netreg_status,
+					e->netreg_lac, e->netreg_ci);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int mode;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CREG=3D");
+
+		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+			goto error;
+
+		if (mode < 0 || mode > 2)
+			goto error;
+
+		DBG("set netreg status %d", mode);
+
+		e->modem_creg =3D mode;
+
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void cgreg_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	char buf[256];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CGREG: %d, %d", e->modem_cgreg,
+					e->gprs_status);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int mode;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CGREG=3D");
+
+		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+			goto error;
+
+		if (mode < 0 || mode > 2)
+			goto error;
+
+		DBG("set GPRS cgreg status %d", mode);
+
+		e->modem_cgreg =3D mode;
+
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void cops_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	char buf[50];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+COPS: %d", e->modem_cops);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int mode;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+COPS=3D");
+
+		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
+			goto error;
+
+		if (mode < 0 || mode > 2)
+			goto error;
+
+		DBG("set GPRS cops status %d", mode);
+
+		e->modem_cops =3D mode;
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void cgatt_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct ofono_emulator_req *req;
+	char buf[12];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CGATT: %d", e->modem_attached);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int attached;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CGATT=3D");
+
+		if (g_at_result_iter_next_number(&iter, &attached) =3D=3D FALSE)
+			goto error;
+
+		if (attached !=3D 0 && attached !=3D 1)
+			goto error;
+
+		DBG("set GPRS attach status %d", attached);
+
+		req =3D ofono_emulator_req_new(generic_cb, e);
+		if (!req)
+			goto error;
+
+		req->data =3D &attached;
+
+		e->status =3D OFONO_EMULATOR_STATUS_SET_CGATT;
+
+		notify_status_watches(e, req);
+
+		e->modem_attached =3D attached;
+		g_free(req);
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
+static void cgdcont_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct ofono_emulator_req *req;
+	char buf[256];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+		snprintf(buf, sizeof(buf), "+CGDCONT: %d", e->modem_context);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		int cid;
+		const char *protocol;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CGDCONT=3D");
+
+		if (g_at_result_iter_next_number(&iter, &cid) =3D=3D FALSE)
+			goto error;
+
+		if (g_at_result_iter_next_string(&iter, &protocol) =3D=3D FALSE)
+			goto error;
+
+		DBG("set CGDCONT %d %s", cid, protocol);
+
+		req =3D ofono_emulator_req_new(generic_cb, e);
+		if (!req)
+			goto error;
+
+		e->status =3D OFONO_EMULATOR_STATUS_SET_CGDCONT;
+
+		notify_status_watches(e, req);
+
+		e->modem_context =3D cid;
+
+		g_free(req);
+		break;
+	}
+	default:
+		goto error;
+	};
+
+	return;
+error:
+	ofono_emulator_send_final(e, G_AT_SERVER_RESULT_ERROR);
+}
+
 static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
@@ -465,6 +835,13 @@ ofono_bool_t ofono_emulator_enable(struct ofono_emulat=
or *e, int fd)
 	g_at_server_set_disconnect_function(e->server, emulator_disconnect, e);
 =

 	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+	g_at_server_register(e->server, "+CFUN", cfun_cb, e, NULL);
+	g_at_server_register(e->server, "+CPIN", cpin_cb, e, NULL);
+	g_at_server_register(e->server, "+CREG", creg_cb, e, NULL);
+	g_at_server_register(e->server, "+CGREG", cgreg_cb, e, NULL);
+	g_at_server_register(e->server, "+COPS", cops_cb, e, NULL);
+	g_at_server_register(e->server, "+CGATT", cgatt_cb, e, NULL);
+	g_at_server_register(e->server, "+CGDCONT", cgdcont_cb, e, NULL);
 =

 	g_io_channel_unref(channel);
 =

-- =

1.6.3.3


--===============8883310285695261724==--

