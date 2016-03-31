Content-Type: multipart/mixed; boundary="===============6070435738187054367=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 3/6] netmon: Add serving cell info support
Date: Thu, 31 Mar 2016 09:53:34 +0530
Message-ID: <1459398214-5849-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6070435738187054367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |   3 +-
 src/netmon.c | 350 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h  |   1 +
 3 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 src/netmon.c

diff --git a/Makefile.am b/Makefile.am
index b9f114d..ec648bd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -598,7 +598,8 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
-			src/hfp.h src/siri.c
+			src/hfp.h src/siri.c \
+			src/netmon.c
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/netmon.c b/src/netmon.c
new file mode 100644
index 0000000..a8a0ffd
--- /dev/null
+++ b/src/netmon.c
@@ -0,0 +1,350 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *
+ *  Copyright (C) 2008-2016  Intel Corporation. All rights reserved.
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
+#include <stdint.h>
+#include <stdarg.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include <ofono/netmon.h>
+
+#define CELL_INFO_DICT_APPEND(p_dict, key, info, type, dbus_type)	do { \
+	type value; \
+	if (info < 0) \
+		break; \
+	value =3D (type) info; \
+	ofono_dbus_dict_append(p_dict, key, dbus_type, &value); \
+} while (0)
+
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_netmon {
+	const struct ofono_netmon_driver *driver;
+	DBusMessage *pending;
+	DBusMessage *reply;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static const char *cell_type_to_tech_name(enum ofono_netmon_cell_type type)
+{
+	switch (type) {
+	case OFONO_NETMON_CELL_TYPE_GSM:
+		return "gsm";
+	case OFONO_NETMON_CELL_TYPE_UMTS:
+		return "umts";
+	case OFONO_NETMON_CELL_TYPE_LTE:
+		return "lte";
+	}
+
+	return NULL;
+}
+
+void ofono_netmon_serving_cell_notify(struct ofono_netmon *netmon,
+					enum ofono_netmon_cell_type type,
+					int info_type, ...)
+{
+	va_list arglist;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	enum ofono_netmon_info next_info_type =3D info_type;
+	const char *technology =3D cell_type_to_tech_name(type);
+	char *mcc =3D NULL;
+	char *mnc =3D NULL;
+	int intval;
+	netmon->reply =3D dbus_message_new_method_return(netmon->pending);
+
+	if (netmon->reply =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(netmon->reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	va_start(arglist, info_type);
+
+	if (technology =3D=3D NULL)
+		goto done;
+
+	ofono_dbus_dict_append(&dict, "Technology", DBUS_TYPE_STRING, &technology=
);
+
+	while (next_info_type !=3D OFONO_NETMON_INFO_INVALID) {
+		switch (next_info_type) {
+		case OFONO_NETMON_INFO_MCC:
+			mcc =3D va_arg(arglist, char *);
+
+			if (mcc && strlen(mcc))
+				ofono_dbus_dict_append(&dict, "MobileCountryCode",
+						DBUS_TYPE_STRING, &mcc);
+
+			break;
+
+		case OFONO_NETMON_INFO_MNC:
+			mnc =3D va_arg(arglist, char *);
+
+			if (mnc && strlen(mnc))
+				ofono_dbus_dict_append(&dict, "MobileNetworkCode", \
+						DBUS_TYPE_STRING, &mnc);
+
+			break;
+
+		case OFONO_NETMON_INFO_LAC:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "LocationAreaCode", \
+					intval, uint16_t, DBUS_TYPE_UINT16);
+
+			break;
+
+		case OFONO_NETMON_INFO_CI:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "CellId",
+					intval, uint32_t, DBUS_TYPE_UINT32);
+
+			break;
+
+		case OFONO_NETMON_INFO_ARFCN:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ARFCN",
+					intval, uint16_t, DBUS_TYPE_UINT16);
+			break;
+
+		case OFONO_NETMON_INFO_BSIC:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "BSIC",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+
+			break;
+
+		case OFONO_NETMON_INFO_RXLEV:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalStrength",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+
+			break;
+
+		case OFONO_NETMON_INFO_TIMING_ADVANCE:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "TimingAdvance",
+					intval, uint8_t, DBUS_TYPE_BYTE);
+
+			break;
+
+		case OFONO_NETMON_INFO_PSC:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "PrimaryScramblingCode",
+					intval, uint16_t, DBUS_TYPE_UINT16);
+
+			break;
+
+		case OFONO_NETMON_INFO_BER:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "BitErrorRate", \
+					intval, uint8_t, DBUS_TYPE_BYTE);
+
+			break;
+
+		case OFONO_NETMON_INFO_RSSI:
+			intval =3D va_arg(arglist, int);
+
+			CELL_INFO_DICT_APPEND(&dict, "Strength", \
+					intval, uint8_t, DBUS_TYPE_BYTE);
+			break;
+
+		case OFONO_NETMON_INFO_INVALID:
+			break;
+		}
+
+		next_info_type =3D va_arg(arglist, int);
+	}
+
+done:
+	va_end(arglist);
+
+	dbus_message_iter_close_container(&iter, &dict);
+}
+
+static void serving_cell_info_callback(const struct ofono_error *error,
+		void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+	DBusMessage *reply =3D netmon->reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(netmon->pending);
+
+	__ofono_dbus_pending_reply(&netmon->pending, reply);
+}
+
+static DBusMessage *netmon_get_serving_cell_info(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+
+	if (!netmon->driver && !netmon->driver->request_update)
+		return __ofono_error_not_implemented(msg);
+
+	if (netmon->pending)
+		return __ofono_error_busy(msg);
+
+	netmon->pending =3D dbus_message_ref(msg);
+
+	netmon->driver->request_update(netmon, serving_cell_info_callback, netmon=
);
+
+	return NULL;
+}
+
+static const GDBusMethodTable netmon_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("GetServingCellInformation",
+			NULL, GDBUS_ARGS({ "cellinfo", "a{sv}" }),
+			netmon_get_serving_cell_info) },
+	{ }
+};
+
+int ofono_netmon_driver_register(const struct ofono_netmon_driver *d)
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
+void ofono_netmon_driver_unregister(const struct ofono_netmon_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void netmon_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	ofono_modem_remove_interface(modem, OFONO_NETMON_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_NETMON_INTERFACE);
+}
+
+static void netmon_remove(struct ofono_atom *atom)
+{
+	struct ofono_netmon *netmon =3D __ofono_atom_get_data(atom);
+
+	if (netmon =3D=3D NULL)
+		return;
+
+	if (netmon->driver && netmon->driver->remove)
+		netmon->driver->remove(netmon);
+
+	g_free(netmon);
+}
+
+struct ofono_netmon *ofono_netmon_create(struct ofono_modem *modem,
+			unsigned int vendor, const char *driver, void *data)
+{
+	struct ofono_netmon *netmon;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	netmon =3D g_try_new0(struct ofono_netmon, 1);
+
+	if (netmon =3D=3D NULL)
+		return NULL;
+
+	netmon->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_NETMON,
+						netmon_remove, netmon);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_netmon_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(netmon, vendor, data) < 0)
+			continue;
+
+		netmon->driver =3D drv;
+		break;
+	}
+
+	return netmon;
+}
+
+void ofono_netmon_register(struct ofono_netmon *netmon)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(netmon->atom);
+	const char *path =3D __ofono_atom_get_path(netmon->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+				OFONO_NETMON_INTERFACE,
+				netmon_methods, NULL, NULL,
+				netmon, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_NETMON_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_NETMON_INTERFACE);
+
+	__ofono_atom_register(netmon->atom, netmon_unregister);
+}
+
+void ofono_netmon_remove(struct ofono_netmon *netmon)
+{
+	__ofono_atom_free(netmon->atom);
+}
+
+void ofono_netmon_set_data(struct ofono_netmon *netmon, void *data)
+{
+	netmon->driver_data =3D data;
+}
+
+void *ofono_netmon_get_data(struct ofono_netmon *netmon)
+{
+	return netmon->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index bfcb58f..31fb893 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -152,6 +152,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CDMA_NETREG,
 	OFONO_ATOM_TYPE_HANDSFREE,
 	OFONO_ATOM_TYPE_SIRI,
+	OFONO_ATOM_TYPE_NETMON,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.9.1


--===============6070435738187054367==--

