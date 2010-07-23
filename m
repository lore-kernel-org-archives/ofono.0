Content-Type: multipart/mixed; boundary="===============2497600340410362367=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/5] bluetooth: Add bluetooth server support for DUN
Date: Fri, 23 Jul 2010 17:40:31 +0800
Message-ID: <1279878034-12971-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1279878034-12971-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2497600340410362367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It watches Bluetooth adapter property changes and added DUN record to
listen client connection request. Btio library is the low level socket
API for RFCOMM connection.
---
 plugins/bluetooth.c |  379 ++++++++++++++++++++++++++++++++++++++++
 plugins/bluetooth.h |   14 ++
 plugins/btio.c      |  480 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/btio.h      |  118 +++++++++++++
 4 files changed, 991 insertions(+), 0 deletions(-)
 create mode 100644 plugins/btio.c
 create mode 100644 plugins/btio.h

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 10cc49d..5890161 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -35,12 +35,71 @@
 #include <ofono/dbus.h>
 =

 #include "bluetooth.h"
+#include "btio.h"
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
index fb0d841..ab42c99 100644
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
@@ -22,12 +23,16 @@
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 =

 #define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
 =

 /* Profiles bitfield */
 #define HFP_AG 0x01
 =

+/* Service bitfield */
+#define DUN_GW 0x01
+
 struct bluetooth_profile {
 	const char *name;
 	int (*create)(const char *device, const char *dev_addr,
@@ -36,10 +41,19 @@ struct bluetooth_profile {
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

diff --git a/plugins/btio.c b/plugins/btio.c
new file mode 100644
index 0000000..ab52a10
--- /dev/null
+++ b/plugins/btio.c
@@ -0,0 +1,480 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+#include <stdarg.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <poll.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "btio.h"
+
+#define ERROR_FAILED(gerr, str, err) \
+		g_set_error(gerr, BT_IO_ERROR, BT_IO_ERROR_FAILED, \
+				str ": %s (%d)", strerror(err), err)
+
+#define DEFAULT_DEFER_TIMEOUT 30
+
+struct set_opts {
+	bdaddr_t src;
+	int defer;
+	int sec_level;
+	uint8_t channel;
+	int master;
+};
+
+struct connect {
+	BtIOConnect connect;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+struct accept {
+	BtIOConnect connect;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+struct server {
+	BtIOConnect connect;
+	BtIOConfirm confirm;
+	gpointer user_data;
+	GDestroyNotify destroy;
+};
+
+static inline void bacpy(bdaddr_t *dst, const bdaddr_t *src)
+{
+	memcpy(dst, src, sizeof(bdaddr_t));
+}
+
+static void baswap(bdaddr_t *dst, const bdaddr_t *src)
+{
+	register unsigned char *d =3D (unsigned char *) dst;
+	register const unsigned char *s =3D (const unsigned char *) src;
+	register int i;
+
+	for (i =3D 0; i < 6; i++)
+		d[i] =3D s[5-i];
+}
+
+static int ba2str(const bdaddr_t *ba, char *str)
+{
+	uint8_t b[6];
+
+	baswap((bdaddr_t *) b, ba);
+	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+		b[0], b[1], b[2], b[3], b[4], b[5]);
+}
+
+static void server_remove(struct server *server)
+{
+	if (server->destroy)
+		server->destroy(server->user_data);
+	g_free(server);
+}
+
+static void accept_remove(struct accept *accept)
+{
+	if (accept->destroy)
+		accept->destroy(accept->user_data);
+	g_free(accept);
+}
+
+static gboolean accept_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct accept *accept =3D user_data;
+	GError *err =3D NULL;
+
+	/* If the user aborted this accept attempt */
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_HUP | G_IO_ERR))
+		g_set_error(&err, BT_IO_ERROR, BT_IO_ERROR_DISCONNECTED,
+				"HUP or ERR on socket");
+
+	accept->connect(io, err, accept->user_data);
+
+	g_clear_error(&err);
+
+	return FALSE;
+}
+
+static gboolean server_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct server *server =3D user_data;
+	int srv_sock, cli_sock;
+	GIOChannel *cli_io;
+
+	/* If the user closed the server */
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	srv_sock =3D g_io_channel_unix_get_fd(io);
+
+	cli_sock =3D accept(srv_sock, NULL, NULL);
+	if (cli_sock < 0)
+		return TRUE;
+
+	cli_io =3D g_io_channel_unix_new(cli_sock);
+
+	g_io_channel_set_close_on_unref(cli_io, TRUE);
+	g_io_channel_set_flags(cli_io, G_IO_FLAG_NONBLOCK, NULL);
+
+	if (server->confirm)
+		server->confirm(cli_io, server->user_data);
+	else
+		server->connect(cli_io, NULL, server->user_data);
+
+	g_io_channel_unref(cli_io);
+
+	return TRUE;
+}
+
+static void server_add(GIOChannel *io, BtIOConnect connect,
+				BtIOConfirm confirm, gpointer user_data,
+				GDestroyNotify destroy)
+{
+	struct server *server;
+	GIOCondition cond;
+
+	server =3D g_new0(struct server, 1);
+	server->connect =3D connect;
+	server->confirm =3D confirm;
+	server->user_data =3D user_data;
+	server->destroy =3D destroy;
+
+	cond =3D G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, server_cb, server,
+					(GDestroyNotify) server_remove);
+}
+
+static void accept_add(GIOChannel *io, BtIOConnect connect, gpointer user_=
data,
+							GDestroyNotify destroy)
+{
+	struct accept *accept;
+	GIOCondition cond;
+
+	accept =3D g_new0(struct accept, 1);
+	accept->connect =3D connect;
+	accept->user_data =3D user_data;
+	accept->destroy =3D destroy;
+
+	cond =3D G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT, cond, accept_cb, accept,
+					(GDestroyNotify) accept_remove);
+}
+
+static int rfcomm_set_lm(int sock, int level)
+{
+	int lm_map[] =3D {
+		0,
+		RFCOMM_LM_AUTH,
+		RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT,
+		RFCOMM_LM_AUTH | RFCOMM_LM_ENCRYPT | RFCOMM_LM_SECURE,
+	}, opt =3D lm_map[level];
+
+	if (setsockopt(sock, SOL_RFCOMM, RFCOMM_LM, &opt, sizeof(opt)) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static gboolean set_sec_level(int sock, BtIOType type, int level, GError *=
*err)
+{
+	struct bt_security sec;
+	int ret;
+
+	if (level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH) {
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Valid security level range is %d-%d",
+				BT_SECURITY_LOW, BT_SECURITY_HIGH);
+		return FALSE;
+	}
+
+	memset(&sec, 0, sizeof(sec));
+	sec.level =3D level;
+
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) =3D=3D 0)
+		return TRUE;
+
+	if (errno !=3D ENOPROTOOPT) {
+		ERROR_FAILED(err, "setsockopt(BT_SECURITY)", errno);
+		return FALSE;
+	}
+
+	ret =3D rfcomm_set_lm(sock, level);
+	if (ret < 0) {
+		ERROR_FAILED(err, "setsockopt(LM)", -ret);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static int rfcomm_bind(int sock, const bdaddr_t *src, uint8_t channel)
+{
+	struct sockaddr_rc addr;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.rc_family =3D AF_BLUETOOTH;
+	bacpy(&addr.rc_bdaddr, src);
+	addr.rc_channel =3D channel;
+
+	return bind(sock, (struct sockaddr *) &addr, sizeof(addr));
+}
+
+static gboolean rfcomm_set(int sock, int sec_level, int master, GError **e=
rr)
+{
+	if (sec_level && !set_sec_level(sock, BT_IO_RFCOMM, sec_level, err))
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean parse_set_opts(struct set_opts *opts, GError **err,
+						BtIOOption opt1, va_list args)
+{
+	BtIOOption opt =3D opt1;
+
+	memset(opts, 0, sizeof(*opts));
+
+	/* Set defaults */
+	opts->defer =3D DEFAULT_DEFER_TIMEOUT;
+	opts->master =3D -1;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_CHANNEL:
+			opts->channel =3D va_arg(args, int);
+			break;
+		case BT_IO_OPT_SEC_LEVEL:
+			opts->sec_level =3D va_arg(args, int);
+			break;
+		default:
+			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+					"Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt =3D va_arg(args, int);
+	}
+
+	return TRUE;
+}
+
+static gboolean get_peers(int sock, struct sockaddr *src, struct sockaddr =
*dst,
+				socklen_t len, GError **err)
+{
+	socklen_t olen;
+
+	memset(src, 0, len);
+	olen =3D len;
+	if (getsockname(sock, src, &olen) < 0) {
+		ERROR_FAILED(err, "getsockname", errno);
+		return FALSE;
+	}
+
+	memset(dst, 0, len);
+	olen =3D len;
+	if (getpeername(sock, dst, &olen) < 0) {
+		ERROR_FAILED(err, "getpeername", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
+								va_list args)
+{
+	BtIOOption opt =3D opt1;
+	struct sockaddr_rc src, dst;
+
+	if (!get_peers(sock, (struct sockaddr *) &src,
+				(struct sockaddr *) &dst, sizeof(src), err))
+		return FALSE;
+
+	while (opt !=3D BT_IO_OPT_INVALID) {
+		switch (opt) {
+		case BT_IO_OPT_SOURCE:
+			ba2str(&src.rc_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_DEST:
+			ba2str(&dst.rc_bdaddr, va_arg(args, char *));
+			break;
+		case BT_IO_OPT_CHANNEL:
+			*(va_arg(args, uint8_t *)) =3D src.rc_channel ?
+					src.rc_channel : dst.rc_channel;
+			break;
+		default:
+			g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+					"Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt =3D va_arg(args, int);
+	}
+
+	return TRUE;
+}
+
+static gboolean get_valist(GIOChannel *io, BtIOType type, GError **err,
+						BtIOOption opt1, va_list args)
+{
+	int sock =3D g_io_channel_unix_get_fd(io);
+
+	if (type !=3D BT_IO_RFCOMM) {
+		g_set_error(err, BT_IO_ERROR, BT_IO_ERROR_INVALID_ARGS,
+				"Unknown BtIO type %d", type);
+		return FALSE;
+	}
+
+	return rfcomm_get(sock, err, opt1, args);
+}
+
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_d=
ata,
+					GDestroyNotify destroy, GError **err)
+{
+	int sock;
+	char c;
+	struct pollfd pfd;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	memset(&pfd, 0, sizeof(pfd));
+	pfd.fd =3D sock;
+	pfd.events =3D POLLOUT;
+
+	if (poll(&pfd, 1, 0) < 0) {
+		ERROR_FAILED(err, "poll", errno);
+		return FALSE;
+	}
+
+	if (!(pfd.revents & POLLOUT)) {
+		int ret;
+		ret =3D read(sock, &c, 1);
+	}
+
+	accept_add(io, connect, user_data, destroy);
+
+	return TRUE;
+}
+
+gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
+							BtIOOption opt1, ...)
+{
+	va_list args;
+	gboolean ret;
+
+	va_start(args, opt1);
+	ret =3D get_valist(io, type, err, opt1, args);
+	va_end(args);
+
+	return ret;
+}
+
+static GIOChannel *create_io(BtIOType type, gboolean server,
+					struct set_opts *opts, GError **err)
+{
+	int sock;
+	GIOChannel *io;
+
+	if (type !=3D BT_IO_RFCOMM)
+		return NULL;
+
+	sock =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
+	if (sock < 0) {
+		ERROR_FAILED(err, "socket(STREAM, RFCOMM)", errno);
+		return NULL;
+	}
+
+	if (rfcomm_bind(sock, &opts->src,
+				server ? opts->channel : 0) < 0) {
+		ERROR_FAILED(err, "rfcomm_bind", errno);
+		return NULL;
+	}
+
+	if (!rfcomm_set(sock, opts->sec_level, opts->master, err))
+		return NULL;
+
+	io =3D g_io_channel_unix_new(sock);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	return io;
+}
+
+GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
+				BtIOConfirm confirm, gpointer user_data,
+				GDestroyNotify destroy, GError **err,
+				BtIOOption opt1, ...)
+{
+	GIOChannel *io;
+	va_list args;
+	struct set_opts opts;
+	int sock;
+	gboolean ret;
+
+	va_start(args, opt1);
+	ret =3D parse_set_opts(&opts, err, opt1, args);
+	va_end(args);
+
+	if (ret =3D=3D FALSE)
+		return NULL;
+
+	io =3D create_io(type, TRUE, &opts, err);
+	if (io =3D=3D NULL)
+		return NULL;
+
+	sock =3D g_io_channel_unix_get_fd(io);
+
+	if (confirm)
+		setsockopt(sock, SOL_BLUETOOTH, BT_DEFER_SETUP, &opts.defer,
+							sizeof(opts.defer));
+
+	if (listen(sock, 5) < 0) {
+		ERROR_FAILED(err, "listen", errno);
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	server_add(io, connect, confirm, user_data, destroy);
+
+	return io;
+}
+
+GQuark bt_io_error_quark(void)
+{
+	return g_quark_from_static_string("bt-io-error-quark");
+}
+
diff --git a/plugins/btio.h b/plugins/btio.h
new file mode 100644
index 0000000..78d5961
--- /dev/null
+++ b/plugins/btio.h
@@ -0,0 +1,118 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009  Nokia Corporation
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#include <glib.h>
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <endian.h>
+#include <byteswap.h>
+
+#ifndef AF_BLUETOOTH
+#define AF_BLUETOOTH	31
+#define PF_BLUETOOTH	AF_BLUETOOTH
+#endif
+
+#define BTPROTO_RFCOMM		3
+#define SOL_RFCOMM		18
+#define SOL_BLUETOOTH		274
+
+struct bt_security {
+	uint8_t level;
+};
+#define BT_SECURITY_SDP		0
+#define BT_SECURITY_LOW		1
+#define BT_SECURITY_MEDIUM	2
+#define BT_SECURITY_HIGH	3
+#define BT_SECURITY		4
+
+#define BT_DEFER_SETUP		7
+
+/* BD Address */
+typedef struct {
+	uint8_t b[6];
+} __attribute__((packed)) bdaddr_t;
+
+#define RFCOMM_LM       	0x03
+#define RFCOMM_LM_AUTH		0x0002
+#define RFCOMM_LM_ENCRYPT	0x0004
+#define RFCOMM_LM_TRUSTED	0x0008
+#define RFCOMM_LM_RELIABLE	0x0010
+#define RFCOMM_LM_SECURE	0x0020
+
+#include <sys/socket.h>
+
+/* RFCOMM socket address */
+struct sockaddr_rc {
+	sa_family_t	rc_family;
+	bdaddr_t	rc_bdaddr;
+	uint8_t		rc_channel;
+};
+
+typedef enum {
+	BT_IO_ERROR_DISCONNECTED,
+	BT_IO_ERROR_CONNECT_FAILED,
+	BT_IO_ERROR_FAILED,
+	BT_IO_ERROR_INVALID_ARGS,
+} BtIOError;
+
+#define BT_IO_ERROR bt_io_error_quark()
+
+GQuark bt_io_error_quark(void);
+
+typedef enum {
+	BT_IO_RFCOMM,
+} BtIOType;
+
+typedef enum {
+	BT_IO_OPT_INVALID =3D 0,
+	BT_IO_OPT_SOURCE,
+	BT_IO_OPT_DEST,
+	BT_IO_OPT_SEC_LEVEL,
+	BT_IO_OPT_CHANNEL,
+} BtIOOption;
+
+typedef enum {
+	BT_IO_SEC_SDP =3D 0,
+	BT_IO_SEC_LOW,
+	BT_IO_SEC_MEDIUM,
+	BT_IO_SEC_HIGH,
+} BtIOSecLevel;
+
+typedef void (*BtIOConfirm)(GIOChannel *io, gpointer user_data);
+
+typedef void (*BtIOConnect)(GIOChannel *io, GError *err, gpointer user_dat=
a);
+
+gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_d=
ata,
+					GDestroyNotify destroy, GError **err);
+
+gboolean bt_io_get(GIOChannel *io, BtIOType type, GError **err,
+					BtIOOption opt1, ...);
+
+GIOChannel *bt_io_listen(BtIOType type, BtIOConnect connect,
+					BtIOConfirm confirm, gpointer user_data,
+					GDestroyNotify destroy, GError **err,
+					BtIOOption opt1, ...);
-- =

1.7.0.4


--===============2497600340410362367==--

