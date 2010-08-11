Content-Type: multipart/mixed; boundary="===============2738320557648237205=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 07/16] emulator: Register mandatory AT command handlers
Date: Wed, 11 Aug 2010 10:26:32 +0800
Message-ID: <1281493601-14351-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1281493601-14351-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2738320557648237205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Register mandatory AT command handlers for DUN server.
---
 include/emulator.h |    2 +
 src/emulator.c     |  381 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 383 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 641f38c..1ff813f 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -37,6 +37,8 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_DUN_CONNECT,
 	OFONO_EMULATOR_STATUS_DUN_CONNECTED,
 	OFONO_EMULATOR_STATUS_DUN_DISCONNECTED,
+	OFONO_EMULATOR_STATUS_SET_CGATT,
+	OFONO_EMULATOR_STATUS_SET_CGDCONT,
 };
 =

 enum _GAtServerResult;
diff --git a/src/emulator.c b/src/emulator.c
index 378426c..8811f6c 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -49,6 +49,14 @@ struct dun_context {
 	struct ofono_gprs_primary_context pri_ctx;
 };
 =

+struct modem_settings {
+	int mode;
+	int creg;
+	int cgreg;
+	int cops;
+	int attached;
+};
+
 struct ofono_emulator {
 	struct ofono_modem *modem;
 	struct ofono_atom *atom;
@@ -57,6 +65,7 @@ struct ofono_emulator {
 	GAtServer *server;
 	GAtPPP *ppp;
 	struct dun_context context;
+	struct modem_settings settings;
 	enum ofono_emulator_status status;
 	struct ofono_watchlist *status_watches;
 };
@@ -146,6 +155,371 @@ static struct ofono_emulator_req *ofono_emulator_req_=
new(void *cb,
 	return req;
 }
 =

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
+		snprintf(buf, sizeof(buf), "+CFUN: %d", e->settings.mode);
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
+		e->settings.mode =3D mode;
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
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
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
+		e->settings.creg =3D mode;
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
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
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
+		e->settings.cgreg =3D mode;
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
+		snprintf(buf, sizeof(buf), "+COPS: %d", e->settings.cops);
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
+		e->settings.cops =3D mode;
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
+		snprintf(buf, sizeof(buf), "+CGATT: %d", e->settings.attached);
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
+		e->settings.attached =3D attached;
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
+	struct ofono_emulator_gprs_context_req *req;
+	struct dun_context *context =3D &e->context;
+	struct ofono_gprs_primary_context *ctx =3D &context->pri_ctx;
+	char buf[256];
+
+	switch (type) {
+	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	case G_AT_SERVER_REQUEST_TYPE_QUERY:
+	{
+		const char *proto =3D gprs_proto_to_string(ctx->proto);
+
+		snprintf(buf, sizeof(buf), "+CGDCONT: %d, \"%s\", \"%s\"",
+						ctx->cid, proto, ctx->apn);
+		ofono_emulator_send_info(e, buf, TRUE);
+		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
+		break;
+	}
+	case G_AT_SERVER_REQUEST_TYPE_SET:
+	{
+		GAtResultIter iter;
+		unsigned int cid;
+		const char *proto;
+		const char *apn;
+
+		g_at_result_iter_init(&iter, result);
+		g_at_result_iter_next(&iter, "+CGDCONT=3D");
+
+		if (g_at_result_iter_next_number(&iter, (gint *)&cid) =3D=3D FALSE)
+			goto error;
+
+		if (g_at_result_iter_next_string(&iter, &proto) =3D=3D FALSE)
+			goto error;
+
+		if (g_at_result_iter_next_string(&iter, &apn) =3D=3D FALSE)
+			goto error;
+
+		DBG("set CGDCONT %d %s %s", cid, proto, apn);
+
+		if (cid <=3D 0 || proto =3D=3D NULL || apn =3D=3D NULL)
+			goto error;
+
+		if (cid =3D=3D ctx->cid)
+			goto error;
+
+		if (context->active)
+			goto error;
+
+		ctx->cid =3D cid;
+		gprs_proto_from_string(proto, &ctx->proto);
+		strncpy(ctx->apn, apn, OFONO_GPRS_MAX_APN_LENGTH);
+		ctx->apn[OFONO_GPRS_MAX_APN_LENGTH] =3D '\0';
+
+		req =3D g_try_new0(struct ofono_emulator_gprs_context_req, 1);
+		if (!req)
+			goto error;
+
+		req->proto =3D proto;
+		req->apn =3D apn;
+		req->cb =3D generic_cb;
+		req->cb_data =3D e;
+
+		e->status =3D OFONO_EMULATOR_STATUS_SET_CGDCONT;
+
+		notify_status_watches(e, req);
+
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
+	g_free(req);
+}
+
 static void ppp_connect(const char *interface, const char *local,
 			const char *remote,
 			const char *dns1, const char *dns2,
@@ -426,6 +800,13 @@ struct ofono_emulator *ofono_emulator_create(struct of=
ono_modem *modem,
 	__ofono_atom_register(e->atom, emulator_unregister);
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

 	return e;
 }
-- =

1.7.0.4


--===============2738320557648237205==--

