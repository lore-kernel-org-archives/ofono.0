Content-Type: multipart/mixed; boundary="===============0802407699040883351=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 2/2] dun_gw: Add BlueZ 5 version
Date: Tue, 12 Mar 2013 14:01:30 +0100
Message-ID: <1363093290-8723-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1363093290-8723-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0802407699040883351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds initial implementation of the D-Bus Profile1
interface and methods responsible for handling Bluetooth connections.

The DUN GW profile interface is registered as soon as a GPRS capable
modem is registered in oFono.
---
 Makefile.am             |    3 +
 plugins/bluez5.h        |    1 +
 plugins/dun_gw_bluez5.c |  235 +++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 239 insertions(+)
 create mode 100644 plugins/dun_gw_bluez5.c

diff --git a/Makefile.am b/Makefile.am
index bf4806b..ebe20bd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -443,6 +443,9 @@ builtin_sources +=3D plugins/hfp_hf_bluez5.c plugins/bl=
uez5.h
 =

 builtin_modules +=3D hfp_ag_bluez5
 builtin_sources +=3D plugins/hfp_ag_bluez5.c plugins/bluez5.h
+
+builtin_modules +=3D dun_gw_bluez5
+builtin_sources +=3D plugins/dun_gw_bluez5.c plugins/bluez5.h
 endif
 endif
 endif
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 573a54c..5b8c1f5 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -25,6 +25,7 @@
 #define BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device1"
 #define BLUEZ_ERROR_INTERFACE		BLUEZ_SERVICE ".Error"
 =

+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 =

diff --git a/plugins/dun_gw_bluez5.c b/plugins/dun_gw_bluez5.c
new file mode 100644
index 0000000..326ea9f
--- /dev/null
+++ b/plugins/dun_gw_bluez5.c
@@ -0,0 +1,235 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdint.h>
+#include <sys/socket.h>
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
+#define DUN_GW_VERSION_1_0		0x0100
+#define DUN_GW_CHANNEL			1
+#define DUN_GW_EXT_PROFILE_PATH		"/bluetooth/profile/dun_gw"
+
+static guint modemwatch_id;
+static GList *modems;
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
+	/* Pick the first powered modem */
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
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
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
+static void gprs_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (cond !=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		modems =3D g_list_remove(modems, modem);
+		if (modems !=3D NULL)
+			return;
+
+		bt_unregister_profile(conn, DUN_GW_EXT_PROFILE_PATH);
+
+		return;
+	}
+
+	modems =3D g_list_append(modems, modem);
+
+	if (modems->next =3D=3D NULL)
+		bt_register_profile(conn, DUN_GW_UUID, DUN_GW_VERSION_1_0,
+					"dun_gw", DUN_GW_EXT_PROFILE_PATH);
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
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_GPRS,
+						gprs_watch, modem, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
+}
+
+static int dun_gw_init(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	DBG("");
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	/* Registers External Profile handler */
+	if (!g_dbus_register_interface(conn, DUN_GW_EXT_PROFILE_PATH,
+					BLUEZ_PROFILE_INTERFACE,
+					profile_methods, NULL,
+					NULL, NULL, NULL)) {
+		ofono_error("Register Profile interface failed: %s",
+						DUN_GW_EXT_PROFILE_PATH);
+		return -EIO;
+	}
+
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+	return 0;
+}
+
+static void dun_gw_exit(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	g_list_free(modems);
+
+	bt_unregister_profile(conn, DUN_GW_EXT_PROFILE_PATH);
+	g_dbus_unregister_interface(conn, DUN_GW_EXT_PROFILE_PATH,
+						BLUEZ_PROFILE_INTERFACE);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw_bluez5, "Dial-up Networking Profile Plugins",
+				VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+				dun_gw_init, dun_gw_exit)
-- =

1.7.9.5


--===============0802407699040883351==--

