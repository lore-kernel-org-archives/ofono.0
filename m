Content-Type: multipart/mixed; boundary="===============1936269006739478339=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 01/11] hfp_hf: Add HFP external Profile registration
Date: Thu, 22 Nov 2012 14:53:18 -0300
Message-ID: <1353606808-25032-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1936269006739478339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the functions to allow registering and unregistering HFP
external profile using BlueZ ProfileManager1 interface.
---
 plugins/bluetooth.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   5 +-
 plugins/hfp_hf.c    |  12 +++++
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 09c9870..201c851 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -65,6 +65,39 @@ struct cb_data {
 	GIOChannel *io;
 };
 =

+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] =3D { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void dict_append_entry(DBusMessageIter *dict, const char *key, int =
type,
+								void *val)
+{
+	DBusMessageIter entry;
+
+	if (type =3D=3D DBUS_TYPE_STRING) {
+		const char *str =3D *((const char **) val);
+		if (str =3D=3D NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 void bluetooth_create_path(const char *dev_addr, const char *adapter_addr,
 				char *buf, int size)
 {
@@ -968,6 +1001,110 @@ void bluetooth_unregister_uuid(const char *uuid)
 	bluetooth_unref();
 }
 =

+static void register_profile_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	DBusError derr;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("RegisterProfile() replied an error: %s, %s",
+						derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+done:
+	dbus_message_unref(reply);
+}
+
+int bluetooth_register_profile(const char *uuid, const char *name,
+							const char *object)
+{
+	DBusMessageIter iter, dict;
+	DBusPendingCall *c;
+	DBusMessage *msg;
+
+	DBG("Bluetooth: Registering %s (%s) profile", uuid, name);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, "/org/bluez",
+			BLUEZ_PROFILE_MGMT_INTERFACE, "RegisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &object);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &uuid);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(connection, msg, &c, -1)) {
+		ofono_error("Sending RegisterProfile failed");
+		dbus_message_unref(msg);
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(c, register_profile_cb, NULL, NULL);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+
+	return 0;
+}
+
+static void unregister_profile_cb(DBusPendingCall *call, gpointer user_dat=
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
+		ofono_error("UnregisterProfile() replied an error: %s, %s",
+						derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	DBG("");
+
+done:
+	dbus_message_unref(reply);
+}
+
+void bluetooth_unregister_profile(const char *object)
+{
+	DBusMessageIter iter;
+	DBusPendingCall *c;
+	DBusMessage *msg;
+
+	DBG("Bluetooth: Unregistering profile %s", object);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, "/org/bluez",
+			BLUEZ_PROFILE_MGMT_INTERFACE, "UnregisterProfile");
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &object);
+
+	if (!dbus_connection_send_with_reply(connection, msg, &c, -1)) {
+		ofono_error("Sending RegisterProfile failed");
+		dbus_message_unref(msg);
+		return;
+	}
+
+	dbus_pending_call_set_notify(c, unregister_profile_cb, NULL, NULL);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+}
+
 struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
 					ConnectFunc cb, gpointer user_data)
 {
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index af59d3d..ffaf9e3 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -24,6 +24,7 @@
 =

 #define	BLUEZ_SERVICE "org.bluez"
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
@@ -66,7 +67,9 @@ void bluetooth_get_properties();
 int bluetooth_register_uuid(const char *uuid,
 				struct bluetooth_profile *profile);
 void bluetooth_unregister_uuid(const char *uuid);
-
+int bluetooth_register_profile(const char *uuid, const char *name,
+							const char *object);
+void bluetooth_unregister_profile(const char *object);
 struct server *bluetooth_register_server(guint8 channel, const char *sdp_r=
ecord,
 					ConnectFunc cb, gpointer user_data);
 void bluetooth_unregister_server(struct server *server);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 7c500e3..1e0064c 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -54,6 +54,8 @@
 #define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
 #define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
 =

+#define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
+
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
@@ -534,6 +536,14 @@ static int hfp_init(void)
 		return err;
 	}
 =

+	err =3D bluetooth_register_profile(HFP_HS_UUID, "hfp_hf",
+						HFP_EXT_PROFILE_PATH);
+	if (err < 0) {
+		bluetooth_unregister_uuid(HFP_AG_UUID);
+		ofono_modem_driver_unregister(&hfp_driver);
+		return err;
+	}
+
 	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

@@ -542,6 +552,8 @@ static int hfp_init(void)
 =

 static void hfp_exit(void)
 {
+
+	bluetooth_unregister_profile(HFP_EXT_PROFILE_PATH);
 	bluetooth_unregister_uuid(HFP_AG_UUID);
 	ofono_modem_driver_unregister(&hfp_driver);
 =

-- =

1.7.11.7


--===============1936269006739478339==--

