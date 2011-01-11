Content-Type: multipart/mixed; boundary="===============7201373903805806599=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 4/9] gps: implement interface/atom
Date: Tue, 11 Jan 2011 00:23:53 -0300
Message-ID: <1294716238-21218-5-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7201373903805806599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 src/gps.c   |  389 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |    2 +
 3 files changed, 392 insertions(+), 1 deletions(-)
 create mode 100644 src/gps.c

diff --git a/Makefile.am b/Makefile.am
index 70e65f0..d5029d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -334,7 +334,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/gps.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gps.c b/src/gps.c
new file mode 100644
index 0000000..fde2703
--- /dev/null
+++ b/src/gps.c
@@ -0,0 +1,389 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ProFUSION embedded systems.
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
+static GSList *g_drivers =3D NULL;
+
+struct gps_settings {
+	enum ofono_gps_device_type type;
+	char *device;
+};
+
+struct ofono_gps {
+	DBusMessage *pending;
+	ofono_bool_t powered;
+	const struct ofono_gps_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	struct gps_settings settings;
+};
+
+static const char *gps_settings_type_to_string(enum ofono_gps_device_type =
type)
+{
+	switch (type) {
+	case OFONO_GPS_DEVICE_TYPE_NMEA:
+		return "nmea";
+	};
+
+	return NULL;
+}
+
+static char **gps_get_settings(struct gps_settings *settings)
+{
+	const char *typec =3D "Type";
+	const char *devicec =3D "Device";
+	char **ret;
+
+	ret =3D g_new0(char *, 5);
+
+	ret[0] =3D g_strdup(typec);
+	ret[1] =3D g_strdup(gps_settings_type_to_string(settings->type));
+
+	ret[2] =3D g_strdup(devicec);
+	ret[3] =3D g_strdup(settings->device);
+
+	return ret;
+}
+
+static DBusMessage *gps_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+	void **settings_properties;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	value =3D gps->powered;
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+
+	settings_properties =3D (void *)gps_get_settings(&gps->settings);
+	ofono_dbus_dict_append_dict(&dict, "Settings", DBUS_TYPE_STRING,
+							 &settings_properties);
+	g_free(settings_properties);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void gps_signal_powered(struct ofono_gps *gps)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(gps->atom);
+	ofono_bool_t value =3D gps->powered;
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_LOCATION_REPORTING_INTERFACE,
+					"Powered",
+					DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void gps_signal_settings(struct ofono_gps *gps)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(gps->atom);
+	void **settings_properties;
+
+	settings_properties =3D (void *)gps_get_settings(&gps->settings);
+	ofono_dbus_signal_dict_property_changed(conn, path,
+					OFONO_LOCATION_REPORTING_INTERFACE,
+					"Settings", DBUS_TYPE_STRING,
+					&settings_properties);
+	g_free(settings_properties);
+}
+
+static void gps_update_settings(struct ofono_gps *gps,
+						enum ofono_gps_device_type type,
+						const char *dev)
+{
+	gps->settings.type =3D type;
+	gps->settings.device =3D g_strdup(dev);
+
+	gps_signal_settings(gps);
+}
+
+static void gps_enable_callback(const struct ofono_error *error,
+					enum ofono_gps_device_type type,
+					const char *device,
+					void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Powering ON gps failed");
+
+		reply =3D __ofono_error_failed(gps->pending);
+		__ofono_dbus_pending_reply(&gps->pending, reply);
+
+		return;
+	}
+
+	gps->powered =3D TRUE;
+
+	reply =3D dbus_message_new_method_return(gps->pending);
+	__ofono_dbus_pending_reply(&gps->pending, reply);
+
+	gps_update_settings(gps, type, device);
+	gps_signal_powered(gps);
+}
+
+static void gps_disable_callback(const struct ofono_error *error,
+						void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Powering OFF gps failed");
+
+		reply =3D __ofono_error_failed(gps->pending);
+		__ofono_dbus_pending_reply(&gps->pending, reply);
+
+		return;
+	}
+
+	gps->powered =3D FALSE;
+
+	reply =3D dbus_message_new_method_return(gps->pending);
+	__ofono_dbus_pending_reply(&gps->pending, reply);
+
+	if (gps->settings.device !=3D NULL) {
+		g_free(gps->settings.device);
+		gps->settings.device =3D NULL;
+	}
+
+	gps_signal_powered(gps);
+}
+
+static DBusMessage *gps_set_property(DBusConnection *conn, DBusMessage *ms=
g,
+					void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (gps->pending)
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
+	if (g_strcmp0(property, "Powered") =3D=3D 0) {
+		dbus_bool_t value;
+		int target;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+		target =3D value;
+
+		if (gps->powered =3D=3D target)
+			return dbus_message_new_method_return(msg);
+
+		gps->pending =3D dbus_message_ref(msg);
+
+		if (value =3D=3D TRUE)
+			gps->driver->enable(gps, gps_enable_callback, gps);
+		else
+			gps->driver->disable(gps, gps_disable_callback, gps);
+
+		return NULL;
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable gps_methods[] =3D {
+	{ "GetProperties",  "",    "a{sv}",  gps_get_properties,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",    "sv",  "",       gps_set_property,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable gps_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+int ofono_gps_driver_register(const struct ofono_gps_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d =3D=3D NULL || d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_gps_driver_unregister(const struct ofono_gps_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d =3D=3D NULL)
+		return;
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+struct ofono_modem *ofono_gps_get_modem(struct ofono_gps *g)
+{
+	return __ofono_atom_get_modem(g->atom);
+}
+
+static void gps_unregister(struct ofono_atom *atom)
+{
+	struct ofono_gps *gps =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(gps->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gps->atom);
+
+	ofono_modem_remove_interface(modem, OFONO_LOCATION_REPORTING_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					OFONO_LOCATION_REPORTING_INTERFACE);
+}
+
+static void gps_remove(struct ofono_atom *atom)
+{
+	struct ofono_gps *gps =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (gps =3D=3D NULL)
+		return;
+
+	if (gps->driver && gps->driver->remove)
+		gps->driver->remove(gps);
+
+	g_free(gps);
+}
+
+struct ofono_gps *ofono_gps_create(struct ofono_modem *modem,
+					 unsigned int vendor,
+					 const char *driver, void *data)
+{
+	struct ofono_gps *gps;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	gps =3D g_try_new0(struct ofono_gps, 1);
+	if (gps =3D=3D NULL)
+		return NULL;
+
+	gps->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_GPS,
+						gps_remove, gps);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_gps_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver) !=3D 0)
+			continue;
+
+		if (drv->probe(gps, vendor, data) < 0)
+			continue;
+
+		gps->driver =3D drv;
+		break;
+	}
+
+	return gps;
+}
+
+void ofono_gps_register(struct ofono_gps *gps)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gps->atom);
+	const char *path =3D __ofono_atom_get_path(gps->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_LOCATION_REPORTING_INTERFACE,
+					gps_methods, gps_signals, NULL, gps,
+					NULL)) {
+		ofono_error("Could not create %s interface",
+					OFONO_LOCATION_REPORTING_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_LOCATION_REPORTING_INTERFACE);
+	__ofono_atom_register(gps->atom, gps_unregister);
+}
+
+void ofono_gps_remove(struct ofono_gps *gps)
+{
+	__ofono_atom_free(gps->atom);
+}
+
+void ofono_gps_set_data(struct ofono_gps *gps,
+					void *data)
+{
+	gps->driver_data =3D data;
+}
+
+void *ofono_gps_get_data(struct ofono_gps *gps)
+{
+	return gps->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..e60140f 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_GPS =3D 24,
 };
 =

 enum ofono_atom_watch_condition {
@@ -208,6 +209,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
l_settings *cs);
 #include <ofono/radio-settings.h>
 #include <ofono/audio-settings.h>
 #include <ofono/ctm.h>
+#include <ofono/gps.h>
 =

 #include <ofono/voicecall.h>
 =

-- =

1.7.2.3


--===============7201373903805806599==--

