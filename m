Content-Type: multipart/mixed; boundary="===============5637193630697963457=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 4/8] gps: implement interface/atom
Date: Thu, 16 Dec 2010 17:30:19 -0300
Message-ID: <1292531423-22316-5-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5637193630697963457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    2 +-
 src/gps.c   |  333 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h |    2 +
 3 files changed, 336 insertions(+), 1 deletions(-)
 create mode 100644 src/gps.c

diff --git a/Makefile.am b/Makefile.am
index 370f63e..45f1ba3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c
+			src/smsagent.c src/smsagent.h src/ctm.c src/gps.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gps.c b/src/gps.c
new file mode 100644
index 0000000..09c448e
--- /dev/null
+++ b/src/gps.c
@@ -0,0 +1,333 @@
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
+#define GPS_FLAG_CACHED 0x1
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_gps {
+	DBusMessage *pending;
+	int flags;
+	ofono_bool_t powered;
+	const struct ofono_gps_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *gps_get_properties_reply(DBusMessage *msg,
+						struct ofono_gps *gps)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
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
+						OFONO_GPS_INTERFACE,
+						"Powered",
+						DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void gps_set_powered_callback(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Error setting gps powered property");
+
+		reply =3D __ofono_error_failed(gps->pending);
+		__ofono_dbus_pending_reply(&gps->pending, reply);
+
+		return;
+	}
+
+	gps->powered =3D !gps->powered;
+
+	reply =3D dbus_message_new_method_return(gps->pending);
+	__ofono_dbus_pending_reply(&gps->pending, reply);
+
+	gps_signal_powered(gps);
+}
+
+
+static void gps_query_powered_callback(const struct ofono_error *error,
+					ofono_bool_t powered, void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+	ofono_bool_t powered_old;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Error during gps power query");
+
+		reply =3D __ofono_error_failed(gps->pending);
+		__ofono_dbus_pending_reply(&gps->pending, reply);
+
+		return;
+	}
+
+	gps->flags |=3D GPS_FLAG_CACHED;
+
+	powered_old =3D gps->powered;
+	gps->powered =3D powered;
+
+	reply =3D gps_get_properties_reply(gps->pending, gps);
+	__ofono_dbus_pending_reply(&gps->pending, reply);
+
+	if (gps->powered !=3D powered_old)
+		gps_signal_powered(gps);
+
+}
+
+static DBusMessage *gps_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_gps *gps =3D data;
+
+	if (gps->flags & GPS_FLAG_CACHED)
+		return gps_get_properties_reply(msg, gps);
+
+	if (gps->pending)
+		return __ofono_error_busy(msg);
+
+	gps->pending =3D dbus_message_ref(msg);
+
+	gps->driver->query_gps(gps, gps_query_powered_callback, gps);
+
+	return NULL;
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
+		gps->driver->set_gps(gps, target, gps_set_powered_callback,
+					gps);
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
+static void gps_unregister(struct ofono_atom *atom)
+{
+	struct ofono_gps *gps =3D __ofono_atom_get_data(atom);
+	const char *path =3D __ofono_atom_get_path(gps->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(gps->atom);
+
+	ofono_modem_remove_interface(modem, OFONO_GPS_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_GPS_INTERFACE);
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
+	if (!g_dbus_register_interface(conn, path, OFONO_GPS_INTERFACE,
+					gps_methods, gps_signals, NULL, gps,
+					NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_GPS_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_GPS_INTERFACE);
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
index 792134b..aa62368 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -126,6 +126,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_STK =3D 20,
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
+	OFONO_ATOM_TYPE_GPS =3D 23,
 };
 =

 enum ofono_atom_watch_condition {
@@ -207,6 +208,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
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


--===============5637193630697963457==--

