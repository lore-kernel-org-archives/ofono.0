Content-Type: multipart/mixed; boundary="===============3471795043895598525=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2 06/11] elect: Add device D-Bus interface
Date: Fri, 09 Dec 2011 17:35:41 +0100
Message-ID: <1323448546-2728-7-git-send-email-wagi@monom.org>
In-Reply-To: <1323448546-2728-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3471795043895598525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 elect/device.c |  232 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/elect.h  |    1 +
 2 files changed, 233 insertions(+), 0 deletions(-)

diff --git a/elect/device.c b/elect/device.c
index 8f4d6a0..33091e6 100644
--- a/elect/device.c
+++ b/elect/device.c
@@ -35,11 +35,19 @@
 =

 #include "elect.h"
 =

+#define STATIC_IP_NETMASK "255.255.255.255"
+
 static DBusConnection *connection;
 =

 static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

+struct ipv4_settings {
+	char *interface;
+	char *ip;
+	char **nameservers;
+};
+
 struct elect_device {
 	/* The D-Bus path to this device */
 	char *elect_path;
@@ -49,6 +57,9 @@ struct elect_device {
 	char *address;
 	char *name;
 =

+	gboolean active;
+	struct ipv4_settings settings;
+
 	DBusPendingCall *call;
 };
 =

@@ -57,9 +68,84 @@ const char *__elect_device_get_path(struct elect_device =
*device)
 	return  device->elect_path;
 }
 =

+static void settings_append(struct elect_device *device,
+					DBusMessageIter *iter)
+{
+	DBusMessageIter variant;
+	DBusMessageIter array;
+	char typesig[5];
+	char arraysig[6];
+	const char *method;
+	const char *netmask;
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D typesig[0] =3D DBUS_DICT_ENTRY_BEGIN_CHAR;
+	arraysig[2] =3D typesig[1] =3D DBUS_TYPE_STRING;
+	arraysig[3] =3D typesig[2] =3D DBUS_TYPE_VARIANT;
+	arraysig[4] =3D typesig[3] =3D DBUS_DICT_ENTRY_END_CHAR;
+	arraysig[5] =3D typesig[4] =3D '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	if (device->active =3D=3D FALSE)
+		goto out;
+
+	if (device->settings.interface)
+		ofono_dbus_dict_append(&array, "Interface",
+				DBUS_TYPE_STRING, &device->settings.interface);
+
+	method =3D "static";
+	ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING, &method);
+
+	if (device->settings.ip)
+		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
+					&device->settings.ip);
+
+	netmask =3D STATIC_IP_NETMASK;
+	ofono_dbus_dict_append(&array, "Netmask", DBUS_TYPE_STRING,
+					&netmask);
+
+	if (device->settings.nameservers)
+		ofono_dbus_dict_append_array(&array, "DomainNameServers",
+						DBUS_TYPE_STRING,
+						&device->settings.nameservers);
+
+out:
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void settings_append_dict(struct elect_device *device,
+				DBusMessageIter *dict)
+{
+	DBusMessageIter entry;
+	const char *key =3D "Settings";
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	settings_append(device, &entry);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 void __elect_device_append_properties(struct elect_device *device,
 					DBusMessageIter *dict)
 {
+	settings_append_dict(device, dict);
+
+	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN,
+				&device->active);
+
+	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
+				&device->name);
 }
 =

 void __elect_device_foreach(elect_device_foreach_func func, void *userdata)
@@ -78,6 +164,141 @@ void __elect_device_foreach(elect_device_foreach_func =
func, void *userdata)
 	}
 }
 =

+static DBusMessage *device_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct elect_device *device =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	__elect_device_append_properties(device, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *set_property_active(struct elect_device *device,
+					DBusMessage *msg,
+					DBusMessageIter *var)
+{
+	ofono_bool_t active;
+
+	DBG("%p elect_path %s", device, device->elect_path);
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(var, &active);
+
+	device->active =3D active;
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *device_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct elect_device *device =3D data;
+	DBusMessageIter iter, var;
+	const char *name;
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_str_equal(name, "Active"))
+		return set_property_active(device, msg, &var);
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable device_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	device_get_properties },
+	{ "SetProperty",	"sv",	"",		device_set_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable device_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static int register_device(struct elect_device *device)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	DBG("%p elect_path %s", device, device->elect_path);
+
+	if (!g_dbus_register_interface(connection, device->elect_path,
+					ELECT_DEVICE_INTERFACE,
+					device_methods, device_signals,
+					NULL, device, NULL)) {
+		ofono_error("Could not register Device %s", device->path);
+		return -EIO;
+	}
+
+	signal =3D dbus_message_new_signal(ELECT_MANAGER_PATH,
+						ELECT_MANAGER_INTERFACE,
+						"DeviceAdded");
+
+	if (signal =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+					&device->elect_path);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	__elect_device_append_properties(device, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(connection, signal);
+
+	return 0;
+}
+
+static int unregister_device(struct elect_device *device)
+{
+	DBG("%p elect_path %s", device, device->elect_path);
+
+	g_dbus_unregister_interface(connection, device->elect_path,
+					ELECT_DEVICE_INTERFACE);
+
+	g_dbus_emit_signal(connection, ELECT_MANAGER_PATH,
+				ELECT_MANAGER_INTERFACE, "DeviceRemoved",
+				DBUS_TYPE_OBJECT_PATH, &device->elect_path,
+				DBUS_TYPE_INVALID);
+
+	return 0;
+}
+
 static int bt_probe(const char *path, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -122,6 +343,8 @@ static int bt_probe(const char *path, const char *dev_a=
ddr,
 =

 	g_hash_table_insert(device_hash, g_strdup(path), device);
 =

+	register_device(device);
+
 	next_device_id +=3D 1;
 =

 	return 0;
@@ -151,6 +374,8 @@ static gboolean bt_remove_device(gpointer key, gpointer=
 value,
 	if (prefix && g_str_has_prefix(path, prefix) =3D=3D FALSE)
 		return FALSE;
 =

+	unregister_device(device);
+
 	return TRUE;
 }
 =

@@ -196,6 +421,10 @@ static void destroy_device(gpointer user)
 	if (device->call)
 		dbus_pending_call_cancel(device->call);
 =

+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+
 	g_free(device->elect_path);
 	g_free(device->path);
 	g_free(device->address);
@@ -206,6 +435,9 @@ static void destroy_device(gpointer user)
 =

 static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
 {
+	struct elect_device *device =3D user_data;
+
+	unregister_device(device);
 }
 =

 void __elect_device_shutdown(void)
diff --git a/elect/elect.h b/elect/elect.h
index 30791d7..b9ead99 100644
--- a/elect/elect.h
+++ b/elect/elect.h
@@ -40,6 +40,7 @@ void __ofono_log_enable(struct ofono_debug_desc *start,
 =

 #define ELECT_SERVICE			"org.ofono.elect"
 #define ELECT_MANAGER_INTERFACE		"org.ofono.elect.Manager"
+#define ELECT_DEVICE_INTERFACE		"org.ofono.elect.Device"
 #define ELECT_MANAGER_PATH		"/"
 =

 int __ofono_dbus_init(DBusConnection *conn);
-- =

1.7.8.110.g4cb5d1


--===============3471795043895598525==--

