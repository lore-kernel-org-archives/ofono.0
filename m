Content-Type: multipart/mixed; boundary="===============4366856634456154101=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/3] Add radio settings atom and driver API
Date: Thu, 04 Feb 2010 08:58:29 +0200
Message-ID: <1265266709-3835-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4366856634456154101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This interface exposes a rw property for radio access selection mode
setting.
---
 Makefile.am                |    6 +-
 doc/radio-settings-api.txt |   42 +++++
 include/radio-settings.h   |   74 +++++++++
 src/ofono.h                |    2 +
 src/radio-settings.c       |  372 ++++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 494 insertions(+), 2 deletions(-)
 create mode 100644 doc/radio-settings-api.txt
 create mode 100644 include/radio-settings.h
 create mode 100644 src/radio-settings.c

diff --git a/Makefile.am b/Makefile.am
index 33339df..672ce0b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -11,7 +11,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/sms.h include/sim.h include/message-waiting.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
-			include/gprs.h include/gprs-context.h
+			include/gprs.h include/gprs-context.h \
+			include/radio-settings.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -224,7 +225,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/phonebook.c src/history.c src/message-waiting.c \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
-			src/gprs.c src/idmap.h src/idmap.c
+			src/gprs.c src/idmap.h src/idmap.c \
+			src/radio-settings.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
new file mode 100644
index 0000000..c36b574
--- /dev/null
+++ b/doc/radio-settings-api.txt
@@ -0,0 +1,42 @@
+Radio Settings hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.RadioSettings
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns all radio access properties. See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void SetProperty(string name, variant value)
+
+			Changes the value of the specified property. Only
+			properties that are listed as read-write are
+			changeable. On success a PropertyChanged signal
+			will be emitted.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.DoesNotExist
+					 [service].Error.InProgress
+
+Signals		PropertyChanged(string property, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	string Mode [read-write]
+
+			The current radio access selection mode, also known
+			as network preference.
+
+			The possible values are:
+				"dual"     Radio access selection is done
+					   automatically, using either 2G
+					   or 3G, depending on reception.
+				"2g"       Only GSM used for radio access.
+				"3g"       Only UTRAN used for radio access.
+				"unknown"  Mode currently unknown.
diff --git a/include/radio-settings.h b/include/radio-settings.h
new file mode 100644
index 0000000..807d3da
--- /dev/null
+++ b/include/radio-settings.h
@@ -0,0 +1,74 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_RADIO_SETTINGS_H
+#define __OFONO_RADIO_SETTINGS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum ofono_radio_access_mode {
+	OFONO_RADIO_ACCESS_MODE_DUAL =3D 0,
+	OFONO_RADIO_ACCESS_MODE_2G =3D 1,
+	OFONO_RADIO_ACCESS_MODE_3G =3D 2,
+};
+
+struct ofono_radio_settings;
+
+typedef void (*ofono_radio_settings_mode_set_cb_t)(const struct ofono_erro=
r *error,
+							void *data);
+typedef void (*ofono_radio_settings_mode_query_cb_t)(const struct ofono_er=
ror *error,
+						enum ofono_radio_access_mode mode,
+						void *data);
+
+struct ofono_radio_settings_driver {
+	const char *name;
+	int (*probe)(struct ofono_radio_settings *rs, unsigned int vendor, void *=
data);
+	void (*remove)(struct ofono_radio_settings *rs);
+	void (*query_mode)(struct ofono_radio_settings *rs,
+				ofono_radio_settings_mode_query_cb_t cb, void *data);
+	void (*set_mode)(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_settings_mode_set_cb_t cb, void *data);
+};
+
+int ofono_radio_settings_driver_register(const struct ofono_radio_settings=
_driver *d);
+void ofono_radio_settings_driver_unregister(const struct ofono_radio_setti=
ngs_driver *d);
+
+struct ofono_radio_settings *ofono_radio_settings_create(struct ofono_mode=
m *modem,
+								unsigned int vendor,
+								const char *driver,
+								void *data);
+
+void ofono_radio_settings_register(struct ofono_radio_settings *rs);
+void ofono_radio_settings_remove(struct ofono_radio_settings *rs);
+
+void ofono_radio_settings_set_data(struct ofono_radio_settings *rs, void *=
data);
+void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_RADIO_SETTINGS_H */
diff --git a/src/ofono.h b/src/ofono.h
index 379f413..ff67728 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -113,6 +113,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
 	OFONO_ATOM_TYPE_GPRS =3D 16,
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
+	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
 };
 =

 enum ofono_atom_watch_condition {
@@ -168,6 +169,7 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-settings.h>
 =

 #include <ofono/sim.h>
 =

diff --git a/src/radio-settings.c b/src/radio-settings.c
new file mode 100644
index 0000000..6e41194
--- /dev/null
+++ b/src/radio-settings.c
@@ -0,0 +1,372 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#include <stdio.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+
+#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
+#define RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
+
+#define RADIO_SETTINGS_MODE_CACHED 0x1
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_radio_settings {
+	DBusMessage *pending;
+	int flags;
+	int mode;
+	int pending_mode;
+	const struct ofono_radio_settings_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static const char *radio_access_mode_to_string(enum ofono_radio_access_mod=
e mode)
+{
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_DUAL:
+		return "dual";
+	case OFONO_RADIO_ACCESS_MODE_2G:
+		return "2g";
+	case OFONO_RADIO_ACCESS_MODE_3G:
+		return "3g";
+	default:
+		return "unknown";
+	}
+}
+
+static int string_to_radio_access_mode(const char *mode)
+
+{
+	if (g_strcmp0(mode, "dual") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_DUAL;
+	if (g_strcmp0(mode, "2g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_2G;
+	if (g_strcmp0(mode, "3g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_3G;
+	return -1;
+}
+
+static DBusMessage *radio_get_properties_reply(DBusMessage *msg,
+						struct ofono_radio_settings *rs)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	const char *mode =3D radio_access_mode_to_string(rs->mode);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "Mode", DBUS_TYPE_STRING, &mode);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void radio_set_mode(struct ofono_radio_settings *rs,
+				enum ofono_radio_access_mode mode)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *str_mode;
+
+	if (rs->mode =3D=3D (int)mode)
+		return;
+
+	rs->mode =3D mode;
+	rs->flags |=3D RADIO_SETTINGS_MODE_CACHED;
+
+	path =3D __ofono_atom_get_path(rs->atom);
+	str_mode =3D radio_access_mode_to_string(rs->mode);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						RADIO_SETTINGS_INTERFACE,
+						"Mode", DBUS_TYPE_STRING,
+						&str_mode);
+}
+
+static void radio_mode_set_callback(const struct ofono_error *error, void =
*data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Error setting radio access mode");
+		rs->pending_mode =3D rs->mode;
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(rs->pending);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+
+	radio_set_mode(rs, rs->pending_mode);
+}
+
+static void radio_mode_query_callback(const struct ofono_error *error,
+					enum ofono_radio_access_mode mode,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Error during radio access mode query");
+		reply =3D __ofono_error_failed(rs->pending);
+		__ofono_dbus_pending_reply(&rs->pending, reply);
+		return;
+	}
+
+	radio_set_mode(rs, mode);
+
+	reply =3D radio_get_properties_reply(rs->pending, rs);
+	__ofono_dbus_pending_reply(&rs->pending, reply);
+}
+
+static DBusMessage *radio_get_properties(DBusConnection *conn, DBusMessage=
 *msg,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+
+	if (rs->flags & RADIO_SETTINGS_MODE_CACHED)
+		return radio_get_properties_reply(msg, rs);
+
+	if (!rs->driver->query_mode)
+		return __ofono_error_not_implemented(msg);
+
+	if (rs->pending)
+		return __ofono_error_busy(msg);
+
+	rs->pending =3D dbus_message_ref(msg);
+	rs->driver->query_mode(rs, radio_mode_query_callback, rs);
+
+	return NULL;
+}
+
+static DBusMessage *radio_set_property(DBusConnection *conn, DBusMessage *=
msg,
+					void *data)
+{
+	struct ofono_radio_settings *rs =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (rs->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (g_strcmp0(property, "Mode") =3D=3D 0) {
+		const char *value;
+		int mode =3D -1;
+
+		if (!rs->driver->set_mode)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		mode =3D string_to_radio_access_mode(value);
+
+		if (mode =3D=3D -1)
+			return __ofono_error_invalid_args(msg);
+
+		if (rs->mode =3D=3D mode)
+			return dbus_message_new_method_return(msg);
+
+		rs->pending =3D dbus_message_ref(msg);
+		rs->pending_mode =3D mode;
+
+		rs->driver->set_mode(rs, mode, radio_mode_set_callback, rs);
+
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable radio_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	radio_get_properties,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",	"sv",	"",		radio_set_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable radio_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+int ofono_radio_settings_driver_register(const struct ofono_radio_settings=
_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (!d || !d->probe)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_radio_settings_driver_unregister(const struct ofono_radio_setti=
ngs_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (!d)
+		return;
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void radio_settings_unregister(struct ofono_atom *atom)
+{
+	struct ofono_radio_settings *rs =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(rs->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(rs->atom);
+
+	ofono_modem_remove_interface(modem, RADIO_SETTINGS_INTERFACE);
+	g_dbus_unregister_interface(conn, path, RADIO_SETTINGS_INTERFACE);
+}
+
+static void radio_settings_remove(struct ofono_atom *atom)
+{
+	struct ofono_radio_settings *rs =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (!rs)
+		return;
+
+	if (rs->driver && rs->driver->remove)
+		rs->driver->remove(rs);
+
+	g_free(rs);
+}
+
+struct ofono_radio_settings *ofono_radio_settings_create(struct ofono_mode=
m *modem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_radio_settings *rs;
+	GSList *l;
+
+	if (!driver)
+		return NULL;
+
+	rs =3D g_try_new0(struct ofono_radio_settings, 1);
+	if (!rs)
+		return NULL;
+
+	rs->mode =3D -1;
+
+	rs->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_RADIO_SETTINGS,
+						radio_settings_remove, rs);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_radio_settings_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver) !=3D 0)
+			continue;
+
+		if (drv->probe(rs, vendor, data) < 0)
+			continue;
+
+		rs->driver =3D drv;
+		break;
+	}
+
+	return rs;
+}
+
+void ofono_radio_settings_register(struct ofono_radio_settings *rs)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(rs->atom);
+	const char *path =3D __ofono_atom_get_path(rs->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					RADIO_SETTINGS_INTERFACE,
+					radio_methods, radio_signals,
+					NULL, rs, NULL)) {
+		ofono_error("Could not create %s interface",
+				RADIO_SETTINGS_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, RADIO_SETTINGS_INTERFACE);
+	__ofono_atom_register(rs->atom, radio_settings_unregister);
+}
+
+void ofono_radio_settings_remove(struct ofono_radio_settings *rs)
+{
+	__ofono_atom_free(rs->atom);
+}
+
+void ofono_radio_settings_set_data(struct ofono_radio_settings *rs,
+					void *data)
+{
+	rs->driver_data =3D data;
+}
+
+void *ofono_radio_settings_get_data(struct ofono_radio_settings *rs)
+{
+	return rs->driver_data;
+}
-- =

1.6.3.3


--===============4366856634456154101==--

