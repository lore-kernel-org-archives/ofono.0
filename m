Content-Type: multipart/mixed; boundary="===============1419350783757647526=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v3 2/7] gps: add gps atom and gpsagent implementations
Date: Wed, 26 Jan 2011 12:32:49 -0300
Message-ID: <1296055974-9640-3-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1296055974-9640-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1419350783757647526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    3 +-
 src/gps.c      |  326 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/gpsagent.c |  145 +++++++++++++++++++++++++
 src/gpsagent.h |   37 +++++++
 src/ofono.conf |    1 +
 src/ofono.h    |    2 +
 6 files changed, 513 insertions(+), 1 deletions(-)
 create mode 100644 src/gps.c
 create mode 100644 src/gpsagent.c
 create mode 100644 src/gpsagent.h

diff --git a/Makefile.am b/Makefile.am
index 7374f70..de70976 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -355,7 +355,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c
+			src/message.h src/message.c src/gps.c \
+			src/gpsagent.c src/gpsagent.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/gps.c b/src/gps.c
new file mode 100644
index 0000000..b5916ee
--- /dev/null
+++ b/src/gps.c
@@ -0,0 +1,326 @@
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
+#include "gpsagent.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_gps {
+	DBusMessage *pending;
+	const struct ofono_gps_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+	int fd;
+	struct gps_agent *agent;
+};
+
+static const char *gps_device_type_to_string(enum ofono_gps_device_type ty=
pe)
+{
+	switch (type) {
+	case OFONO_GPS_DEVICE_TYPE_NMEA:
+		return "nmea";
+	};
+
+	return NULL;
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
+	const char *type;
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
+	type =3D gps_device_type_to_string(gps->driver->type);
+	ofono_dbus_dict_append(&dict, "Type", DBUS_TYPE_STRING, &type);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static void gps_enable_callback(const struct ofono_error *error,
+					int fd,
+					void *data)
+{
+	struct ofono_gps *gps =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Powering ON gps failed");
+
+		gps_agent_free(gps->agent);
+
+		reply =3D __ofono_error_failed(gps->pending);
+		__ofono_dbus_pending_reply(&gps->pending, reply);
+
+		return;
+	}
+
+	gps->fd =3D fd;
+	gps_agent_send_noreply(gps->agent, "ReceiveGpsFileDescriptor", fd);
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
+	gps->fd =3D -1;
+}
+
+static void agent_exited(gpointer user_data)
+{
+	struct ofono_gps *gps =3D user_data;
+
+	gps->agent =3D NULL;
+
+	gps->driver->disable(gps, gps_disable_callback, gps);
+}
+
+static DBusMessage *gps_register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_gps *gps =3D data;
+	const char *agent_path;
+
+	if (gps->agent)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	gps->agent =3D gps_agent_new(dbus_message_get_sender(msg), agent_path);
+	if (gps->agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	gps_agent_set_removed_notify(gps->agent, agent_exited, gps);
+
+	gps->driver->enable(gps, gps_enable_callback, gps);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *gps_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_gps *gps =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (gps->agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (gps_agent_matches(gps->agent, agent_bus, agent_path) =3D=3D FALSE)
+		return __ofono_error_failed(msg);
+
+	gps_agent_free(gps->agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable gps_methods[] =3D {
+	{ "GetProperties",  "",    "a{sv}",  gps_get_properties,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterAgent",		"o",	"",	gps_register_agent },
+	{ "UnregisterAgent",		"o",	"",	gps_unregister_agent },
+
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
+void ofono_gps_set_data(struct ofono_gps *gps, void *data)
+{
+	gps->driver_data =3D data;
+}
+
+int ofono_gps_get_fd(struct ofono_gps *gps)
+{
+	return gps->fd;
+}
+
+void *ofono_gps_get_data(struct ofono_gps *gps)
+{
+	return gps->driver_data;
+}
diff --git a/src/gpsagent.c b/src/gpsagent.c
new file mode 100644
index 0000000..bc7d44f
--- /dev/null
+++ b/src/gpsagent.c
@@ -0,0 +1,145 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include <ofono/dbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "gpsagent.h"
+
+#define AGENT_INTERFACE "org.ofono.LocationReportingAgent"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+struct gps_agent {
+	char *path;
+	char *service;
+	guint disconnect_watch;
+	ofono_destroy_func removed_cb;
+	void *removed_data;
+};
+
+void gps_agent_send_noreply(struct gps_agent *agent, const char *method, i=
nt fd)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->service, agent->path,
+						AGENT_INTERFACE, method);
+	if (message =3D=3D NULL)
+		return;
+
+	if (fd !=3D -1)
+		dbus_message_append_args(message, DBUS_TYPE_UNIX_FD, &fd,
+							DBUS_TYPE_INVALID);
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+static inline void gps_agent_send_release(struct gps_agent *agent)
+{
+	gps_agent_send_noreply(agent, "Release", -1);
+}
+
+static void gps_agent_disconnect_cb(DBusConnection *conn, void *data)
+{
+	struct gps_agent *agent =3D data;
+
+	agent->disconnect_watch =3D 0;
+
+	gps_agent_free(agent);
+}
+
+struct gps_agent *gps_agent_new(const char *service, const char *path)
+{
+	struct gps_agent *agent =3D g_try_new0(struct gps_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent =3D=3D NULL)
+		return NULL;
+
+	agent->service =3D g_strdup(service);
+	agent->path =3D g_strdup(path);
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, service,
+							gps_agent_disconnect_cb,
+							agent, NULL);
+
+	return agent;
+}
+
+void gps_agent_set_removed_notify(struct gps_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data)
+{
+	agent->removed_cb =3D destroy;
+	agent->removed_data =3D user_data;
+}
+
+void gps_agent_free(struct gps_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent =3D=3D NULL)
+		return;
+
+	if (agent->disconnect_watch) {
+		gps_agent_send_release(agent);
+
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	if (agent->removed_cb)
+		agent->removed_cb(agent->removed_data);
+
+	g_free(agent->path);
+	g_free(agent->service);
+	g_free(agent);
+}
+
+ofono_bool_t gps_agent_matches(struct gps_agent *agent, const char *servic=
e,
+				const char *path)
+{
+	if (path =3D=3D NULL || service =3D=3D NULL)
+		return FALSE;
+
+	return g_str_equal(agent->path, path) &&
+			g_str_equal(agent->service, service);
+}
diff --git a/src/gpsagent.h b/src/gpsagent.h
new file mode 100644
index 0000000..0ff5bf4
--- /dev/null
+++ b/src/gpsagent.h
@@ -0,0 +1,37 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+struct gps_agent;
+
+struct gps_agent *gps_agent_new(const char *service, const char *path);
+
+void gps_agent_set_removed_notify(struct gps_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data);
+
+ofono_bool_t gps_agent_matches(struct gps_agent *agent, const char *servic=
e,
+				const char *path);
+
+void gps_agent_free(struct gps_agent *agent);
+
+void gps_agent_send_noreply(struct gps_agent *agent,
+				 const char *method, int fd);
diff --git a/src/ofono.conf b/src/ofono.conf
index 0dfa038..b06ea63 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -13,6 +13,7 @@
     <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
     <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
+    <allow send_interface=3D"org.ofono.LocationReportingAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
diff --git a/src/ofono.h b/src/ofono.h
index e48dbf6..7c34062 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -128,6 +128,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CTM,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
 	OFONO_ATOM_TYPE_SIM_AUTH,
+	OFONO_ATOM_TYPE_GPS,
 };
 =

 enum ofono_atom_watch_condition {
@@ -209,6 +210,7 @@ gboolean __ofono_call_settings_is_busy(struct ofono_cal=
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


--===============1419350783757647526==--

