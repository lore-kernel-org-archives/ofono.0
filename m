Content-Type: multipart/mixed; boundary="===============5553084740441824878=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH 02/12] Add handsfree atom for HFP-specific capabilities
Date: Thu, 15 Sep 2011 18:34:33 +0200
Message-ID: <1316104483-13144-3-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1316104483-13144-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5553084740441824878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    6 +-
 include/dbus.h      |    1 +
 include/handsfree.h |   57 +++++++++++++
 src/handsfree.c     |  223 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h         |    1 +
 5 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 include/handsfree.h
 create mode 100644 src/handsfree.c

diff --git a/Makefile.am b/Makefile.am
index 9baab0c..9142777 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,7 +17,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/gprs-provision.h include/emulator.h \
 			include/location-reporting.h \
 			include/cdma-connman.h include/gnss.h \
-			include/private-network.h include/cdma-netreg.h
+			include/private-network.h include/cdma-netreg.h \
+			include/handsfree.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -422,7 +423,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/cdma-connman.c src/gnss.c \
 			src/gnssagent.c src/gnssagent.h \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
-			src/cdma-sms.c src/private-network.c src/cdma-netreg.c
+			src/cdma-sms.c src/private-network.c src/cdma-netreg.c \
+			src/handsfree.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/dbus.h b/include/dbus.h
index 65bda72..5bf2669 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -58,6 +58,7 @@ extern "C" {
 #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
 #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
 #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
+#define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
diff --git a/include/handsfree.h b/include/handsfree.h
new file mode 100644
index 0000000..ddec353
--- /dev/null
+++ b/include/handsfree.h
@@ -0,0 +1,57 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_HANDSFREE_H
+#define __OFONO_HANDSFREE_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_handsfree;
+
+struct ofono_handsfree_driver {
+	const char *name;
+	int (*probe)(struct ofono_handsfree *hf, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_handsfree *hf);
+};
+
+int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d=
);
+void ofono_handsfree_driver_unregister(
+			const struct ofono_handsfree_driver *d);
+
+struct ofono_handsfree *ofono_handsfree_create(struct ofono_modem *modem,
+			unsigned int vendor, const char *driver, void *data);
+
+void ofono_handsfree_register(struct ofono_handsfree *hf);
+void ofono_handsfree_remove(struct ofono_handsfree *hf);
+
+void ofono_handsfree_set_data(struct ofono_handsfree *hf, void *data);
+void *ofono_handsfree_get_data(struct ofono_handsfree *hf);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_HANDSFREE_H */
diff --git a/src/handsfree.c b/src/handsfree.c
new file mode 100644
index 0000000..797fe69
--- /dev/null
+++ b/src/handsfree.c
@@ -0,0 +1,223 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/handsfree.h>
+
+#include <gdbus.h>
+#include "ofono.h"
+#include "common.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_handsfree {
+	const struct ofono_handsfree_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *handsfree_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
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
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *handsfree_set_property(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
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
+	return __ofono_error_invalid_args(msg);
+}
+
+static GDBusMethodTable handsfree_methods[] =3D {
+	{ "GetProperties",    "",    "a{sv}", handsfree_get_properties,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",      "sv",  "", handsfree_set_property,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static GDBusSignalTable handsfree_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static void handsfree_remove(struct ofono_atom *atom)
+{
+	struct ofono_handsfree *hf =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (hf =3D=3D NULL)
+		return;
+
+	if (hf->driver !=3D NULL && hf->driver->remove !=3D NULL)
+		hf->driver->remove(hf);
+
+	g_free(hf);
+}
+
+struct ofono_handsfree *ofono_handsfree_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver,
+					void *data)
+{
+	struct ofono_handsfree *hf;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	hf =3D g_try_new0(struct ofono_handsfree, 1);
+	if (hf =3D=3D NULL)
+		return NULL;
+
+	hf->atom =3D __ofono_modem_add_atom(modem,
+					OFONO_ATOM_TYPE_HANDSFREE,
+					handsfree_remove, hf);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_handsfree_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(hf, vendor, data) < 0)
+			continue;
+
+		hf->driver =3D drv;
+		break;
+	}
+
+	return hf;
+}
+
+static void handsfree_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	ofono_modem_remove_interface(modem, OFONO_HANDSFREE_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					OFONO_HANDSFREE_INTERFACE);
+}
+
+void ofono_handsfree_register(struct ofono_handsfree *hf)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(hf->atom);
+	const char *path =3D __ofono_atom_get_path(hf->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_HANDSFREE_INTERFACE,
+					handsfree_methods, handsfree_signals,
+					NULL, hf, NULL)) {
+		ofono_error("Could not create %s interface",
+					OFONO_HANDSFREE_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_HANDSFREE_INTERFACE);
+
+	__ofono_atom_register(hf->atom, handsfree_unregister);
+}
+
+int ofono_handsfree_driver_register(const struct ofono_handsfree_driver *d)
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
+void ofono_handsfree_driver_unregister(
+				const struct ofono_handsfree_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+void ofono_handsfree_remove(struct ofono_handsfree *hf)
+{
+	__ofono_atom_free(hf->atom);
+}
+
+void ofono_handsfree_set_data(struct ofono_handsfree *hf, void *data)
+{
+	hf->driver_data =3D data;
+}
+
+void *ofono_handsfree_get_data(struct ofono_handsfree *hf)
+{
+	return hf->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 188c664..a5995b0 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -138,6 +138,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_GNSS,
 	OFONO_ATOM_TYPE_CDMA_SMS,
 	OFONO_ATOM_TYPE_CDMA_NETREG,
+	OFONO_ATOM_TYPE_HANDSFREE,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.6


--===============5553084740441824878==--

