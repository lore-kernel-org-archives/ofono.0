Content-Type: multipart/mixed; boundary="===============5148818266043788646=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2 1/3] cdmamodem: Create org.ofono.cdma.NetworkRegistration
 interface.
Date: Sat, 23 Jul 2011 06:09:28 +0200
Message-ID: <1311394170-7381-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311394170-7381-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5148818266043788646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    6 +-
 include/cdma-netreg.h |   63 +++++++++++++
 include/dbus.h        |    2 +
 src/cdma-netreg.c     |  233 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h           |    2 +
 5 files changed, 303 insertions(+), 3 deletions(-)
 create mode 100644 include/cdma-netreg.h
 create mode 100644 src/cdma-netreg.c

diff --git a/Makefile.am b/Makefile.am
index d44e62b..837d374 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -16,8 +16,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/cdma-sms.h include/sim-auth.h \
 			include/gprs-provision.h include/emulator.h \
 			include/location-reporting.h \
-			include/cdma-connman.h include/gnss.h \
-			include/private-network.h
+			include/cdma-connman.h include/cdma-netreg.h \
+			include/gnss.h include/private-network.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -410,7 +410,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/cdma-connman.c src/gnss.c \
 			src/gnssagent.c src/gnssagent.h \
 			src/cdma-smsutil.h src/cdma-smsutil.c \
-			src/cdma-sms.c src/private-network.c
+			src/cdma-sms.c src/cdma-netreg.c src/private-network.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
new file mode 100644
index 0000000..36f8593
--- /dev/null
+++ b/include/cdma-netreg.h
@@ -0,0 +1,63 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __OFONO_CDMA_NETREG_H
+#define __OFONO_CDMA_NETREG_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_cdma_netreg;
+
+struct ofono_cdma_netreg_driver {
+	const char *name;
+	int (*probe)(struct ofono_cdma_netreg *cdma_netreg, unsigned int vendor,
+			void *data);
+	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
+};
+
+void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
+					int status);
+
+int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d);
+void ofono_cdma_netreg_driver_unregister(const struct ofono_cdma_netreg_dr=
iver *d);
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
+						unsigned int vendor,
+						const char *driver,
+						void *data);
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *cdma_netreg);
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *cdma_netreg);
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg, voi=
d *data);
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg);
+
+int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_CDMA_NETREG_H */
diff --git a/include/dbus.h b/include/dbus.h
index 4dd9db5..65bda72 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -63,6 +63,8 @@ extern "C" {
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
 #define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
 #define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
+#define OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE \
+					"org.ofono.cdma.NetworkRegistration"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
new file mode 100644
index 0000000..c19a861
--- /dev/null
+++ b/src/cdma-netreg.c
@@ -0,0 +1,233 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 U=
SA
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
+#include <sys/time.h>
+
+#include "ofono.h"
+#include "common.h"
+
+static GSList *g_drivers;
+
+struct ofono_cdma_netreg {
+	int status;
+	const struct ofono_cdma_netreg_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static DBusMessage *network_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_netreg *netreg =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	const char *status =3D registration_status_to_string(netreg->status);
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
+	ofono_dbus_dict_append(&dict, "Status", DBUS_TYPE_STRING, &status);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable cdma_netreg_manager_methods[] =3D {
+	/* TODO */
+	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
+	{ }
+};
+
+static GDBusSignalTable cdma_netreg_manager_signals[] =3D {
+	/* TODO */
+	{ }
+};
+
+static void set_registration_status(struct ofono_cdma_netreg *netreg,
+						int status)
+{
+	const char *str_status =3D registration_status_to_string(status);
+	const char *path =3D __ofono_atom_get_path(netreg->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	netreg->status =3D status;
+
+	ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"Status", DBUS_TYPE_STRING, &str_status);
+}
+
+void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
+					int status)
+{
+	if (netreg =3D=3D NULL)
+		return;
+
+	if (netreg->status !=3D status)
+		set_registration_status(netreg, status);
+}
+
+int ofono_cdma_netreg_get_status(struct ofono_cdma_netreg *netreg)
+{
+	if (netreg =3D=3D NULL)
+		return -1;
+
+	return netreg->status;
+}
+
+int ofono_cdma_netreg_driver_register(const struct ofono_cdma_netreg_drive=
r *d)
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
+void ofono_cdma_netreg_driver_unregister(const struct ofono_cdma_netreg_dr=
iver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+static void cdma_netreg_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	g_dbus_unregister_interface(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+
+	ofono_modem_remove_interface(modem,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+}
+
+static void cdma_netreg_remove(struct ofono_atom *atom)
+{
+	struct ofono_cdma_netreg *cdma_netreg =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (cdma_netreg =3D=3D NULL)
+		return;
+
+	if (cdma_netreg->driver && cdma_netreg->driver->remove)
+		cdma_netreg->driver->remove(cdma_netreg);
+
+	g_free(cdma_netreg);
+}
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
+						unsigned int vendor,
+						const char *driver,
+						void *data)
+{
+	struct ofono_cdma_netreg *cdma_netreg;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	cdma_netreg =3D g_try_new0(struct ofono_cdma_netreg, 1);
+	if (cdma_netreg =3D=3D NULL)
+		return NULL;
+
+	cdma_netreg->atom =3D __ofono_modem_add_atom(modem,
+					OFONO_ATOM_TYPE_CDMA_NETREG,
+					cdma_netreg_remove, cdma_netreg);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cdma_netreg_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(cdma_netreg, vendor, data) < 0)
+			continue;
+
+		cdma_netreg->driver =3D drv;
+		break;
+	}
+
+	return cdma_netreg;
+}
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *cdma_netreg)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(cdma_netreg->atom);
+	const char *path =3D __ofono_atom_get_path(cdma_netreg->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				cdma_netreg_manager_methods,
+				cdma_netreg_manager_signals,
+				NULL, cdma_netreg, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+
+	__ofono_atom_register(cdma_netreg->atom, cdma_netreg_unregister);
+}
+
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *cdma_netreg)
+{
+	__ofono_atom_free(cdma_netreg->atom);
+}
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *cdma_netreg, voi=
d *data)
+{
+	cdma_netreg->driver_data =3D data;
+}
+
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *cdma_netreg)
+{
+	return cdma_netreg->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 6524806..3de3052 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -135,6 +135,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_LOCATION_REPORTING,
 	OFONO_ATOM_TYPE_GNSS,
 	OFONO_ATOM_TYPE_CDMA_SMS,
+	OFONO_ATOM_TYPE_CDMA_NETREG
 };
 =

 enum ofono_atom_watch_condition {
@@ -474,6 +475,7 @@ void __ofono_gprs_provision_free_settings(
 #include <ofono/emulator.h>
 #include <ofono/gnss.h>
 #include <ofono/cdma-sms.h>
+#include <ofono/cdma-netreg.h>
 #include <ofono/private-network.h>
 =

 void __ofono_private_network_release(int id);
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5148818266043788646==--

