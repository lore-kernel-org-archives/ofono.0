Content-Type: multipart/mixed; boundary="===============1556187275929076673=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/6] emulator: Add ofono_emulator framework
Date: Mon, 05 Jul 2010 13:45:04 +0800
Message-ID: <1278308709-13908-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1556187275929076673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each type of emulator can be register through emulator drivers
statically. When modem powers up, oFono probes emulator driver to create
emulator for each modem.
---
 Makefile.am        |    4 +-
 include/dbus.h     |    1 +
 include/emulator.h |   63 ++++++++++++
 src/emulator.c     |  271 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c        |    1 +
 src/ofono.h        |    6 +
 6 files changed, 344 insertions(+), 2 deletions(-)
 create mode 100644 include/emulator.h
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 96116a5..8ecb2d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
-			include/nettime.h
+			include/nettime.h include/emulator.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -272,7 +272,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c
+			src/nettime.c src/emulator.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/dbus.h b/include/dbus.h
index d988760..281be80 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -49,6 +49,7 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_DATA_CONNECTION_MANAGER_INTERFACE "org.ofono.DataConnectionM=
anager"
 #define OFONO_DATA_CONTEXT_INTERFACE "org.ofono.PrimaryDataContext"
+#define OFONO_EMULATOR_INTERFACE "org.ofono.Emulator"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..0c87b13
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,63 @@
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
+#ifndef __OFONO_EMULATOR_H
+#define __OFONO_EMULATOR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_emulator;
+
+enum ofono_emulator_type {
+	OFONO_EMULATOR_TYPE_NONE,
+	OFONO_EMULATOR_TYPE_DUN,
+};
+
+struct ofono_emulator_driver {
+	const char *name;
+	enum ofono_emulator_type type;
+	int (*probe)(struct ofono_emulator *e);
+	void (*remove)(struct ofono_emulator *e);
+	int (*enable)(struct ofono_emulator *e, int fd);
+	int (*disable)(struct ofono_emulator *e);
+};
+
+const char *ofono_emulator_get_path(struct ofono_emulator *e);
+void ofono_emulator_set_data(struct ofono_emulator *e, void *user_data);
+void *ofono_emulator_get_data(struct ofono_emulator *e);
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver);
+void ofono_emulator_remove(struct ofono_emulator *e);
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver);
+void ofono_emulator_driver_unregister(
+				const struct ofono_emulator_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..6b63398
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,271 @@
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
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+
+struct ofono_emulator {
+	struct ofono_emulator_driver *driver;
+	struct ofono_modem *modem;
+	struct ofono_atom *atom;
+	unsigned int id;
+	void *user_data;
+};
+
+static GSList *emulator_list;
+static GSList *ofono_emulator_drivers;
+static unsigned int ofono_emulator_ids;
+
+static unsigned int ofono_emulator_next_id()
+{
+	unsigned int i;
+
+	for (i =3D 1; i < sizeof(ofono_emulator_ids) * 8; i++) {
+		if (ofono_emulator_ids & (0x1 << i))
+			continue;
+
+		ofono_emulator_ids |=3D (0x1 << i);
+
+		return i;
+	}
+
+	return 0;
+}
+
+static void ofono_emulator_release_id(int id)
+{
+	ofono_emulator_ids &=3D ~(0x1 << id);
+}
+
+static enum ofono_atom_type ofono_emulator_atom_type(
+					enum ofono_emulator_type type)
+{
+	switch (type) {
+	case OFONO_EMULATOR_TYPE_DUN:
+		return OFONO_ATOM_TYPE_EMULATOR_DUN;
+	default:
+		return 0;
+	}
+}
+
+static const char *ofono_emulator_type_to_str(enum ofono_emulator_type typ=
e)
+{
+	switch (type) {
+	case OFONO_EMULATOR_TYPE_DUN:
+		return "dun";
+	default:
+		return "";
+	}
+}
+
+const char *ofono_emulator_get_path(struct ofono_emulator *e)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/%s_emulator",
+			ofono_modem_get_path(e->modem),
+			ofono_emulator_type_to_str(e->driver->type));
+
+	return path;
+}
+
+void ofono_emulator_set_data(struct ofono_emulator *e, void *user_data)
+{
+	if (!e)
+		return;
+
+	e->user_data =3D user_data;
+}
+
+void *ofono_emulator_get_data(struct ofono_emulator *e)
+{
+	if (!e)
+		return NULL;
+
+	return e->user_data;
+}
+
+static void emulator_remove(struct ofono_atom *atom)
+{
+	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
+
+	DBG("");
+
+	emulator_list =3D g_slist_remove(emulator_list, e);
+
+	if (e->driver->remove)
+		e->driver->remove(e);
+
+	ofono_emulator_release_id(e->id);
+	g_free(e);
+	e =3D NULL;
+}
+
+static struct ofono_emulator *create_emulator(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver)
+{
+	struct ofono_emulator *e;
+
+	DBG("");
+
+	e =3D g_try_new0(struct ofono_emulator, 1);
+	if (!e)
+		goto error;
+
+	e->modem =3D modem;
+	e->driver =3D driver;
+	e->id =3D ofono_emulator_next_id();
+
+	return e;
+error:
+	g_free(e);
+	return NULL;
+}
+
+static DBusMessage *emulator_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable ofono_emulator_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}", emulator_get_properties },
+	{ }
+};
+
+static GDBusSignalTable ofono_emulator_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+};
+
+static void ofono_emulator_dbus_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
+	const char *path;
+
+	path =3D ofono_emulator_get_path(e);
+
+	g_dbus_unregister_interface(conn, path, OFONO_EMULATOR_INTERFACE);
+
+	return;
+}
+
+static gboolean ofono_emulator_dbus_register(struct ofono_modem *modem,
+						struct ofono_emulator *e)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D ofono_emulator_get_path(e);
+
+	if (!g_dbus_register_interface(conn, path, OFONO_EMULATOR_INTERFACE,
+				ofono_emulator_methods, ofono_emulator_signals,
+				NULL, e, NULL)) {
+		ofono_error("Could not create ofono_emulator %s", path);
+		ofono_emulator_remove(e);
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver)
+{
+	struct ofono_emulator *e;
+	enum ofono_atom_type type;
+
+	DBG("");
+
+	e =3D create_emulator(modem, driver);
+	if (!e)
+		return NULL;
+
+	type =3D ofono_emulator_atom_type(driver->type);
+	e->atom =3D __ofono_modem_add_atom(modem, type, emulator_remove, e);
+
+	if (!ofono_emulator_dbus_register(modem, e)) {
+		ofono_emulator_remove(e);
+		return NULL;
+	}
+
+	__ofono_atom_register(e->atom, ofono_emulator_dbus_unregister);
+
+	if (driver->probe(e) < 0) {
+		ofono_emulator_remove(e);
+		return NULL;
+	}
+
+	return e;
+}
+
+void __ofono_emulator_probe_drivers(struct ofono_modem *modem)
+{
+	GSList *l;
+	struct ofono_emulator *e;
+
+	for (l =3D ofono_emulator_drivers; l; l =3D l->next) {
+		struct ofono_emulator_driver *driver =3D l->data;
+
+		e =3D ofono_emulator_create(modem, driver);
+		if (!e)
+			continue;
+
+		emulator_list =3D g_slist_prepend(emulator_list, e);
+	}
+}
+
+void ofono_emulator_remove(struct ofono_emulator *e)
+{
+	DBG("");
+
+	if (!e)
+		return;
+
+	__ofono_atom_free(e->atom);
+}
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	ofono_emulator_drivers =3D g_slist_prepend(ofono_emulator_drivers,
+							(void *)driver);
+
+	return 0;
+}
+
+void ofono_emulator_driver_unregister(
+				const struct ofono_emulator_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	ofono_emulator_drivers =3D g_slist_remove(ofono_emulator_drivers, driver);
+}
diff --git a/src/modem.c b/src/modem.c
index 43e4a6d..8137f97 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -396,6 +396,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 				driver->post_sim(modem);
 			__ofono_history_probe_drivers(modem);
 			__ofono_nettime_probe_drivers(modem);
+			__ofono_emulator_probe_drivers(modem);
 		}
 		break;
 =

diff --git a/src/ofono.h b/src/ofono.h
index e2271e6..ac2a5b0 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -117,6 +117,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
 	OFONO_ATOM_TYPE_STK =3D 19,
 	OFONO_ATOM_TYPE_NETTIME =3D 20,
+	OFONO_ATOM_TYPE_EMULATOR_DUN =3D 21,
 };
 =

 enum ofono_atom_watch_condition {
@@ -273,3 +274,8 @@ void __ofono_nettime_probe_drivers(struct ofono_modem *=
modem);
 =

 void __ofono_nettime_info_received(struct ofono_modem *modem,
 					struct ofono_network_time *info);
+
+#include <ofono/emulator.h>
+
+void __ofono_emulator_probe_drivers(struct ofono_modem *modem);
+
-- =

1.6.3.3


--===============1556187275929076673==--

