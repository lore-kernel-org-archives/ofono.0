Content-Type: multipart/mixed; boundary="===============4232067587598256943=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/15] emulator: Implement dialing up for DUN
Date: Wed, 07 Jul 2010 18:01:46 +0800
Message-ID: <1278496912-13777-10-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278496912-13777-9-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4232067587598256943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It handles client ATD*99# request and complete GPRS connection. Pass
client IP address through IPCP packet to client side.
---
 include/emulator.h |   34 ++++++++
 src/emulator.c     |  226 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 260 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 8b10f8c..b8fb0d5 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -34,6 +34,10 @@ enum ofono_emulator_status {
 	OFONO_EMULATOR_STATUS_IDLE =3D 0,
 	OFONO_EMULATOR_STATUS_CREATE,
 	OFONO_EMULATOR_STATUS_DESTROY,
+	OFONO_EMULATOR_STATUS_GPRS_CONNECT,
+	OFONO_EMULATOR_STATUS_DUN_CONNECTING,
+	OFONO_EMULATOR_STATUS_DUN_CONNECTED,
+	OFONO_EMULATOR_STATUS_DUN_DISCONNECTED,
 };
 =

 enum ofono_emulator_type {
@@ -52,6 +56,36 @@ struct ofono_emulator_driver {
 =

 enum _GAtServerResult;
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
+struct ofono_emulator_dun_connect_req {
+	const char *iface;
+	const char *local;
+	const char *peer;
+	const char *dns1;
+	const char *dns2;
+	ofono_emulator_cb_t cb;
+	void *cb_data;
+};
+
 const char *ofono_emulator_get_path(struct ofono_emulator *e);
 =

 struct ofono_emulator *ofono_emulator_find(struct ofono_modem *modem,
diff --git a/src/emulator.c b/src/emulator.c
index aa203f1..dda74a1 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -29,10 +29,22 @@
 #include <glib.h>
 #include <gdbus.h>
 =

+#include <netinet/in.h>
+#include <arpa/inet.h>
+
 #include "ofono.h"
 #include "gatserver.h"
+#include "gatppp.h"
 #include "common.h"
 =

+struct context_info {
+	char *interface;
+	char *local;
+	char *peer;
+	char *dns1;
+	char *dns2;
+};
+
 struct ofono_emulator {
 	struct ofono_emulator_driver *driver;
 	struct ofono_modem *modem;
@@ -40,9 +52,11 @@ struct ofono_emulator {
 	unsigned int id;
 	void *user_data;
 	GAtServer *server;
+	GAtPPP *ppp;
 	ofono_bool_t powered;
 	enum ofono_emulator_status status;
 	struct ofono_watchlist *status_watches;
+	struct context_info *info;
 };
 =

 static GSList *emulator_list;
@@ -165,6 +179,210 @@ static void notify_status_watches(struct ofono_emulat=
or *e, void *data)
 	}
 }
 =

+static void ppp_connect_cb(GAtServerResult res, void *user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	if (res =3D=3D G_AT_SERVER_RESULT_OK) {
+		DBG("PPP actived!\n");
+		e->status =3D OFONO_EMULATOR_STATUS_DUN_CONNECTED;
+	} else {
+		DBG("Failed to active PPP connection!\n");
+		e->status =3D OFONO_EMULATOR_STATUS_IDLE;
+	}
+
+	notify_status_watches(e, NULL);
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+				const char *dns1, const char *dns2,
+				gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct ofono_emulator_dun_connect_req *req;
+
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Remote IP Address: %s\n", peer);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+
+	req =3D g_try_new0(struct ofono_emulator_dun_connect_req, 1);
+	if (!req)
+		return;
+
+	req->iface =3D iface;
+	req->local =3D local;
+	req->peer =3D peer;
+	req->dns1 =3D dns1;
+	req->dns2 =3D dns2;
+	req->cb =3D ppp_connect_cb;
+	req->cb_data =3D e;
+
+	e->status =3D OFONO_EMULATOR_STATUS_DUN_CONNECTING;
+
+	notify_status_watches(e, req);
+
+	g_free(req);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_emulator *e =3D user_data;
+	struct context_info *info =3D e->info;
+	struct ofono_emulator_req *req;
+
+	DBG("");
+
+	g_at_ppp_unref(e->ppp);
+	e->ppp =3D NULL;
+
+	g_at_server_resume(e->server);
+
+	g_free(info->interface);
+	g_free(info->local);
+	g_free(info->peer);
+	g_free(info->dns1);
+	g_free(info->dns2);
+	g_free(info);
+
+	req =3D ofono_emulator_req_new(generic_cb, e);
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
+	struct context_info *info =3D e->info;
+
+	DBG("");
+
+	io =3D g_at_server_get_io(server);
+
+	/* suspend server port */
+	g_at_server_suspend(server);
+
+	/* open ppp */
+	e->ppp =3D g_at_ppp_server_new_from_io(io, info->local);
+	if (e->ppp =3D=3D NULL) {
+		g_at_server_resume(server);
+		return FALSE;
+	}
+
+	g_at_ppp_set_server_info(e->ppp, info->peer, info->dns1, info->dns2);
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
+	struct context_info *info;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		goto error;
+
+	if (!dns[0] || !dns[1])
+		goto error;
+
+	info =3D g_try_new0(struct context_info, 1);
+	if (!info)
+		goto error;
+
+	info->interface =3D g_strdup(interface);
+	info->local =3D g_strdup(local);
+	info->peer =3D g_strdup(peer);
+	info->dns1 =3D g_strdup(dns[0]);
+	info->dns2 =3D g_strdup(dns[1]);
+
+	e->info =3D info;
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
+		e->status =3D OFONO_EMULATOR_STATUS_GPRS_CONNECT;
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
+	if (!dial_call(e, dial_str))
+		goto error;
+
+	return;
+
+error:
+	g_at_server_send_final(server, res);
+}
+
 static void emulator_remove(struct ofono_atom *atom)
 {
 	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
@@ -190,6 +408,12 @@ void ofono_emulator_disable(struct ofono_emulator *e)
 	if (e->server =3D=3D NULL)
 		return;
 =

+	if (e->ppp) {
+		g_at_ppp_shutdown(e->ppp);
+		g_at_ppp_unref(e->ppp);
+		e->ppp =3D NULL;
+	}
+
 	e->status =3D OFONO_EMULATOR_STATUS_DESTROY;
 	notify_status_watches(e, NULL);
 =

@@ -240,6 +464,8 @@ ofono_bool_t ofono_emulator_enable(struct ofono_emulato=
r *e, int fd)
 	g_at_server_set_debug(e->server, ofono_emulator_debug, "Server");
 	g_at_server_set_disconnect_function(e->server, emulator_disconnect, e);
 =

+	g_at_server_register(e->server, "D", dial_cb, e, NULL);
+
 	g_io_channel_unref(channel);
 =

 	e->powered =3D TRUE;
-- =

1.6.3.3


--===============4232067587598256943==--

