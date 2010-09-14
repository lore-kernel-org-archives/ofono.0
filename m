Content-Type: multipart/mixed; boundary="===============0360050434271134694=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH V2 3/5] bluetooth: Add bluetooth server support for DUN
Date: Tue, 14 Sep 2010 22:44:48 +0800
Message-ID: <1284475490-32727-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284475490-32727-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0360050434271134694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It watches Bluetooth adapter property changes and addes DUN record to
listen DUN client connection request.
---
 plugins/bluetooth.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   14 ++
 2 files changed, 393 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 10cc49d..0577747 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -34,13 +34,72 @@
 =

 #include <ofono/dbus.h>
 =

+#include <btio.h>
 #include "bluetooth.h"
 =

 static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
+static GSList *server_list =3D NULL;
 static gint ref_count;
 =

+static const gchar *dun_record =3D "<?xml version=3D\"1.0\" encoding=3D\"U=
TF-8\" ?>	\
+<record>									\
+  <attribute id=3D\"0x0001\">							\
+    <sequence>									\
+      <uuid value=3D\"0x1103\"/>							\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0004\">							\
+    <sequence>									\
+      <sequence>								\
+        <uuid value=3D\"0x0100\"/>						\
+      </sequence>								\
+      <sequence>								\
+        <uuid value=3D\"0x0003\"/>						\
+        <uint8 value=3D\"%u\" name=3D\"channel\"/>					\
+      </sequence>								\
+      <sequence>								\
+        <uuid value=3D\"0x0008\"/>						\
+      </sequence>								\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0009\">							\
+    <sequence>									\
+      <sequence>								\
+        <uuid value=3D\"0x1103\"/>						\
+        <uint16 value=3D\"0x0100\" name=3D\"version\"/>				\
+      </sequence>								\
+    </sequence>									\
+  </attribute>									\
+										\
+  <attribute id=3D\"0x0100\">							\
+    <text value=3D\"%s\" name=3D\"name\"/>						\
+  </attribute>									\
+</record>";
+
+#define TIMEOUT (60*1000) /* Timeout for user response (miliseconds) */
+
+struct client {
+	GIOChannel	*io;
+	guint		watch;
+};
+
+struct server {
+	guint16		service;
+	gchar		*name;
+	guint8		channel;
+	GIOChannel	*io;
+	gchar		*adapter;
+	guint		handle;
+	ConnectFunc	connect_cb;
+	gpointer	user_data;
+
+	struct client	client;
+};
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -370,6 +429,253 @@ static gboolean property_changed(DBusConnection *conn=
ection, DBusMessage *msg,
 	return TRUE;
 }
 =

+static void disconnect(struct server *server)
+{
+	struct client *client =3D &server->client;
+
+	if (!client->io)
+		return;
+
+	g_io_channel_unref(client->io);
+	client->io =3D NULL;
+
+	if (client->watch > 0) {
+		g_source_remove(client->watch);
+		client->watch =3D 0;
+	}
+
+	return;
+}
+
+static void server_stop(gpointer data, gpointer user_data)
+{
+	struct server *server =3D data;
+
+	disconnect(server);
+
+	if (server->handle) {
+		DBusMessage *msg;
+
+		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+						server->adapter,
+						BLUEZ_SERVICE_INTERFACE,
+						"RemoveRecord");
+		dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
+						DBUS_TYPE_INVALID);
+		g_dbus_send_message(connection, msg);
+
+		server->handle =3D 0;
+	}
+
+	if (server->io) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io =3D NULL;
+	}
+
+	g_free(server->adapter);
+	server->adapter =3D NULL;
+}
+
+static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpointer=
 data)
+{
+	struct server *server =3D data;
+
+	disconnect(server);
+
+	return FALSE;
+}
+
+static void cancel_authorization(struct server *server)
+{
+	DBusMessage *msg;
+
+	if (!server->adapter)
+		return;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, server->adapter,
+						BLUEZ_SERVICE_INTERFACE,
+						"CancelAuthorization");
+
+	g_dbus_send_message(connection, msg);
+}
+
+static void auth_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	struct client *client =3D &server->client;
+	GIOChannel *io =3D client->io;
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
+			cancel_authorization(server);
+
+		dbus_error_free(&derr);
+		goto failed;
+	}
+
+	ofono_info("RequestAuthorization succeeded");
+
+	if (!bt_io_accept(io, server->connect_cb, server->user_data,
+						NULL, &err)) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	g_source_remove(client->watch);
+
+	client->watch =3D g_io_add_watch(client->io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					client_event, server);
+
+	dbus_message_unref(reply);
+
+	return;
+
+failed:
+	dbus_message_unref(reply);
+	disconnect(server);
+}
+
+static gboolean auth_watch(GIOChannel *io, GIOCondition cond,
+						gpointer user_data)
+{
+	struct server *server =3D user_data;
+
+	cancel_authorization(server);
+	disconnect(server);
+
+	return FALSE;
+}
+
+static void confirm_event(GIOChannel *io, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	struct client *client =3D &server->client;
+	GError *err =3D NULL;
+	char address[18];
+	const char *addr;
+	guint8 channel;
+	int ret;
+
+	if (client->io) {
+		ofono_error("Rejecting connection since one client already \
+				connected");
+		return;
+	}
+
+	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_DEST, address,
+					BT_IO_OPT_CHANNEL, &channel,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		ofono_error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	ofono_info("New connection from: %s, channel %u", address, channel);
+
+	addr =3D address;
+	ret =3D bluetooth_send_with_reply(server->adapter,
+					BLUEZ_SERVICE_INTERFACE,
+					"RequestAuthorization",
+					auth_cb, server, NULL, TIMEOUT,
+					DBUS_TYPE_STRING, &addr,
+					DBUS_TYPE_UINT32, &server->handle,
+					DBUS_TYPE_INVALID);
+	if (ret < 0) {
+		ofono_error("Request Bluetooth authorization failed");
+		return;
+	}
+
+	ofono_info("RequestAuthorization(%s, 0x%x)", address, server->handle);
+
+	client->io =3D g_io_channel_ref(io);
+	client->watch =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					auth_watch, server);
+
+	return;
+}
+
+static void add_record_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct server *server =3D user_data;
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
+		server_stop(server, NULL);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &handle,
+					DBUS_TYPE_INVALID);
+	server->handle =3D handle;
+
+	ofono_info("Registered: %s, handle: 0x%x", server->name, handle);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void server_start(gpointer data, gpointer user_data)
+{
+	struct server *server =3D data;
+	gchar *path =3D user_data;
+	GError *err =3D NULL;
+	gchar *xml;
+
+	if (server->handle !=3D 0)
+		return;
+
+	if (server->service !=3D DUN_GW)
+		goto failed;
+
+	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, confirm_event,
+					server, NULL, &err,
+					BT_IO_OPT_CHANNEL, server->channel,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (!server->io) {
+		ofono_error("Bluetooth %s register failed: %s",
+					server->name, err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	server->adapter =3D g_strdup(path);
+
+	xml =3D g_markup_printf_escaped(dun_record, server->channel,
+					server->name);
+
+	bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE, "AddRecord",
+					add_record_cb, server, NULL, -1,
+					DBUS_TYPE_STRING, &xml,
+					DBUS_TYPE_INVALID);
+
+	g_free(xml);
+
+	return;
+
+failed:
+	server_stop(server, NULL);
+}
+
 static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
 {
 	const char *path =3D user_data;
@@ -394,6 +700,9 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 	g_hash_table_insert(adapter_address_hash,
 				g_strdup(path), g_strdup(addr));
 =

+	if (server_list)
+		g_slist_foreach(server_list, server_start, (gpointer)path);
+
 	for (l =3D device_list; l; l =3D l->next) {
 		const char *device =3D l->data;
 =

@@ -428,11 +737,26 @@ static gboolean adapter_removed(DBusConnection *conne=
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
+		if (!server->adapter)
+			continue;
+
+		if (!g_str_equal(path, server->adapter))
+			continue;
+
+		/* Don't remove handle if the adapter has been removed */
+		server->handle =3D 0;
+		server_stop(server, NULL);
+	}
+
 	return TRUE;
 }
 =

@@ -564,6 +888,7 @@ static int bluetooth_ref()
 static void bluetooth_unref()
 {
 	gboolean is_zero;
+	GSList *l;
 =

 	is_zero =3D g_atomic_int_dec_and_test(&ref_count);
 =

@@ -580,6 +905,20 @@ static void bluetooth_unref()
 =

 	if (adapter_address_hash)
 		g_hash_table_destroy(adapter_address_hash);
+
+	if (server_list =3D=3D NULL)
+		return;
+
+	for (l =3D server_list; l; l =3D l->next) {
+		struct server *server =3D l->data;
+
+		server_stop(server, NULL);
+		g_free(server->name);
+		g_free(server);
+	}
+
+	g_slist_free(server_list);
+	server_list =3D NULL;
 }
 =

 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
@@ -604,5 +943,45 @@ void bluetooth_unregister_uuid(const char *uuid)
 	bluetooth_unref();
 }
 =

+struct server *bluetooth_register_server(guint16 service, char *name,
+						guint8 channel, ConnectFunc cb,
+						gpointer user_data)
+{
+	struct server *server;
+	int err =3D bluetooth_ref();
+
+	if (err !=3D 0)
+		return NULL;
+
+	server =3D g_try_new0(struct server, 1);
+	if (!server)
+		return NULL;
+
+	server->service =3D service;
+	server->name =3D g_strdup(name);
+	server->channel =3D channel;
+	server->connect_cb =3D cb;
+	server->user_data =3D user_data;
+
+	server_list =3D g_slist_prepend(server_list, server);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+					manager_properties_cb, NULL, NULL, -1,
+					DBUS_TYPE_INVALID);
+
+	return server;
+}
+
+void bluetooth_unregister_server(struct server *server)
+{
+	server_list =3D g_slist_remove(server_list, server);
+
+	server_stop(server, NULL);
+	g_free(server->name);
+	g_free(server);
+
+	bluetooth_unref();
+}
+
 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index b70bb0c..1780e85 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -2,6 +2,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -22,6 +23,7 @@
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 =

 #define DBUS_TIMEOUT 15
 =

@@ -30,6 +32,9 @@
 /* Profiles bitfield */
 #define HFP_AG 0x01
 =

+/* Service bitfield */
+#define DUN_GW 0x01
+
 struct bluetooth_profile {
 	const char *name;
 	int (*create)(const char *device, const char *dev_addr,
@@ -38,10 +43,19 @@ struct bluetooth_profile {
 	void (*set_alias)(const char *device, const char *);
 };
 =

+typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
+
+struct server;
+
 int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
 =

+struct server *bluetooth_register_server(guint16 service, char *name,
+						guint8 channel, ConnectFunc cb,
+						gpointer user_data);
+void bluetooth_unregister_server(struct server *server);
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 							char *buf, int size);
 =

-- =

1.7.0.4


--===============0360050434271134694==--

