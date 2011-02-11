Content-Type: multipart/mixed; boundary="===============2050945356412545304=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH] bluetooth: single SDP record for all adapters
Date: Fri, 11 Feb 2011 10:31:05 +0100
Message-ID: <1297416665-26621-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2050945356412545304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |  140 +++++++++++++++++++++++------------------------=
---
 1 files changed, 64 insertions(+), 76 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index d38006b..8443f90 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -43,14 +43,16 @@ static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 static gint bluetooth_refcount;
 static GSList *server_list =3D NULL;
+static const char *adapter_any_name =3D "any";
+static char *adapter_any_path;
 =

 #define TIMEOUT 60 /* Timeout for user response (seconds) */
 =

 struct server {
 	guint8 channel;
 	char *sdp_record;
+	guint32 handle;
 	GIOChannel *io;
-	GHashTable *adapter_hash;
 	ConnectFunc connect_cb;
 	gpointer user_data;
 };
@@ -437,11 +439,11 @@ static void get_adapter_properties(const char *path, =
const char *handle,
 			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 }
 =

-static void remove_record(char *path, guint handle, struct server *server)
+static void remove_record(struct server *server)
 {
 	DBusMessage *msg;
 =

-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, adapter_any_path,
 					BLUEZ_SERVICE_INTERFACE,
 					"RemoveRecord");
 	if (msg =3D=3D NULL) {
@@ -449,24 +451,12 @@ static void remove_record(char *path, guint handle, s=
truct server *server)
 		return;
 	}
 =

-	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &handle,
+	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
 					DBUS_TYPE_INVALID);
 	g_dbus_send_message(connection, msg);
 =

-	ofono_info("Unregistered handle for %s, channel %d: 0x%x", path,
-			server->channel, handle);
-}
-
-static void server_stop(struct server *server)
-{
-	g_hash_table_foreach_remove(server->adapter_hash,
-					(GHRFunc) remove_record, server);
-
-	if (server->io !=3D NULL) {
-		g_io_channel_shutdown(server->io, TRUE, NULL);
-		g_io_channel_unref(server->io);
-		server->io =3D NULL;
-	}
+	ofono_info("Unregistered handle for channel %d: 0x%x",
+			server->channel, server->handle);
 }
 =

 static void cb_data_destroy(gpointer data)
@@ -542,7 +532,6 @@ static void new_connection(GIOChannel *io, gpointer use=
r_data)
 {
 	struct server *server =3D user_data;
 	struct cb_data *cbd;
-	guint handle;
 	const char *addr;
 	GError *err =3D NULL;
 	char laddress[18], raddress[18];
@@ -550,7 +539,6 @@ static void new_connection(GIOChannel *io, gpointer use=
r_data)
 	GHashTableIter iter;
 	gpointer key, value;
 	const char *path;
-	gpointer handlep;
 =

 	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, laddress,
 					BT_IO_OPT_DEST, raddress,
@@ -578,10 +566,6 @@ static void new_connection(GIOChannel *io, gpointer us=
er_data)
 	if (path =3D=3D NULL)
 		return;
 =

-	handlep =3D g_hash_table_lookup(server->adapter_hash, path);
-	if (handlep =3D=3D NULL)
-		return;
-
 	cbd =3D g_try_new0(struct cb_data, 1);
 	if (cbd =3D=3D NULL) {
 		ofono_error("Unable to allocate client cb_data structure");
@@ -593,19 +577,18 @@ static void new_connection(GIOChannel *io, gpointer u=
ser_data)
 	cbd->io =3D io;
 =

 	addr =3D raddress;
-	handle =3D GPOINTER_TO_UINT(handlep);
 =

 	if (bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
 					"RequestAuthorization",
 					auth_cb, cbd, cb_data_destroy,
 					TIMEOUT, DBUS_TYPE_STRING, &addr,
-					DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_UINT32, &server->handle,
 					DBUS_TYPE_INVALID) < 0) {
 		ofono_error("Request Bluetooth authorization failed");
 		return;
 	}
 =

-	ofono_info("RequestAuthorization(%s, 0x%x)", raddress, handle);
+	ofono_info("RequestAuthorization(%s, 0x%x)", raddress, server->handle);
 =

 	cbd->source =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					client_event, cbd);
@@ -613,10 +596,9 @@ static void new_connection(GIOChannel *io, gpointer us=
er_data)
 =

 static void add_record_cb(DBusPendingCall *call, gpointer user_data)
 {
-	struct cb_data *cb_data =3D user_data;
+	struct server *server =3D user_data;
 	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
 	DBusError derr;
-	guint32 handle;
 =

 	dbus_error_init(&derr);
 =

@@ -624,47 +606,31 @@ static void add_record_cb(DBusPendingCall *call, gpoi=
nter user_data)
 		ofono_error("Replied with an error: %s, %s",
 					derr.name, derr.message);
 		dbus_error_free(&derr);
-		g_free(cb_data->path);
 		goto done;
 	}
 =

-	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &server->handle,
 					DBUS_TYPE_INVALID);
 =

-	g_hash_table_insert(cb_data->server->adapter_hash, cb_data->path,
-				GUINT_TO_POINTER(handle));
-
-	ofono_info("Registered handle for %s, channel %d: 0x%x", cb_data->path,
-			cb_data->server->channel, handle);
+	ofono_info("Registered handle for channel %d: 0x%x",
+			server->channel, server->handle);
 =

 done:
-	/* Do not free cb_data->path, it is used in adapter_hash */
-	g_free(cb_data);
 	dbus_message_unref(reply);
 }
 =

 static void add_record(gpointer data, gpointer user_data)
 {
 	struct server *server =3D data;
-	const char *path =3D user_data;
-	struct cb_data *cb_data;
 =

 	if (server->sdp_record =3D=3D NULL)
 		return;
 =

-	cb_data =3D g_try_new0(struct cb_data, 1);
-	if (cb_data =3D=3D NULL) {
-		ofono_error("Unable to allocate cb_data structure");
-		return;
-	}
-
-	cb_data->server =3D server;
-	cb_data->path =3D g_strdup(path);
-
-	bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE, "AddRecord",
-				add_record_cb, cb_data, NULL, -1,
-				DBUS_TYPE_STRING, &server->sdp_record,
-				DBUS_TYPE_INVALID);
+	bluetooth_send_with_reply(adapter_any_path,
+					BLUEZ_SERVICE_INTERFACE, "AddRecord",
+					add_record_cb, server, NULL, -1,
+					DBUS_TYPE_STRING, &server->sdp_record,
+					DBUS_TYPE_INVALID);
 }
 =

 static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
@@ -680,8 +646,6 @@ static gboolean adapter_added(DBusConnection *connectio=
n, DBusMessage *message,
 			"GetProperties", adapter_properties_cb, g_strdup(path),
 			g_free, -1, DBUS_TYPE_INVALID);
 =

-	g_slist_foreach(server_list, add_record, (gpointer) path);
-
 	return TRUE;
 }
 =

@@ -689,19 +653,11 @@ static gboolean adapter_removed(DBusConnection *conne=
ction,
 				DBusMessage *message, void *user_data)
 {
 	const char *path;
-	GSList *l;
 =

 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID) =3D=3D TRUE)
 		g_hash_table_remove(adapter_address_hash, path);
 =

-	for (l =3D server_list; l; l =3D l->next) {
-		struct server *server =3D l->data;
-
-		/* Handle have already been removed, so removing related path */
-		g_hash_table_remove(server->adapter_hash, path);
-	}
-
 	return TRUE;
 }
 =

@@ -728,8 +684,6 @@ static void parse_adapters(DBusMessageIter *array, gpoi=
nter user_data)
 				"GetProperties", adapter_properties_cb,
 				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 =

-		g_slist_foreach(server_list, add_record, (gpointer) path);
-
 		dbus_message_iter_next(&value);
 	}
 }
@@ -770,6 +724,32 @@ static void bluetooth_disconnect(DBusConnection *conne=
ction, void *user_data)
 	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
 }
 =

+static void find_adapter_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	const char *path;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Replied with an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	adapter_any_path =3D g_strdup(path);
+
+	g_slist_foreach(server_list, (GFunc)add_record, NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
 static guint bluetooth_watch;
 static guint adapter_added_watch;
 static guint adapter_removed_watch;
@@ -815,6 +795,11 @@ static void bluetooth_ref(void)
 				manager_properties_cb, NULL, NULL, -1,
 				DBUS_TYPE_INVALID);
 =

+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
+				find_adapter_cb, NULL, NULL, -1,
+				DBUS_TYPE_STRING, &adapter_any_name,
+				DBUS_TYPE_INVALID);
+
 increment:
 	g_atomic_int_inc(&bluetooth_refcount);
 =

@@ -832,6 +817,8 @@ static void bluetooth_unref(void)
 	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
 		return;
 =

+	g_free(adapter_any_path);
+
 	g_dbus_remove_watch(connection, bluetooth_watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
@@ -865,8 +852,6 @@ struct server *bluetooth_register_server(guint8 channel=
, const char *sdp_record,
 {
 	struct server *server;
 	GError *err;
-	GHashTableIter iter;
-	gpointer key, value;
 =

 	server =3D g_try_new0(struct server, 1);
 	if (!server)
@@ -892,24 +877,27 @@ struct server *bluetooth_register_server(guint8 chann=
el, const char *sdp_record,
 =

 	server->connect_cb =3D cb;
 	server->user_data =3D user_data;
-	server->adapter_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-							g_free, NULL);
-
-	g_hash_table_iter_init(&iter, adapter_address_hash);
-
-	while (g_hash_table_iter_next(&iter, &key, &value))
-		add_record(server, key);
 =

 	server_list =3D g_slist_prepend(server_list, server);
 =

+	if(adapter_any_path !=3D NULL)
+		add_record(server, NULL);
+
 	return server;
 }
 =

 void bluetooth_unregister_server(struct server *server)
 {
 	server_list =3D g_slist_remove(server_list, server);
-	server_stop(server);
-	g_hash_table_destroy(server->adapter_hash);
+
+	remove_record(server);
+
+	if (server->io !=3D NULL) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io =3D NULL;
+	}
+
 	g_free(server->sdp_record);
 	g_free(server);
 =

-- =

1.7.1


--===============2050945356412545304==--

