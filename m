Content-Type: multipart/mixed; boundary="===============0671478887054977629=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/6] bluetooth: Add versioning information to BlueZ plugins
Date: Thu, 10 Jan 2013 11:44:45 -0300
Message-ID: <1357829089-16029-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1357829089-16029-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0671478887054977629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As BlueZ 5 introduced backwards incompatible changes, and we want to
keep support for BlueZ 4 based plugins for some time, we need to separate
the plugins that are based on BlueZ 4 from the ones based on BlueZ 5.

The HFP HF plugin is renamed to hfp_hf_bluez4 to make it easy to add
a HFP HF that talks to BlueZ 5.
---
 Makefile.am             |  18 +-
 dundee/bluetooth.c      |   2 +-
 plugins/bluetooth.c     | 989 --------------------------------------------=
----
 plugins/bluetooth.h     |  84 ----
 plugins/bluez4.c        | 989 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluez4.h        |  84 ++++
 plugins/dun_gw.c        |   2 +-
 plugins/hfp_ag.c        |   2 +-
 plugins/hfp_hf.c        | 552 ---------------------------
 plugins/hfp_hf_bluez4.c | 552 +++++++++++++++++++++++++++
 plugins/sap.c           |   2 +-
 plugins/telit.c         |   2 +-
 12 files changed, 1639 insertions(+), 1639 deletions(-)
 delete mode 100644 plugins/bluetooth.c
 delete mode 100644 plugins/bluetooth.h
 create mode 100644 plugins/bluez4.c
 create mode 100644 plugins/bluez4.h
 delete mode 100644 plugins/hfp_hf.c
 create mode 100644 plugins/hfp_hf_bluez4.c

diff --git a/Makefile.am b/Makefile.am
index 811a3f5..85824be 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -408,23 +408,23 @@ builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

 if BLUEZ4
-builtin_modules +=3D bluetooth
-builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
+builtin_modules +=3D bluez4
+builtin_sources +=3D plugins/bluez4.c plugins/bluez4.h
 =

 builtin_modules +=3D telit
-builtin_sources +=3D plugins/telit.c plugins/bluetooth.h
+builtin_sources +=3D plugins/telit.c plugins/bluez4.h
 =

 builtin_modules +=3D sap
-builtin_sources +=3D plugins/sap.c plugins/bluetooth.h
+builtin_sources +=3D plugins/sap.c plugins/bluez4.h
 =

-builtin_modules +=3D hfp
-builtin_sources +=3D plugins/hfp_hf.c plugins/bluetooth.h
+builtin_modules +=3D hfp_bluez4
+builtin_sources +=3D plugins/hfp_hf_bluez4.c plugins/bluez4.h
 =

 builtin_modules +=3D hfp_ag
-builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth.h
+builtin_sources +=3D plugins/hfp_ag.c plugins/bluez4.h
 =

 builtin_modules +=3D dun_gw
-builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
+builtin_sources +=3D plugins/dun_gw.c plugins/bluez4.h
 =

 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
@@ -747,7 +747,7 @@ if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

 dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) $(btio_sourc=
es) \
-			src/log.c src/dbus.c plugins/bluetooth.c \
+			src/log.c src/dbus.c plugins/bluez4.c \
 			dundee/dundee.h dundee/main.c dundee/dbus.c \
 			dundee/manager.c dundee/device.c dundee/bluetooth.c
 =

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
index 9ddc72c..58355d3 100644
--- a/dundee/bluetooth.c
+++ b/dundee/bluetooth.c
@@ -32,7 +32,7 @@
 =

 #include <glib.h>
 =

-#include "plugins/bluetooth.h"
+#include "plugins/bluez4.h"
 =

 #include "dundee.h"
 =

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
deleted file mode 100644
index 5d28530..0000000
--- a/plugins/bluetooth.c
+++ /dev/null
@@ -1,989 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *  Copyright (C) 2010  ProFUSION embedded systems
- *  Copyright (C) 2010  Gustavo F. Padovan <gustavo@padovan.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <glib.h>
-#include <gdbus.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-
-#include <btio.h>
-#include "bluetooth.h"
-
-static DBusConnection *connection;
-static GHashTable *uuid_hash =3D NULL;
-static GHashTable *adapter_address_hash =3D NULL;
-static gint bluetooth_refcount;
-static GSList *server_list =3D NULL;
-static const char *adapter_any_name =3D "any";
-static char *adapter_any_path;
-
-#define TIMEOUT 60 /* Timeout for user response (seconds) */
-
-struct server {
-	guint8 channel;
-	char *sdp_record;
-	guint32 handle;
-	GIOChannel *io;
-	ConnectFunc connect_cb;
-	gpointer user_data;
-};
-
-struct cb_data {
-	struct server *server;
-	char *path;
-	guint source;
-	GIOChannel *io;
-};
-
-void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
-				char *buf, int size)
-{
-	int i, j;
-
-	for (i =3D 0, j =3D 0; adapter_addr[j] && i < size - 1; j++)
-		if (adapter_addr[j] >=3D '0' && adapter_addr[j] <=3D '9')
-			buf[i++] =3D adapter_addr[j];
-		else if (adapter_addr[j] >=3D 'A' && adapter_addr[j] <=3D 'F')
-			buf[i++] =3D adapter_addr[j];
-
-	if (i < size - 1)
-		buf[i++] =3D '_';
-
-	for (j =3D 0; dev_addr[j] && i < size - 1; j++)
-		if (dev_addr[j] >=3D '0' && dev_addr[j] <=3D '9')
-			buf[i++] =3D dev_addr[j];
-		else if (dev_addr[j] >=3D 'A' && dev_addr[j] <=3D 'F')
-			buf[i++] =3D dev_addr[j];
-
-	buf[i] =3D '\0';
-}
-
-int bluetooth_send_with_reply(const char *path, const char *interface,
-				const char *method, DBusPendingCall **call,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, DBusFreeFunction free_func,
-				int timeout, int type, ...)
-{
-	DBusMessage *msg;
-	DBusPendingCall *c;
-	va_list args;
-	int err;
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
-						interface, method);
-	if (msg =3D=3D NULL) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
-		err =3D -ENOMEM;
-		goto fail;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		va_end(args);
-		err =3D -EIO;
-		goto fail;
-	}
-
-	va_end(args);
-
-	if (timeout > 0)
-		timeout *=3D 1000;
-
-	if (!dbus_connection_send_with_reply(connection, msg, &c, timeout)) {
-		ofono_error("Sending %s failed", method);
-		err =3D -EIO;
-		goto fail;
-	}
-
-	if (call !=3D NULL)
-		*call =3D c;
-
-	dbus_pending_call_set_notify(c, cb, user_data, free_func);
-	dbus_pending_call_unref(c);
-
-	dbus_message_unref(msg);
-
-	return 0;
-
-fail:
-	if (free_func && user_data)
-		free_func(user_data);
-
-	if (msg)
-		dbus_message_unref(msg);
-
-	return err;
-}
-
-typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
-
-struct property_handler {
-	const char *property;
-	PropertyHandler callback;
-	gpointer user_data;
-};
-
-static gint property_handler_compare(gconstpointer a, gconstpointer b)
-{
-	const struct property_handler *handler =3D a;
-	const char *property =3D b;
-
-	return strcmp(handler->property, property);
-}
-
-void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...)
-{
-	va_list args;
-	GSList *prop_handlers =3D NULL;
-	DBusMessageIter array, dict;
-
-	va_start(args, property);
-
-	while (property !=3D NULL) {
-		struct property_handler *handler =3D
-					g_new0(struct property_handler, 1);
-
-		handler->property =3D property;
-		handler->callback =3D va_arg(args, PropertyHandler);
-		handler->user_data =3D va_arg(args, gpointer);
-
-		property =3D va_arg(args, const char *);
-
-		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
-	}
-
-	va_end(args);
-
-	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
-		goto done;
-
-	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
-		goto done;
-
-	dbus_message_iter_recurse(&array, &dict);
-
-	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
-		DBusMessageIter entry, value;
-		const char *key;
-		GSList *l;
-
-		dbus_message_iter_recurse(&dict, &entry);
-
-		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
-			goto done;
-
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-
-		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
-			goto done;
-
-		dbus_message_iter_recurse(&entry, &value);
-
-		l =3D g_slist_find_custom(prop_handlers, key,
-					property_handler_compare);
-
-		if (l) {
-			struct property_handler *handler =3D l->data;
-
-			handler->callback(&value, handler->user_data);
-		}
-
-		dbus_message_iter_next(&dict);
-	}
-
-done:
-	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
-	g_slist_free(prop_handlers);
-}
-
-static void parse_uuids(DBusMessageIter *array, gpointer user_data)
-{
-	GSList **uuids =3D user_data;
-	DBusMessageIter value;
-
-	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
-		return;
-
-	dbus_message_iter_recurse(array, &value);
-
-	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
-		const char *uuid;
-
-		dbus_message_iter_get_basic(&value, &uuid);
-
-		*uuids =3D g_slist_prepend(*uuids, (char *) uuid);
-
-		dbus_message_iter_next(&value);
-	}
-}
-
-static void parse_string(DBusMessageIter *iter, gpointer user_data)
-{
-	char **str =3D user_data;
-	int arg_type =3D dbus_message_iter_get_arg_type(iter);
-
-	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D DBUS_TYPE_STRING)
-		return;
-
-	dbus_message_iter_get_basic(iter, str);
-}
-
-static void bluetooth_probe(GSList *uuids, const char *path,
-				const char *device, const char *adapter,
-				const char *alias)
-{
-	for (; uuids; uuids =3D uuids->next) {
-		struct bluetooth_profile *driver;
-		const char *uuid =3D uuids->data;
-		int err;
-
-		driver =3D g_hash_table_lookup(uuid_hash, uuid);
-		if (driver =3D=3D NULL)
-			continue;
-
-		err =3D driver->probe(path, device, adapter, alias);
-		if (err =3D=3D 0 || err =3D=3D -EALREADY)
-			continue;
-
-		ofono_error("%s probe: %s (%d)", driver->name, strerror(-err),
-									-err);
-	}
-}
-
-static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
-{
-	DBusMessage *reply;
-	const char *path =3D user_data;
-	const char *adapter =3D NULL;
-	const char *adapter_addr =3D NULL;
-	const char *device_addr =3D NULL;
-	const char *alias =3D NULL;
-	struct DBusError derr;
-	GSList *uuids =3D NULL;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Device.GetProperties replied an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	DBG("");
-
-	bluetooth_parse_properties(reply, "UUIDs", parse_uuids, &uuids,
-				"Adapter", parse_string, &adapter,
-				"Address", parse_string, &device_addr,
-				"Alias", parse_string, &alias, NULL);
-
-	if (adapter)
-		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
-							adapter);
-
-	if (!device_addr || !adapter_addr)
-		goto done;
-
-	bluetooth_probe(uuids, path, device_addr, adapter_addr, alias);
-
-done:
-	g_slist_free(uuids);
-	dbus_message_unref(reply);
-}
-
-static void parse_devices(DBusMessageIter *array, gpointer user_data)
-{
-	DBusMessageIter value;
-	GSList **device_list =3D user_data;
-
-	DBG("");
-
-	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
-		return;
-
-	dbus_message_iter_recurse(array, &value);
-
-	while (dbus_message_iter_get_arg_type(&value)
-			=3D=3D DBUS_TYPE_OBJECT_PATH) {
-		const char *path;
-
-		dbus_message_iter_get_basic(&value, &path);
-
-		*device_list =3D g_slist_prepend(*device_list, (gpointer) path);
-
-		dbus_message_iter_next(&value);
-	}
-}
-
-static gboolean property_changed(DBusConnection *conn, DBusMessage *msg,
-				void *user_data)
-{
-	const char *property;
-	DBusMessageIter iter;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
-		return FALSE;
-
-	dbus_message_iter_get_basic(&iter, &property);
-	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
-		GSList *uuids =3D NULL;
-		const char *path =3D dbus_message_get_path(msg);
-		DBusMessageIter variant;
-
-		if (!dbus_message_iter_next(&iter))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&iter, &variant);
-
-		parse_uuids(&variant, &uuids);
-
-		/* We need the full set of properties to be able to create
-		 * the modem properly, including Adapter and Alias, so
-		 * refetch everything again
-		 */
-		if (uuids)
-			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
-					device_properties_cb, g_strdup(path),
-					g_free, -1, DBUS_TYPE_INVALID);
-	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
-		const char *path =3D dbus_message_get_path(msg);
-		struct bluetooth_profile *profile;
-		const char *alias =3D NULL;
-		DBusMessageIter variant;
-		GHashTableIter hash_iter;
-		gpointer key, value;
-
-		if (!dbus_message_iter_next(&iter))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&iter, &variant);
-
-		parse_string(&variant, &alias);
-
-		g_hash_table_iter_init(&hash_iter, uuid_hash);
-		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
-			profile =3D value;
-			if (profile->set_alias)
-				profile->set_alias(path, alias);
-		}
-	}
-
-	return TRUE;
-}
-
-static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
-{
-	const char *path =3D user_data;
-	DBusMessage *reply;
-	DBusError derr;
-	GSList *device_list =3D NULL;
-	GSList *l;
-	const char *addr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Adapter.GetProperties replied an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	DBG("");
-
-	bluetooth_parse_properties(reply,
-					"Devices", parse_devices, &device_list,
-					"Address", parse_string, &addr,
-					NULL);
-
-	DBG("Adapter Address: %s, Path: %s", addr, path);
-	g_hash_table_insert(adapter_address_hash,
-				g_strdup(path), g_strdup(addr));
-
-	for (l =3D device_list; l; l =3D l->next) {
-		const char *device =3D l->data;
-
-		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
-					"GetProperties", NULL,
-					device_properties_cb, g_strdup(device),
-					g_free, -1, DBUS_TYPE_INVALID);
-	}
-
-done:
-	g_slist_free(device_list);
-	dbus_message_unref(reply);
-}
-
-static void get_adapter_properties(const char *path, const char *handle,
-						gpointer user_data)
-{
-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
-}
-
-static void remove_record(struct server *server)
-{
-	DBusMessage *msg;
-
-	if (server->handle =3D=3D 0)
-		return;
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, adapter_any_path,
-					BLUEZ_SERVICE_INTERFACE,
-					"RemoveRecord");
-	if (msg =3D=3D NULL) {
-		ofono_error("Unable to allocate D-Bus RemoveRecord message");
-		return;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
-					DBUS_TYPE_INVALID);
-	g_dbus_send_message(connection, msg);
-
-	ofono_info("Unregistered handle for channel %d: 0x%x",
-			server->channel, server->handle);
-}
-
-static void cb_data_destroy(gpointer data)
-{
-	struct cb_data *cb_data =3D data;
-
-	if (cb_data->source !=3D 0)
-		g_source_remove(cb_data->source);
-
-	g_free(cb_data->path);
-	g_free(cb_data);
-}
-
-static void cancel_authorization(struct cb_data *user_data)
-{
-	DBusMessage *msg;
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, user_data->path,
-						BLUEZ_SERVICE_INTERFACE,
-						"CancelAuthorization");
-
-	if (msg =3D=3D NULL) {
-		ofono_error("Unable to allocate D-Bus CancelAuthorization"
-				" message");
-		return;
-	}
-
-	g_dbus_send_message(connection, msg);
-}
-
-static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpointer=
 data)
-{
-	struct cb_data *cb_data =3D data;
-
-	cancel_authorization(cb_data);
-	cb_data->source =3D 0;
-
-	return FALSE;
-}
-
-static void auth_cb(DBusPendingCall *call, gpointer user_data)
-{
-	struct cb_data *cb_data =3D user_data;
-	struct server *server =3D cb_data->server;
-	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
-	DBusError derr;
-	GError *err =3D NULL;
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("RequestAuthorization error: %s, %s",
-				derr.name, derr.message);
-
-		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
-			cancel_authorization(cb_data);
-
-		dbus_error_free(&derr);
-	} else {
-		ofono_info("RequestAuthorization succeeded");
-
-		if (!bt_io_accept(cb_data->io, server->connect_cb,
-					server->user_data, NULL, &err)) {
-			ofono_error("%s", err->message);
-			g_error_free(err);
-		}
-	}
-
-	dbus_message_unref(reply);
-}
-
-static void new_connection(GIOChannel *io, gpointer user_data)
-{
-	struct server *server =3D user_data;
-	struct cb_data *cbd;
-	const char *addr;
-	GError *err =3D NULL;
-	char laddress[18], raddress[18];
-	guint8 channel;
-	GHashTableIter iter;
-	gpointer key, value;
-	const char *path;
-
-	bt_io_get(io, BT_IO_RFCOMM, &err, BT_IO_OPT_SOURCE, laddress,
-					BT_IO_OPT_DEST, raddress,
-					BT_IO_OPT_CHANNEL, &channel,
-					BT_IO_OPT_INVALID);
-	if (err) {
-		ofono_error("%s", err->message);
-		g_error_free(err);
-		return;
-	}
-
-	ofono_info("New connection for %s on channel %u from: %s,", laddress,
-							channel, raddress);
-
-	path =3D NULL;
-	g_hash_table_iter_init(&iter, adapter_address_hash);
-
-	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		if (g_str_equal(laddress, value) =3D=3D TRUE) {
-			path =3D key;
-			break;
-		}
-	}
-
-	if (path =3D=3D NULL)
-		return;
-
-	cbd =3D g_try_new0(struct cb_data, 1);
-	if (cbd =3D=3D NULL) {
-		ofono_error("Unable to allocate client cb_data structure");
-		return;
-	}
-
-	cbd->path =3D g_strdup(path);
-	cbd->server =3D server;
-	cbd->io =3D io;
-
-	addr =3D raddress;
-
-	if (bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
-					"RequestAuthorization", NULL,
-					auth_cb, cbd, cb_data_destroy,
-					TIMEOUT, DBUS_TYPE_STRING, &addr,
-					DBUS_TYPE_UINT32, &server->handle,
-					DBUS_TYPE_INVALID) < 0) {
-		ofono_error("Request Bluetooth authorization failed");
-		return;
-	}
-
-	ofono_info("RequestAuthorization(%s, 0x%x)", raddress, server->handle);
-
-	cbd->source =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					client_event, cbd);
-}
-
-static void remove_service_handle(gpointer data, gpointer user_data)
-{
-	struct server *server =3D data;
-
-	server->handle =3D 0;
-}
-
-static void add_record_cb(DBusPendingCall *call, gpointer user_data)
-{
-	struct server *server =3D user_data;
-	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
-	DBusError derr;
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Replied with an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &server->handle,
-					DBUS_TYPE_INVALID);
-
-	ofono_info("Registered handle for channel %d: 0x%x",
-			server->channel, server->handle);
-
-done:
-	dbus_message_unref(reply);
-}
-
-static void add_record(gpointer data, gpointer user_data)
-{
-	struct server *server =3D data;
-
-	if (server->sdp_record =3D=3D NULL)
-		return;
-
-	bluetooth_send_with_reply(adapter_any_path,
-					BLUEZ_SERVICE_INTERFACE, "AddRecord",
-					NULL, add_record_cb, server, NULL, -1,
-					DBUS_TYPE_STRING, &server->sdp_record,
-					DBUS_TYPE_INVALID);
-}
-
-static void find_adapter_cb(DBusPendingCall *call, gpointer user_data)
-{
-	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
-	DBusError derr;
-	const char *path;
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Replied with an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID);
-
-	adapter_any_path =3D g_strdup(path);
-
-	g_slist_foreach(server_list, (GFunc) add_record, NULL);
-
-done:
-	dbus_message_unref(reply);
-}
-
-static gboolean adapter_added(DBusConnection *conn, DBusMessage *message,
-				void *user_data)
-{
-	const char *path;
-
-	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-			"GetProperties", NULL, adapter_properties_cb,
-			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
-
-	return TRUE;
-}
-
-static void bluetooth_remove(gpointer key, gpointer value, gpointer user_d=
ata)
-{
-	struct bluetooth_profile *profile =3D value;
-
-	profile->remove(user_data);
-}
-
-static gboolean adapter_removed(DBusConnection *conn,
-				DBusMessage *message, void *user_data)
-{
-	const char *path;
-
-	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID) =3D=3D FALSE)
-		return FALSE;
-
-	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
-	g_hash_table_remove(adapter_address_hash, path);
-
-	return TRUE;
-}
-
-static gboolean device_removed(DBusConnection *conn,
-				DBusMessage *message, void *user_data)
-{
-	const char *path;
-
-	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID) =3D=3D FALSE)
-		return FALSE;
-
-	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
-
-	return TRUE;
-}
-
-static void parse_adapters(DBusMessageIter *array, gpointer user_data)
-{
-	DBusMessageIter value;
-
-	DBG("");
-
-	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
-		return;
-
-	dbus_message_iter_recurse(array, &value);
-
-	while (dbus_message_iter_get_arg_type(&value)
-			=3D=3D DBUS_TYPE_OBJECT_PATH) {
-		const char *path;
-
-		dbus_message_iter_get_basic(&value, &path);
-
-		DBG("Calling GetProperties on %s", path);
-
-		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
-				"GetProperties", NULL, adapter_properties_cb,
-				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
-
-		dbus_message_iter_next(&value);
-	}
-}
-
-static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
-{
-	DBusMessage *reply;
-	DBusError derr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Manager.GetProperties() replied an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	DBG("");
-
-	bluetooth_parse_properties(reply, "Adapters", parse_adapters, NULL,
-						NULL);
-
-done:
-	dbus_message_unref(reply);
-}
-
-static void bluetooth_connect(DBusConnection *conn, void *user_data)
-{
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				NULL, manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
-
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
-				NULL, find_adapter_cb, NULL, NULL, -1,
-				DBUS_TYPE_STRING, &adapter_any_name,
-				DBUS_TYPE_INVALID);
-}
-
-static void bluetooth_disconnect(DBusConnection *conn, void *user_data)
-{
-	if (uuid_hash =3D=3D NULL)
-		return;
-
-	g_hash_table_foreach(uuid_hash, bluetooth_remove, NULL);
-
-	g_slist_foreach(server_list, (GFunc) remove_service_handle, NULL);
-}
-
-static guint bluetooth_watch;
-static guint adapter_added_watch;
-static guint adapter_removed_watch;
-static guint device_removed_watch;
-static guint property_watch;
-
-static void bluetooth_ref(void)
-{
-	if (bluetooth_refcount > 0)
-		goto increment;
-
-	connection =3D ofono_dbus_get_connection();
-
-	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
-					bluetooth_connect,
-					bluetooth_disconnect, NULL, NULL);
-
-	adapter_added_watch =3D g_dbus_add_signal_watch(connection, BLUEZ_SERVICE,
-						NULL, BLUEZ_MANAGER_INTERFACE,
-						"AdapterAdded",
-						adapter_added, NULL, NULL);
-
-	adapter_removed_watch =3D g_dbus_add_signal_watch(connection,
-						BLUEZ_SERVICE, NULL,
-						BLUEZ_MANAGER_INTERFACE,
-						"AdapterRemoved",
-						adapter_removed, NULL, NULL);
-
-	device_removed_watch =3D g_dbus_add_signal_watch(connection,
-						BLUEZ_SERVICE, NULL,
-						BLUEZ_ADAPTER_INTERFACE,
-						"DeviceRemoved",
-						device_removed, NULL, NULL);
-
-	property_watch =3D g_dbus_add_signal_watch(connection,
-						BLUEZ_SERVICE, NULL,
-						BLUEZ_DEVICE_INTERFACE,
-						"PropertyChanged",
-						property_changed, NULL, NULL);
-
-	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
-			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
-		goto remove;
-	}
-
-	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, NULL);
-
-	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, g_free);
-
-increment:
-	g_atomic_int_inc(&bluetooth_refcount);
-
-	return;
-
-remove:
-	g_dbus_remove_watch(connection, bluetooth_watch);
-	g_dbus_remove_watch(connection, adapter_added_watch);
-	g_dbus_remove_watch(connection, adapter_removed_watch);
-	g_dbus_remove_watch(connection, property_watch);
-}
-
-static void bluetooth_unref(void)
-{
-	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
-		return;
-
-	g_free(adapter_any_path);
-	adapter_any_path =3D NULL;
-
-	g_dbus_remove_watch(connection, bluetooth_watch);
-	g_dbus_remove_watch(connection, adapter_added_watch);
-	g_dbus_remove_watch(connection, adapter_removed_watch);
-	g_dbus_remove_watch(connection, property_watch);
-
-	g_hash_table_destroy(uuid_hash);
-	g_hash_table_destroy(adapter_address_hash);
-}
-
-void bluetooth_get_properties()
-{
-	g_hash_table_foreach(adapter_address_hash,
-				(GHFunc) get_adapter_properties, NULL);
-}
-
-int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
-{
-	bluetooth_ref();
-
-	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
-
-	g_hash_table_foreach(adapter_address_hash,
-				(GHFunc) get_adapter_properties, NULL);
-
-	return 0;
-}
-
-void bluetooth_unregister_uuid(const char *uuid)
-{
-	g_hash_table_remove(uuid_hash, uuid);
-
-	bluetooth_unref();
-}
-
-struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
-					ConnectFunc cb, gpointer user_data)
-{
-	struct server *server;
-	GError *err =3D NULL;
-
-	server =3D g_try_new0(struct server, 1);
-	if (!server)
-		return NULL;
-
-	server->channel =3D channel;
-
-	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, new_connection,
-					server, NULL, &err,
-					BT_IO_OPT_CHANNEL, server->channel,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-					BT_IO_OPT_INVALID);
-	if (server->io =3D=3D NULL) {
-		g_error_free(err);
-		g_free(server);
-		return NULL;
-	}
-
-	bluetooth_ref();
-
-	if (sdp_record !=3D NULL)
-		server->sdp_record =3D g_strdup(sdp_record);
-
-	server->connect_cb =3D cb;
-	server->user_data =3D user_data;
-
-	server_list =3D g_slist_prepend(server_list, server);
-
-	if (adapter_any_path !=3D NULL)
-		add_record(server, NULL);
-
-	return server;
-}
-
-void bluetooth_unregister_server(struct server *server)
-{
-	server_list =3D g_slist_remove(server_list, server);
-
-	remove_record(server);
-
-	if (server->io !=3D NULL) {
-		g_io_channel_shutdown(server->io, TRUE, NULL);
-		g_io_channel_unref(server->io);
-		server->io =3D NULL;
-	}
-
-	g_free(server->sdp_record);
-	g_free(server);
-
-	bluetooth_unref();
-}
-
-OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
deleted file mode 100644
index 4fc16ad..0000000
--- a/plugins/bluetooth.h
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2010  Gustavo F. Padovan <gustavo@padovan.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#include <ofono/modem.h>
-#include <ofono/dbus.h>
-
-#define	BLUEZ_SERVICE "org.bluez"
-#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
-#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
-#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
-#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
-#define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
-
-#define DBUS_TIMEOUT 15
-
-#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
-#define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
-#define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
-#define SAP_UUID	"0000112d-0000-1000-8000-00805f9b34fb"
-
-struct bluetooth_profile {
-	const char *name;
-	int (*probe)(const char *device, const char *dev_addr,
-			const char *adapter_addr, const char *alias);
-	void (*remove)(const char *prefix);
-	void (*set_alias)(const char *device, const char *);
-};
-
-struct bluetooth_sap_driver {
-	const char *name;
-	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
-								int bt_fd);
-	void (*pre_sim) (struct ofono_modem *modem);
-	void (*post_sim) (struct ofono_modem *modem);
-	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
-				ofono_modem_online_cb_t cb, void *user_data);
-	void (*post_online) (struct ofono_modem *modem);
-	int (*disable) (struct ofono_modem *modem);
-};
-
-struct server;
-
-typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
-
-void bluetooth_get_properties();
-int bluetooth_register_uuid(const char *uuid,
-				struct bluetooth_profile *profile);
-void bluetooth_unregister_uuid(const char *uuid);
-
-struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
-					ConnectFunc cb, gpointer user_data);
-void bluetooth_unregister_server(struct server *server);
-
-void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
-							char *buf, int size);
-
-int bluetooth_send_with_reply(const char *path, const char *interface,
-				const char *method, DBusPendingCall **call,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, DBusFreeFunction free_func,
-				int timeout, int type, ...);
-void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...);
-
-int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
-					struct ofono_modem *modem);
-void bluetooth_sap_client_unregister(struct ofono_modem *modem);
diff --git a/plugins/bluez4.c b/plugins/bluez4.c
new file mode 100644
index 0000000..6a29d9f
--- /dev/null
+++ b/plugins/bluez4.c
@@ -0,0 +1,989 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2010  Gustavo F. Padovan <gustavo@padovan.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+
+#include <btio.h>
+#include "bluez4.h"
+
+static DBusConnection *connection;
+static GHashTable *uuid_hash =3D NULL;
+static GHashTable *adapter_address_hash =3D NULL;
+static gint bluetooth_refcount;
+static GSList *server_list =3D NULL;
+static const char *adapter_any_name =3D "any";
+static char *adapter_any_path;
+
+#define TIMEOUT 60 /* Timeout for user response (seconds) */
+
+struct server {
+	guint8 channel;
+	char *sdp_record;
+	guint32 handle;
+	GIOChannel *io;
+	ConnectFunc connect_cb;
+	gpointer user_data;
+};
+
+struct cb_data {
+	struct server *server;
+	char *path;
+	guint source;
+	GIOChannel *io;
+};
+
+void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
+				char *buf, int size)
+{
+	int i, j;
+
+	for (i =3D 0, j =3D 0; adapter_addr[j] && i < size - 1; j++)
+		if (adapter_addr[j] >=3D '0' && adapter_addr[j] <=3D '9')
+			buf[i++] =3D adapter_addr[j];
+		else if (adapter_addr[j] >=3D 'A' && adapter_addr[j] <=3D 'F')
+			buf[i++] =3D adapter_addr[j];
+
+	if (i < size - 1)
+		buf[i++] =3D '_';
+
+	for (j =3D 0; dev_addr[j] && i < size - 1; j++)
+		if (dev_addr[j] >=3D '0' && dev_addr[j] <=3D '9')
+			buf[i++] =3D dev_addr[j];
+		else if (dev_addr[j] >=3D 'A' && dev_addr[j] <=3D 'F')
+			buf[i++] =3D dev_addr[j];
+
+	buf[i] =3D '\0';
+}
+
+int bluetooth_send_with_reply(const char *path, const char *interface,
+				const char *method, DBusPendingCall **call,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *c;
+	va_list args;
+	int err;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+						interface, method);
+	if (msg =3D=3D NULL) {
+		ofono_error("Unable to allocate new D-Bus %s message", method);
+		err =3D -ENOMEM;
+		goto fail;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		va_end(args);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	va_end(args);
+
+	if (timeout > 0)
+		timeout *=3D 1000;
+
+	if (!dbus_connection_send_with_reply(connection, msg, &c, timeout)) {
+		ofono_error("Sending %s failed", method);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	if (call !=3D NULL)
+		*call =3D c;
+
+	dbus_pending_call_set_notify(c, cb, user_data, free_func);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+
+	return 0;
+
+fail:
+	if (free_func && user_data)
+		free_func(user_data);
+
+	if (msg)
+		dbus_message_unref(msg);
+
+	return err;
+}
+
+typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
+
+struct property_handler {
+	const char *property;
+	PropertyHandler callback;
+	gpointer user_data;
+};
+
+static gint property_handler_compare(gconstpointer a, gconstpointer b)
+{
+	const struct property_handler *handler =3D a;
+	const char *property =3D b;
+
+	return strcmp(handler->property, property);
+}
+
+void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...)
+{
+	va_list args;
+	GSList *prop_handlers =3D NULL;
+	DBusMessageIter array, dict;
+
+	va_start(args, property);
+
+	while (property !=3D NULL) {
+		struct property_handler *handler =3D
+					g_new0(struct property_handler, 1);
+
+		handler->property =3D property;
+		handler->callback =3D va_arg(args, PropertyHandler);
+		handler->user_data =3D va_arg(args, gpointer);
+
+		property =3D va_arg(args, const char *);
+
+		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
+	}
+
+	va_end(args);
+
+	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
+		goto done;
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, value;
+		const char *key;
+		GSList *l;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+			goto done;
+
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			goto done;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		l =3D g_slist_find_custom(prop_handlers, key,
+					property_handler_compare);
+
+		if (l) {
+			struct property_handler *handler =3D l->data;
+
+			handler->callback(&value, handler->user_data);
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
+	g_slist_free(prop_handlers);
+}
+
+static void parse_uuids(DBusMessageIter *array, gpointer user_data)
+{
+	GSList **uuids =3D user_data;
+	DBusMessageIter value;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value) =3D=3D DBUS_TYPE_STRING) {
+		const char *uuid;
+
+		dbus_message_iter_get_basic(&value, &uuid);
+
+		*uuids =3D g_slist_prepend(*uuids, (char *) uuid);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void parse_string(DBusMessageIter *iter, gpointer user_data)
+{
+	char **str =3D user_data;
+	int arg_type =3D dbus_message_iter_get_arg_type(iter);
+
+	if (arg_type !=3D DBUS_TYPE_OBJECT_PATH && arg_type !=3D DBUS_TYPE_STRING)
+		return;
+
+	dbus_message_iter_get_basic(iter, str);
+}
+
+static void bluetooth_probe(GSList *uuids, const char *path,
+				const char *device, const char *adapter,
+				const char *alias)
+{
+	for (; uuids; uuids =3D uuids->next) {
+		struct bluetooth_profile *driver;
+		const char *uuid =3D uuids->data;
+		int err;
+
+		driver =3D g_hash_table_lookup(uuid_hash, uuid);
+		if (driver =3D=3D NULL)
+			continue;
+
+		err =3D driver->probe(path, device, adapter, alias);
+		if (err =3D=3D 0 || err =3D=3D -EALREADY)
+			continue;
+
+		ofono_error("%s probe: %s (%d)", driver->name, strerror(-err),
+									-err);
+	}
+}
+
+static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	const char *path =3D user_data;
+	const char *adapter =3D NULL;
+	const char *adapter_addr =3D NULL;
+	const char *device_addr =3D NULL;
+	const char *alias =3D NULL;
+	struct DBusError derr;
+	GSList *uuids =3D NULL;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Device.GetProperties replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+	bluetooth_parse_properties(reply, "UUIDs", parse_uuids, &uuids,
+				"Adapter", parse_string, &adapter,
+				"Address", parse_string, &device_addr,
+				"Alias", parse_string, &alias, NULL);
+
+	if (adapter)
+		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
+							adapter);
+
+	if (!device_addr || !adapter_addr)
+		goto done;
+
+	bluetooth_probe(uuids, path, device_addr, adapter_addr, alias);
+
+done:
+	g_slist_free(uuids);
+	dbus_message_unref(reply);
+}
+
+static void parse_devices(DBusMessageIter *array, gpointer user_data)
+{
+	DBusMessageIter value;
+	GSList **device_list =3D user_data;
+
+	DBG("");
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value)
+			=3D=3D DBUS_TYPE_OBJECT_PATH) {
+		const char *path;
+
+		dbus_message_iter_get_basic(&value, &path);
+
+		*device_list =3D g_slist_prepend(*device_list, (gpointer) path);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static gboolean property_changed(DBusConnection *conn, DBusMessage *msg,
+				void *user_data)
+{
+	const char *property;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
+		GSList *uuids =3D NULL;
+		const char *path =3D dbus_message_get_path(msg);
+		DBusMessageIter variant;
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		parse_uuids(&variant, &uuids);
+
+		/* We need the full set of properties to be able to create
+		 * the modem properly, including Adapter and Alias, so
+		 * refetch everything again
+		 */
+		if (uuids)
+			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
+					"GetProperties", NULL,
+					device_properties_cb, g_strdup(path),
+					g_free, -1, DBUS_TYPE_INVALID);
+	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
+		const char *path =3D dbus_message_get_path(msg);
+		struct bluetooth_profile *profile;
+		const char *alias =3D NULL;
+		DBusMessageIter variant;
+		GHashTableIter hash_iter;
+		gpointer key, value;
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		parse_string(&variant, &alias);
+
+		g_hash_table_iter_init(&hash_iter, uuid_hash);
+		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
+			profile =3D value;
+			if (profile->set_alias)
+				profile->set_alias(path, alias);
+		}
+	}
+
+	return TRUE;
+}
+
+static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	const char *path =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+	GSList *device_list =3D NULL;
+	GSList *l;
+	const char *addr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Adapter.GetProperties replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+	bluetooth_parse_properties(reply,
+					"Devices", parse_devices, &device_list,
+					"Address", parse_string, &addr,
+					NULL);
+
+	DBG("Adapter Address: %s, Path: %s", addr, path);
+	g_hash_table_insert(adapter_address_hash,
+				g_strdup(path), g_strdup(addr));
+
+	for (l =3D device_list; l; l =3D l->next) {
+		const char *device =3D l->data;
+
+		bluetooth_send_with_reply(device, BLUEZ_DEVICE_INTERFACE,
+					"GetProperties", NULL,
+					device_properties_cb, g_strdup(device),
+					g_free, -1, DBUS_TYPE_INVALID);
+	}
+
+done:
+	g_slist_free(device_list);
+	dbus_message_unref(reply);
+}
+
+static void get_adapter_properties(const char *path, const char *handle,
+						gpointer user_data)
+{
+	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+			"GetProperties", NULL, adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+}
+
+static void remove_record(struct server *server)
+{
+	DBusMessage *msg;
+
+	if (server->handle =3D=3D 0)
+		return;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, adapter_any_path,
+					BLUEZ_SERVICE_INTERFACE,
+					"RemoveRecord");
+	if (msg =3D=3D NULL) {
+		ofono_error("Unable to allocate D-Bus RemoveRecord message");
+		return;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &server->handle,
+					DBUS_TYPE_INVALID);
+	g_dbus_send_message(connection, msg);
+
+	ofono_info("Unregistered handle for channel %d: 0x%x",
+			server->channel, server->handle);
+}
+
+static void cb_data_destroy(gpointer data)
+{
+	struct cb_data *cb_data =3D data;
+
+	if (cb_data->source !=3D 0)
+		g_source_remove(cb_data->source);
+
+	g_free(cb_data->path);
+	g_free(cb_data);
+}
+
+static void cancel_authorization(struct cb_data *user_data)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, user_data->path,
+						BLUEZ_SERVICE_INTERFACE,
+						"CancelAuthorization");
+
+	if (msg =3D=3D NULL) {
+		ofono_error("Unable to allocate D-Bus CancelAuthorization"
+				" message");
+		return;
+	}
+
+	g_dbus_send_message(connection, msg);
+}
+
+static gboolean client_event(GIOChannel *chan, GIOCondition cond, gpointer=
 data)
+{
+	struct cb_data *cb_data =3D data;
+
+	cancel_authorization(cb_data);
+	cb_data->source =3D 0;
+
+	return FALSE;
+}
+
+static void auth_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct cb_data *cb_data =3D user_data;
+	struct server *server =3D cb_data->server;
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
+	} else {
+		ofono_info("RequestAuthorization succeeded");
+
+		if (!bt_io_accept(cb_data->io, server->connect_cb,
+					server->user_data, NULL, &err)) {
+			ofono_error("%s", err->message);
+			g_error_free(err);
+		}
+	}
+
+	dbus_message_unref(reply);
+}
+
+static void new_connection(GIOChannel *io, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	struct cb_data *cbd;
+	const char *addr;
+	GError *err =3D NULL;
+	char laddress[18], raddress[18];
+	guint8 channel;
+	GHashTableIter iter;
+	gpointer key, value;
+	const char *path;
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
+	path =3D NULL;
+	g_hash_table_iter_init(&iter, adapter_address_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		if (g_str_equal(laddress, value) =3D=3D TRUE) {
+			path =3D key;
+			break;
+		}
+	}
+
+	if (path =3D=3D NULL)
+		return;
+
+	cbd =3D g_try_new0(struct cb_data, 1);
+	if (cbd =3D=3D NULL) {
+		ofono_error("Unable to allocate client cb_data structure");
+		return;
+	}
+
+	cbd->path =3D g_strdup(path);
+	cbd->server =3D server;
+	cbd->io =3D io;
+
+	addr =3D raddress;
+
+	if (bluetooth_send_with_reply(path, BLUEZ_SERVICE_INTERFACE,
+					"RequestAuthorization", NULL,
+					auth_cb, cbd, cb_data_destroy,
+					TIMEOUT, DBUS_TYPE_STRING, &addr,
+					DBUS_TYPE_UINT32, &server->handle,
+					DBUS_TYPE_INVALID) < 0) {
+		ofono_error("Request Bluetooth authorization failed");
+		return;
+	}
+
+	ofono_info("RequestAuthorization(%s, 0x%x)", raddress, server->handle);
+
+	cbd->source =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					client_event, cbd);
+}
+
+static void remove_service_handle(gpointer data, gpointer user_data)
+{
+	struct server *server =3D data;
+
+	server->handle =3D 0;
+}
+
+static void add_record_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct server *server =3D user_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
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
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_UINT32, &server->handle,
+					DBUS_TYPE_INVALID);
+
+	ofono_info("Registered handle for channel %d: 0x%x",
+			server->channel, server->handle);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void add_record(gpointer data, gpointer user_data)
+{
+	struct server *server =3D data;
+
+	if (server->sdp_record =3D=3D NULL)
+		return;
+
+	bluetooth_send_with_reply(adapter_any_path,
+					BLUEZ_SERVICE_INTERFACE, "AddRecord",
+					NULL, add_record_cb, server, NULL, -1,
+					DBUS_TYPE_STRING, &server->sdp_record,
+					DBUS_TYPE_INVALID);
+}
+
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
+	g_slist_foreach(server_list, (GFunc) add_record, NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static gboolean adapter_added(DBusConnection *conn, DBusMessage *message,
+				void *user_data)
+{
+	const char *path;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+			"GetProperties", NULL, adapter_properties_cb,
+			g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+
+	return TRUE;
+}
+
+static void bluetooth_remove(gpointer key, gpointer value, gpointer user_d=
ata)
+{
+	struct bluetooth_profile *profile =3D value;
+
+	profile->remove(user_data);
+}
+
+static gboolean adapter_removed(DBusConnection *conn,
+				DBusMessage *message, void *user_data)
+{
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return FALSE;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
+	g_hash_table_remove(adapter_address_hash, path);
+
+	return TRUE;
+}
+
+static gboolean device_removed(DBusConnection *conn,
+				DBusMessage *message, void *user_data)
+{
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return FALSE;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, (gpointer) path);
+
+	return TRUE;
+}
+
+static void parse_adapters(DBusMessageIter *array, gpointer user_data)
+{
+	DBusMessageIter value;
+
+	DBG("");
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		return;
+
+	dbus_message_iter_recurse(array, &value);
+
+	while (dbus_message_iter_get_arg_type(&value)
+			=3D=3D DBUS_TYPE_OBJECT_PATH) {
+		const char *path;
+
+		dbus_message_iter_get_basic(&value, &path);
+
+		DBG("Calling GetProperties on %s", path);
+
+		bluetooth_send_with_reply(path, BLUEZ_ADAPTER_INTERFACE,
+				"GetProperties", NULL, adapter_properties_cb,
+				g_strdup(path), g_free, -1, DBUS_TYPE_INVALID);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Manager.GetProperties() replied an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+	bluetooth_parse_properties(reply, "Adapters", parse_adapters, NULL,
+						NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void bluetooth_connect(DBusConnection *conn, void *user_data)
+{
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				NULL, manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
+				NULL, find_adapter_cb, NULL, NULL, -1,
+				DBUS_TYPE_STRING, &adapter_any_name,
+				DBUS_TYPE_INVALID);
+}
+
+static void bluetooth_disconnect(DBusConnection *conn, void *user_data)
+{
+	if (uuid_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove, NULL);
+
+	g_slist_foreach(server_list, (GFunc) remove_service_handle, NULL);
+}
+
+static guint bluetooth_watch;
+static guint adapter_added_watch;
+static guint adapter_removed_watch;
+static guint device_removed_watch;
+static guint property_watch;
+
+static void bluetooth_ref(void)
+{
+	if (bluetooth_refcount > 0)
+		goto increment;
+
+	connection =3D ofono_dbus_get_connection();
+
+	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
+					bluetooth_connect,
+					bluetooth_disconnect, NULL, NULL);
+
+	adapter_added_watch =3D g_dbus_add_signal_watch(connection, BLUEZ_SERVICE,
+						NULL, BLUEZ_MANAGER_INTERFACE,
+						"AdapterAdded",
+						adapter_added, NULL, NULL);
+
+	adapter_removed_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterRemoved",
+						adapter_removed, NULL, NULL);
+
+	device_removed_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
+						BLUEZ_ADAPTER_INTERFACE,
+						"DeviceRemoved",
+						device_removed, NULL, NULL);
+
+	property_watch =3D g_dbus_add_signal_watch(connection,
+						BLUEZ_SERVICE, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						property_changed, NULL, NULL);
+
+	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
+			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
+		goto remove;
+	}
+
+	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, g_free);
+
+increment:
+	g_atomic_int_inc(&bluetooth_refcount);
+
+	return;
+
+remove:
+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
+}
+
+static void bluetooth_unref(void)
+{
+	if (g_atomic_int_dec_and_test(&bluetooth_refcount) =3D=3D FALSE)
+		return;
+
+	g_free(adapter_any_path);
+	adapter_any_path =3D NULL;
+
+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
+
+	g_hash_table_destroy(uuid_hash);
+	g_hash_table_destroy(adapter_address_hash);
+}
+
+void bluetooth_get_properties()
+{
+	g_hash_table_foreach(adapter_address_hash,
+				(GHFunc) get_adapter_properties, NULL);
+}
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	bluetooth_ref();
+
+	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+
+	g_hash_table_foreach(adapter_address_hash,
+				(GHFunc) get_adapter_properties, NULL);
+
+	return 0;
+}
+
+void bluetooth_unregister_uuid(const char *uuid)
+{
+	g_hash_table_remove(uuid_hash, uuid);
+
+	bluetooth_unref();
+}
+
+struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
+					ConnectFunc cb, gpointer user_data)
+{
+	struct server *server;
+	GError *err =3D NULL;
+
+	server =3D g_try_new0(struct server, 1);
+	if (!server)
+		return NULL;
+
+	server->channel =3D channel;
+
+	server->io =3D bt_io_listen(BT_IO_RFCOMM, NULL, new_connection,
+					server, NULL, &err,
+					BT_IO_OPT_CHANNEL, server->channel,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID);
+	if (server->io =3D=3D NULL) {
+		g_error_free(err);
+		g_free(server);
+		return NULL;
+	}
+
+	bluetooth_ref();
+
+	if (sdp_record !=3D NULL)
+		server->sdp_record =3D g_strdup(sdp_record);
+
+	server->connect_cb =3D cb;
+	server->user_data =3D user_data;
+
+	server_list =3D g_slist_prepend(server_list, server);
+
+	if (adapter_any_path !=3D NULL)
+		add_record(server, NULL);
+
+	return server;
+}
+
+void bluetooth_unregister_server(struct server *server)
+{
+	server_list =3D g_slist_remove(server_list, server);
+
+	remove_record(server);
+
+	if (server->io !=3D NULL) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+		server->io =3D NULL;
+	}
+
+	g_free(server->sdp_record);
+	g_free(server);
+
+	bluetooth_unref();
+}
+
+OFONO_PLUGIN_DEFINE(bluez4, "Bluetooth Utils Plugins", VERSION,
+				OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluez4.h b/plugins/bluez4.h
new file mode 100644
index 0000000..4fc16ad
--- /dev/null
+++ b/plugins/bluez4.h
@@ -0,0 +1,84 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Gustavo F. Padovan <gustavo@padovan.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+
+#define	BLUEZ_SERVICE "org.bluez"
+#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
+#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
+#define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
+
+#define DBUS_TIMEOUT 15
+
+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
+#define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
+#define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
+#define SAP_UUID	"0000112d-0000-1000-8000-00805f9b34fb"
+
+struct bluetooth_profile {
+	const char *name;
+	int (*probe)(const char *device, const char *dev_addr,
+			const char *adapter_addr, const char *alias);
+	void (*remove)(const char *prefix);
+	void (*set_alias)(const char *device, const char *);
+};
+
+struct bluetooth_sap_driver {
+	const char *name;
+	int (*enable) (struct ofono_modem *modem, struct ofono_modem *sap_modem,
+								int bt_fd);
+	void (*pre_sim) (struct ofono_modem *modem);
+	void (*post_sim) (struct ofono_modem *modem);
+	void (*set_online) (struct ofono_modem *modem, ofono_bool_t online,
+				ofono_modem_online_cb_t cb, void *user_data);
+	void (*post_online) (struct ofono_modem *modem);
+	int (*disable) (struct ofono_modem *modem);
+};
+
+struct server;
+
+typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
+
+void bluetooth_get_properties();
+int bluetooth_register_uuid(const char *uuid,
+				struct bluetooth_profile *profile);
+void bluetooth_unregister_uuid(const char *uuid);
+
+struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
+					ConnectFunc cb, gpointer user_data);
+void bluetooth_unregister_server(struct server *server);
+
+void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
+							char *buf, int size);
+
+int bluetooth_send_with_reply(const char *path, const char *interface,
+				const char *method, DBusPendingCall **call,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...);
+void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...);
+
+int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
+					struct ofono_modem *modem);
+void bluetooth_sap_client_unregister(struct ofono_modem *modem);
diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 75b62eb..fc8bde4 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -33,7 +33,7 @@
 #include <ofono/modem.h>
 #include <gdbus.h>
 =

-#include "bluetooth.h"
+#include "bluez4.h"
 =

 #define DUN_GW_CHANNEL	1
 =

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index c2d1d30..12374ad 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -33,7 +33,7 @@
 #include <ofono/modem.h>
 #include <gdbus.h>
 =

-#include "bluetooth.h"
+#include "bluez4.h"
 =

 #define HFP_AG_CHANNEL	13
 =

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
deleted file mode 100644
index 7c500e3..0000000
--- a/plugins/hfp_hf.c
+++ /dev/null
@@ -1,552 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *  Copyright (C) 2010  ProFUSION embedded systems
- *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <errno.h>
-#include <unistd.h>
-#include <glib.h>
-#include <gatchat.h>
-#include <gattty.h>
-#include <gdbus.h>
-#include <ofono.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/plugin.h>
-#include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/devinfo.h>
-#include <ofono/netreg.h>
-#include <ofono/voicecall.h>
-#include <ofono/call-volume.h>
-#include <ofono/handsfree.h>
-
-#include <drivers/hfpmodem/slc.h>
-
-#include "bluetooth.h"
-
-#define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
-
-#define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
-#define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
-
-#ifndef DBUS_TYPE_UNIX_FD
-#define DBUS_TYPE_UNIX_FD -1
-#endif
-
-static DBusConnection *connection;
-static GHashTable *modem_hash =3D NULL;
-
-struct hfp_data {
-	struct hfp_slc_info info;
-	char *handsfree_path;
-	char *handsfree_address;
-	DBusMessage *slc_msg;
-	gboolean agent_registered;
-	DBusPendingCall *call;
-};
-
-static void hfp_debug(const char *str, void *user_data)
-{
-	const char *prefix =3D user_data;
-
-	ofono_info("%s%s", prefix, str);
-}
-
-static void slc_established(gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	ofono_modem_set_powered(modem, TRUE);
-
-	msg =3D dbus_message_new_method_return(data->slc_msg);
-	g_dbus_send_message(connection, msg);
-	dbus_message_unref(data->slc_msg);
-	data->slc_msg =3D NULL;
-
-	ofono_info("Service level connection established");
-}
-
-static void slc_failed(gpointer userdata)
-{
-	struct ofono_modem *modem =3D userdata;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	msg =3D g_dbus_create_error(data->slc_msg, HFP_AGENT_ERROR_INTERFACE
-					".Failed",
-					"HFP Handshake failed");
-	g_dbus_send_message(connection, msg);
-	dbus_message_unref(data->slc_msg);
-	data->slc_msg =3D NULL;
-
-	ofono_error("Service level connection failed");
-	ofono_modem_set_powered(modem, FALSE);
-
-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
-}
-
-static void hfp_disconnected_cb(gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	ofono_modem_set_powered(modem, FALSE);
-
-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
-}
-
-/* either oFono or Phone could request SLC connection */
-static int service_level_connection(struct ofono_modem *modem, int fd)
-{
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	GIOChannel *io;
-	GAtSyntax *syntax;
-	GAtChat *chat;
-
-	io =3D g_io_channel_unix_new(fd);
-	if (io =3D=3D NULL) {
-		ofono_error("Service level connection failed: %s (%d)",
-			strerror(errno), errno);
-		return -EIO;
-	}
-
-	syntax =3D g_at_syntax_new_gsm_permissive();
-	chat =3D g_at_chat_new(io, syntax);
-	g_at_syntax_unref(syntax);
-	g_io_channel_unref(io);
-
-	if (chat =3D=3D NULL)
-		return -ENOMEM;
-
-	g_at_chat_set_disconnect_function(chat, hfp_disconnected_cb, modem);
-
-	if (getenv("OFONO_AT_DEBUG"))
-		g_at_chat_set_debug(chat, hfp_debug, "");
-
-	data->info.chat =3D chat;
-	hfp_slc_establish(&data->info, slc_established, slc_failed, modem);
-
-	return -EINPROGRESS;
-}
-
-static DBusMessage *hfp_agent_new_connection(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	int fd, err;
-	struct ofono_modem *modem =3D data;
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-	guint16 version;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
-				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
-		return __ofono_error_invalid_args(msg);
-
-	hfp_slc_info_init(&hfp_data->info, version);
-
-	err =3D service_level_connection(modem, fd);
-	if (err < 0 && err !=3D -EINPROGRESS)
-		return __ofono_error_failed(msg);
-
-	hfp_data->slc_msg =3D msg;
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
-static DBusMessage *hfp_agent_release(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct ofono_modem *modem =3D data;
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-	const char *obj_path =3D ofono_modem_get_path(modem);
-
-	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
-	hfp_data->agent_registered =3D FALSE;
-
-	g_hash_table_remove(modem_hash, hfp_data->handsfree_path);
-	ofono_modem_remove(modem);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static const GDBusMethodTable agent_methods[] =3D {
-	{ GDBUS_ASYNC_METHOD("NewConnection",
-				GDBUS_ARGS({ "fd", "h" }, { "version", "q" }),
-				NULL, hfp_agent_new_connection) },
-	{ GDBUS_METHOD("Release", NULL, NULL, hfp_agent_release) },
-	{ }
-};
-
-static int hfp_hf_probe(const char *device, const char *dev_addr,
-				const char *adapter_addr, const char *alias)
-{
-	struct ofono_modem *modem;
-	struct hfp_data *data;
-	char buf[256];
-
-	/* We already have this device in our hash, ignore */
-	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
-		return -EALREADY;
-
-	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
-			device, dev_addr, adapter_addr);
-
-	strcpy(buf, "hfp/");
-	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
-
-	modem =3D ofono_modem_create(buf, "hfp");
-	if (modem =3D=3D NULL)
-		return -ENOMEM;
-
-	data =3D g_try_new0(struct hfp_data, 1);
-	if (data =3D=3D NULL)
-		goto free;
-
-	data->handsfree_path =3D g_strdup(device);
-	if (data->handsfree_path =3D=3D NULL)
-		goto free;
-
-	data->handsfree_address =3D g_strdup(dev_addr);
-	if (data->handsfree_address =3D=3D NULL)
-		goto free;
-
-	ofono_modem_set_data(modem, data);
-	ofono_modem_set_name(modem, alias);
-	ofono_modem_register(modem);
-
-	g_hash_table_insert(modem_hash, g_strdup(device), modem);
-
-	return 0;
-
-free:
-	if (data !=3D NULL)
-		g_free(data->handsfree_path);
-
-	g_free(data);
-	ofono_modem_remove(modem);
-
-	return -ENOMEM;
-}
-
-static gboolean hfp_remove_modem(gpointer key, gpointer value,
-					gpointer user_data)
-{
-	struct ofono_modem *modem =3D value;
-	const char *device =3D key;
-	const char *prefix =3D user_data;
-
-	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
-		return FALSE;
-
-	ofono_modem_remove(modem);
-
-	return TRUE;
-}
-
-static void hfp_hf_remove(const char *prefix)
-{
-	DBG("%s", prefix);
-
-	if (modem_hash =3D=3D NULL)
-		return;
-
-	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem,
-							(gpointer) prefix);
-}
-
-static void hfp_hf_set_alias(const char *device, const char *alias)
-{
-	struct ofono_modem *modem;
-
-	if (device =3D=3D NULL || alias =3D=3D NULL)
-		return;
-
-	modem =3D	g_hash_table_lookup(modem_hash, device);
-	if (modem =3D=3D NULL)
-		return;
-
-	ofono_modem_set_name(modem, alias);
-}
-
-static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
-{
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	DBG("Registering oFono Agent to bluetooth daemon");
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent");
-	if (msg =3D=3D NULL)
-		return -ENOMEM;
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
-static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
-{
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	DBG("Unregistering oFono Agent from bluetooth daemon");
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent");
-	if (msg =3D=3D NULL)
-		return -ENOMEM;
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
-static int hfp_probe(struct ofono_modem *modem)
-{
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	if (data =3D=3D NULL)
-		return -EINVAL;
-
-	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
-			agent_methods, NULL, NULL, modem, NULL);
-
-	data->agent_registered =3D TRUE;
-
-	if (hfp_register_ofono_handsfree(modem) !=3D 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static void hfp_remove(struct ofono_modem *modem)
-{
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	const char *obj_path =3D ofono_modem_get_path(modem);
-
-	if (data->call !=3D NULL)
-		dbus_pending_call_cancel(data->call);
-
-	if (g_dbus_unregister_interface(connection, obj_path,
-					HFP_AGENT_INTERFACE))
-		hfp_unregister_ofono_handsfree(modem);
-
-	g_free(data->handsfree_address);
-	g_free(data->handsfree_path);
-	g_free(data);
-
-	ofono_modem_set_data(modem, NULL);
-}
-
-static void hfp_connect_reply(DBusPendingCall *call, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusError derr;
-	DBusMessage *reply, *msg;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	if (ofono_modem_get_powered(modem))
-		goto done;
-
-	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply))
-		goto done;
-
-	DBG("Connect reply: %s", derr.message);
-
-	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
-		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
-				data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "Disconnect");
-		if (msg =3D=3D NULL)
-			ofono_error("Disconnect failed");
-		else
-			g_dbus_send_message(connection, msg);
-	}
-
-	ofono_modem_set_powered(modem, FALSE);
-
-	dbus_error_free(&derr);
-
-done:
-	dbus_message_unref(reply);
-	data->call =3D NULL;
-}
-
-/* power up hardware */
-static int hfp_enable(struct ofono_modem *modem)
-{
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
-
-	DBG("%p", modem);
-
-	status =3D bluetooth_send_with_reply(data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Connect",
-					&data->call, hfp_connect_reply,
-					modem, NULL,
-					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
-
-	if (status < 0)
-		return -EINVAL;
-
-	return -EINPROGRESS;
-}
-
-static void hfp_power_down(DBusPendingCall *call, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *reply;
-	DBusError derr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		DBG("Disconnect reply: %s", derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	ofono_modem_set_powered(modem, FALSE);
-
-done:
-	dbus_message_unref(reply);
-	data->call =3D NULL;
-}
-
-static int hfp_disable(struct ofono_modem *modem)
-{
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
-
-	DBG("%p", modem);
-
-	g_at_chat_unref(data->info.chat);
-	data->info.chat =3D NULL;
-
-	if (data->agent_registered) {
-		status =3D bluetooth_send_with_reply(data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					&data->call, hfp_power_down,
-					modem, NULL,
-					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
-
-		if (status < 0)
-			return -EINVAL;
-	}
-
-	return -EINPROGRESS;
-}
-
-static void hfp_pre_sim(struct ofono_modem *modem)
-{
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	DBG("%p", modem);
-
-	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
-	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
-	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
-	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
-	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
-}
-
-static void hfp_post_sim(struct ofono_modem *modem)
-{
-	DBG("%p", modem);
-}
-
-static struct ofono_modem_driver hfp_driver =3D {
-	.name		=3D "hfp",
-	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
-	.probe		=3D hfp_probe,
-	.remove		=3D hfp_remove,
-	.enable		=3D hfp_enable,
-	.disable	=3D hfp_disable,
-	.pre_sim	=3D hfp_pre_sim,
-	.post_sim	=3D hfp_post_sim,
-};
-
-static struct bluetooth_profile hfp_hf =3D {
-	.name		=3D "hfp_hf",
-	.probe		=3D hfp_hf_probe,
-	.remove		=3D hfp_hf_remove,
-	.set_alias	=3D hfp_hf_set_alias,
-};
-
-static int hfp_init(void)
-{
-	int err;
-
-	if (DBUS_TYPE_UNIX_FD < 0)
-		return -EBADF;
-
-	connection =3D ofono_dbus_get_connection();
-
-	err =3D ofono_modem_driver_register(&hfp_driver);
-	if (err < 0)
-		return err;
-
-	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_hf);
-	if (err < 0) {
-		ofono_modem_driver_unregister(&hfp_driver);
-		return err;
-	}
-
-	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-						g_free, NULL);
-
-	return 0;
-}
-
-static void hfp_exit(void)
-{
-	bluetooth_unregister_uuid(HFP_AG_UUID);
-	ofono_modem_driver_unregister(&hfp_driver);
-
-	g_hash_table_destroy(modem_hash);
-}
-
-OFONO_PLUGIN_DEFINE(hfp, "Hands-Free Profile Plugins", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_init, hfp_exit)
diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
new file mode 100644
index 0000000..450c183
--- /dev/null
+++ b/plugins/hfp_hf_bluez4.c
@@ -0,0 +1,552 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
+#include <ofono/handsfree.h>
+
+#include <drivers/hfpmodem/slc.h>
+
+#include "bluez4.h"
+
+#define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
+
+#define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
+#define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+static DBusConnection *connection;
+static GHashTable *modem_hash =3D NULL;
+
+struct hfp_data {
+	struct hfp_slc_info info;
+	char *handsfree_path;
+	char *handsfree_address;
+	DBusMessage *slc_msg;
+	gboolean agent_registered;
+	DBusPendingCall *call;
+};
+
+static void hfp_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static void slc_established(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	msg =3D dbus_message_new_method_return(data->slc_msg);
+	g_dbus_send_message(connection, msg);
+	dbus_message_unref(data->slc_msg);
+	data->slc_msg =3D NULL;
+
+	ofono_info("Service level connection established");
+}
+
+static void slc_failed(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	msg =3D g_dbus_create_error(data->slc_msg, HFP_AGENT_ERROR_INTERFACE
+					".Failed",
+					"HFP Handshake failed");
+	g_dbus_send_message(connection, msg);
+	dbus_message_unref(data->slc_msg);
+	data->slc_msg =3D NULL;
+
+	ofono_error("Service level connection failed");
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->info.chat);
+	data->info.chat =3D NULL;
+}
+
+static void hfp_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->info.chat);
+	data->info.chat =3D NULL;
+}
+
+/* either oFono or Phone could request SLC connection */
+static int service_level_connection(struct ofono_modem *modem, int fd)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	io =3D g_io_channel_unix_new(fd);
+	if (io =3D=3D NULL) {
+		ofono_error("Service level connection failed: %s (%d)",
+			strerror(errno), errno);
+		return -EIO;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(io);
+
+	if (chat =3D=3D NULL)
+		return -ENOMEM;
+
+	g_at_chat_set_disconnect_function(chat, hfp_disconnected_cb, modem);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, hfp_debug, "");
+
+	data->info.chat =3D chat;
+	hfp_slc_establish(&data->info, slc_established, slc_failed, modem);
+
+	return -EINPROGRESS;
+}
+
+static DBusMessage *hfp_agent_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	int fd, err;
+	struct ofono_modem *modem =3D data;
+	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
+	guint16 version;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	hfp_slc_info_init(&hfp_data->info, version);
+
+	err =3D service_level_connection(modem, fd);
+	if (err < 0 && err !=3D -EINPROGRESS)
+		return __ofono_error_failed(msg);
+
+	hfp_data->slc_msg =3D msg;
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *hfp_agent_release(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
+	const char *obj_path =3D ofono_modem_get_path(modem);
+
+	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
+	hfp_data->agent_registered =3D FALSE;
+
+	g_hash_table_remove(modem_hash, hfp_data->handsfree_path);
+	ofono_modem_remove(modem);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable agent_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("NewConnection",
+				GDBUS_ARGS({ "fd", "h" }, { "version", "q" }),
+				NULL, hfp_agent_new_connection) },
+	{ GDBUS_METHOD("Release", NULL, NULL, hfp_agent_release) },
+	{ }
+};
+
+static int hfp_hf_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct hfp_data *data;
+	char buf[256];
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			device, dev_addr, adapter_addr);
+
+	strcpy(buf, "hfp/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	modem =3D ofono_modem_create(buf, "hfp");
+	if (modem =3D=3D NULL)
+		return -ENOMEM;
+
+	data =3D g_try_new0(struct hfp_data, 1);
+	if (data =3D=3D NULL)
+		goto free;
+
+	data->handsfree_path =3D g_strdup(device);
+	if (data->handsfree_path =3D=3D NULL)
+		goto free;
+
+	data->handsfree_address =3D g_strdup(dev_addr);
+	if (data->handsfree_address =3D=3D NULL)
+		goto free;
+
+	ofono_modem_set_data(modem, data);
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+
+	return 0;
+
+free:
+	if (data !=3D NULL)
+		g_free(data->handsfree_path);
+
+	g_free(data);
+	ofono_modem_remove(modem);
+
+	return -ENOMEM;
+}
+
+static gboolean hfp_remove_modem(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct ofono_modem *modem =3D value;
+	const char *device =3D key;
+	const char *prefix =3D user_data;
+
+	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void hfp_hf_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, hfp_remove_modem,
+							(gpointer) prefix);
+}
+
+static void hfp_hf_set_alias(const char *device, const char *alias)
+{
+	struct ofono_modem *modem;
+
+	if (device =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL)
+		return;
+
+	ofono_modem_set_name(modem, alias);
+}
+
+static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	DBG("Registering oFono Agent to bluetooth daemon");
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent");
+	if (msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
+				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
+}
+
+static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	DBG("Unregistering oFono Agent from bluetooth daemon");
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent");
+	if (msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
+				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
+}
+
+static int hfp_probe(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	if (data =3D=3D NULL)
+		return -EINVAL;
+
+	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
+			agent_methods, NULL, NULL, modem, NULL);
+
+	data->agent_registered =3D TRUE;
+
+	if (hfp_register_ofono_handsfree(modem) !=3D 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void hfp_remove(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	const char *obj_path =3D ofono_modem_get_path(modem);
+
+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
+	if (g_dbus_unregister_interface(connection, obj_path,
+					HFP_AGENT_INTERFACE))
+		hfp_unregister_ofono_handsfree(modem);
+
+	g_free(data->handsfree_address);
+	g_free(data->handsfree_path);
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
+}
+
+static void hfp_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusError derr;
+	DBusMessage *reply, *msg;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (ofono_modem_get_powered(modem))
+		goto done;
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply))
+		goto done;
+
+	DBG("Connect reply: %s", derr.message);
+
+	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
+		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+				data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Disconnect");
+		if (msg =3D=3D NULL)
+			ofono_error("Disconnect failed");
+		else
+			g_dbus_send_message(connection, msg);
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	dbus_error_free(&derr);
+
+done:
+	dbus_message_unref(reply);
+	data->call =3D NULL;
+}
+
+/* power up hardware */
+static int hfp_enable(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	int status;
+
+	DBG("%p", modem);
+
+	status =3D bluetooth_send_with_reply(data->handsfree_path,
+					BLUEZ_GATEWAY_INTERFACE, "Connect",
+					&data->call, hfp_connect_reply,
+					modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
+
+	if (status < 0)
+		return -EINVAL;
+
+	return -EINPROGRESS;
+}
+
+static void hfp_power_down(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Disconnect reply: %s", derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+
+done:
+	dbus_message_unref(reply);
+	data->call =3D NULL;
+}
+
+static int hfp_disable(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	int status;
+
+	DBG("%p", modem);
+
+	g_at_chat_unref(data->info.chat);
+	data->info.chat =3D NULL;
+
+	if (data->agent_registered) {
+		status =3D bluetooth_send_with_reply(data->handsfree_path,
+					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
+					&data->call, hfp_power_down,
+					modem, NULL,
+					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
+
+		if (status < 0)
+			return -EINVAL;
+	}
+
+	return -EINPROGRESS;
+}
+
+static void hfp_pre_sim(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "hfpmodem", data->handsfree_address);
+	ofono_voicecall_create(modem, 0, "hfpmodem", &data->info);
+	ofono_netreg_create(modem, 0, "hfpmodem", &data->info);
+	ofono_call_volume_create(modem, 0, "hfpmodem", &data->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", &data->info);
+}
+
+static void hfp_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver hfp_driver =3D {
+	.name		=3D "hfp",
+	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
+	.probe		=3D hfp_probe,
+	.remove		=3D hfp_remove,
+	.enable		=3D hfp_enable,
+	.disable	=3D hfp_disable,
+	.pre_sim	=3D hfp_pre_sim,
+	.post_sim	=3D hfp_post_sim,
+};
+
+static struct bluetooth_profile hfp_hf =3D {
+	.name		=3D "hfp_hf",
+	.probe		=3D hfp_hf_probe,
+	.remove		=3D hfp_hf_remove,
+	.set_alias	=3D hfp_hf_set_alias,
+};
+
+static int hfp_init(void)
+{
+	int err;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_modem_driver_register(&hfp_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_hf);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&hfp_driver);
+		return err;
+	}
+
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void hfp_exit(void)
+{
+	bluetooth_unregister_uuid(HFP_AG_UUID);
+	ofono_modem_driver_unregister(&hfp_driver);
+
+	g_hash_table_destroy(modem_hash);
+}
+
+OFONO_PLUGIN_DEFINE(hfp_bluez4, "Hands-Free Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_init, hfp_exit)
diff --git a/plugins/sap.c b/plugins/sap.c
index d893bc1..d1913fb 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -37,7 +37,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 =

-#include "bluetooth.h"
+#include "bluez4.h"
 #include "util.h"
 =

 #ifndef DBUS_TYPE_UNIX_FD
diff --git a/plugins/telit.c b/plugins/telit.c
index 79bc421..392283a 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -58,7 +58,7 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

-#include "bluetooth.h"
+#include "bluez4.h"
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
-- =

1.7.11.7


--===============0671478887054977629==--

