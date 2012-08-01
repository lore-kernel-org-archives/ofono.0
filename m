Content-Type: multipart/mixed; boundary="===============6012930488148675748=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v6 01/12] bluetooth: Add org.bluez.Telephony helpers
Date: Wed, 01 Aug 2012 12:09:36 +0200
Message-ID: <1343815787-22670-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343815787-22670-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6012930488148675748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add function to register/unregister Telephony agent to BlueZ
---
 plugins/bluetooth.c |  191 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   13 ++++
 2 files changed, 204 insertions(+)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 5d28530..3e8291a 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -44,6 +44,7 @@ static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 static gint bluetooth_refcount;
 static GSList *server_list =3D NULL;
+static GSList *telephony_list =3D NULL;
 static const char *adapter_any_name =3D "any";
 static char *adapter_any_path;
 =

@@ -65,6 +66,13 @@ struct cb_data {
 	GIOChannel *io;
 };
 =

+struct agent {
+	char *path;
+	char *uuid;
+	guint16 version;
+	guint16 features;
+};
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -146,6 +154,60 @@ fail:
 	return err;
 }
 =

+static void register_telephony_agent(const char *path, const char *handle,
+						struct agent *agent)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+
+	DBG("Registering oFono Agent for %s to %s", agent->uuid, path);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+				BLUEZ_TELEPHONY_INTERFACE, "RegisterAgent");
+	if (msg =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+							&agent->path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	ofono_dbus_dict_append(&dict, "UUID", DBUS_TYPE_STRING, &agent->uuid);
+
+	ofono_dbus_dict_append(&dict, "Version", DBUS_TYPE_UINT16,
+							&agent->version);
+	ofono_dbus_dict_append(&dict, "Features", DBUS_TYPE_UINT16,
+							&agent->features);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(connection, msg);
+}
+
+static void unregister_telephony_agent(const char *path, const char *handl=
e,
+						struct agent *agent)
+{
+	DBusMessage *msg;
+
+	DBG("Unregistering oFono Agent for %s from %s", agent->uuid, path);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, path,
+					BLUEZ_TELEPHONY_INTERFACE,
+					"UnregisterAgent");
+	if (msg =3D=3D NULL)
+		return;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &agent->path,
+					DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+}
+
 typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
 =

 struct property_handler {
@@ -455,6 +517,9 @@ static void adapter_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 					g_free, -1, DBUS_TYPE_INVALID);
 	}
 =

+	for (l =3D telephony_list; l; l =3D l->next)
+		register_telephony_agent(path, NULL, l->data);
+
 done:
 	g_slist_free(device_list);
 	dbus_message_unref(reply);
@@ -985,5 +1050,131 @@ void bluetooth_unregister_server(struct server *serv=
er)
 	bluetooth_unref();
 }
 =

+int bluetooth_parse_newconnection_message(DBusMessage *msg, const char **d=
evice,
+					guint16 *version, guint16 *features,
+					const char **transport_path)
+{
+	DBusMessageIter args, props;
+	int fd;
+	gboolean has_device =3D FALSE;
+
+	dbus_message_iter_init(msg, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) !=3D DBUS_TYPE_UNIX_FD)
+		return -EINVAL;
+
+	dbus_message_iter_get_basic(&args, &fd);
+	dbus_message_iter_next(&args);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) !=3D DBUS_TYPE_DICT_ENTRY)
+		return -EINVAL;
+
+	while (dbus_message_iter_get_arg_type(&props) =3D=3D DBUS_TYPE_DICT_ENTRY=
) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var =3D dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "Device") =3D=3D 0) {
+			if (var !=3D DBUS_TYPE_OBJECT_PATH)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, device);
+			has_device =3D TRUE;
+		} else if (strcasecmp(key, "Version") =3D=3D 0) {
+			if (var !=3D DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, version);
+		} else if (strcasecmp(key, "Features") =3D=3D 0) {
+			if (var !=3D DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, features);
+		} else if (strcasecmp(key, "Transport") =3D=3D 0) {
+			if (var !=3D DBUS_TYPE_OBJECT_PATH)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, transport_path);
+		}
+
+		dbus_message_iter_next(&props);
+	}
+
+	return has_device ? fd : -EINVAL;
+}
+
+void bluetooth_register_telephony_agent(const char *path, const char *uuid,
+					guint16 version, guint16 features,
+					const GDBusMethodTable *methods,
+					void *user_data,
+					GDBusDestroyFunction destroy)
+{
+	GSList *l;
+	struct agent *agent;
+
+	for (l =3D telephony_list; l; l =3D l->next) {
+		agent =3D l->data;
+
+		if (g_strcmp0(path, agent->path) =3D=3D 0) {
+			ofono_error("Telephony agent path \"%s\" already " \
+					"registered", path);
+			return;
+		}
+	}
+
+	agent =3D g_try_new0(struct agent, 1);
+	if (!agent)
+		return;
+
+	agent->path =3D g_strdup(path);
+	agent->uuid =3D g_strdup(uuid);
+	agent->version =3D version;
+	agent->features =3D features;
+
+	bluetooth_ref();
+
+	g_dbus_register_interface(connection, path,
+				BLUEZ_TELEPHONY_AGENT_INTERFACE, methods, NULL,
+				NULL, user_data, destroy);
+
+	telephony_list =3D g_slist_prepend(telephony_list, agent);
+
+	g_hash_table_foreach(adapter_address_hash,
+			(GHFunc) register_telephony_agent, agent);
+}
+
+void bluetooth_unregister_telephony_agent(const char *path)
+{
+	GSList *l;
+	struct agent *agent;
+
+	for (l =3D telephony_list; l; l =3D l->next) {
+		agent =3D l->data;
+
+		if (g_strcmp0(path, agent->path) =3D=3D 0)
+			break;
+	}
+
+	if (l =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach(adapter_address_hash,
+			(GHFunc) unregister_telephony_agent, agent);
+
+	telephony_list =3D g_slist_remove(telephony_list, agent);
+	g_free(agent->path);
+	g_free(agent->uuid);
+	g_free(agent);
+
+	g_dbus_unregister_interface(connection, path,
+				BLUEZ_TELEPHONY_AGENT_INTERFACE);
+
+	bluetooth_unref();
+}
+
 OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 4fc16ad..6a2fbf0 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -21,6 +21,7 @@
 =

 #include <ofono/modem.h>
 #include <ofono/dbus.h>
+#include <gdbus.h>
 =

 #define	BLUEZ_SERVICE "org.bluez"
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
@@ -28,6 +29,8 @@
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
 #define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
+#define	BLUEZ_TELEPHONY_INTERFACE	BLUEZ_SERVICE ".Telephony"
+#define	BLUEZ_TELEPHONY_AGENT_INTERFACE	BLUEZ_SERVICE ".TelephonyAgent"
 =

 #define DBUS_TIMEOUT 15
 =

@@ -82,3 +85,13 @@ void bluetooth_parse_properties(DBusMessage *reply, cons=
t char *property, ...);
 int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
 					struct ofono_modem *modem);
 void bluetooth_sap_client_unregister(struct ofono_modem *modem);
+
+int bluetooth_parse_newconnection_message(DBusMessage *msg, const char **d=
evice,
+					guint16 *version, guint16 *features,
+					const char **transport_path);
+void bluetooth_register_telephony_agent(const char *path, const char *uuid,
+					guint16 version, guint16 features,
+					const GDBusMethodTable *methods,
+					void *user_data,
+					GDBusDestroyFunction destroy);
+void bluetooth_unregister_telephony_agent(const char *path);
-- =

1.7.9.5


--===============6012930488148675748==--

