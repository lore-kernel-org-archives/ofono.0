Content-Type: multipart/mixed; boundary="===============3336911004762775599=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/2] Add generic bluetooth manager
Date: Thu, 06 May 2010 06:17:07 -0300
Message-ID: <1273137428-29291-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3336911004762775599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This manager is responsible for handle DBus for the Bluetooth
profiles. Each Bluetooth profile can register callbacks for create a
modem, remove all modems and set_alias.
The idea is to have here soon code the handle Bluetooth Agent stuff too.
---
 Makefile.am         |    6 +-
 include/bluetooth.h |   48 +++++
 plugins/hfp.c       |  539 +++++++----------------------------------------=
---
 src/bluetooth.c     |  554 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 677 insertions(+), 470 deletions(-)
 create mode 100644 include/bluetooth.h
 create mode 100644 src/bluetooth.c

diff --git a/Makefile.am b/Makefile.am
index 463e52e..501f4bd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h include/stk.h
+			include/radio-settings.h include/stk.h \
+			include/bluetooth.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -259,7 +260,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
-			src/radio-settings.c src/stkutil.h src/stkutil.c
+			src/radio-settings.c src/stkutil.h src/stkutil.c \
+			src/bluetooth.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/bluetooth.h b/include/bluetooth.h
new file mode 100644
index 0000000..db3663e
--- /dev/null
+++ b/include/bluetooth.h
@@ -0,0 +1,48 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+#ifndef __BLUETOOTH_H
+#define __BLUETOOTH_H
+
+#define	BLUEZ_SERVICE "org.bluez"
+#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
+#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+
+#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805F9B34FB"
+
+/* Profiles bitfield */
+#define HFP_AG 0x01
+#define DUN_GW 0x02
+
+struct bluetooth_profile {
+	const char *name;
+	int (*create)(const char *device, const char *dev_addr, const char *adapt=
er_addr, const char *alias);
+	/* FIXME: remove() or remove_all() */
+	void (*remove_all)();
+	void (*set_alias)(const char *device, const char *);
+};
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile);
+void bluetooth_unregister_uuid(const char *uuid);
+
+
+#endif /* __BLUETOOTH_H */
diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..d669b84 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -45,17 +45,13 @@
 =

 #include <ofono/dbus.h>
 =

-#define	BLUEZ_SERVICE "org.bluez"
-#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
-#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
-#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#include <ofono/bluetooth.h>
+
 #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
 =

 #define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
 #define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
 =

-#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
-
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
@@ -66,8 +62,7 @@ static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

 static DBusConnection *connection;
-static GHashTable *uuid_hash =3D NULL;
-static GHashTable *adapter_address_hash;
+static GHashTable *modem_hash =3D NULL;
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -183,33 +178,11 @@ static void cmer_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 		sevice_level_conn_established(modem);
 }
 =

-static int send_method_call(const char *dest, const char *path,
-				const char *interface, const char *method,
-				int type, ...)
-{
-	DBusMessage *msg;
-	va_list args;
-
-	msg =3D dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
-		return -ENOMEM;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return -EIO;
-	}
-
-	va_end(args);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
+/*
+ * FIXME: Group all agent stuff DBus calls in bluetooth.c
+ *then we can reuse common agent code for all Bluetooth plugins.
+  This will remove this function from here.
+  */
 static int send_method_call_with_reply(const char *dest, const char *path,
 				const char *interface, const char *method,
 				DBusPendingCallNotifyFunction cb,
@@ -263,101 +236,6 @@ fail:
 	return err;
 }
 =

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
-static void parse_properties_reply(DBusMessage *reply,
-					const char *property, ...)
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
-	g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
-	g_slist_free(prop_handlers);
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
 static void cind_status_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -600,6 +478,10 @@ static int hfp_create_modem(const char *device, const =
char *dev_addr,
 	struct hfp_data *data;
 	char buf[256];
 =

+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
+		return -EALREADY;
+
 	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
 			device, dev_addr, adapter_addr);
 =

@@ -628,7 +510,7 @@ static int hfp_create_modem(const char *device, const c=
har *dev_addr,
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

-	g_hash_table_insert(uuid_hash, g_strdup(device), modem);
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
 =

 	return 0;
 =

@@ -639,312 +521,75 @@ free:
 	return -ENOMEM;
 }
 =

-static void has_hfp_uuid(DBusMessageIter *array, gpointer user_data)
-{
-	gboolean *hfp =3D user_data;
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
-		if (!strcasecmp(uuid, HFP_AG_UUID)) {
-			*hfp =3D TRUE;
-			return;
-		}
-
-		dbus_message_iter_next(&value);
-	}
-}
-
-static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
-{
-	DBusMessage *reply;
-	char *path =3D user_data;
-	gboolean have_hfp =3D FALSE;
-	const char *adapter =3D NULL;
-	const char *adapter_addr =3D NULL;
-	const char *device_addr =3D NULL;
-	const char *alias =3D NULL;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
-		goto done;
-	}
-
-	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
-		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
-			ofono_info("Error from GetProperties reply: %s",
-					dbus_message_get_error_name(reply));
-
-		goto done;
-	}
-
-	parse_properties_reply(reply, "UUIDs", has_hfp_uuid, &have_hfp,
-				"Adapter", parse_string, &adapter,
-				"Address", parse_string, &device_addr,
-				"Alias", parse_string, &alias, NULL);
-
-	if (adapter)
-		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
-							adapter);
-
-	if (have_hfp && device_addr && adapter_addr)
-		hfp_create_modem(path, device_addr, adapter_addr, alias);
-
-done:
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
-static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
-{
-	const char *path =3D user_data;
-	DBusMessage *reply;
-	GSList *device_list =3D NULL;
-	GSList *l;
-	const char *addr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
-		goto done;
-	}
-
-	parse_properties_reply(reply, "Devices", parse_devices, &device_list,
-				"Address", parse_string, &addr, NULL);
-
-	DBG("Adapter Address: %s, Path: %s", addr, path);
-	g_hash_table_insert(adapter_address_hash,
-				g_strdup(path), g_strdup(addr));
-
-	for (l =3D device_list; l; l =3D l->next) {
-		const char *device =3D l->data;
-
-		send_method_call_with_reply(BLUEZ_SERVICE, device,
-				BLUEZ_DEVICE_INTERFACE, "GetProperties",
-				device_properties_cb, g_strdup(device), g_free,
-				-1, DBUS_TYPE_INVALID);
-	}
-
-done:
-	g_slist_free(device_list);
-	dbus_message_unref(reply);
-}
-
-static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
-				void *user_data)
-{
-	const char *path;
-	int ret;
-
-	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID);
-
-	ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
-			BLUEZ_ADAPTER_INTERFACE, "GetProperties",
-			adapter_properties_cb, g_strdup(path), g_free,
-			-1, DBUS_TYPE_INVALID);
-
-	return TRUE;
-}
-
-static gboolean adapter_removed(DBusConnection *connection,
-				DBusMessage *message, void *user_data)
-{
-	const char *path;
-
-	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID) =3D=3D TRUE)
-		g_hash_table_remove(adapter_address_hash, path);
-
-	return TRUE;
-}
-
-static gboolean property_changed(DBusConnection *connection, DBusMessage *=
msg,
-				void *user_data)
+static gboolean hfp_remove_each_modem(gpointer key, gpointer value, gpoint=
er user_data)
 {
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
-		gboolean have_hfp =3D FALSE;
-		const char *path =3D dbus_message_get_path(msg);
-		DBusMessageIter variant;
-
-		/* We already have this device in our hash, ignore */
-		if (g_hash_table_lookup(uuid_hash, path) !=3D NULL)
-			return TRUE;
-
-		if (!dbus_message_iter_next(&iter))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&iter, &variant);
-
-		has_hfp_uuid(&variant, &have_hfp);
-
-		/* We need the full set of properties to be able to create
-		 * the modem properly, including Adapter and Alias, so
-		 * refetch everything again
-		 */
-		if (have_hfp)
-			send_method_call_with_reply(BLUEZ_SERVICE, path,
-				BLUEZ_DEVICE_INTERFACE, "GetProperties",
-				device_properties_cb, g_strdup(path), g_free,
-				-1, DBUS_TYPE_INVALID);
-	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
-		const char *path =3D dbus_message_get_path(msg);
-		struct ofono_modem *modem =3D
-			g_hash_table_lookup(uuid_hash, path);
-		const char *alias =3D NULL;
-		DBusMessageIter variant;
-
-		if (modem =3D=3D NULL)
-			return TRUE;
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
+	struct ofono_modem *modem =3D value;
 =

-		ofono_modem_set_name(modem, alias);
-	}
+	ofono_modem_remove(modem);
 =

 	return TRUE;
 }
 =

-static void parse_adapters(DBusMessageIter *array, gpointer user_data)
+static void hfp_remove_all_modem()
 {
-	DBusMessageIter value;
-
-	DBG("");
-
-	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+	if (modem_hash =3D=3D NULL)
 		return;
 =

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
-		send_method_call_with_reply(BLUEZ_SERVICE, path,
-				BLUEZ_ADAPTER_INTERFACE, "GetProperties",
-				adapter_properties_cb, g_strdup(path), g_free,
-				-1, DBUS_TYPE_INVALID);
-
-		dbus_message_iter_next(&value);
-	}
-}
-
-static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
-{
-	DBusMessage *reply;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
-		DBG("Bluetooth daemon is apparently not available.");
-		goto done;
-	}
-
-	parse_properties_reply(reply, "Adapters", parse_adapters, NULL, NULL);
-
-done:
-	dbus_message_unref(reply);
+	g_hash_table_foreach_remove(modem_hash, hfp_remove_each_modem, NULL);
 }
 =

-static gboolean hfp_remove_each_modem(gpointer key, gpointer value, gpoint=
er user_data)
+static void hfp_set_alias(const char *device, const char *alias)
 {
-	struct ofono_modem *modem =3D value;
-
-	ofono_modem_remove(modem);
+	struct ofono_modem *modem;
 =

-	return TRUE;
-}
+	if (!device || !alias)
+		return;
 =

-static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
-{
-	if (uuid_hash =3D=3D NULL)
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (!modem)
 		return;
 =

-	g_hash_table_foreach_remove(uuid_hash, hfp_remove_each_modem, NULL);
+	ofono_modem_set_name(modem, alias);
 }
 =

 static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
 =

 	DBG("Registering oFono Agent to bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
 				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
 }
 =

 static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
 =

 	DBG("Unregistering oFono Agent from bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
 				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
 }
 =

 static int hfp_probe(struct ofono_modem *modem)
@@ -975,7 +620,7 @@ static void hfp_remove(struct ofono_modem *modem)
 					HFP_AGENT_INTERFACE))
 		hfp_unregister_ofono_handsfree(modem);
 =

-	g_hash_table_remove(uuid_hash, data->handsfree_path);
+	g_hash_table_remove(modem_hash, data->handsfree_path);
 =

 	g_free(data->handsfree_path);
 	g_free(data);
@@ -988,8 +633,7 @@ static void hfp_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
-	DBusMessage *reply;
-	int ret;
+	DBusMessage *reply, *msg;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -1003,11 +647,13 @@ static void hfp_connect_reply(DBusPendingCall *call,=
 gpointer user_data)
 	DBG("Connect reply: %s", derr.message);
 =

 	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
-		ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					DBUS_TYPE_INVALID);
-		if (ret < 0)
-			ofono_error("Disconnect failed(%d)", ret);
+		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+				data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Disconnect");
+		if (!msg)
+			ofono_error("Disconnect failed");
+		else
+			g_dbus_send_message(connection, msg);
 	}
 =

 	ofono_modem_set_powered(modem, FALSE);
@@ -1108,10 +754,12 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

-static guint bluetooth_exit_watch;
-static guint adapter_added_watch;
-static guint adapter_removed_watch;
-static guint uuid_watch;
+static struct bluetooth_profile hfp_profile =3D {
+	.name		=3D "hfp",
+	.create		=3D hfp_create_modem,
+	.remove_all	=3D hfp_remove_all_modem,
+	.set_alias	=3D hfp_set_alias,
+};
 =

 static int hfp_init()
 {
@@ -1122,73 +770,28 @@ static int hfp_init()
 =

 	connection =3D ofono_dbus_get_connection();
 =

-	bluetooth_exit_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVI=
CE,
-			NULL, bluetooth_disconnect, NULL, NULL);
-
-	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
-						BLUEZ_MANAGER_INTERFACE,
-						"AdapterAdded",
-						adapter_added, NULL, NULL);
-
-	adapter_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
-						BLUEZ_MANAGER_INTERFACE,
-						"AdapterRemoved",
-						adapter_removed, NULL, NULL);
-
-	uuid_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
-						BLUEZ_DEVICE_INTERFACE,
-						"PropertyChanged",
-						property_changed, NULL, NULL);
+	err =3D ofono_modem_driver_register(&hfp_driver);
+	if (err < 0)
+		return err;
 =

-	if (bluetooth_exit_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
-			adapter_removed_watch =3D=3D 0|| uuid_watch =3D=3D 0) {
-		err =3D -EIO;
-		goto remove;
+	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_profile);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&hfp_driver);
+		return err;
 	}
 =

-	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

-	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
-							g_free, g_free);
-
-	err =3D ofono_modem_driver_register(&hfp_driver);
-	if (err < 0)
-		goto remove;
-
-	send_method_call_with_reply(BLUEZ_SERVICE, "/",
-				BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
-
 	return 0;
-
-remove:
-	g_dbus_remove_watch(connection, bluetooth_exit_watch);
-	g_dbus_remove_watch(connection, adapter_added_watch);
-	g_dbus_remove_watch(connection, adapter_removed_watch);
-	g_dbus_remove_watch(connection, uuid_watch);
-
-	if (uuid_hash)
-		g_hash_table_destroy(uuid_hash);
-
-	if (adapter_address_hash)
-		g_hash_table_destroy(adapter_address_hash);
-
-	return err;
 }
 =

 static void hfp_exit()
 {
-	g_dbus_remove_watch(connection, bluetooth_exit_watch);
-	g_dbus_remove_watch(connection, adapter_added_watch);
-	g_dbus_remove_watch(connection, adapter_removed_watch);
-	g_dbus_remove_watch(connection, uuid_watch);
-
+	bluetooth_unregister_uuid(HFP_AG_UUID);
 	ofono_modem_driver_unregister(&hfp_driver);
 =

-	g_hash_table_destroy(uuid_hash);
-	g_hash_table_destroy(adapter_address_hash);
+	g_hash_table_destroy(modem_hash);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp, "Hands-Free Profile Plugins", VERSION,
diff --git a/src/bluetooth.c b/src/bluetooth.c
new file mode 100644
index 0000000..256ef4f
--- /dev/null
+++ b/src/bluetooth.c
@@ -0,0 +1,554 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+#include <ofono.h>
+
+#include <ofono/dbus.h>
+#include <ofono/bluetooth.h>
+
+static DBusConnection *connection;
+static GHashTable *uuid_hash =3D NULL;
+static GHashTable *adapter_address_hash =3D NULL;
+
+static int refcnt =3D 0;
+
+static int send_method_call_with_reply(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+	int err;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
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
+		timeout *=3D1000;
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
+		ofono_error("Sending %s failed", method);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, free_func);
+	dbus_pending_call_unref(call);
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
+static void parse_properties_reply(DBusMessage *reply,
+					const char *property, ...)
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
+	g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
+	g_slist_free(prop_handlers);
+}
+
+static void has_uuid(DBusMessageIter *array, gpointer user_data)
+{
+	gboolean *profiles =3D user_data;
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
+		if (!strcasecmp(uuid, HFP_AG_UUID))
+			*profiles |=3D HFP_AG;
+
+		if (!strcasecmp(uuid, DUN_GW_UUID))
+			*profiles |=3D DUN_GW;
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
+static void device_properties_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	int have_uuid =3D 0;
+	const char *path =3D user_data;
+	const char *adapter =3D NULL;
+	const char *adapter_addr =3D NULL;
+	const char *device_addr =3D NULL;
+	const char *alias =3D NULL;
+	struct bluetooth_profile *profile;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
+		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
+			ofono_info("Error from GetProperties reply: %s",
+					dbus_message_get_error_name(reply));
+
+		goto done;
+	}
+
+	parse_properties_reply(reply, "UUIDs", has_uuid, &have_uuid,
+				"Adapter", parse_string, &adapter,
+				"Address", parse_string, &device_addr,
+				"Alias", parse_string, &alias, NULL);
+
+	if (adapter)
+		adapter_addr =3D g_hash_table_lookup(adapter_address_hash,
+							adapter);
+
+	if ((have_uuid & HFP_AG) && device_addr && adapter_addr) {
+		profile =3D g_hash_table_lookup(uuid_hash, HFP_AG_UUID);
+		profile->create(path, device_addr, adapter_addr, alias);
+	}
+
+done:
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
+static gboolean property_changed(DBusConnection *connection, DBusMessage *=
msg,
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
+		int profiles =3D 0;
+		const char *path =3D dbus_message_get_path(msg);
+		DBusMessageIter variant;
+
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		has_uuid(&variant, &profiles);
+
+		/* We need the full set of properties to be able to create
+		 * the modem properly, including Adapter and Alias, so
+		 * refetch everything again
+		 */
+		if (profiles)
+			send_method_call_with_reply(BLUEZ_SERVICE, path,
+				BLUEZ_DEVICE_INTERFACE, "GetProperties",
+				device_properties_cb, g_strdup(path), g_free,
+				-1, DBUS_TYPE_INVALID);
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
+		g_hash_table_iter_init (&hash_iter, uuid_hash);
+		while (g_hash_table_iter_next(&hash_iter, &key, &value))
+		{
+			profile =3D value;
+			profile->set_alias(path, alias);
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
+	GSList *device_list =3D NULL;
+	GSList *l;
+	const char *addr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	parse_properties_reply(reply, "Devices", parse_devices, &device_list,
+				"Address", parse_string, &addr, NULL);
+
+	DBG("Adapter Address: %s, Path: %s", addr, path);
+	g_hash_table_insert(adapter_address_hash,
+				g_strdup(path), g_strdup(addr));
+
+	for (l =3D device_list; l; l =3D l->next) {
+		const char *device =3D l->data;
+
+		send_method_call_with_reply(BLUEZ_SERVICE, device,
+				BLUEZ_DEVICE_INTERFACE, "GetProperties",
+				device_properties_cb, g_strdup(device), g_free,
+				-1, DBUS_TYPE_INVALID);
+	}
+
+done:
+	g_slist_free(device_list);
+	dbus_message_unref(reply);
+}
+
+static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
+				void *user_data)
+{
+	const char *path;
+	int ret;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	ret =3D send_method_call_with_reply(BLUEZ_SERVICE, path,
+			BLUEZ_ADAPTER_INTERFACE, "GetProperties",
+			adapter_properties_cb, g_strdup(path), g_free,
+			-1, DBUS_TYPE_INVALID);
+
+	return TRUE;
+}
+
+static gboolean adapter_removed(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID) =3D=3D TRUE)
+		g_hash_table_remove(adapter_address_hash, path);
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
+		send_method_call_with_reply(BLUEZ_SERVICE, path,
+				BLUEZ_ADAPTER_INTERFACE, "GetProperties",
+				adapter_properties_cb, g_strdup(path), g_free,
+				-1, DBUS_TYPE_INVALID);
+
+		dbus_message_iter_next(&value);
+	}
+}
+
+static void manager_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
+{
+	DBusMessage *reply;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		DBG("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	DBG("");
+
+	parse_properties_reply(reply, "Adapters", parse_adapters, NULL, NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void bluetooth_remove_all_modem(gpointer key, gpointer value, gpoin=
ter user_data)
+{
+	struct bluetooth_profile *profile =3D value;
+
+	profile->remove_all();
+}
+
+static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
+{
+	if (!uuid_hash)
+		return;
+
+	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
+}
+
+static guint bluetooth_watch;
+static guint adapter_added_watch;
+static guint adapter_removed_watch;
+static guint property_watch;
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	int err;
+
+	if (refcnt++ > 0)
+		goto done;
+
+	connection =3D ofono_dbus_get_connection();
+
+	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
+					NULL, bluetooth_disconnect, NULL, NULL);
+
+	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterAdded",
+						adapter_added, NULL, NULL);
+
+	adapter_removed_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterRemoved",
+						adapter_removed, NULL, NULL);
+
+	property_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						property_changed, NULL, NULL);
+
+	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
+			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
+		err =3D -EIO;
+		goto remove;
+	}
+
+	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, g_free);
+
+done:
+	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+
+	send_method_call_with_reply(BLUEZ_SERVICE, "/",
+				BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
+	return 0;
+
+remove:
+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
+	return err;
+}
+
+void bluetooth_unregister_uuid(const char *uuid)
+{
+	g_hash_table_remove(uuid_hash, uuid);
+
+	if (--refcnt)
+		return;
+
+	g_dbus_remove_watch(connection, bluetooth_watch);
+	g_dbus_remove_watch(connection, adapter_added_watch);
+	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
+
+	g_hash_table_destroy(uuid_hash);
+	g_hash_table_destroy(adapter_address_hash);
+}
-- =

1.7.0.4


--===============3336911004762775599==--

