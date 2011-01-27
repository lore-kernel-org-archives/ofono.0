Content-Type: multipart/mixed; boundary="===============2039274597088695360=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] bluetooth: add Bluetooth service authorization support
Date: Thu, 27 Jan 2011 21:20:23 +0100
Message-ID: <1296159623-24155-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1296159623-24155-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2039274597088695360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index c766205..1a17441 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -44,6 +44,8 @@ static GHashTable *adapter_address_hash =3D NULL;
 static gint bluetooth_refcount;
 static GSList *server_list =3D NULL;
 =

+#define TIMEOUT (60*1000) /* Timeout for user response (milliseconds) */
+
 struct server {
 	guint8 channel;
 	char *sdp_record;
@@ -58,6 +60,7 @@ struct cb_data {
 	struct server *server;
 	char *path;
 	guint source;
+	GIOChannel *io;
 };
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
@@ -489,13 +492,103 @@ static gboolean client_event(GIOChannel *chan, GIOCo=
ndition cond, gpointer data)
 	return FALSE;
 }
 =

+static void cancel_authorization(struct cb_data *user_data)
+{
+	DBusMessage *msg;
+
+	if (user_data->path =3D=3D NULL)
+		return;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, user_data->path,
+						BLUEZ_SERVICE_INTERFACE,
+						"CancelAuthorization");
+
+	g_dbus_send_message(connection, msg);
+}
+
+static void auth_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct cb_data *cb_data =3D user_data;
+	struct server *server =3D cb_data->server;
+
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	GError *err =3D NULL;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("RequestAuthorization error: %s, %s",
+				derr.name, derr.message);
+
+		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
+			cancel_authorization(cb_data);
+
+		dbus_error_free(&derr);
+
+		dbus_message_unref(reply);
+
+		goto failed;
+	}
+
+	dbus_message_unref(reply);
+
+	ofono_info("RequestAuthorization succeeded");
+
+	if (!bt_io_accept(cb_data->io, server->connect_cb, server->user_data,
+						NULL, &err)) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	g_source_remove(cb_data->source);
+	server->client_list =3D g_slist_remove(server->client_list,
+						(void *) cb_data->source);
+
+	cb_data->source =3D g_io_add_watch(cb_data->io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					client_event, cb_data);
+	server->client_list =3D g_slist_prepend(server->client_list,
+						(void *)cb_data->source);
+
+	return;
+
+failed:
+	g_source_remove(cb_data->source);
+	server->client_list =3D g_slist_remove(server->client_list,
+						(void *) cb_data->source);
+
+	cb_data_destroy(cb_data);
+}
+
+static gboolean auth_watch(GIOChannel *io, GIOCondition cond,
+						gpointer user_data)
+{
+	struct cb_data *cb_data =3D user_data;
+	struct server *server =3D cb_data->server;
+
+	cancel_authorization(cb_data);
+	server->client_list =3D g_slist_remove(server->client_list,
+						(void *) cb_data->source);
+
+	cb_data_destroy(cb_data);
+
+	return FALSE;
+}
+
 static void confirm_event(GIOChannel *io, gpointer user_data)
 {
 	struct server *server =3D user_data;
 	struct cb_data *client_data;
+	guint handle;
+	const char *addr;
+	int ret;
 	GError *err =3D NULL;
 	char laddress[18], raddress[18];
 	guint8 channel;
+	GHashTableIter iter;
+	gpointer key, value;
 =

 	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, laddress,
 					BT_IO_OPT_DEST, raddress,
@@ -510,14 +603,6 @@ static void confirm_event(GIOChannel *io, gpointer use=
r_data)
 	ofono_info("New connection for %s on  channel %u from: %s,", laddress,
 							channel, raddress);
 =

-	if (!bt_io_accept(io, server->connect_cb, server->user_data,
-						NULL, &err)) {
-		ofono_error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_unref(io);
-		return;
-	}
-
 	client_data =3D g_try_new0(struct cb_data, 1);
 	if (client_data =3D=3D NULL) {
 		ofono_error("Unable to allocate client cb_data structure");
@@ -525,9 +610,39 @@ static void confirm_event(GIOChannel *io, gpointer use=
r_data)
 	}
 =

 	client_data->server =3D server;
+
+	g_hash_table_iter_init(&iter, adapter_address_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		if (g_strcmp0(laddress, value) =3D=3D 0) {
+			client_data->path =3D g_strdup(key);
+			DBG("adapter path : %s", client_data->path);
+			break;
+		}
+	}
+
+	client_data->io =3D io;
+
+	handle =3D (guint) g_hash_table_lookup(server->adapter_hash,
+						client_data->path);
+	addr =3D raddress;
+	ret =3D bluetooth_send_with_reply(client_data->path,
+					BLUEZ_SERVICE_INTERFACE,
+					"RequestAuthorization",
+					auth_cb, client_data, NULL, TIMEOUT,
+					DBUS_TYPE_STRING, &addr,
+					DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_INVALID);
+	if (ret < 0) {
+		ofono_error("Request Bluetooth authorization failed");
+		return;
+	}
+
+	ofono_info("RequestAuthorization(%s, 0x%x)", raddress, handle);
+
 	client_data->source =3D g_io_add_watch(io,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					client_event, client_data);
+					auth_watch, client_data);
 	server->client_list =3D g_slist_prepend(server->client_list,
 						(void *)client_data->source);
 }
-- =

1.7.1


--===============2039274597088695360==--

