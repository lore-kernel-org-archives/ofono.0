Content-Type: multipart/mixed; boundary="===============6955464235874570122=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/8] Add skeleton of src/emulator.c
Date: Tue, 13 Apr 2010 22:18:15 +0800
Message-ID: <1271168299-4862-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1271168299-4862-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6955464235874570122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    7 +-
 include/dbus.h     |    1 +
 include/emulator.h |   75 +++++++++++++++++++
 src/emulator.c     |  203 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |    4 +
 5 files changed, 287 insertions(+), 3 deletions(-)
 create mode 100644 include/emulator.h
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 20dff39..eda7ad6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h
+			include/radio-settings.h include/emulator.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -238,9 +238,10 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sour=
ces) \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
-			src/radio-settings.c src/stkutil.h src/stkutil.c
+			src/radio-settings.c src/stkutil.h src/stkutil.c \
+			src/emulator.c
 =

-src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
+src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl -lutil
 =

 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic -Wl,--version-script=3Dsrc/ofo=
no.ver
 =

diff --git a/include/dbus.h b/include/dbus.h
index 5bf0505..9007da2 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -47,6 +47,7 @@ extern "C" {
 #define OFONO_SMS_MANAGER_INTERFACE "org.ofono.SmsManager"
 #define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
+#define OFONO_EMULATOR_INTERFACE "org.ofono.ModemEmulator"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..3d07e36
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,75 @@
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
+typedef void (*ofono_emulator_cb_t)(const struct ofono_error *error,
+					void *data);
+
+struct ofono_emulator_driver {
+	const char *name;
+
+	/* Detect existence of device and initialize any device-specific data
+	 * structures */
+	int (*probe)(struct ofono_emulator *emulator);
+
+	/* Destroy data structures allocated during probe and cleanup */
+	void (*remove)(struct ofono_emulator *emulator);
+
+	/* Power up device */
+	int (*enable)(struct ofono_emulator *emulator);
+
+	/* Power down device */
+	int (*disable)(struct ofono_emulator *emulator);
+
+	/* Notify a new call from real modem */
+	void (*notify_call)(struct ofono_emulator *emulator,
+				struct ofono_call *nc);
+};
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *d);
+void ofono_emulator_driver_unregister(const struct ofono_emulator_driver *=
d);
+
+void ofono_emulator_register(struct ofono_emulator *emulator);
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					unsigned int vendor,
+					const char *driver, void *data);
+
+void ofono_emulator_watch_voicecall(struct ofono_emulator *emulator);
+
+void ofono_emulator_set_data(struct ofono_emulator *emulator, void *data);
+void *ofono_emulator_get_data(struct ofono_emulator *emulator);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..33e0a85
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,203 @@
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
+#include <string.h>
+#include <stdio.h>
+#include <time.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+
+static GSList *g_drivers =3D NULL;
+
+struct ofono_emulator {
+	const struct ofono_emulator_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *emulator_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	return reply;
+}
+
+static DBusMessage *emulator_enable(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_emulator *emulator =3D data;
+
+	if (emulator->driver->enable)
+		emulator->driver->enable(emulator);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *emulator_disable(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_emulator *emulator =3D data;
+
+	if (emulator =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (emulator->driver->disable)
+		emulator->driver->disable(emulator);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable emulator_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	emulator_get_properties },
+	{ "EnableEmulator",	"",	"",		emulator_enable	},
+	{ "DisableEmulator",	"",	"",		emulator_disable },
+	{ }
+};
+
+static GDBusSignalTable emulator_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+};
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_emulator_driver_unregister(const struct ofono_emulator_driver *=
d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void emulator_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	ofono_modem_remove_interface(modem, OFONO_EMULATOR_INTERFACE);
+	g_dbus_unregister_interface(conn, path,
+					OFONO_EMULATOR_INTERFACE);
+}
+
+void ofono_emulator_register(struct ofono_emulator *emulator)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(emulator->atom);
+	const char *path =3D __ofono_atom_get_path(emulator->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_EMULATOR_INTERFACE,
+					emulator_methods, emulator_signals,
+					NULL, emulator, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_EMULATOR_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_EMULATOR_INTERFACE);
+
+	__ofono_atom_register(emulator->atom, emulator_unregister);
+}
+
+static void emulator_remove(struct ofono_atom *atom)
+{
+	struct ofono_emulator *emulator =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (emulator =3D=3D NULL)
+		return;
+
+	if (emulator->driver && emulator->driver->remove)
+		emulator->driver->remove(emulator);
+
+	g_free(emulator);
+}
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data)
+{
+	struct ofono_emulator *emulator;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	emulator =3D g_try_new0(struct ofono_emulator, 1);
+
+	if (emulator =3D=3D NULL)
+		return NULL;
+
+	emulator->atom =3D __ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_EMULATOR,
+						emulator_remove, emulator);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_emulator_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(emulator) < 0)
+			continue;
+
+		emulator->driver =3D drv;
+		break;
+	}
+
+	return emulator;
+}
+
+void ofono_emulator_set_data(struct ofono_emulator *emulator, void *data)
+{
+	emulator->driver_data =3D data;
+}
+
+void *ofono_emulator_get_data(struct ofono_emulator *emulator)
+{
+	return emulator->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 115ad6b..118406d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -114,6 +114,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_GPRS =3D 16,
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
+	OFONO_ATOM_TYPE_EMULATOR =3D 19,
 };
 =

 enum ofono_atom_watch_condition {
@@ -168,6 +169,8 @@ unsigned int __ofono_atom_add_signal_watch(struct ofono=
_atom *atom,
 gboolean __ofono_atom_remove_signal_watch(struct ofono_atom *atom,
 						unsigned int id);
 =

+#include <gdbus/gdbus.h>
+
 unsigned int __ofono_modem_add_atom_watch(struct ofono_modem *modem,
 					enum ofono_atom_type type,
 					ofono_atom_watch_func notify,
@@ -189,6 +192,7 @@ void __ofono_atom_free(struct ofono_atom *atom);
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/radio-settings.h>
+#include <ofono/emulator.h>
 =

 #include <ofono/sim.h>
 =

-- =

1.6.6.1


--===============6955464235874570122==--

