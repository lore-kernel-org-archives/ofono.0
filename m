Content-Type: multipart/mixed; boundary="===============6179051857354337378=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/3] Add radio access atom and driver API
Date: Wed, 03 Feb 2010 00:38:04 +0200
Message-ID: <1265150286-14548-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6179051857354337378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This atom provides access to the modem's radio access properties. It
currently includes a single rw property, namely the radio access
selection mode setting.

This allows the user to query and select the used radio access
technology preference. In dual mode, either 2G or 3G is used depending
on reception. 2G only mode or 3G only mode force selection of the
respective access only.

In the future, this atom could be extended, if necessary, to handle
other radio access related modem features such as CELL_DCH status,
UTRAN channel, or frequency band.
---
 Makefile.am            |    6 +-
 include/radio-access.h |   72 ++++++++++
 src/ofono.h            |    2 +
 src/radio-access.c     |  354 ++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 432 insertions(+), 2 deletions(-)
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

diff --git a/include/radio-access.h b/include/radio-access.h
new file mode 100644
index 0000000..6677573
--- /dev/null
+++ b/include/radio-access.h
@@ -0,0 +1,72 @@
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
+struct ofono_radio_access;
+
+typedef void (*ofono_radio_access_mode_set_cb_t)(const struct ofono_error =
*error,
+							void *data);
+typedef void (*ofono_radio_access_mode_query_cb_t)(const struct ofono_erro=
r *error,
+							int mode, void *data);
+
+struct ofono_radio_access_driver {
+	const char *name;
+	int (*probe)(struct ofono_radio_access *radio_access,
+			unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_radio_access *radio_access);
+	void (*query_mode)(struct ofono_radio_access *radio_access,
+				ofono_radio_access_mode_query_cb_t cb, void *data);
+	void (*set_mode)(struct ofono_radio_access *radio_access, int mode,
+				ofono_radio_access_mode_set_cb_t cb, void *data);
+};
+
+void ofono_radio_access_mode_notify(struct ofono_radio_access *radio_acces=
s,
+					int mode);
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
+void ofono_radio_access_register(struct ofono_radio_access *radio_access);
+void ofono_radio_access_remove(struct ofono_radio_access *radio_access);
+
+void ofono_radio_access_set_data(struct ofono_radio_access *radio_access,
+					void *data);
+void *ofono_radio_access_get_data(struct ofono_radio_access *radio_access);
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
index 0000000..ba34c71
--- /dev/null
+++ b/src/radio-access.c
@@ -0,0 +1,354 @@
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
+enum radio_access_mode {
+	RADIO_ACCESS_MODE_DUAL =3D 0,
+	RADIO_ACCESS_MODE_2G =3D 1,
+	RADIO_ACCESS_MODE_3G =3D 2
+};
+
+struct ofono_radio_access {
+	DBusMessage *pending;
+	int mode;
+	int pending_mode;
+	const struct ofono_radio_access_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static const char *radio_access_mode_to_string(int mode)
+{
+	switch (mode) {
+	case RADIO_ACCESS_MODE_DUAL:
+		return "2g+3g";
+
+	case RADIO_ACCESS_MODE_2G:
+		return "2g";
+
+	case RADIO_ACCESS_MODE_3G:
+		return "3g";
+
+	default:
+		return "unknown";
+	}
+}
+
+static int string_to_radio_access_mode(const char *mode)
+{
+	if (g_strcmp0(mode, "2g+3g") =3D=3D 0)
+		return RADIO_ACCESS_MODE_DUAL;
+
+	if (g_strcmp0(mode, "2g") =3D=3D 0)
+		return RADIO_ACCESS_MODE_2G;
+
+	if (g_strcmp0(mode, "3g") =3D=3D 0)
+		return RADIO_ACCESS_MODE_3G;
+
+	return -1;
+}
+
+static void ra_mode_query_callback(const struct ofono_error *error, int mo=
de,
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
+		int mode =3D -1;
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
+	{ "GetProperties",	"",	"a{sv}",	ra_get_properties,
+							G_DBUS_METHOD_FLAG_ASYNC },
+
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
+void ofono_radio_access_mode_notify(struct ofono_radio_access *ra, int mod=
e)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (ra->mode =3D=3D mode)
+		return;
+
+	ra->mode =3D mode;
+
+	if (mode !=3D -1) {
+		const char *path =3D __ofono_atom_get_path(ra->atom);
+		const char *str_mode =3D radio_access_mode_to_string(mode);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						RADIO_ACCESS_INTERFACE,
+						"Mode", DBUS_TYPE_STRING,
+						&str_mode);
+	}
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


--===============6179051857354337378==--

