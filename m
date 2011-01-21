Content-Type: multipart/mixed; boundary="===============4283350961629351846=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 3/7] src: add CDMA Connection Manager support
Date: Fri, 21 Jan 2011 15:06:46 -0800
Message-ID: <1295651210-22922-4-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4283350961629351846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 Makefile.am        |    3 +-
 src/cdma-connman.c |  571 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |    2 +
 3 files changed, 575 insertions(+), 1 deletions(-)
 create mode 100644 src/cdma-connman.c

diff --git a/Makefile.am b/Makefile.am
index c4f5983..dc50a83 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -356,7 +356,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c
+			src/message.h src/message.c \
+			src/cdma-connman.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
new file mode 100644
index 0000000..ca8499d
--- /dev/null
+++ b/src/cdma-connman.c
@@ -0,0 +1,571 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011 Nokia Corporation. All rights reserved.
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
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <net/if.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+
+static GSList *g_drivers;
+
+struct cdma_connman_settings {
+	char *interface;
+	gboolean static_ip;
+	char *ip;
+	char *netmask;
+	char *gateway;
+	char **dns;
+};
+
+struct ofono_cdma_connman {
+	ofono_bool_t powered;
+	ofono_bool_t dormant;
+	struct cdma_connman_settings *settings;
+	DBusMessage *pending;
+	const struct ofono_cdma_connman_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static void cdma_connman_settings_free(struct cdma_connman_settings *setti=
ngs)
+{
+	DBG("");
+
+	g_free(settings->interface);
+	g_free(settings->ip);
+	g_free(settings->netmask);
+	g_free(settings->gateway);
+	g_strfreev(settings->dns);
+
+	g_free(settings);
+}
+
+static void cdma_connman_ifupdown(const char *interface, ofono_bool_t acti=
ve)
+{
+	struct ifreq ifr;
+	int sk;
+
+	DBG("");
+
+	if (interface =3D=3D NULL)
+		return;
+
+	sk =3D socket(PF_INET, SOCK_DGRAM, 0);
+	if (sk < 0)
+		return;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, interface, IFNAMSIZ);
+
+	if (ioctl(sk, SIOCGIFFLAGS, &ifr) < 0)
+		goto done;
+
+	if (active =3D=3D TRUE) {
+		if (ifr.ifr_flags & IFF_UP)
+			goto done;
+		ifr.ifr_flags |=3D IFF_UP;
+	} else {
+		if (!(ifr.ifr_flags & IFF_UP))
+			goto done;
+		ifr.ifr_flags &=3D ~IFF_UP;
+	}
+
+	if (ioctl(sk, SIOCSIFFLAGS, &ifr) < 0)
+		ofono_error("Failed to change interface flags");
+
+done:
+	close(sk);
+}
+
+static void cdma_connman_settings_append_variant(
+					struct cdma_connman_settings *settings,
+					DBusMessageIter *iter)
+{
+	DBusMessageIter variant;
+	DBusMessageIter array;
+	char typesig[5];
+	char arraysig[6];
+	const char *method;
+
+	DBG("");
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
+	if (settings =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&array, "Interface",
+				DBUS_TYPE_STRING, &settings->interface);
+
+	if (settings->static_ip =3D=3D TRUE)
+		method =3D "static";
+	else
+		method =3D "dhcp";
+
+	ofono_dbus_dict_append(&array, "Method", DBUS_TYPE_STRING, &method);
+
+	if (settings->ip)
+		ofono_dbus_dict_append(&array, "Address", DBUS_TYPE_STRING,
+					&settings->ip);
+
+	if (settings->netmask)
+		ofono_dbus_dict_append(&array, "Netmask", DBUS_TYPE_STRING,
+					&settings->netmask);
+
+	if (settings->gateway)
+		ofono_dbus_dict_append(&array, "Gateway", DBUS_TYPE_STRING,
+					&settings->gateway);
+
+	if (settings->dns)
+		ofono_dbus_dict_append_array(&array, "DomainNameServers",
+						DBUS_TYPE_STRING,
+						&settings->dns);
+
+done:
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void cdma_connman_settings_signal(struct ofono_cdma_connman *cm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *prop =3D "Settings";
+
+	DBG("");
+
+	path =3D __ofono_atom_get_path(cm->atom);
+
+	signal =3D dbus_message_new_signal(path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"PropertyChanged");
+	if (signal =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &prop);
+
+	cdma_connman_settings_append_variant(cm->settings, &iter);
+
+	g_dbus_send_message(conn, signal);
+}
+
+static void cdma_connman_settings_update(struct ofono_cdma_connman *cm,
+					const char *interface,
+					ofono_bool_t static_ip,
+					const char *ip, const char *netmask,
+					const char *gateway, const char **dns)
+{
+	DBG("");
+
+	if (cm->settings)
+		cdma_connman_settings_free(cm->settings);
+
+	cm->settings =3D g_try_new0(struct cdma_connman_settings, 1);
+	if (cm->settings =3D=3D NULL)
+		return;
+
+	cm->settings->interface =3D g_strdup(interface);
+	cm->settings->static_ip =3D static_ip;
+	cm->settings->ip =3D g_strdup(ip);
+	cm->settings->netmask =3D g_strdup(netmask);
+	cm->settings->gateway =3D g_strdup(gateway);
+	cm->settings->dns =3D g_strdupv((char **)dns);
+
+	cdma_connman_ifupdown(interface, TRUE);
+
+	cdma_connman_settings_signal(cm);
+}
+
+static void cdma_connman_settings_reset(struct ofono_cdma_connman *cm)
+{
+	char *interface;
+
+	DBG("");
+
+	if (cm->settings =3D=3D NULL)
+		return;
+
+	interface =3D cm->settings->interface;
+	cm->settings->interface =3D NULL;
+
+	cdma_connman_settings_free(cm->settings);
+	cm->settings =3D NULL;
+
+	cdma_connman_settings_signal(cm);
+
+	cdma_connman_ifupdown(interface, FALSE);
+
+	g_free(interface);
+}
+
+static void activate_callback(const struct ofono_error *error,
+				const char *interface,
+				ofono_bool_t static_ip,
+				const char *ip, const char *netmask,
+				const char *gateway, const char **dns,
+				void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_cdma_connman *cm =3D data;
+	dbus_bool_t value;
+	const char *path;
+
+	DBG("%p %s", cm, interface);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Activating packet data service failed with error: %s",
+				telephony_error_to_str(error));
+		__ofono_dbus_pending_reply(&cm->pending,
+					__ofono_error_failed(cm->pending));
+		return;
+	}
+
+	cm->powered =3D TRUE;
+	__ofono_dbus_pending_reply(&cm->pending,
+				dbus_message_new_method_return(cm->pending));
+
+	/*
+	 * If we don't have the interface, don't bother emitting any settings,
+	 * as nobody can make use of them
+	 */
+	if (interface !=3D NULL)
+		cdma_connman_settings_update(cm, interface, static_ip,
+						ip, netmask, gateway, dns);
+
+	path =3D __ofono_atom_get_path(cm->atom);
+	value =3D cm->powered;
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Powered", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void deactivate_callback(const struct ofono_error *error, void *dat=
a)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_cdma_connman *cm =3D data;
+	dbus_bool_t value;
+	const char *path;
+
+	DBG("");
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Deactivating packet data service failed with error: %s",
+				telephony_error_to_str(error));
+		__ofono_dbus_pending_reply(&cm->pending,
+					__ofono_error_failed(cm->pending));
+		return;
+	}
+
+	cm->powered =3D FALSE;
+	__ofono_dbus_pending_reply(&cm->pending,
+				dbus_message_new_method_return(cm->pending));
+
+	cdma_connman_settings_reset(cm);
+
+	path =3D __ofono_atom_get_path(cm->atom);
+	value =3D cm->powered;
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				"Powered", DBUS_TYPE_BOOLEAN, &value);
+}
+
+static void cdma_connman_settings_append_properties(
+						struct ofono_cdma_connman *cm,
+						DBusMessageIter *dict)
+{
+	DBusMessageIter entry;
+	const char *key =3D "Settings";
+
+	DBG("");
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	cdma_connman_settings_append_variant(cm->settings, &entry);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static DBusMessage *cdma_connman_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_connman *cm =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t value;
+
+	DBG("");
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
+	value =3D cm->powered;
+	ofono_dbus_dict_append(&dict, "Powered", DBUS_TYPE_BOOLEAN, &value);
+
+	/* TODO: Dormant property. Not yet supported. */
+	value =3D cm->dormant;
+	ofono_dbus_dict_append(&dict, "Dormant", DBUS_TYPE_BOOLEAN, &value);
+
+	if (cm->settings)
+		cdma_connman_settings_append_properties(cm, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *cdma_connman_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_connman *cm =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_bool_t value;
+
+	DBG("");
+
+	if (cm->pending)
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
+	if (!strcmp(property, "Powered")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (cm->powered =3D=3D (ofono_bool_t) value)
+			return dbus_message_new_method_return(msg);
+
+		if (cm->driver =3D=3D NULL || cm->driver->activate =3D=3D NULL ||
+				cm->driver->deactivate =3D=3D NULL)
+			return __ofono_error_not_implemented(msg);
+
+		cm->pending =3D dbus_message_ref(msg);
+
+		/* TODO: add logic to support CDMA Network Registration */
+		if (value)
+			cm->driver->activate(cm, activate_callback, cm);
+		else
+			cm->driver->deactivate(cm, deactivate_callback, cm);
+
+		return dbus_message_new_method_return(msg);
+	}
+
+	/* TODO: Dormant property. Not yet supported. */
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable cdma_connman_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",
+						cdma_connman_get_properties },
+	{ "SetProperty",	"sv",	"",	cdma_connman_set_property,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable cdma_connman_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+int ofono_cdma_connman_driver_register(
+				const struct ofono_cdma_connman_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_cdma_connman_driver_unregister(
+				const struct ofono_cdma_connman_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void cdma_connman_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	DBG("");
+
+	g_dbus_unregister_interface(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
+	ofono_modem_remove_interface(modem,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
+}
+
+static void cdma_connman_remove(struct ofono_atom *atom)
+{
+	struct ofono_cdma_connman *cm =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (cm =3D=3D NULL)
+		return;
+
+	if (cm->driver && cm->driver->remove)
+		cm->driver->remove(cm);
+
+	g_free(cm);
+}
+
+struct ofono_cdma_connman *ofono_cdma_connman_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data)
+{
+	struct ofono_cdma_connman *cm;
+	GSList *l;
+
+	DBG("");
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	cm =3D g_try_new0(struct ofono_cdma_connman, 1);
+	if (cm =3D=3D NULL)
+		return NULL;
+
+	cm->atom =3D __ofono_modem_add_atom(modem,
+					OFONO_ATOM_TYPE_CDMA_CONNMAN,
+					cdma_connman_remove, cm);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cdma_connman_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(cm, vendor, data) < 0)
+			continue;
+
+		cm->driver =3D drv;
+		break;
+	}
+
+	return cm;
+}
+
+void ofono_cdma_connman_register(struct ofono_cdma_connman *cm)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cm->atom);
+	const char *path =3D __ofono_atom_get_path(cm->atom);
+
+	DBG("");
+
+	if (!g_dbus_register_interface(conn, path,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE,
+				cdma_connman_methods, cdma_connman_signals,
+				NULL, cm, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem,
+				OFONO_CDMA_CONNECTION_MANAGER_INTERFACE);
+
+	/* TODO: add watch to support CDMA Network Registration atom */
+
+	__ofono_atom_register(cm->atom, cdma_connman_unregister);
+}
+
+void ofono_cdma_connman_remove(struct ofono_cdma_connman *cm)
+{
+	__ofono_atom_free(cm->atom);
+}
+
+void ofono_cdma_connman_set_data(struct ofono_cdma_connman *cm, void *data)
+{
+	cm->driver_data =3D data;
+}
+
+void *ofono_cdma_connman_get_data(struct ofono_cdma_connman *cm)
+{
+	return cm->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index e48dbf6..4d798fd 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME,
 	OFONO_ATOM_TYPE_CTM,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
+	OFONO_ATOM_TYPE_CDMA_CONNMAN,
 	OFONO_ATOM_TYPE_SIM_AUTH,
 };
 =

@@ -419,4 +420,5 @@ void __ofono_nettime_info_received(struct ofono_modem *=
modem,
 					struct ofono_network_time *info);
 =

 #include <ofono/cdma-voicecall.h>
+#include <ofono/cdma-connman.h>
 #include <ofono/sim-auth.h>
-- =

1.7.0.4


--===============4283350961629351846==--

