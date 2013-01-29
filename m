Content-Type: multipart/mixed; boundary="===============0180227591662140551=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 2/2] hfp_ag: Add BlueZ 5 version
Date: Tue, 29 Jan 2013 11:42:40 +0100
Message-ID: <1359456160-9514-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1359456160-9514-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0180227591662140551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds initial implementation of the D-Bus Profile1
interface and methods responsible for handling Bluetooth connections.

The HFP AG profile interface is registered as soon as a voice capable
modem is registered in oFono.
---
 Makefile.am             |    3 +
 plugins/hfp_ag_bluez5.c |  269 +++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 272 insertions(+)
 create mode 100644 plugins/hfp_ag_bluez5.c

diff --git a/Makefile.am b/Makefile.am
index ee6d24c..ef4d314 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -439,6 +439,9 @@ builtin_sources +=3D plugins/bluez5.c plugins/bluez5.h
 =

 builtin_modules +=3D hfp_bluez5
 builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bluez5.h
+
+builtin_modules +=3D hfp_ag_bluez5
+builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bluez5.h
 endif
 endif
 endif
diff --git a/plugins/hfp_ag_bluez5.c b/plugins/hfp_ag_bluez5.c
new file mode 100644
index 0000000..59e37bc
--- /dev/null
+++ b/plugins/hfp_ag_bluez5.c
@@ -0,0 +1,269 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  Intel Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <glib.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <gdbus.h>
+
+#include "bluez5.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+#define HFP_AG_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_ag"
+
+static guint modemwatch_id;
+static GList *modems;
+static GHashTable *sim_hash =3D NULL;
+
+static DBusMessage *profile_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter entry;
+	const char *device;
+	int fd;
+	struct ofono_emulator *em;
+	struct ofono_modem *modem;
+
+	DBG("Profile handler NewConnection");
+
+	if (dbus_message_iter_init(msg, &entry) =3D=3D FALSE)
+		goto invalid;
+
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&entry, &device);
+	dbus_message_iter_next(&entry);
+
+	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&entry, &fd);
+	dbus_message_iter_next(&entry);
+
+	if (fd < 0)
+		goto invalid;
+
+	DBG("%s", device);
+
+	/* Pick the first voicecall capable modem */
+	modem =3D modems->data;
+	if (modem =3D=3D NULL) {
+		close(fd);
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".Rejected",
+						"No voice call capable modem");
+	}
+
+	DBG("Picked modem %p for emulator", modem);
+
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_HFP);
+	if (em =3D=3D NULL) {
+		close(fd);
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".Rejected",
+						"Not enough resources");
+	}
+
+	ofono_emulator_register(em, fd);
+
+	return dbus_message_new_method_return(msg);
+
+invalid:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
+}
+
+static DBusMessage *profile_release(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler Release");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+						".NotImplemented",
+						"Implementation not provided");
+}
+
+static DBusMessage *profile_cancel(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler Cancel");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static DBusMessage *profile_disconnection(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	DBG("Profile handler RequestDisconnection");
+
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".NotImplemented",
+					"Implementation not provided");
+}
+
+static const GDBusMethodTable profile_methods[] =3D {
+	{ GDBUS_ASYNC_METHOD("NewConnection",
+				GDBUS_ARGS({ "device", "o"}, { "fd", "h"},
+						{ "fd_properties", "a{sv}" }),
+				NULL, profile_new_connection) },
+	{ GDBUS_METHOD("Release", NULL, NULL, profile_release) },
+	{ GDBUS_METHOD("Cancel", NULL, NULL, profile_cancel) },
+	{ GDBUS_METHOD("RequestDisconnection",
+				GDBUS_ARGS({"device", "o"}), NULL,
+				profile_disconnection) },
+	{ }
+};
+
+static void sim_state_watch(enum ofono_sim_state new_state, void *data)
+{
+	struct ofono_modem *modem =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (new_state !=3D OFONO_SIM_STATE_READY) {
+		if (modems =3D=3D NULL)
+			return;
+
+		modems =3D g_list_remove(modems, modem);
+		if (modems !=3D NULL)
+			return;
+
+		bluetooth_unregister_profile(conn, HFP_AG_EXT_PROFILE_PATH);
+
+		return;
+	}
+
+	if (__ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_VOICECALL) =3D=3D NULL)
+		return;
+
+	modems =3D g_list_append(modems, modem);
+
+	if (modems->next !=3D NULL)
+		return;
+
+	bluetooth_register_profile(conn, HFP_AG_UUID, "hfp_ag",
+						HFP_AG_EXT_PROFILE_PATH);
+}
+
+static gboolean sim_watch_remove(gpointer key, gpointer value,
+				gpointer user_data)
+{
+	struct ofono_sim *sim =3D key;
+
+	ofono_sim_remove_state_watch(sim, GPOINTER_TO_UINT(value));
+
+	return TRUE;
+}
+
+static void sim_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_sim *sim =3D __ofono_atom_get_data(atom);
+	struct ofono_modem *modem =3D data;
+	int watch;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		sim_state_watch(OFONO_SIM_STATE_NOT_PRESENT, modem);
+
+		sim_watch_remove(sim, g_hash_table_lookup(sim_hash, sim), NULL);
+		g_hash_table_remove(sim_hash, sim);
+
+		return;
+	}
+
+	watch =3D ofono_sim_add_state_watch(sim, sim_state_watch, modem, NULL);
+	g_hash_table_insert(sim_hash, sim, GUINT_TO_POINTER(watch));
+	sim_state_watch(ofono_sim_get_state(sim), modem);
+}
+
+static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
+{
+	DBG("modem: %p, added: %d", modem, added);
+
+	if (added =3D=3D FALSE)
+		return;
+
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_SIM,
+					sim_watch, modem, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
+}
+
+static int hfp_ag_init(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	/* Registers External Profile handler */
+	if (!g_dbus_register_interface(conn, HFP_AG_EXT_PROFILE_PATH,
+					BLUEZ_PROFILE_INTERFACE,
+					profile_methods, NULL,
+					NULL, NULL, NULL)) {
+		ofono_error("Register Profile interface failed: %s",
+						HFP_AG_EXT_PROFILE_PATH);
+		return -EIO;
+	}
+
+	sim_hash =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+	return 0;
+}
+
+static void hfp_ag_exit(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	__ofono_modemwatch_remove(modemwatch_id);
+	g_dbus_unregister_interface(conn, HFP_AG_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+
+	g_list_free(modems);
+	g_hash_table_foreach_remove(sim_hash, sim_watch_remove, NULL);
+	g_hash_table_destroy(sim_hash);
+}
+
+OFONO_PLUGIN_DEFINE(hfp_ag_bluez5, "Hands-Free Audio Gateway Profile Plugi=
ns",
+				VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+				hfp_ag_init, hfp_ag_exit)
-- =

1.7.9.5


--===============0180227591662140551==--

