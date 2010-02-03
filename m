Content-Type: multipart/mixed; boundary="===============4170665380314530138=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/3] Add radio access atom and driver API
Date: Wed, 03 Feb 2010 17:32:19 +0200
Message-ID: <1265211141-21294-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1265211141-21294-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4170665380314530138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This atom provides access to the modem's radio access properties. It
currently includes an rw property for radio access selection mode, and
a readonly property for radio access link state.

This interface allows the user to query and select the preferred radio
access mode. In dual mode, either 2G or 3G is used depending on
reception. 2G only mode or 3G only mode force selection to the
respective access only.

The status property allows applications to time their non-urgent
network access to when the radio access link is already active. This
is an important enabler for saving battery.
---
 Makefile.am              |    6 +-
 doc/radio-access-api.txt |   58 +++++++
 include/radio-access.h   |   85 ++++++++++
 src/ofono.h              |    2 +
 src/radio-access.c       |  384 ++++++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 533 insertions(+), 2 deletions(-)
 create mode 100644 doc/radio-access-api.txt
 create mode 100644 include/radio-access.h
 create mode 100644 src/radio-access.c

diff --git a/Makefile.am b/Makefile.am
index 33339df..a18e4b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -11,7 +11,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/sms.h include/sim.h include/message-waiting.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
-			include/gprs.h include/gprs-context.h
+			include/gprs.h include/gprs-context.h \
+			include/radio-access.h
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
+			src/radio-access.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

diff --git a/doc/radio-access-api.txt b/doc/radio-access-api.txt
new file mode 100644
index 0000000..018c5e7
--- /dev/null
+++ b/doc/radio-access-api.txt
@@ -0,0 +1,58 @@
+Radio Access hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.RadioAccess
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
+				"2g+3g"    Radio access selection is done
+					   automatically, with internal
+					   preference given to GSM.
+				"3g+2g"    Radio access selection is done
+					   automatically, with internal
+					   preference given to UTRAN.
+				"2g"       Radio access selection is
+					   limited to GSM only.
+				"3g"       Radio access selection is
+					   limited to UTRAN only.
+
+		string State [readonly]
+
+			The current radio access link state.
+
+			The possible values are:
+				"active"   Radio access link is currently
+					   active, e.g., in CELL_DCH state.
+				"idle"     Radio access link is currently
+					   idle.
+				"unknown"  Radio access link state is
+					   currently unavailable.
diff --git a/include/radio-access.h b/include/radio-access.h
new file mode 100644
index 0000000..9afab3d
--- /dev/null
+++ b/include/radio-access.h
@@ -0,0 +1,85 @@
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
+#ifndef __OFONO_RADIO_ACCESS_H
+#define __OFONO_RADIO_ACCESS_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+enum ofono_radio_access_mode {
+	OFONO_RADIO_ACCESS_MODE_2G_3G =3D 0,
+	OFONO_RADIO_ACCESS_MODE_3G_2G =3D 1,
+	OFONO_RADIO_ACCESS_MODE_2G =3D 2,
+	OFONO_RADIO_ACCESS_MODE_3G =3D 3,
+};
+
+enum ofono_radio_access_state {
+	OFONO_RADIO_ACCESS_STATE_IDLE =3D 0,
+	OFONO_RADIO_ACCESS_STATE_ACTIVE =3D 1,
+};
+
+struct ofono_radio_access;
+
+typedef void (*ofono_radio_access_mode_set_cb_t)(const struct ofono_error =
*error,
+							void *data);
+typedef void (*ofono_radio_access_mode_query_cb_t)(const struct ofono_erro=
r *error,
+						enum ofono_radio_access_mode mode,
+						void *data);
+
+struct ofono_radio_access_driver {
+	const char *name;
+	int (*probe)(struct ofono_radio_access *ra, unsigned int vendor, void *da=
ta);
+	void (*remove)(struct ofono_radio_access *ra);
+	void (*query_mode)(struct ofono_radio_access *ra,
+				ofono_radio_access_mode_query_cb_t cb, void *data);
+	void (*set_mode)(struct ofono_radio_access *ra,
+				enum ofono_radio_access_mode mode,
+				ofono_radio_access_mode_set_cb_t cb, void *data);
+};
+
+void ofono_radio_access_mode_notify(struct ofono_radio_access *ra,
+					enum ofono_radio_access_mode mode);
+void ofono_radio_access_state_notify(struct ofono_radio_access *ra,
+					enum ofono_radio_access_state state);
+
+int ofono_radio_access_driver_register(const struct ofono_radio_access_dri=
ver *d);
+void ofono_radio_access_driver_unregister(const struct ofono_radio_access_=
driver *d);
+
+struct ofono_radio_access *ofono_radio_access_create(struct ofono_modem *m=
odem,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_radio_access_register(struct ofono_radio_access *ra);
+void ofono_radio_access_remove(struct ofono_radio_access *ra);
+
+void ofono_radio_access_set_data(struct ofono_radio_access *ra,	void *data=
);
+void *ofono_radio_access_get_data(struct ofono_radio_access *ra);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_RADIO_ACCESS_H */
diff --git a/src/ofono.h b/src/ofono.h
index 379f413..c519eef 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -113,6 +113,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPES_CALL_VOLUME =3D 15,
 	OFONO_ATOM_TYPE_GPRS =3D 16,
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
+	OFONO_ATOM_TYPE_RADIO_ACCESS =3D 18,
 };
 =

 enum ofono_atom_watch_condition {
@@ -168,6 +169,7 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/radio-access.h>
 =

 #include <ofono/sim.h>
 =

diff --git a/src/radio-access.c b/src/radio-access.c
new file mode 100644
index 0000000..80d9cb7
--- /dev/null
+++ b/src/radio-access.c
@@ -0,0 +1,384 @@
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
+#define RADIO_ACCESS_INTERFACE "org.ofono.RadioAccess"
+#define RADIO_ACCESS_INTERFACE "org.ofono.RadioAccess"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_radio_access {
+	DBusMessage *pending;
+	enum ofono_radio_access_mode mode;
+	enum ofono_radio_access_mode pending_mode;
+	enum ofono_radio_access_state state;
+	const struct ofono_radio_access_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static const char *radio_access_mode_to_string(enum ofono_radio_access_mod=
e mode)
+{
+	switch (mode) {
+	case OFONO_RADIO_ACCESS_MODE_2G_3G:
+		return "2g+3g";
+	case OFONO_RADIO_ACCESS_MODE_3G_2G:
+		return "3g+2g";
+	case OFONO_RADIO_ACCESS_MODE_2G:
+		return "2g";
+	case OFONO_RADIO_ACCESS_MODE_3G:
+		return "3g";
+	default:
+		return "unknown";
+	}
+}
+
+static const char *radio_access_state_to_string(enum ofono_radio_access_st=
ate state)
+{
+	switch (state) {
+	case OFONO_RADIO_ACCESS_STATE_ACTIVE:
+		return "active";
+	case OFONO_RADIO_ACCESS_STATE_IDLE:
+		return "idle";
+	default:
+		return "unknown";
+	}
+}
+
+static enum ofono_radio_access_mode string_to_radio_access_mode(const char=
 *mode)
+
+{
+	if (g_strcmp0(mode, "2g+3g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_2G_3G;
+	if (g_strcmp0(mode, "3g+2g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_3G_2G;
+	if (g_strcmp0(mode, "2g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_2G;
+	if (g_strcmp0(mode, "3g") =3D=3D 0)
+		return OFONO_RADIO_ACCESS_MODE_3G;
+	return -1;
+}
+
+static void ra_mode_query_callback(const struct ofono_error *error,
+					enum ofono_radio_access_mode mode,
+					void *data)
+{
+	struct ofono_radio_access *ra =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Error during radio access mode query");
+		return;
+	}
+
+	ofono_radio_access_mode_notify(ra, mode);
+}
+
+static void ra_mode_set_callback(const struct ofono_error *error, void *da=
ta)
+{
+	struct ofono_radio_access *ra =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_debug("Error setting radio access mode");
+		ra->pending_mode =3D ra->mode;
+		reply =3D __ofono_error_failed(ra->pending);
+		__ofono_dbus_pending_reply(&ra->pending, reply);
+		return;
+	}
+
+	reply =3D dbus_message_new_method_return(ra->pending);
+	__ofono_dbus_pending_reply(&ra->pending, reply);
+
+	ofono_radio_access_mode_notify(ra, ra->pending_mode);
+}
+
+static DBusMessage *ra_get_properties(DBusConnection *conn, DBusMessage *m=
sg,
+					void *data)
+{
+	struct ofono_radio_access *ra =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	const char *mode =3D radio_access_mode_to_string(ra->mode);
+	const char *state =3D radio_access_state_to_string(ra->state);
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
+	ofono_dbus_dict_append(&dict, "State", DBUS_TYPE_STRING, &state);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *ra_set_property(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct ofono_radio_access *ra =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (ra->pending)
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
+		enum ofono_radio_access_mode mode =3D -1;
+
+		if (!ra->driver->set_mode)
+			return __ofono_error_not_implemented(msg);
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		mode =3D string_to_radio_access_mode(value);
+
+		if (ra->mode =3D=3D mode)
+			return dbus_message_new_method_return(msg);
+
+		ra->pending =3D dbus_message_ref(msg);
+		ra->pending_mode =3D mode;
+
+		ra->driver->set_mode(ra, mode, ra_mode_set_callback, ra);
+
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable ra_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	ra_get_properties },
+	{ "SetProperty",	"sv",	"",		ra_set_property,
+							G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable ra_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+void ofono_radio_access_mode_notify(struct ofono_radio_access *ra,
+					 enum ofono_radio_access_mode mode)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *str_mode;
+
+	if (ra->mode =3D=3D mode)
+		return;
+
+	ra->mode =3D mode;
+
+	path =3D __ofono_atom_get_path(ra->atom);
+	str_mode =3D radio_access_mode_to_string(mode);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						RADIO_ACCESS_INTERFACE,
+						"Mode", DBUS_TYPE_STRING,
+						&str_mode);
+}
+
+void ofono_radio_access_state_notify(struct ofono_radio_access *ra,
+					enum ofono_radio_access_state state)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *str_state;
+
+	if (ra->state =3D=3D state)
+		return;
+
+	ra->state =3D state;
+
+	path =3D __ofono_atom_get_path(ra->atom);
+	str_state =3D radio_access_state_to_string(state);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						RADIO_ACCESS_INTERFACE,
+						"State", DBUS_TYPE_STRING,
+						&str_state);
+}
+
+int ofono_radio_access_driver_register(const struct ofono_radio_access_dri=
ver *d)
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
+void ofono_radio_access_driver_unregister(const struct ofono_radio_access_=
driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (!d)
+		return;
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void radio_access_unregister(struct ofono_atom *atom)
+{
+	struct ofono_radio_access *ra =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(ra->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ra->atom);
+
+	ofono_modem_remove_interface(modem, RADIO_ACCESS_INTERFACE);
+	g_dbus_unregister_interface(conn, path, RADIO_ACCESS_INTERFACE);
+}
+
+static void radio_access_remove(struct ofono_atom *atom)
+{
+	struct ofono_radio_access *ra =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (!ra)
+		return;
+
+	if (ra->driver && ra->driver->remove)
+		ra->driver->remove(ra);
+
+	g_free(ra);
+}
+
+struct ofono_radio_access *ofono_radio_access_create(struct ofono_modem *m=
odem,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_radio_access *ra;
+	GSList *l;
+
+	if (!driver)
+		return NULL;
+
+	ra =3D g_try_new0(struct ofono_radio_access, 1);
+	if (!ra)
+		return NULL;
+
+	ra->mode =3D -1;
+	ra->state =3D -1;
+
+	ra->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_RADIO_ACCESS,
+						radio_access_remove, ra);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_radio_access_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver) !=3D 0)
+			continue;
+
+		if (drv->probe(ra, vendor, data) < 0)
+			continue;
+
+		ra->driver =3D drv;
+		break;
+	}
+
+	return ra;
+}
+
+void ofono_radio_access_register(struct ofono_radio_access *ra)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(ra->atom);
+	const char *path =3D __ofono_atom_get_path(ra->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					RADIO_ACCESS_INTERFACE,
+					ra_methods, ra_signals, NULL, ra,
+					NULL)) {
+		ofono_error("Could not create %s interface",
+				RADIO_ACCESS_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, RADIO_ACCESS_INTERFACE);
+
+	if (ra->driver->query_mode)
+		ra->driver->query_mode(ra, ra_mode_query_callback, ra);
+
+	__ofono_atom_register(ra->atom, radio_access_unregister);
+}
+
+void ofono_radio_access_remove(struct ofono_radio_access *ra)
+{
+	__ofono_atom_free(ra->atom);
+}
+
+void ofono_radio_access_set_data(struct ofono_radio_access *ra,
+					void *data)
+{
+	ra->driver_data =3D data;
+}
+
+void *ofono_radio_access_get_data(struct ofono_radio_access *ra)
+{
+	return ra->driver_data;
+}
-- =

1.6.3.3


--===============4170665380314530138==--

