Content-Type: multipart/mixed; boundary="===============4416026041139190340=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/21] emulator: Implement dialing up for DUN
Date: Wed, 29 Sep 2010 17:44:50 +0800
Message-ID: <1285753501-7668-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1285753501-7668-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4416026041139190340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It handles client ATD*99# request and complete GPRS connection. Pass
client IP address through IPCP packet to client side.
---
 include/emulator.h |   30 +++++++
 src/emulator.c     |  221 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 251 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 0d5568c..e6eeb06 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -34,6 +34,9 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_IDLE =3D 0,
 	OFONO_EMULATOR_STATUS_CREATE,
 	OFONO_EMULATOR_STATUS_DESTROY,
+	OFONO_EMULATOR_STATUS_DUN_CONNECT,
+	OFONO_EMULATOR_STATUS_DUN_CONNECTED,
+	OFONO_EMULATOR_STATUS_DUN_DISCONNECTED,
 };
 =

 enum _GAtServerResult;
@@ -46,6 +49,33 @@ struct ofono_emulator_driver {
 	void (*remove)();
 };
 =

+typedef void (*ofono_emulator_cb_t)(enum _GAtServerResult res, void *data);
+
+struct ofono_emulator_req {
+	void *data;
+	ofono_emulator_cb_t cb;
+	void *cb_data;
+};
+
+typedef void (*ofono_emulator_gprs_connect_cb)(const struct ofono_error *e=
rror,
+						const char *interface,
+						const char *local,
+						const char *peer,
+						const char **dns, void *data);
+
+struct ofono_emulator_gprs_connect_req {
+	const char *dial_str;
+	ofono_emulator_gprs_connect_cb cb;
+	void *cb_data;
+};
+
+struct ofono_emulator_gprs_context_req {
+	const char *proto;
+	const char *apn;
+	ofono_emulator_cb_t cb;
+	void *cb_data;
+};
+
 int ofono_emulator_enable(struct ofono_emulator *emulator, GIOChannel *cha=
nnel);
 void ofono_emulator_remove(gpointer user_data);
 struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
diff --git a/src/emulator.c b/src/emulator.c
index 455af11..3329b36 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -32,12 +32,30 @@
 #include "ofono.h"
 #include "common.h"
 #include "gatserver.h"
+#include "gatppp.h"
+
+struct context_settings {
+	char *interface;
+	gboolean static_ip;
+	char *ip;
+	char *netmask;
+	char *gateway;
+	char **dns;
+};
+
+struct dun_context {
+	ofono_bool_t active;
+	struct context_settings settings;
+	struct ofono_gprs_primary_context pri_ctx;
+};
 =

 struct ofono_emulator {
 	struct ofono_modem *modem;
 	struct ofono_atom *atom;
 	unsigned int id;
 	GAtServer *server;
+	GAtPPP *ppp;
+	struct dun_context context;
 	struct ofono_emulator_driver *driver;
 	enum ofono_emulator_status status;
 	struct ofono_watchlist *status_watches;
@@ -124,6 +142,201 @@ static void notify_status_watches(struct ofono_emulat=
or *e, void *data)
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
+static void ppp_connect(const char *interface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct dun_context *ctx =3D &e->context;
+	struct context_settings *settings =3D &ctx->settings;
+
+	e->status =3D OFONO_EMULATOR_STATUS_DUN_CONNECTED;
+	ctx->active =3D TRUE;
+
+	DBG("DUN server connected!\n");
+
+	DBG("Network Device: %s\n", settings->interface);
+	DBG("IP Address: %s\n", settings->ip);
+	DBG("Remote IP Address: %s\n", settings->gateway);
+	DBG("Primary DNS Server: %s\n", settings->dns[0]);
+	DBG("Secondary DNS Server: %s\n", settings->dns[1]);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct dun_context *ctx =3D &e->context;
+	struct context_settings *settings =3D &ctx->settings;
+	struct ofono_emulator_req *req;
+
+	DBG("");
+
+	g_at_ppp_unref(e->ppp);
+	e->ppp =3D NULL;
+
+	g_at_server_resume(e->server);
+
+	ctx->active =3D FALSE;
+
+	g_free(settings->interface);
+	g_free(settings->ip);
+	g_free(settings->netmask);
+	g_free(settings->gateway);
+	g_strfreev(settings->dns);
+
+	req =3D ofono_emulator_req_new(NULL, NULL);
+	if (!req)
+		return;
+
+	e->status =3D OFONO_EMULATOR_STATUS_DUN_DISCONNECTED;
+	notify_status_watches(e, req);
+
+	g_free(req);
+}
+
+static gboolean setup_ppp(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtIO *io;
+	struct context_settings *settings =3D &e->context.settings;
+
+	DBG("");
+
+	io =3D g_at_server_get_io(server);
+
+	/* suspend server port */
+	g_at_server_suspend(server);
+
+	/* open ppp */
+	e->ppp =3D g_at_ppp_server_new_from_io(io, settings->ip);
+	if (e->ppp =3D=3D NULL) {
+		g_at_server_resume(server);
+		return FALSE;
+	}
+
+	g_at_ppp_set_server_info(e->ppp, settings->gateway,
+					settings->dns[0], settings->dns[1]);
+	g_at_ppp_set_credentials(e->ppp, "", "");
+	g_at_ppp_set_debug(e->ppp, ofono_emulator_debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(e->ppp, ppp_connect, e);
+	g_at_ppp_set_disconnect_function(e->ppp, ppp_disconnect, e);
+
+	return FALSE;
+}
+
+static void gprs_connect_cb(const struct ofono_error *error,
+				const char *interface,
+				const char *local,
+				const char *peer,
+				const char **dns, void *data)
+{
+	struct ofono_emulator *e =3D data;
+	struct context_settings *settings =3D &e->context.settings;
+	const char *netmask =3D "255.255.255.255";
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto error;
+
+	if (!dns[0] || !dns[1])
+		goto error;
+
+	settings->interface =3D g_strdup(interface);
+	settings->static_ip =3D FALSE;
+	settings->ip =3D g_strdup(local);
+	settings->netmask =3D g_strdup(netmask);
+	settings->gateway =3D g_strdup(peer);
+	settings->dns =3D g_strdupv((char **)dns);
+
+	g_at_server_send_intermediate(e->server, "CONNECT");
+
+	g_idle_add(setup_ppp, e);
+
+	return;
+
+error:
+	g_at_server_send_final(e->server, G_AT_SERVER_RESULT_NO_CARRIER);
+}
+
+static gboolean dial_call(struct ofono_emulator *e, const char *dial_str)
+{
+	char c =3D *dial_str;
+
+	DBG("dial call %s", dial_str);
+
+	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+		struct ofono_emulator_gprs_connect_req *req;
+
+		req =3D g_try_new0(struct ofono_emulator_gprs_connect_req, 1);
+		if (!req)
+			return FALSE;
+
+		req->cb =3D gprs_connect_cb;
+		req->cb_data =3D e;
+		req->dial_str =3D dial_str;
+
+		e->status =3D OFONO_EMULATOR_STATUS_DUN_CONNECT;
+		notify_status_watches(e, req);
+
+		g_free(req);
+	}
+
+	return TRUE;
+}
+
+static void dial_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
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
+	if (e->context.active =3D=3D TRUE)
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
 int ofono_emulator_enable(struct ofono_emulator *e, GIOChannel *channel)
 {
 	if (channel =3D=3D NULL)
@@ -139,6 +352,8 @@ int ofono_emulator_enable(struct ofono_emulator *e, GIO=
Channel *channel)
 	g_at_server_set_disconnect_function(e->server, ofono_emulator_remove,
 						e);
 =

+	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+
 	return 0;
 }
 =

@@ -146,6 +361,12 @@ static void emulator_disable(struct ofono_emulator *e)
 {
 	DBG("");
 =

+	if (e->ppp) {
+		g_at_ppp_shutdown(e->ppp);
+		g_at_ppp_unref(e->ppp);
+		e->ppp =3D NULL;
+	}
+
 	g_at_server_shutdown(e->server);
 	g_at_server_unref(e->server);
 	e->server =3D NULL;
-- =

1.7.0.4


--===============4416026041139190340==--

