Content-Type: multipart/mixed; boundary="===============3586275595996269022=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 14/16] dundee: Add device D-Bus interface
Date: Tue, 22 May 2012 18:33:22 +0200
Message-ID: <1337704404-5260-15-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3586275595996269022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/device.c |  225 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/dundee.h |    1 +
 2 files changed, 226 insertions(+)

diff --git a/dundee/device.c b/dundee/device.c
index 1a83f76..8baf760 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -36,11 +36,21 @@
 static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

+struct ipv4_settings {
+	char *interface;
+	char *ip;
+	char **nameservers;
+};
+
 struct dundee_device {
 	char *path;
 	struct dundee_device_driver *driver;
 	gboolean registered;
 =

+	char *name;
+	gboolean active;
+	struct ipv4_settings settings;
+
 	void *data;
 };
 =

@@ -49,9 +59,75 @@ const char *__dundee_device_get_path(struct dundee_devic=
e *device)
 	return device->path;
 }
 =

+static void settings_append(struct dundee_device *device,
+					DBusMessageIter *iter)
+{
+	DBusMessageIter variant;
+	DBusMessageIter array;
+	char typesig[5];
+	char arraysig[6];
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
+	if (device->settings.ip)
+		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
+					&device->settings.ip);
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
+static void settings_append_dict(struct dundee_device *device,
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
 void __dundee_device_append_properties(struct dundee_device *device,
 					DBusMessageIter *dict)
 {
+	settings_append_dict(device, dict);
+
+	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
+				&device->name);
+
+	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN,
+				&device->active);
 }
 =

 void __dundee_device_foreach(dundee_device_foreach_func func, void *userda=
ta)
@@ -70,13 +146,145 @@ void __dundee_device_foreach(dundee_device_foreach_fu=
nc func, void *userdata)
 	}
 }
 =

+static DBusMessage *device_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct dundee_device *device =3D data;
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
+	__dundee_device_append_properties(device, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *set_property_active(struct dundee_device *device,
+					DBusMessage *msg,
+					DBusMessageIter *var)
+{
+	ofono_bool_t active;
+
+	DBG("%p path %s", device, device->path);
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __dundee_error_invalid_args(msg);
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
+	struct dundee_device *device =3D data;
+	DBusMessageIter iter, var;
+	const char *name;
+
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return __dundee_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __dundee_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __dundee_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_str_equal(name, "Active"))
+		return set_property_active(device, msg, &var);
+
+	return __dundee_error_invalid_args(msg);
+}
+
+static const GDBusMethodTable device_methods[] =3D {
+	{ GDBUS_METHOD("GetProperties",
+			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+			device_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, device_set_property) },
+	{ }
+};
+
+static const GDBusSignalTable device_signals[] =3D {
+	{ GDBUS_SIGNAL("PropertyChanged",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
 static int register_device(struct dundee_device *device)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	DBG("%p path %s", device, device->path);
+
+	if (!g_dbus_register_interface(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE,
+					device_methods, device_signals,
+					NULL, device, NULL)) {
+		ofono_error("Could not register Device %s", device->path);
+		return -EIO;
+	}
+
+	signal =3D dbus_message_new_signal(DUNDEE_MANAGER_PATH,
+						DUNDEE_MANAGER_INTERFACE,
+						"DeviceAdded");
+
+	if (signal =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+					&device->path);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	__dundee_device_append_properties(device, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(conn, signal);
+
 	return 0;
 }
 =

 static int unregister_device(struct dundee_device *device)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("%p path %s", device, device->path);
+
+	g_dbus_unregister_interface(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE);
+
+	g_dbus_emit_signal(conn, DUNDEE_MANAGER_PATH,
+				DUNDEE_MANAGER_INTERFACE, "DeviceRemoved",
+				DBUS_TYPE_OBJECT_PATH, &device->path,
+				DBUS_TYPE_INVALID);
+
 	return 0;
 }
 =

@@ -84,7 +292,12 @@ static void destroy_device(gpointer user)
 {
 	struct dundee_device *device =3D user;
 =

+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+
 	g_free(device->path);
+	g_free(device->name);
 =

 	g_free(device);
 }
@@ -148,8 +361,20 @@ void *dundee_device_get_data(struct dundee_device *dev=
ice)
 =

 int dundee_device_set_name(struct dundee_device *device, const char *name)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
 	DBG("%p name %s", device, name);
 =

+	g_free(device->name);
+	device->name =3D g_strdup(name);
+
+	if (device->registered =3D=3D FALSE)
+		return 0;
+
+	ofono_dbus_signal_property_changed(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE, "Name",
+					DBUS_TYPE_STRING, &device->name);
+
 	return 0;
 }
 =

diff --git a/dundee/dundee.h b/dundee/dundee.h
index cf0c36a..7104531 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -84,6 +84,7 @@ void __ofono_log_enable(struct ofono_debug_desc *start,
 =

 #define DUNDEE_SERVICE			"org.ofono.dundee"
 #define DUNDEE_MANAGER_INTERFACE	"org.ofono.dundee.Manager"
+#define DUNDEE_DEVICE_INTERFACE		"org.ofono.dundee.Device"
 #define DUNDEE_MANAGER_PATH		"/"
 =

 int __ofono_dbus_init(DBusConnection *conn);
-- =

1.7.10.130.g36e6c


--===============3586275595996269022==--

