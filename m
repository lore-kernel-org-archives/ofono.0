Content-Type: multipart/mixed; boundary="===============8746035934459718243=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] bluetooth: Add bluetooth server support
Date: Fri, 04 Feb 2011 15:44:03 +0100
Message-ID: <1296830644-15768-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1296830644-15768-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8746035934459718243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    1 +
 plugins/bluetooth.c |  281 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 plugins/bluetooth.h |    9 ++
 3 files changed, 288 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 758fb10..e402de4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -321,6 +321,7 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
oth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
 endif
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 93dd7a1..b489dad 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -35,12 +35,30 @@
 =

 #include <ofono/dbus.h>
 =

+#include <btio.h>
 #include "bluetooth.h"
 =

 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 static gint bluetooth_refcount;
+static GSList *server_list =3D NULL;
+
+struct server {
+	guint8 channel;
+	char *sdp_record;
+	GIOChannel *io;
+	GHashTable *adapter_hash;
+	ConnectFunc connect_cb;
+	gpointer user_data;
+	GSList *client_list;
+};
+
+struct cb_data {
+	struct server *server;
+	char *path;
+	guint source;
+};
 =

 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
@@ -409,6 +427,202 @@ done:
 	dbus_message_unref(reply);
 }
 =

+static void get_adapter_properties(const char *path, const char *handle,
+						gpointer user_data)
+{
+	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+			"GetProperties", adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+}
+
+static void remove_record(char *path, guint handle, struct server *server)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+					BLUEZ_SERVICE_INTERFACE,
+					"RemoveRecord");
+	if (msg =3D=3D NULL) {
+		ofono_error("Unable to allocate D-Bus RemoveRecord message");
+		return;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_INVALID);
+	g_dbus_send_message(connection, msg);
+
+	ofono_info("Unregistered handle for %s, channel %d: 0x%x", path,
+			server->channel, handle);
+}
+
+static void server_stop(struct server *server)
+{
+	/* Remove all client sources related to server */
+	while (server->client_list) {
+		g_source_remove(GPOINTER_TO_UINT(server->client_list->data));
+		server->client_list =3D g_slist_remove(server->client_list,
+						server->client_list->data);
+	}
+
+	g_hash_table_foreach_remove(server->adapter_hash,
+					(GHRFunc) remove_record, server);
+
+	if (server->io !=3D NULL) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io =3D NULL;
+	}
+}
+
+static void cb_data_destroy(gpointer data)
+{
+	struct cb_data *cb_data =3D data;
+
+	if (cb_data->path !=3D NULL)
+		g_free(cb_data->path);
+	g_free(cb_data);
+}
+
+static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpointer=
 data)
+{
+	struct cb_data *cb_data =3D data;
+	struct server *server =3D cb_data->server;
+
+	server->client_list =3D g_slist_remove(server->client_list,
+					GUINT_TO_POINTER(cb_data->source));
+
+	cb_data_destroy(cb_data);
+
+	return FALSE;
+}
+
+static void confirm_event(GIOChannel *io, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	struct cb_data *client_data;
+	GError *err =3D NULL;
+	char laddress[18], raddress[18];
+	guint8 channel;
+
+	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, laddress,
+					BT_IO_OPT_DEST, raddress,
+					BT_IO_OPT_CHANNEL, &channel,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	ofono_info("New connection for %s on channel %u from: %s,", laddress,
+							channel, raddress);
+
+	if (!bt_io_accept(io, server->connect_cb, server->user_data,
+						NULL, &err)) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		g_io_channel_unref(io);
+		return;
+	}
+
+	client_data =3D g_try_new0(struct cb_data, 1);
+	if (client_data =3D=3D NULL) {
+		ofono_error("Unable to allocate client cb_data structure");
+		return;
+	}
+
+	client_data->server =3D server;
+	client_data->source =3D g_io_add_watch(io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					client_event, client_data);
+	server->client_list =3D g_slist_prepend(server->client_list,
+					GUINT_TO_POINTER(client_data->source));
+}
+
+static void add_record_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct cb_data *cb_data =3D user_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	guint32 handle;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Replied with an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		g_free(cb_data->path);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_INVALID);
+
+	g_hash_table_insert(cb_data->server->adapter_hash, cb_data->path,
+				GUINT_TO_POINTER(handle));
+
+	ofono_info("Registered handle for %s, channel %d: 0x%x", cb_data->path,
+			cb_data->server->channel, handle);
+
+done:
+	/* Do not free cb_data->path, it is used in adapter_hash */
+	g_free(cb_data);
+	dbus_message_unref(reply);
+}
+
+static void server_add_record(const char *path, const char *handle,
+				struct server *server)
+{
+	struct cb_data *cb_data;
+
+	cb_data =3D g_try_new0(struct cb_data, 1);
+	if (cb_data =3D=3D NULL) {
+		ofono_error("Unable to allocate cb_data structure");
+		return;
+	}
+
+	cb_data->server =3D server;
+	cb_data->path =3D g_strdup(path);
+
+	bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE, "AddRecord",
+				add_record_cb, cb_data, NULL, -1,
+				DBUS_TYPE_STRING, &server->sdp_record,
+				DBUS_TYPE_INVALID);
+}
+
+static void server_start(struct server *server, char *path)
+{
+	GError *err =3D NULL;
+
+	if (server->io !=3D NULL)
+		goto out;
+
+	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
+					server, NULL, &err,
+					BT_IO_OPT_CHANNEL, server->channel,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (server->io =3D=3D NULL) {
+		ofono_error("Bluetooth channel %d register failed: %s",
+					server->channel, err->message);
+		g_error_free(err);
+		server_stop(server);
+		return;
+	}
+
+out:
+	if (server->sdp_record =3D=3D NULL)
+		return;
+
+	if (path !=3D NULL)
+		server_add_record(path, NULL, server);
+	else
+		g_hash_table_foreach(adapter_address_hash,
+					(GHFunc) server_add_record, server);
+
+}
+
 static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
 				void *user_data)
 {
@@ -422,6 +636,10 @@ static gboolean adapter_added(DBusConnection *connecti=
on, DBusMessage *message,
 			"GetProperties", adapter_properties_cb, g_strdup(path),
 			g_free, -1, DBUS_TYPE_INVALID);
 =

+	if (server_list)
+		g_slist_foreach(server_list, (GFunc) server_start,
+				(gpointer) path);
+
 	return TRUE;
 }
 =

@@ -429,11 +647,19 @@ static gboolean adapter_removed(DBusConnection *conne=
ction,
 				DBusMessage *message, void *user_data)
 {
 	const char *path;
+	GSList *l;
 =

 	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID) =3D=3D TRUE)
 		g_hash_table_remove(adapter_address_hash, path);
 =

+	for (l =3D server_list; l; l =3D l->next) {
+		struct server *server =3D l->data;
+
+		/* Handle have already been removed, so removing related path */
+		g_hash_table_remove(server->adapter_hash, path);
+	}
+
 	return TRUE;
 }
 =

@@ -460,6 +686,10 @@ static void parse_adapters(DBusMessageIter *array, gpo=
inter user_data)
 				"GetProperties", adapter_properties_cb,
 				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
 =

+		if (server_list)
+			g_slist_foreach(server_list, (GFunc) server_start,
+					(gpointer) path);
+
 		dbus_message_iter_next(&value);
 	}
 }
@@ -541,6 +771,10 @@ static void bluetooth_ref(void)
 	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 =

+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
 increment:
 	g_atomic_int_inc(&bluetooth_refcount);
 =

@@ -576,9 +810,8 @@ int bluetooth_register_uuid(const char *uuid, struct bl=
uetooth_profile *profile)
 =

 	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
 =

-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
+	g_hash_table_foreach(adapter_address_hash,
+				(GHFunc) get_adapter_properties, NULL);
 =

 	return 0;
 }
@@ -590,5 +823,47 @@ void bluetooth_unregister_uuid(const char *uuid)
 	bluetooth_unref();
 }
 =

+struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
+					ConnectFunc cb, gpointer user_data)
+{
+	struct server *server;
+
+	server =3D g_try_new0(struct server, 1);
+	if (!server)
+		return NULL;
+
+	bluetooth_ref();
+
+	if (bluetooth_refcount =3D=3D 0) {
+		g_free(server);
+		return NULL;
+	}
+
+	server->channel =3D channel;
+	if (sdp_record !=3D NULL)
+		server->sdp_record =3D g_strdup(sdp_record);
+	server->connect_cb =3D cb;
+	server->user_data =3D user_data;
+	server->adapter_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	server_start(server, NULL);
+
+	server_list =3D g_slist_prepend(server_list, server);
+
+	return server;
+}
+
+void bluetooth_unregister_server(struct server *server)
+{
+	server_list =3D g_slist_remove(server_list, server);
+	server_stop(server);
+	g_hash_table_destroy(server->adapter_hash);
+	g_free(server->sdp_record);
+	g_free(server);
+
+	bluetooth_unref();
+}
+
 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 42b0d13..505d908 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -23,6 +23,7 @@
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 =

 #define DBUS_TIMEOUT 15
 =

@@ -39,10 +40,18 @@ struct bluetooth_profile {
 	void (*set_alias)(const char *device, const char *);
 };
 =

+struct server;
+
+typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
+
 int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

+struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
+					ConnectFunc cb, gpointer user_data);
+void bluetooth_unregister_server(struct server *server);
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 							char *buf, int size);
 =

-- =

1.7.1


--===============8746035934459718243==--

