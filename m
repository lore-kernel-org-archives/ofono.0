Content-Type: multipart/mixed; boundary="===============3969243795532544190=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/6] Add bluetooth plugin skeleton.
Date: Wed, 26 May 2010 01:51:38 -0300
Message-ID: <1274849503-18388-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3969243795532544190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The bluetooth plugin has bluetooth_resgister_uuid() and
bluetooth_unresgister_uuid() where bluetooth profiles plugins such as HFP
and DUN can register themselves to get know about BlueZ stuff ( new
devices, bluetoothd shutdown, etc..)
---
 Makefile.am         |    3 ++
 plugins/bluetooth.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h |   47 ++++++++++++++++++++++++++++++++
 plugins/hfp.c       |    8 +----
 4 files changed, 127 insertions(+), 6 deletions(-)
 create mode 100644 plugins/bluetooth.c
 create mode 100644 plugins/bluetooth.h

diff --git a/Makefile.am b/Makefile.am
index ed13346..e0083ef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,6 +231,9 @@ builtin_sources +=3D plugins/em770.c
 builtin_modules +=3D novatel
 builtin_sources +=3D plugins/novatel.c
 =

+builtin_modules +=3D bluetooth
+builtin_sources +=3D plugins/bluetooth.c
+
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c
 =

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
new file mode 100644
index 0000000..b4fe676
--- /dev/null
+++ b/plugins/bluetooth.c
@@ -0,0 +1,75 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <glib.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#include <ofono/dbus.h>
+
+#include "bluetooth.h"
+
+static DBusConnection *connection;
+static GHashTable *uuid_hash =3D NULL;
+static GHashTable *adapter_address_hash =3D NULL;
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
+{
+	if (uuid_hash)
+		goto done;
+
+	connection =3D ofono_dbus_get_connection();
+
+	uuid_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, g_free);
+
+done:
+	g_hash_table_insert(uuid_hash, g_strdup(uuid), profile);
+
+	return 0;
+}
+
+void bluetooth_unregister_uuid(const char *uuid)
+{
+	g_hash_table_remove(uuid_hash, uuid);
+
+	if (g_hash_table_size(uuid_hash))
+		return;
+
+	g_hash_table_destroy(uuid_hash);
+	g_hash_table_destroy(adapter_address_hash);
+	uuid_hash =3D NULL;
+}
+
+OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
new file mode 100644
index 0000000..99bd617
--- /dev/null
+++ b/plugins/bluetooth.h
@@ -0,0 +1,47 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+#ifndef __BLUETOOTH_H
+#define __BLUETOOTH_H
+
+#define	BLUEZ_SERVICE "org.bluez"
+#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
+#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+
+#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
+#define DUN_GW_UUID	"00001103-0000-1000-8000-00805F9B34FB"
+
+/* Profiles bitfield */
+#define HFP_AG 0x01
+#define DUN_GW 0x02
+
+struct bluetooth_profile {
+	const char *name;
+	int (*create)(const char *device, const char *dev_addr, const char *adapt=
er_addr, const char *alias);
+	void (*remove_all)();
+	void (*set_alias)(const char *device, const char *);
+};
+
+int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile);
+void bluetooth_unregister_uuid(const char *uuid);
+
+
+#endif /* __BLUETOOTH_H */
diff --git a/plugins/hfp.c b/plugins/hfp.c
index e37c9fc..a49e4af 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -45,17 +45,13 @@
 =

 #include <ofono/dbus.h>
 =

-#define	BLUEZ_SERVICE "org.bluez"
-#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
-#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
-#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#include "bluetooth.h"
+
 #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
 =

 #define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
 #define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
 =

-#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
-
 #ifndef DBUS_TYPE_UNIX_FD
 #define DBUS_TYPE_UNIX_FD -1
 #endif
-- =

1.7.1


--===============3969243795532544190==--

