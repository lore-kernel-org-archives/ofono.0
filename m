Content-Type: multipart/mixed; boundary="===============0765455222459762297=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] elect: Add DUN support
Date: Fri, 09 Dec 2011 13:44:05 +0100
Message-ID: <1323434645-13193-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0765455222459762297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---

Hi,

I dropped the Connect()/Disconnect() method and added the
SetProperty() for Active. Also the documentation is now
correct. I'll start now to split this huge patch.

cheers,
daniel

v1: - Elect API change: Connect()/Disconect() dropped, instead =

      SetProperty("Active", TRUE/FALSE)
    - Fix doc

v0: - inital version

 Makefile.am           |   24 ++
 bootstrap-configure   |    1 +
 configure.ac          |    4 +
 doc/elect-api.txt     |   86 ++++++
 elect/device.c        |  718 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/dun.c           |  270 +++++++++++++++++++
 elect/elect.conf      |   23 ++
 elect/elect.h         |  102 +++++++
 elect/elect.service   |   11 +
 elect/main.c          |  254 +++++++++++++++++
 elect/manager.c       |  115 ++++++++
 plugins/bluetooth.h   |    1 +
 test/elect-connect    |   20 ++
 test/elect-disconnect |   20 ++
 14 files changed, 1649 insertions(+), 0 deletions(-)
 create mode 100644 doc/elect-api.txt
 create mode 100644 elect/device.c
 create mode 100644 elect/dun.c
 create mode 100644 elect/elect.conf
 create mode 100644 elect/elect.h
 create mode 100644 elect/elect.service
 create mode 100644 elect/main.c
 create mode 100644 elect/manager.c
 create mode 100755 test/elect-connect
 create mode 100755 test/elect-disconnect

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..657203e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -647,6 +647,30 @@ tools_lookup_provider_name_SOURCES =3D plugins/mbpi.c =
plugins/mbpi.h \
 tools_lookup_provider_name_LDADD =3D @GLIB_LIBS@
 endif
 =

+if ELECT
+
+sbin_PROGRAMS +=3D elect/electd
+
+elect_electd_SOURCES =3D $(gdbus_sources) $(gatchat_sources) $(btio_source=
s) \
+			elect/main.c elect/manager.c elect/device.c elect/dun.c \
+			src/log.c src/dbus.c plugins/bluetooth.c
+
+elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
+
+if DATAFILES
+
+dist_dbusconf_DATA +=3D elect/elect.conf
+
+if SYSTEMD
+systemdunitdir +=3D @SYSTEMD_UNITDIR@
+
+systemdunit_DATA +=3D elect/elect.service
+endif
+
+endif
+
+endif
+
 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
 =

 gatchat_gsmdial_SOURCES =3D gatchat/gsmdial.c $(gatchat_sources)
diff --git a/bootstrap-configure b/bootstrap-configure
index db70c66..d80ed8b 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -14,4 +14,5 @@ fi
 		--localstatedir=3D/var \
 		--enable-capng \
 		--enable-tools \
+		--enable-elect \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 5e4d34f..f8f3387 100644
--- a/configure.ac
+++ b/configure.ac
@@ -165,6 +165,10 @@ if (test "${enable_tools}" =3D "yes"); then
 fi
 AM_CONDITIONAL(TOOLS, test "${enable_tools}" =3D "yes")
 =

+AC_ARG_ENABLE(elect, AC_HELP_STRING([--enable-elect],
+		[enable DUN deamon support]), [enable_elect=3D${enableval}])
+AM_CONDITIONAL(ELECT, test "${enable_elect}" =3D "yes")
+
 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
 				[disable ETSI AT modem support]),
 					[enable_atmodem=3D${enableval}])
diff --git a/doc/elect-api.txt b/doc/elect-api.txt
new file mode 100644
index 0000000..2974f87
--- /dev/null
+++ b/doc/elect-api.txt
@@ -0,0 +1,86 @@
+
+Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono.elect
+Interface	org.ofono.elect.Manager
+Object path	/
+
+Methods		array{object,dict} GetDevices()
+
+			Get an array of device objects and properties
+			that represent the currently attached devices.
+
+			This method call should only be used once when an
+			application starts up. Further device additions
+			and removal shall be monitored via DeviceAdded and
+			DeviceRemoved signals.
+
+Signals		DeviceAdded(object path, dict properties)
+
+			Signal that is sent when a new device is added.  It
+			contains the object path of new device and its
+			properties.
+
+		DeviceRemoved(object path)
+
+			Signal that is sent when a device has been removed.
+			The object path is no longer accessible after this
+			signal and only emitted for reference.
+
+
+Device hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono.elect
+Interface	org.ofono.elect.Device
+Object path	[variable prefix]/{device0,device1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the device object. See
+			the properties section for available properties.
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string Name [readonly]
+
+			Friendly name of the device.
+
+		boolean Active [readwrite]
+
+			Holds whether the device is connected. A
+			connection will be established when this value
+			is set to true. A existing connection will be
+			teared down when set to false.
+
+		dict Settings [readonly]
+
+			Holds all the IP network settings.
+
+			string Interface [readonly, optional]
+
+				Holds the interface of the network interface
+				used by this connection (e.g. "ppp0" "usb0")
+
+			string Method [readonly, optional]
+
+				Holds the IP network config method.
+					"static"- Set IP network statically
+					"dhcp"  - Set IP network through DHCP
+
+			string Address [readonly, optional]
+
+				Holds the IP address for this connection.
+
+			string Netmask [readonly, optional]
+
+				Holds the Netmask for this connection.
+
+			array{string} DomainNameServers [readonly, optional]
+
+				Holds the list of domain name servers for this
+				connection.
diff --git a/elect/device.c b/elect/device.c
new file mode 100644
index 0000000..4db318a
--- /dev/null
+++ b/elect/device.c
@@ -0,0 +1,718 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <netinet/ether.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "plugins/bluetooth.h"
+
+#include "elect.h"
+
+#define STATIC_IP_NETMASK "255.255.255.255"
+
+static DBusConnection *connection;
+
+static GHashTable *device_hash;
+
+struct ipv4_settings {
+	char *interface;
+
+	char *ip;
+	char **nameservers;
+};
+
+struct elect_device {
+	DBusPendingCall *call;
+	DBusMessage *pending;
+
+	char *path;
+	char *address;
+	char *tty;
+
+	char *elect_path;
+	gboolean active;
+	struct ipv4_settings settings;
+	char *name;
+
+	struct elect_dun *dun;
+};
+
+static char *get_ident(const char *path)
+{
+	char *pos;
+
+	if (*path !=3D '/')
+		return NULL;
+
+	pos =3D strrchr(path, '/');
+	if (pos =3D=3D NULL)
+		return NULL;
+
+	return pos + 1;
+}
+
+const char *__elect_device_get_path(struct elect_device *device)
+{
+	return device->elect_path;
+}
+
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
+void __elect_device_append_properties(struct elect_device *device,
+					DBusMessageIter *dict)
+{
+	settings_append_dict(device, dict);
+
+	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN,
+				&device->active);
+
+	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
+				&device->name);
+}
+
+void __elect_device_foreach(elect_device_foreach_func func, void *userdata)
+{
+	GHashTableIter iter;
+	gpointer key, value;
+
+	DBG("");
+
+	g_hash_table_iter_init(&iter, device_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value) =3D=3D TRUE) {
+		struct elect_device *device =3D value;
+
+		func(device, userdata);
+	}
+}
+
+static void settings_changed(struct elect_device *device)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *key =3D "Settings";
+
+	signal =3D dbus_message_new_signal(device->elect_path,
+					ELECT_DEVICE_INTERFACE,
+					"PropertyChanged");
+
+	if (signal =3D=3D NULL)
+		return;
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
+
+	settings_append(device, &iter);
+
+	g_dbus_send_message(connection, signal);
+}
+
+static void connect_cb(const char *interface, const char *ip,
+			const char *peer, const char *dns1, const char *dns2,
+			void *data)
+{
+	struct elect_device *device =3D data;
+	const char *dns[3] =3D { dns1, dns2, 0 };
+
+	DBG("%p", device);
+
+	g_free(device->settings.interface);
+	device->settings.interface =3D g_strdup(interface);
+	if (device->settings.interface =3D=3D NULL)
+		goto err;
+
+	g_free(device->settings.ip);
+	device->settings.ip =3D g_strdup(ip);
+	if (device->settings.ip =3D=3D NULL)
+		goto err;
+
+	g_strfreev(device->settings.nameservers);
+	device->settings.nameservers =3D g_strdupv((gchar **)dns);
+	if (device->settings.nameservers =3D=3D NULL)
+		goto err;
+
+	device->active =3D TRUE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(connection, device->elect_path,
+					ELECT_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	return;
+
+err:
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+}
+
+static int bt_disconnect(struct elect_device *device);
+
+static void disconnect_cb(void *data)
+{
+	struct elect_device *device =3D data;
+
+	DBG("%p", device);
+
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+
+	device->active =3D FALSE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(connection, device->elect_path,
+					ELECT_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	bt_disconnect(device);
+}
+
+static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct elect_device *device =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+	char *tty;
+
+	DBG("%p", device);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	device->call =3D NULL;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Connection to bt serial returned with error: %s, %s",
+						derr.name, derr.message);
+
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &tty,
+			DBUS_TYPE_INVALID);
+
+	DBG("%p tty %s", device, tty);
+
+	device->tty =3D g_strdup(tty);
+
+	device->dun =3D __elect_dun_create(device->tty, connect_cb,
+						disconnect_cb, device);
+	__elect_dun_connect(device->dun);
+
+done:
+	dbus_message_unref(reply);
+
+	if (device->pending !=3D NULL) {
+		DBusMessage *reply;
+
+		if (device->tty !=3D NULL)
+			reply =3D dbus_message_new_method_return(device->pending);
+		else
+			reply =3D __ofono_error_failed(device->pending);
+
+		__ofono_dbus_pending_reply(&device->pending, reply);
+
+		device->pending =3D NULL;
+	}
+}
+
+static int bt_connect(struct elect_device *device)
+{
+	DBusPendingCall *call;
+	int status;
+	char *profile =3D "dun";
+
+	DBG("%p", device);
+
+	status =3D bluetooth_send_with_reply(device->path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					&call, bt_connect_reply,
+					device, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	device->call =3D call;
+
+	return -EINPROGRESS;
+}
+
+static void bt_disconnect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct elect_device *device =3D user_data;
+	DBusMessage *reply;
+
+	DBG("%p", device);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	dbus_message_unref(reply);
+
+	device->call =3D NULL;
+
+	g_free(device->tty);
+	device->tty =3D NULL;
+
+	__elect_dun_unref(device->dun);
+	device->dun =3D NULL;
+}
+
+static int bt_disconnect(struct elect_device *device)
+{
+	DBusPendingCall *call;
+	int status;
+
+	DBG("%p", device);
+
+	if (device->tty =3D=3D NULL)
+		return 0;
+
+	status =3D bluetooth_send_with_reply(device->path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					&call, bt_disconnect_reply,
+					device, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &device->tty,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	device->call =3D call;
+
+	return -EINPROGRESS;
+}
+
+static int register_device(struct elect_device *device);
+
+static int bt_probe(const char *path, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct elect_device *device;
+	char buf[256];
+
+	DBG("");
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(device_hash, path) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			path, dev_addr, adapter_addr);
+
+	strcpy(buf, "dun/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	device =3D g_try_new0(struct elect_device, 1);
+	if (device =3D=3D 0) {
+		DBG("Failed to create device data structure");
+		return -ENOMEM;
+	}
+
+	DBG("%p", device);
+
+	device->path =3D g_strdup(path);
+	if (device->path =3D=3D NULL)
+		goto free;
+
+	device->address =3D g_strdup(dev_addr);
+	if (device->address =3D=3D NULL)
+		goto free;
+
+	device->name =3D g_strdup(alias);
+	if (device->name =3D=3D NULL)
+		goto free;
+
+	device->elect_path =3D g_strdup_printf("/device/%s", get_ident(path));
+	if (device->elect_path =3D=3D NULL)
+		goto free;
+
+	g_hash_table_insert(device_hash, g_strdup(path), device);
+
+	register_device(device);
+
+	return 0;
+
+free:
+	g_free(device->path);
+	g_free(device->address);
+	g_free(device->name);
+	g_free(device->elect_path);
+	g_free(device);
+
+	return -ENOMEM;
+}
+
+static int unregister_device(struct elect_device *device);
+
+static gboolean bt_remove_device(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct elect_device *device =3D value;
+	const char *path =3D key;
+	const char *prefix =3D user_data;
+
+	DBG("%p", device);
+
+	if (device->call !=3D NULL)
+		dbus_pending_call_cancel(device->call);
+
+	if (prefix && g_str_has_prefix(path, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	unregister_device(device);
+
+	return TRUE;
+}
+
+static void bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (device_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(device_hash, bt_remove_device,
+							(gpointer) prefix);
+}
+
+static void bt_set_alias(const char *path, const char *alias)
+{
+	struct elect_device *device;
+
+	DBG("");
+
+	if (path =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	device =3D g_hash_table_lookup(device_hash, path);
+	if (device =3D=3D NULL)
+		return;
+
+	g_free(device->name);
+	device->name =3D g_strdup(alias);
+}
+
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D bt_probe,
+	.remove		=3D bt_remove,
+	.set_alias	=3D bt_set_alias,
+};
+
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
+	int err;
+
+	DBG("%p elect_path %s", device, device->elect_path);
+
+	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(var, &active);
+
+	if (device->pending !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (device->active =3D=3D active)
+		return dbus_message_new_method_return(msg);
+
+	if (active) {
+		err =3D bt_connect(device);
+		if (err !=3D -EINPROGRESS && err < 0)
+			return __ofono_error_failed(msg);
+
+		device->pending =3D dbus_message_ref(msg);
+
+		return NULL;
+	} else {
+		if (device->dun)
+			__elect_dun_disconnect(device->dun);
+
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
+}
+
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
+static void destroy_device(gpointer user)
+{
+	struct elect_device *device =3D user;
+
+	if (device->pending)
+		dbus_message_unref(device->pending);
+
+	if (device->call)
+		dbus_pending_call_cancel(device->call);
+
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+
+	g_free(device->path);
+	g_free(device->address);
+	g_free(device->tty);
+	g_free(device->elect_path);
+	g_free(device->name);
+
+	g_free(device);
+}
+
+static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
+{
+	struct elect_device *device =3D value;
+
+	unregister_device(device);
+}
+
+void __elect_device_shutdown(void)
+{
+	g_hash_table_foreach(device_hash, device_shutdown, NULL);
+
+	__elect_exit();
+}
+
+int __elect_device_init(DBusConnection *conn)
+{
+	int err;
+
+	DBG("");
+
+	connection =3D conn;
+
+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);
+	if (err < 0)
+		return err;
+
+
+	device_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, destroy_device);
+
+	return 0;
+}
+
+void __elect_device_cleanup(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+
+	g_hash_table_destroy(device_hash);
+}
diff --git a/elect/dun.c b/elect/dun.c
new file mode 100644
index 0000000..012591e
--- /dev/null
+++ b/elect/dun.c
@@ -0,0 +1,270 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/signalfd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gatppp.h>
+
+#include "elect.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+struct elect_dun {
+	char *path;
+
+	GAtPPP *ppp;
+	GAtChat *control;
+	GAtChat *modem;
+
+	elect_dun_connect_cb_t connect_cb;
+	elect_dun_disconnect_cb_t disconnect_cb;
+	void *data;
+};
+
+static void dun_debug(const char *str, void *data)
+{
+	DBG("%s: %s\n", (const char *) data, str);
+}
+
+static void kill_ppp(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("%s %s\n", dun->path, ok ? "ok" : "failed");
+
+	if (ok =3D=3D FALSE)
+		return;
+
+	g_at_ppp_unref(dun->ppp);
+	dun->ppp =3D NULL;
+
+	dun->disconnect_cb(dun->data);
+}
+
+static void ppp_suspend_ath0(gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("%s", dun->path);
+
+	g_at_chat_resume(dun->modem);
+	g_at_chat_send(dun->modem, "ATH0", none_prefix, kill_ppp, dun, NULL);
+}
+
+static void resume_ppp(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("%s %s\n", dun->path, ok ? "ok" : "failed");
+
+	if (ok =3D=3D FALSE)
+		return;
+
+	g_at_chat_suspend(dun->modem);
+	g_at_ppp_resume(dun->ppp);
+
+	dun->disconnect_cb(dun->data);
+}
+
+static void ppp_suspend_ato0(gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("%s", dun->path);
+
+	g_at_chat_resume(dun->modem);
+	g_at_chat_send(dun->modem, "ATO0", none_prefix, resume_ppp, dun, NULL);
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Peer IP Address: %s\n", peer);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+
+	if (dun->connect_cb)
+		dun->connect_cb(iface, local, peer, dns1, dns2, dun->data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct elect_dun *dun =3D user_data;
+
+	DBG("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(dun->ppp);
+	dun->ppp =3D NULL;
+
+	g_at_chat_resume(dun->modem);
+
+	if (dun->disconnect_cb)
+		dun->disconnect_cb(dun->data);
+}
+
+static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct elect_dun *dun =3D user_data;
+	GAtIO *io;
+
+	if (!ok) {
+		DBG("Unable to define context\n");
+		return;
+	}
+
+	/* get the data IO channel */
+	io =3D g_at_chat_get_io(dun->modem);
+
+	/*
+	 * shutdown gatchat or else it tries to take all the input
+	 * from the modem and does not let PPP get it.
+	 */
+	g_at_chat_suspend(dun->modem);
+
+	/* open ppp */
+	dun->ppp =3D g_at_ppp_new();
+	if (dun->ppp =3D=3D NULL) {
+		DBG("Unable to create PPP object\n");
+		return;
+	}
+	g_at_ppp_set_debug(dun->ppp, dun_debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(dun->ppp, ppp_connect, dun);
+	g_at_ppp_set_disconnect_function(dun->ppp, ppp_disconnect, dun);
+
+	/* open the ppp connection */
+	g_at_ppp_open(dun->ppp, io);
+}
+
+static int open_serial(struct elect_dun *dun)
+{
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+
+	channel =3D g_at_tty_open(dun->path, NULL);
+	if (channel =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	dun->control =3D g_at_chat_new(channel, syntax);
+	g_io_channel_unref(channel);
+	g_at_syntax_unref(syntax);
+
+	if (dun->control =3D=3D NULL)
+		return -EIO;
+
+	g_at_chat_ref(dun->control);
+	dun->modem =3D dun->control;
+	g_at_chat_set_debug(dun->control, dun_debug, "Control");
+
+	return 0;
+}
+
+struct elect_dun *__elect_dun_create(const char *path,
+				elect_dun_connect_cb_t connect_cb,
+				elect_dun_disconnect_cb_t disconnect_cb,
+				void *data)
+{
+	struct elect_dun *dun;
+
+	DBG("%s", path);
+
+	dun =3D g_try_new0(struct elect_dun, 1);
+	if (dun =3D=3D NULL)
+		return NULL;
+
+	dun->path =3D g_strdup(path);
+	dun->connect_cb =3D connect_cb;
+	dun->disconnect_cb =3D disconnect_cb;
+	dun->data =3D data;
+
+	return dun;
+}
+
+int __elect_dun_connect(struct elect_dun *dun)
+{
+	int err;
+
+	DBG("%s", dun->path);
+
+	err =3D open_serial(dun);
+	if (err < 0)
+		return err;
+
+	g_at_chat_send(dun->control, "ATD*99#", none_prefix, connect_cb,
+		dun, NULL);
+
+	return 0;
+}
+
+int __elect_dun_disconnect(struct elect_dun *dun)
+{
+	DBG("%s", dun->path);
+
+	if (dun->ppp =3D=3D NULL)
+		return -EINVAL;
+
+	/* XXX Which one is the right one? */
+	if (FALSE)
+		g_at_ppp_set_suspend_function(dun->ppp, ppp_suspend_ath0, dun);
+	else
+		g_at_ppp_set_suspend_function(dun->ppp, ppp_suspend_ato0, dun);
+
+	g_at_ppp_suspend(dun->ppp);
+
+	return 0;
+}
+
+void __elect_dun_unref(struct elect_dun *dun)
+{
+	DBG("%s", dun->path);
+
+	if (dun->ppp)
+		g_at_ppp_unref(dun->ppp);
+	if (dun->control)
+		g_at_chat_unref(dun->control);
+
+	g_free(dun->path);
+
+	g_free(dun);
+}
diff --git a/elect/elect.conf b/elect/elect.conf
new file mode 100644
index 0000000..548ffe8
--- /dev/null
+++ b/elect/elect.conf
@@ -0,0 +1,23 @@
+<!-- This configuration file specifies the required security policies
+     for oFono elect (DUN) daemon to work. -->
+
+<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.=
0//EN"
+ "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
+<busconfig>
+
+  <!-- ../system.conf have denied everything, so we just punch some holes =
-->
+
+  <policy user=3D"root">
+    <allow own=3D"org.ofono.elect"/>
+    <allow send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+  <policy at_console=3D"true">
+    <allow send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+  <policy context=3D"default">
+    <deny send_destination=3D"org.ofono.elect"/>
+  </policy>
+
+</busconfig>
diff --git a/elect/elect.h b/elect/elect.h
new file mode 100644
index 0000000..75d161b
--- /dev/null
+++ b/elect/elect.h
@@ -0,0 +1,102 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include <ofono/types.h>
+
+void __elect_exit(void);
+
+#include <ofono/log.h>
+
+int __ofono_log_init(const char *program, const char *debug,
+					ofono_bool_t detach);
+void __ofono_log_cleanup(void);
+void __ofono_log_enable(struct ofono_debug_desc *start,
+					struct ofono_debug_desc *stop);
+
+#include <ofono/dbus.h>
+
+#define ELECT_SERVICE		"org.ofono.elect"
+#define ELECT_MANAGER_INTERFACE	"org.ofono.elect.Manager"
+#define ELECT_DEVICE_INTERFACE	"org.ofono.elect.Device"
+#define ELECT_MANAGER_PATH	"/"
+
+int __ofono_dbus_init(DBusConnection *conn);
+void __ofono_dbus_cleanup(void);
+
+void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
+
+DBusMessage *__ofono_error_invalid_args(DBusMessage *msg);
+DBusMessage *__ofono_error_invalid_format(DBusMessage *msg);
+DBusMessage *__ofono_error_not_implemented(DBusMessage *msg);
+DBusMessage *__ofono_error_failed(DBusMessage *msg);
+DBusMessage *__ofono_error_busy(DBusMessage *msg);
+DBusMessage *__ofono_error_not_found(DBusMessage *msg);
+DBusMessage *__ofono_error_not_active(DBusMessage *msg);
+DBusMessage *__ofono_error_not_supported(DBusMessage *msg);
+DBusMessage *__ofono_error_not_available(DBusMessage *msg);
+DBusMessage *__ofono_error_timed_out(DBusMessage *msg);
+DBusMessage *__ofono_error_sim_not_ready(DBusMessage *msg);
+DBusMessage *__ofono_error_in_use(DBusMessage *msg);
+DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
+DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
+DBusMessage *__ofono_error_not_registered(DBusMessage *msg);
+DBusMessage *__ofono_error_canceled(DBusMessage *msg);
+DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
+DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);
+
+
+int __elect_manager_init(DBusConnection *conn);
+void __elect_manager_cleanup(void);
+
+
+struct elect_device;
+
+int __elect_device_init(DBusConnection *conn);
+void __elect_device_cleanup(void);
+
+typedef void (*elect_device_foreach_func)(struct elect_device *device,
+						void *data);
+void __elect_device_foreach(elect_device_foreach_func cb, void *userdata);
+
+const char *__elect_device_get_path(struct elect_device *device);
+void __elect_device_append_properties(struct elect_device *device,
+					DBusMessageIter *dict);
+void __elect_device_shutdown(void);
+
+
+typedef void (*elect_dun_connect_cb_t)(const char *interface, const char *=
ip,
+				const char *peer,
+				const char *dns1, const char *dns2,
+				void *data);
+typedef void (*elect_dun_disconnect_cb_t)(void *data);
+
+struct elect_dun *__elect_dun_create(const char *path,
+				elect_dun_connect_cb_t connect_cb,
+				elect_dun_disconnect_cb_t disconnect_cb,
+				void *data);
+int __elect_dun_connect(struct elect_dun *dun);
+int __elect_dun_disconnect(struct elect_dun *dun);
+void __elect_dun_unref(struct elect_dun *dun);
diff --git a/elect/elect.service b/elect/elect.service
new file mode 100644
index 0000000..39d9349
--- /dev/null
+++ b/elect/elect.service
@@ -0,0 +1,11 @@
+[Unit]
+Description=3DDUN service
+After=3Dsyslog.target
+
+[Service]
+Type=3Ddbus
+BusName=3Dorg.ofono.elect
+ExecStart=3D/usr/sbin/electd -n
+
+[Install]
+WantedBy=3Dmulti-user.target
diff --git a/elect/main.c b/elect/main.c
new file mode 100644
index 0000000..4a11a0a
--- /dev/null
+++ b/elect/main.c
@@ -0,0 +1,254 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/signalfd.h>
+
+#include <gdbus.h>
+
+#ifdef HAVE_CAPNG
+#include <cap-ng.h>
+#endif
+
+#include "elect.h"
+
+#define SHUTDOWN_GRACE_SECONDS 10
+
+static GMainLoop *event_loop;
+
+void __elect_exit(void)
+{
+	g_main_loop_quit(event_loop);
+}
+
+static gboolean quit_eventloop(gpointer user_data)
+{
+	__elect_exit();
+	return FALSE;
+}
+
+static unsigned int __terminated =3D 0;
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd =3D g_io_channel_unix_get_fd(channel);
+
+	result =3D read(fd, &si, sizeof(si));
+	if (result !=3D sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGINT:
+	case SIGTERM:
+		if (__terminated =3D=3D 0) {
+			ofono_info("Terminating");
+			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
+						quit_eventloop, NULL);
+
+			__elect_device_shutdown();
+		}
+
+		__terminated =3D 1;
+		break;
+	}
+
+	return TRUE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
+		perror("Failed to set signal mask");
+		return 0;
+	}
+
+	fd =3D signalfd(-1, &mask, 0);
+	if (fd < 0) {
+		perror("Failed to create signal descriptor");
+		return 0;
+	}
+
+	channel =3D g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source =3D g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+static void system_bus_disconnected(DBusConnection *conn, void *user_data)
+{
+	ofono_error("System bus has disconnected!");
+
+	g_main_loop_quit(event_loop);
+}
+
+static gchar *option_debug =3D NULL;
+static gboolean option_detach =3D TRUE;
+static gboolean option_version =3D FALSE;
+
+static gboolean parse_debug(const char *key, const char *value,
+					gpointer user_data, GError **error)
+{
+	if (value)
+		option_debug =3D g_strdup(value);
+	else
+		option_debug =3D g_strdup("*");
+
+	return TRUE;
+}
+
+static GOptionEntry options[] =3D {
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
+				"Specify debug options to enable", "DEBUG" },
+	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
+				G_OPTION_ARG_NONE, &option_detach,
+				"Don't run as daemon in background" },
+	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
+				"Show version information and exit" },
+	{ NULL },
+};
+
+int main(int argc, char **argv)
+{
+	GOptionContext *context;
+	GError *err =3D NULL;
+	DBusConnection *conn;
+	DBusError error;
+	guint signal;
+
+#ifdef HAVE_CAPNG
+	/* Drop capabilities */
+	capng_clear(CAPNG_SELECT_BOTH);
+	capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
+				CAP_NET_BIND_SERVICE, CAP_NET_ADMIN,
+				CAP_NET_RAW, CAP_SYS_ADMIN, -1);
+	capng_apply(CAPNG_SELECT_BOTH);
+#endif
+
+	context =3D g_option_context_new(NULL);
+	g_option_context_add_main_entries(context, options, NULL);
+
+	if (g_option_context_parse(context, &argc, &argv, &err) =3D=3D FALSE) {
+		if (err !=3D NULL) {
+			g_printerr("%s\n", err->message);
+			g_error_free(err);
+			return 1;
+		}
+
+		g_printerr("An unknown error occurred\n");
+		return 1;
+	}
+
+	g_option_context_free(context);
+
+	if (option_version =3D=3D TRUE) {
+		printf("%s\n", VERSION);
+		exit(0);
+	}
+
+	if (option_detach =3D=3D TRUE) {
+		if (daemon(0, 0)) {
+			perror("Can't start daemon");
+			return 1;
+		}
+	}
+
+	event_loop =3D g_main_loop_new(NULL, FALSE);
+
+	signal =3D setup_signalfd();
+
+	__ofono_log_init(argv[0], option_debug, option_detach);
+
+	dbus_error_init(&error);
+
+	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, ELECT_SERVICE, &error);
+	if (conn =3D=3D NULL) {
+		if (dbus_error_is_set(&error) =3D=3D TRUE) {
+			ofono_error("Unable to hop onto D-Bus: %s",
+					error.message);
+			dbus_error_free(&error);
+		} else {
+			ofono_error("Unable to hop onto D-Bus");
+		}
+
+		goto cleanup;
+	}
+
+	g_dbus_set_disconnect_function(conn, system_bus_disconnected,
+					NULL, NULL);
+
+	__ofono_dbus_init(conn);
+
+	__elect_device_init(conn);
+	__elect_manager_init(conn);
+
+	g_main_loop_run(event_loop);
+
+	__elect_manager_cleanup();
+	__elect_device_cleanup();
+
+	__ofono_dbus_cleanup();
+	dbus_connection_unref(conn);
+
+cleanup:
+	g_source_remove(signal);
+
+	g_main_loop_unref(event_loop);
+
+	__ofono_log_cleanup();
+
+	return 0;
+}
diff --git a/elect/manager.c b/elect/manager.c
new file mode 100644
index 0000000..c983aea
--- /dev/null
+++ b/elect/manager.c
@@ -0,0 +1,115 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <string.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "elect.h"
+
+static DBusConnection *connection;
+
+static void append_device(struct elect_device *device, void *userdata)
+{
+	DBusMessageIter *array =3D userdata;
+	const char *path =3D __elect_device_get_path(device);
+	DBusMessageIter entry, dict;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_STRUCT,
+						NULL, &entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+					&path);
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE,
+				&dict);
+
+	__elect_device_append_properties(device, &dict);
+	dbus_message_iter_close_container(&entry, &dict);
+	dbus_message_iter_close_container(array, &entry);
+}
+
+static DBusMessage *manager_get_devices(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&array);
+	__elect_device_foreach(append_device, &array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static GDBusMethodTable manager_methods[] =3D {
+	{ "GetDevices",          "",    "a(oa{sv})",  manager_get_devices },
+	{ }
+};
+
+static GDBusSignalTable manager_signals[] =3D {
+	{ "DeviceAdded",        "oa{sv}" },
+	{ "DeviceRemoved",      "o" },
+	{ }
+};
+
+int __elect_manager_init(DBusConnection *conn)
+{
+	gboolean ret;
+
+	connection =3D conn;
+
+	ret =3D g_dbus_register_interface(connection, ELECT_MANAGER_PATH,
+					ELECT_MANAGER_INTERFACE,
+					manager_methods, manager_signals,
+					NULL, NULL, NULL);
+
+	if (ret =3D=3D FALSE)
+		return -1;
+
+	return 0;
+}
+
+void __elect_manager_cleanup(void)
+{
+	g_dbus_unregister_interface(connection, ELECT_MANAGER_PATH,
+					ELECT_MANAGER_INTERFACE);
+}
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index daa1873..4fc16ad 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -27,6 +27,7 @@
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
 #define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
 #define	BLUEZ_SERVICE_INTERFACE		BLUEZ_SERVICE ".Service"
+#define BLUEZ_SERIAL_INTERFACE		BLUEZ_SERVICE ".Serial"
 =

 #define DBUS_TIMEOUT 15
 =

diff --git a/test/elect-connect b/test/elect-connect
new file mode 100755
index 0000000..09e592e
--- /dev/null
+++ b/test/elect-connect
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono.elect', '/'),
+			'org.ofono.elect.Manager')
+	devices =3D manager.GetDevices()
+	path =3D devices[0][0]
+
+print "Connect device %s..." % path
+device =3D dbus.Interface(bus.get_object('org.ofono.elect', path),
+						'org.ofono.elect.Device')
+
+device.Connect()
diff --git a/test/elect-disconnect b/test/elect-disconnect
new file mode 100755
index 0000000..76ff74c
--- /dev/null
+++ b/test/elect-disconnect
@@ -0,0 +1,20 @@
+#!/usr/bin/python
+
+import dbus
+import sys
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+	path =3D sys.argv[1]
+else:
+	manager =3D dbus.Interface(bus.get_object('org.ofono.elect', '/'),
+			'org.ofono.elect.Manager')
+	devices =3D manager.GetDevices()
+	path =3D devices[0][0]
+
+print "Disonnect device %s..." % path
+device =3D dbus.Interface(bus.get_object('org.ofono.elect', path),
+						'org.ofono.elect.Device')
+
+device.Disconnect()
-- =

1.7.8.110.g4cb5d1


--===============0765455222459762297==--

