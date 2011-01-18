Content-Type: multipart/mixed; boundary="===============5552043116054484509=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [gisi-notify-fix PATCHv2 1/2] gisi: simplify pending management
Date: Tue, 18 Jan 2011 23:27:08 +0200
Message-ID: <1295386029-32624-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5552043116054484509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Client or server mark their pending objects with
the function g_isi_pending_set_owner().

When client or server get destroyed or reset the pending objects are
removed with the function g_isi_remove_pending_by_owner(). As a client
or server always uses only a particular resource, all the pending
objects are conveniently stored into a single list.
---
 gisi/client.c |  199 ++++++++++-------------------------------------------=
----
 gisi/modem.c  |   63 ++++++++++++++++++
 gisi/modem.h  |    5 +-
 gisi/server.c |   73 ++-------------------
 4 files changed, 107 insertions(+), 233 deletions(-)

diff --git a/gisi/client.c b/gisi/client.c
index 85e1fa7..ff2b1f4 100644
--- a/gisi/client.c
+++ b/gisi/client.c
@@ -32,58 +32,12 @@
 =

 #include "client.h"
 =

-struct pending_data {
-	GIsiClient *client;
-	GIsiNotifyFunc notify;
-	void *data;
-	GDestroyNotify destroy;
-};
-
 struct _GIsiClient {
 	GIsiModem *modem;
 	unsigned timeout;
 	uint8_t resource;
-	GSList *pending;
 };
 =

-static void pending_destroy(gpointer data)
-{
-	struct pending_data *pd =3D data;
-
-	if (pd =3D=3D NULL)
-		return;
-
-	if (pd->destroy !=3D NULL)
-		pd->destroy(pd->data);
-
-	g_free(pd);
-}
-
-static void pending_resp_notify(const GIsiMessage *msg, void *data)
-{
-	struct pending_data *pd =3D data;
-
-	if (pd =3D=3D NULL)
-		return;
-
-	pd->client->pending =3D g_slist_remove(pd->client->pending,
-						g_isi_pending_from_msg(msg));
-
-	if (pd->notify !=3D NULL)
-		pd->notify(msg, pd->data);
-}
-
-static void pending_notify(const GIsiMessage *msg, void *data)
-{
-	struct pending_data *pd =3D data;
-
-	if (pd =3D=3D NULL)
-		return;
-
-	if (pd->notify !=3D NULL)
-		pd->notify(msg, pd->data);
-}
-
 uint8_t g_isi_client_resource(GIsiClient *client)
 {
 	return client !=3D NULL ? client->resource : 0;
@@ -112,31 +66,13 @@ GIsiClient *g_isi_client_create(GIsiModem *modem, uint=
8_t resource)
 	client->timeout =3D G_ISI_CLIENT_DEFAULT_TIMEOUT;
 	client->resource =3D resource;
 	client->modem =3D modem;
-	client->pending =3D NULL;
 =

 	return client;
 }
 =

-static void foreach_destroy(gpointer value, gpointer user)
-{
-	GIsiPending *op =3D value;
-	GIsiClient *client =3D user;
-
-	if (op =3D=3D NULL || client =3D=3D NULL)
-		return;
-
-	client->pending =3D g_slist_remove(client->pending, op);
-	g_isi_pending_remove(op);
-}
-
 void g_isi_client_reset(GIsiClient *client)
 {
-	if (client =3D=3D NULL || client->pending =3D=3D NULL)
-		return;
-
-	g_slist_foreach(client->pending, foreach_destroy, client);
-	g_slist_free(client->pending);
-	client->pending =3D NULL;
+	g_isi_remove_pending_by_owner(client->modem, client->resource, client);
 };
 =

 void g_isi_client_destroy(GIsiClient *client)
@@ -156,43 +92,19 @@ void g_isi_client_set_timeout(GIsiClient *client, unsi=
gned timeout)
 	client->timeout =3D timeout;
 }
 =

-static struct pending_data *pending_data_create(GIsiClient *client,
-						GIsiNotifyFunc notify,
-						void *data,
-						GDestroyNotify destroy)
-{
-	struct pending_data *pd;
-
-	if (client =3D=3D NULL) {
-		errno =3D EINVAL;
-		return NULL;
-	}
-
-	pd =3D g_try_new0(struct pending_data, 1);
-	if (pd =3D=3D NULL) {
-		errno =3D ENOMEM;
-		return NULL;
-	}
-
-	pd->client =3D client;
-	pd->notify =3D notify;
-	pd->data =3D data;
-	pd->destroy =3D destroy;
-
-	return pd;
-}
-
 gboolean g_isi_client_send(GIsiClient *client,
 			const void *__restrict msg, size_t len,
 			GIsiNotifyFunc notify, void *data,
 			GDestroyNotify destroy)
 {
-	if (client =3D=3D NULL)
-		return FALSE;
+	GIsiPending *op;
+
+	op =3D g_isi_request_send(client->modem, client->resource, msg, len,
+				client->timeout, notify, data, destroy);
 =

-	return g_isi_client_send_with_timeout(client, msg, len,
-						client->timeout,
-						notify, data, destroy);
+	g_isi_pending_set_owner(op, client);
+
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_send_with_timeout(GIsiClient *client,
@@ -201,23 +113,14 @@ gboolean g_isi_client_send_with_timeout(GIsiClient *c=
lient,
 				GIsiNotifyFunc notify, void *data,
 				GDestroyNotify destroy)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(client, notify, data, destroy);
-	if (pd =3D=3D NULL)
-		return FALSE;
-
 	op =3D g_isi_request_send(client->modem, client->resource, buf, len,
-				timeout, pending_resp_notify, pd,
-				pending_destroy);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return FALSE;
-	}
+				timeout, notify, data, destroy);
+
+	g_isi_pending_set_owner(op, client);
 =

-	client->pending =3D g_slist_append(client->pending, op);
-	return TRUE;
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_vsend(GIsiClient *client,
@@ -225,12 +128,14 @@ gboolean g_isi_client_vsend(GIsiClient *client,
 			GIsiNotifyFunc notify, void *data,
 			GDestroyNotify destroy)
 {
-	if (client =3D=3D NULL)
-		return FALSE;
+	GIsiPending *op;
+
+	op =3D g_isi_request_vsend(client->modem, client->resource, iov, iovlen,
+				client->timeout, notify, data, destroy);
+
+	g_isi_pending_set_owner(op, client);
 =

-	return g_isi_client_vsend_with_timeout(client, iov, iovlen,
-						client->timeout,
-						notify, data, destroy);
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_vsend_with_timeout(GIsiClient *client,
@@ -239,85 +144,51 @@ gboolean g_isi_client_vsend_with_timeout(GIsiClient *=
client,
 				GIsiNotifyFunc notify, void *data,
 				GDestroyNotify destroy)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(client, notify, data, destroy);
-	if (pd =3D=3D NULL)
-		return FALSE;
-
 	op =3D g_isi_request_vsend(client->modem, client->resource, iov, iovlen,
-					timeout, pending_resp_notify, pd,
-					pending_destroy);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return FALSE;
-	}
+					timeout, notify, data, destroy);
 =

-	client->pending =3D g_slist_append(client->pending, op);
-	return TRUE;
+	g_isi_pending_set_owner(op, client);
+
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_ind_subscribe(GIsiClient *client, uint8_t type,
 					GIsiNotifyFunc notify, void *data)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(client, notify, data, NULL);
-	if (pd =3D=3D NULL)
-		return FALSE;
-
 	op =3D g_isi_ind_subscribe(client->modem, client->resource, type,
-					pending_notify, pd, pending_destroy);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return FALSE;
-	}
+					notify, data, NULL);
+
+	g_isi_pending_set_owner(op, client);
 =

-	client->pending =3D g_slist_append(client->pending, op);
-	return TRUE;
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_ntf_subscribe(GIsiClient *client, uint8_t type,
 					GIsiNotifyFunc notify, void *data)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(client, notify, data, NULL);
-	if (pd =3D=3D NULL)
-		return FALSE;
-
 	op =3D g_isi_ntf_subscribe(client->modem, client->resource, type,
-					pending_notify, pd, pending_destroy);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return FALSE;
-	}
+					notify, data, NULL);
 =

-	client->pending =3D g_slist_append(client->pending, op);
-	return TRUE;
+	g_isi_pending_set_owner(op, client);
+
+	return op !=3D NULL;
 }
 =

 gboolean g_isi_client_verify(GIsiClient *client, GIsiNotifyFunc notify,
 					void *data, GDestroyNotify destroy)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(client, notify, data, destroy);
-	if (pd =3D=3D NULL)
-		return FALSE;
-
 	op =3D g_isi_resource_ping(client->modem, client->resource,
-					pending_resp_notify, pd,
-					pending_destroy);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return FALSE;
-	}
+					notify, data, destroy);
+
+	g_isi_pending_set_owner(op, client);
 =

-	client->pending =3D g_slist_append(client->pending, op);
-	return TRUE;
+	return op !=3D NULL;
 }
diff --git a/gisi/modem.c b/gisi/modem.c
index 1655929..f80d671 100644
--- a/gisi/modem.c
+++ b/gisi/modem.c
@@ -73,6 +73,7 @@ struct _GIsiModem {
 struct _GIsiPending {
 	enum GIsiMessageType type;
 	GIsiServiceMux *service;
+	gpointer owner;
 	guint timeout;
 	GIsiNotifyFunc notify;
 	GDestroyNotify destroy;
@@ -799,6 +800,68 @@ void g_isi_pending_remove(GIsiPending *op)
 	pending_destroy(op, NULL);
 }
 =

+static void foreach_destroy(GIsiPending *op)
+{
+	if (op->type =3D=3D GISI_MESSAGE_TYPE_IND)
+		service_subs_decr(op->service);
+
+	if (op->type =3D=3D GISI_MESSAGE_TYPE_REQ)
+		service_regs_decr(op->service);
+
+	if (op->type =3D=3D GISI_MESSAGE_TYPE_RESP && op->notify !=3D NULL) {
+		GIsiMessage msg =3D {
+			.error =3D ESHUTDOWN,
+		};
+
+		pending_dispatch(op, &msg);
+	}
+
+	pending_destroy(op, NULL);
+}
+
+void g_isi_pending_set_owner(GIsiPending *op, gpointer owner)
+{
+	if (op =3D=3D NULL)
+		return;
+
+	op->owner =3D owner;
+}
+
+void g_isi_remove_pending_by_owner(GIsiModem *modem, uint8_t resource,
+					gpointer owner)
+{
+	GIsiServiceMux *mux;
+	GSList *l;
+	GSList *next;
+	GIsiPending *op;
+	GSList *owned =3D NULL;
+
+	mux =3D service_get(modem, resource);
+	if (mux =3D=3D NULL)
+		return;
+
+	for (l =3D mux->pending; l !=3D NULL; l =3D next) {
+		next =3D l->next;
+		op =3D l->data;
+
+		if (op->owner !=3D owner)
+			continue;
+
+		mux->pending =3D g_slist_remove_link(mux->pending, l);
+
+		l->next =3D owned;
+		owned =3D l;
+	}
+
+	for (l =3D owned; l !=3D NULL; l =3D l->next) {
+		op =3D l->data;
+
+		foreach_destroy(op);
+	}
+
+	g_slist_free(owned);
+}
+
 GIsiPending *g_isi_ntf_subscribe(GIsiModem *modem, uint8_t resource,
 					uint8_t msgid, GIsiNotifyFunc notify,
 					void *data, GDestroyNotify destroy)
diff --git a/gisi/modem.h b/gisi/modem.h
index fff1338..0de720d 100644
--- a/gisi/modem.h
+++ b/gisi/modem.h
@@ -109,7 +109,10 @@ int g_isi_response_vsend(GIsiModem *modem, const GIsiM=
essage *req,
 =

 GIsiPending *g_isi_pending_from_msg(const GIsiMessage *msg);
 =

-void g_isi_pending_remove(GIsiPending *operation);
+void g_isi_pending_remove(GIsiPending *op);
+void g_isi_pending_set_owner(GIsiPending *op, gpointer owner);
+void g_isi_remove_pending_by_owner(GIsiModem *modem, uint8_t resource,
+					gpointer owner);
 =

 GIsiPending *g_isi_resource_ping(GIsiModem *modem, uint8_t resource,
 					GIsiNotifyFunc notify, void *data,
diff --git a/gisi/server.c b/gisi/server.c
index e6cc9a5..af183f2 100644
--- a/gisi/server.c
+++ b/gisi/server.c
@@ -32,30 +32,12 @@
 =

 #include "server.h"
 =

-struct pending_data {
-	GIsiServer *server;
-	GIsiNotifyFunc notify;
-	void *data;
-};
-
 struct _GIsiServer {
 	GIsiModem *modem;
 	GIsiVersion version;
 	uint8_t resource;
-	GSList *pending;
 };
 =

-static void pending_notify(const GIsiMessage *msg, void *data)
-{
-	struct pending_data *pd =3D data;
-
-	if (pd =3D=3D NULL)
-		return;
-
-	if (pd->notify !=3D NULL)
-		pd->notify(msg, pd->data);
-}
-
 uint8_t g_isi_server_resource(GIsiServer *server)
 {
 	return server !=3D NULL ? server->resource : 0;
@@ -87,30 +69,17 @@ GIsiServer *g_isi_server_create(GIsiModem *modem, uint8=
_t resource,
 =

 	server->resource =3D resource;
 	server->modem =3D modem;
-	server->pending =3D NULL;
 =

 	return server;
 }
 =

-static void foreach_destroy(gpointer value, gpointer user)
-{
-	GIsiPending *op =3D value;
-	GIsiServer *server =3D user;
-
-	if (op =3D=3D NULL || server =3D=3D NULL)
-		return;
-
-	server->pending =3D g_slist_remove(server->pending, op);
-	g_isi_pending_remove(op);
-}
-
 void g_isi_server_destroy(GIsiServer *server)
 {
 	if (server =3D=3D NULL)
 		return;
 =

-	g_slist_foreach(server->pending, foreach_destroy, server);
-	g_slist_free(server->pending);
+	g_isi_remove_pending_by_owner(server->modem, server->resource, server);
+
 	g_free(server);
 }
 =

@@ -132,47 +101,15 @@ int g_isi_server_vsend(GIsiServer *server, const GIsi=
Message *req,
 	return g_isi_response_vsend(server->modem, req, iov, iovlen);
 }
 =

-static struct pending_data *pending_data_create(GIsiServer *server,
-						GIsiNotifyFunc notify,
-						void *data)
-{
-	struct pending_data *pd;
-
-	if (server =3D=3D NULL) {
-		errno =3D EINVAL;
-		return NULL;
-	}
-
-	pd =3D g_try_new0(struct pending_data, 1);
-	if (pd =3D=3D NULL) {
-		errno =3D ENOMEM;
-		return NULL;
-	}
-
-	pd->server =3D server;
-	pd->notify =3D notify;
-	pd->data =3D data;
-
-	return pd;
-}
-
 GIsiPending *g_isi_server_handle(GIsiServer *server, uint8_t type,
 					GIsiNotifyFunc notify, void *data)
 {
-	struct pending_data *pd;
 	GIsiPending *op;
 =

-	pd =3D pending_data_create(server, notify, data);
-	if (pd =3D=3D NULL)
-		return NULL;
-
 	op =3D g_isi_service_bind(server->modem, server->resource, type,
-				pending_notify, pd, g_free);
-	if (op =3D=3D NULL) {
-		g_free(pd);
-		return NULL;
-	}
+				notify, data, NULL);
+
+	g_isi_pending_set_owner(op, server);
 =

-	server->pending =3D g_slist_append(server->pending, op);
 	return op;
 }
-- =

1.7.1


--===============5552043116054484509==--

