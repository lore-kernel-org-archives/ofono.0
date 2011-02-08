Content-Type: multipart/mixed; boundary="===============0419388393625316683=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 4/7] cdma-netreg: Add Signal Strength Support
Date: Tue, 08 Feb 2011 13:04:57 -0800
Message-ID: <1297199100-2712-5-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0419388393625316683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    3 +-
 src/cdma-network.c |  263 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |    2 +
 3 files changed, 267 insertions(+), 1 deletions(-)
 create mode 100644 src/cdma-network.c

diff --git a/Makefile.am b/Makefile.am
index 93550d0..c245b4c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,7 +362,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c src/gprs-provision.c
+			src/message.h src/message.c src/gprs-provision.c \
+			src/cdma-network.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-network.c b/src/cdma-network.c
new file mode 100644
index 0000000..4c03536
--- /dev/null
+++ b/src/cdma-network.c
@@ -0,0 +1,263 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Nokia Corporation. All rights reserved.
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
+
+#include "common.h"
+#include "simutil.h"
+#include "util.h"
+#include "storage.h"
+
+static GSList *g_drivers;
+
+struct ofono_cdma_netreg {
+	int signal_strength;
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
+	/* TODO: Add Status Property */
+
+	if (netreg->signal_strength !=3D -1) {
+		unsigned char strength =3D netreg->signal_strength;
+
+		ofono_dbus_dict_append(&dict, "Strength", DBUS_TYPE_BYTE,
+					&strength);
+	}
+
+	/* TODO: Add DataStrength Property */
+
+	/* TODO: Add SystemIdentifier Property */
+
+	/* TODO: Add NetworkIdentifier Property */
+
+	/* TODO: Add MobileCountryCode Property */
+
+	/* TODO: Add MobileNetworkCode Property */
+
+	/* TODO: Add Name Property */
+
+	/* TODO: Add RoamingPreference Property */
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable network_registration_methods[] =3D {
+	{ "GetProperties",  "",  "a{sv}",	network_get_properties },
+	{ }
+};
+
+static GDBusSignalTable network_registration_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
+static void signal_strength_callback(const struct ofono_error *error,
+					int strength, void *data)
+{
+	struct ofono_cdma_netreg *netreg =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during signal strength query");
+		return;
+	}
+
+	ofono_cdma_netreg_strength_notify(netreg, strength);
+}
+
+void ofono_cdma_netreg_strength_notify(struct ofono_cdma_netreg *netreg,
+					int strength)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (netreg->signal_strength =3D=3D strength)
+		return;
+
+	netreg->signal_strength =3D strength;
+
+	if (strength !=3D -1) {
+		const char *path =3D __ofono_atom_get_path(netreg->atom);
+		unsigned char strength =3D netreg->signal_strength;
+
+		ofono_dbus_signal_property_changed(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				"Strength", DBUS_TYPE_BYTE, &strength);
+	}
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
+	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
+
+	return 0;
+}
+
+void ofono_cdma_netreg_driver_unregister(
+				const struct ofono_cdma_netreg_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
+}
+
+static void netreg_unregister(struct ofono_atom *atom)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	g_dbus_unregister_interface(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+	ofono_modem_remove_interface(modem,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+}
+
+static void netreg_remove(struct ofono_atom *atom)
+{
+	struct ofono_cdma_netreg *netreg =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (netreg =3D=3D NULL)
+		return;
+
+	if (netreg->driver && netreg->driver->remove)
+		netreg->driver->remove(netreg);
+
+	g_free(netreg);
+}
+
+struct ofono_cdma_netreg *ofono_cdma_netreg_create(struct ofono_modem *mod=
em,
+							unsigned int vendor,
+							const char *driver,
+							void *data)
+{
+	struct ofono_cdma_netreg *netreg;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	netreg =3D g_try_new0(struct ofono_cdma_netreg, 1);
+	if (netreg =3D=3D NULL)
+		return NULL;
+
+	netreg->signal_strength =3D -1;
+
+	netreg->atom =3D __ofono_modem_add_atom(modem,
+						OFONO_ATOM_TYPE_CDMA_NETREG,
+						netreg_remove, netreg);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cdma_netreg_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(netreg, vendor, data) < 0)
+			continue;
+
+		netreg->driver =3D drv;
+		break;
+	}
+
+	return netreg;
+}
+
+void ofono_cdma_netreg_register(struct ofono_cdma_netreg *netreg)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(netreg->atom);
+	const char *path =3D __ofono_atom_get_path(netreg->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
+				network_registration_methods,
+				network_registration_signals,
+				NULL, netreg, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem,
+				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE);
+
+	__ofono_atom_register(netreg->atom, netreg_unregister);
+
+	/*
+	 * Bootstrap signal strength value without waiting for the
+	 * stack to report it
+	 */
+	netreg->driver->strength(netreg, signal_strength_callback, netreg);
+}
+
+void ofono_cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	__ofono_atom_free(netreg->atom);
+}
+
+void ofono_cdma_netreg_set_data(struct ofono_cdma_netreg *netreg, void *da=
ta)
+{
+	netreg->driver_data =3D data;
+}
+
+void *ofono_cdma_netreg_get_data(struct ofono_cdma_netreg *netreg)
+{
+	return netreg->driver_data;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 4f0b7c2..4b2f834 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -128,6 +128,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CTM,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
 	OFONO_ATOM_TYPE_SIM_AUTH,
+	OFONO_ATOM_TYPE_CDMA_NETREG,
 };
 =

 enum ofono_atom_watch_condition {
@@ -435,3 +436,4 @@ ofono_bool_t __ofono_gprs_provision_get_settings(const =
char *mcc,
 void __ofono_gprs_provision_free_settings(
 				struct ofono_gprs_provision_data *settings,
 				int count);
+#include <ofono/cdma-netreg.h>
-- =

1.7.0.4


--===============0419388393625316683==--

