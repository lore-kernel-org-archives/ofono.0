Content-Type: multipart/mixed; boundary="===============6443226856151280155=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 1/2 v3] plugins: add upower battery monitor for bluetooth
Date: Wed, 16 Dec 2015 15:00:42 -0500
Message-ID: <1450296043-4083-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6443226856151280155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/upower.c | 388 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 388 insertions(+)
 create mode 100644 plugins/upower.c

diff --git a/plugins/upower.c b/plugins/upower.c
new file mode 100644
index 0000000..5500f00
--- /dev/null
+++ b/plugins/upower.c
@@ -0,0 +1,388 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2015 Canonical Ltd.
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
+#include <glib.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/log.h>
+#include <ofono/emulator.h>
+
+#define DBUS_PROPERTIES_INTERFACE     "org.freedesktop.DBus.Properties"
+#define UPOWER_SERVICE                "org.freedesktop.UPower"
+#define UPOWER_PATH                   "/org/freedesktop/UPower"
+#define UPOWER_INTERFACE              UPOWER_SERVICE
+#define UPOWER_DEVICE_INTERFACE       UPOWER_SERVICE ".Device"
+
+static guint modem_watch;
+static guint upower_daemon_watch;
+static DBusConnection *connection;
+static GHashTable *modem_hfp_watches;
+static int last_battery_level;
+static char *battery_device_path;
+
+static void emulator_battery_cb(struct ofono_atom *atom, void *data)
+{
+	struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+	int val =3D GPOINTER_TO_INT(data);
+
+	DBG("calling set_indicator: %d", val);
+	ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY, val);
+}
+
+static void update_modem_battery_indicator(struct ofono_modem *modem,
+								void *data)
+{
+	__ofono_modem_foreach_registered_atom(modem,
+				OFONO_ATOM_TYPE_EMULATOR_HFP,
+				emulator_battery_cb,
+				data);
+}
+
+static void update_battery_level(double percentage_val)
+{
+	int battery_level;
+
+	if (percentage_val <=3D 1.00) {
+		battery_level =3D 0;
+	} else if (percentage_val > 1.00 && percentage_val <=3D 100.00) {
+		battery_level =3D ((int) percentage_val - 1) / 20 + 1;
+	} else {
+		ofono_error("%s: Invalid value for battery level: %f",
+								__func__,
+								percentage_val);
+		return;
+	}
+
+	DBG("last_battery_level: %d battery_level: %d (%f)", last_battery_level,
+						battery_level, percentage_val);
+
+	if (last_battery_level =3D=3D battery_level)
+		return;
+
+	last_battery_level =3D battery_level;
+
+	__ofono_modem_foreach(update_modem_battery_indicator,
+					GINT_TO_POINTER(battery_level));
+}
+
+static gboolean battery_props_changed(DBusConnection *conn, DBusMessage *m=
sg,
+				void *user_data)
+
+{
+	const char *iface;
+	DBusMessageIter iter, dict;
+	double percentage_val;
+	gboolean percentage_found =3D FALSE;
+	gboolean retval =3D FALSE;
+
+	DBG("");
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING) {
+		ofono_error("%s: iface !=3D TYPE_STRING!", __func__);
+		goto done;
+	}
+
+	dbus_message_iter_get_basic(&iter, &iface);
+
+	if (g_str_equal(iface, UPOWER_DEVICE_INTERFACE) !=3D TRUE) {
+		ofono_error("%s: wrong iface: %s!", __func__, iface);
+		goto done;
+	}
+
+	if (!dbus_message_iter_next(&iter)) {
+		ofono_error("%s: advance iter failed!", __func__);
+		goto done;
+	}
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY) {
+		ofono_error("%s: type !=3D ARRAY!", __func__);
+		goto done;
+	}
+
+	dbus_message_iter_recurse(&iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, val;
+		const char *key;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D
+				DBUS_TYPE_STRING) {
+			ofono_error("%s: key type !=3D STRING!", __func__);
+			goto done;
+		}
+
+		dbus_message_iter_get_basic(&entry, &key);
+
+		if (g_str_equal(key, "Percentage") !=3D TRUE) {
+			dbus_message_iter_next(&dict);
+			continue;
+		}
+
+		dbus_message_iter_next(&entry);
+		if (dbus_message_iter_get_arg_type(&entry) !=3D
+				DBUS_TYPE_VARIANT) {
+			ofono_error("%s: 'Percentage' val !=3D VARIANT",
+								__func__);
+			goto done;
+		}
+
+		dbus_message_iter_recurse(&entry, &val);
+
+		if (dbus_message_iter_get_arg_type(&val) !=3D DBUS_TYPE_DOUBLE) {
+			ofono_error("%s: 'Percentage' val !=3D DOUBLE", __func__);
+			goto done;
+		}
+
+		dbus_message_iter_get_basic(&val, &percentage_val);
+		percentage_found =3D TRUE;
+		break;
+	}
+
+	/* No errors found during parsing, so don't trigger cb removal */
+	retval =3D TRUE;
+
+	if (percentage_found =3D=3D FALSE)
+		goto done;
+
+	update_battery_level(percentage_val);
+
+done:
+	return retval;
+}
+
+static void emulator_hfp_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		struct ofono_emulator *em =3D __ofono_atom_get_data(atom);
+
+		DBG("REGISTERED; calling set_indicator: %d", last_battery_level);
+
+		ofono_emulator_set_indicator(em, OFONO_EMULATOR_IND_BATTERY,
+							last_battery_level);
+		return;
+	}
+
+	DBG("UNREGISTERED");
+}
+
+static void modemwatch(struct ofono_modem *modem, gboolean added, void *us=
er)
+{
+
+	const char *path =3D ofono_modem_get_path(modem);
+
+	DBG("modem: %s, added: %d", path, added);
+
+	if (added) {
+		guint watch_id;
+
+		watch_id =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_EMULATOR_HFP,
+					emulator_hfp_watch, NULL, NULL);
+
+		g_hash_table_insert(modem_hfp_watches, g_strdup(path),
+						GINT_TO_POINTER(watch_id));
+
+	} else {
+		guint *watch_id =3D g_hash_table_lookup(modem_hfp_watches, path);
+
+		if (watch_id !=3D NULL) {
+			__ofono_modem_remove_atom_watch(modem, *watch_id);
+			g_hash_table_remove(modem_hfp_watches, path);
+		}
+	}
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modemwatch(modem, TRUE, user);
+}
+
+static gboolean parse_devices_reply(DBusMessage *reply)
+{
+	DBusMessageIter array, iter;
+	const char *path;
+
+	DBG("");
+
+	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
+		ofono_error("%s: ERROR reply to EnumerateDevices", __func__);
+		return FALSE;
+	}
+
+	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE) {
+		ofono_error("%s: error initializing array iter", __func__);
+		return FALSE;
+	}
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY) {
+		ofono_error("%s: type !=3D ARRAY!", __func__);
+		return FALSE;
+	}
+
+	dbus_message_iter_recurse(&array, &iter);
+
+	while (dbus_message_iter_get_arg_type(&iter) =3D=3D DBUS_TYPE_OBJECT_PATH=
) {
+
+		dbus_message_iter_get_basic(&iter, &path);
+
+		if (g_strrstr(path, "/battery_")) {
+			ofono_info("%s: found 1st battery device: %s", __func__,
+									path);
+			battery_device_path =3D g_strdup(path);
+			break;
+		}
+
+		if (!dbus_message_iter_next(&iter))
+			break;
+	}
+
+	return TRUE;
+}
+
+static void enum_devices_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusMessage *reply;
+
+	DBG("");
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	if (reply =3D=3D NULL) {
+		ofono_error("%s: dbus_message_new_method failed", __func__);
+		goto done;
+	}
+
+	if (parse_devices_reply(reply) =3D=3D FALSE)
+		goto done;
+
+	DBG("parse_devices_reply OK");
+
+	/* TODO: handle removable batteries */
+
+	if (battery_device_path =3D=3D NULL) {
+		ofono_error("%s: no battery detected", __func__);
+		goto done;
+	}
+
+	/* Always listen to PropertiesChanged for battery */
+	g_dbus_add_signal_watch(connection, UPOWER_SERVICE, battery_device_path,
+						DBUS_INTERFACE_PROPERTIES,
+						"PropertiesChanged",
+						battery_props_changed,
+						NULL, NULL);
+
+	modem_watch =3D __ofono_modemwatch_add(modemwatch, NULL, NULL);
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+done:
+	if (reply)
+		dbus_message_unref(reply);
+
+	dbus_pending_call_unref(call);
+}
+
+static void upower_connect(DBusConnection *conn, void *user_data)
+{
+	DBusPendingCall *call;
+	DBusMessage *msg;
+
+	DBG("upower connect");
+
+	msg =3D dbus_message_new_method_call(UPOWER_SERVICE,
+						UPOWER_PATH,
+						UPOWER_INTERFACE,
+						"EnumerateDevices");
+	if (msg =3D=3D NULL) {
+		ofono_error("%s: dbus_message_new_method failed", __func__);
+		return;
+	}
+
+	if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
+		ofono_error("%s: Sending EnumerateDevices failed", __func__);
+		goto done;
+	}
+
+	dbus_pending_call_set_notify(call, enum_devices_reply, NULL, NULL);
+done:
+	dbus_message_unref(msg);
+}
+
+static void upower_disconnect(DBusConnection *conn, void *user_data)
+{
+	DBG("upower disconnect");
+
+	if (modem_watch) {
+		__ofono_modemwatch_remove(modem_watch);
+		modem_watch =3D 0;
+	}
+
+	if (battery_device_path) {
+		g_free(battery_device_path);
+		battery_device_path =3D NULL;
+	}
+}
+
+static int upower_init(void)
+{
+	DBG("upower init");
+
+	connection =3D ofono_dbus_get_connection();
+	upower_daemon_watch =3D g_dbus_add_service_watch(connection,
+							UPOWER_SERVICE,
+							upower_connect,
+							upower_disconnect,
+							NULL, NULL);
+
+	modem_hfp_watches =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+				g_free, NULL);
+
+	return 0;
+}
+
+static void upower_exit(void)
+{
+	if (upower_daemon_watch)
+		g_dbus_remove_watch(connection, upower_daemon_watch);
+
+	if (modem_watch)
+		__ofono_modemwatch_remove(modem_watch);
+
+	if (battery_device_path)
+		g_free(battery_device_path);
+
+	g_hash_table_destroy(modem_hfp_watches);
+}
+
+OFONO_PLUGIN_DEFINE(upower, "upower battery monitor", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, upower_init, upower_exit)
-- =

2.1.4


--===============6443226856151280155==--

