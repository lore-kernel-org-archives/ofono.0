Content-Type: multipart/mixed; boundary="===============0446256104688267378=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 5/7] dun_gw: Add DUN server plugin for oFono
Date: Tue, 08 Feb 2011 20:01:02 -0200
Message-ID: <1297202464-19155-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297202464-19155-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0446256104688267378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server is probed when modem state changes to online. It registers
DUN record to Bluetooth adapter and wait for incoming DUN connection.

Based on a patch from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 Makefile.am         |    3 +
 plugins/bluetooth.h |    3 +
 plugins/dun_gw.c    |  189 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_gw.c

diff --git a/Makefile.am b/Makefile.am
index 047a85f..8a845fa 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -321,6 +321,9 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
oth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_gw
+builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 505d908..79e1a4a 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -32,6 +32,9 @@
 /* Profiles bitfield */
 #define HFP_AG 0x01
 =

+/* Server bitfield */
+#define DUN_GW 0x01
+
 struct bluetooth_profile {
 	const char *name;
 	int (*create)(const char *device, const char *dev_addr,
diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
new file mode 100644
index 0000000..32c199e
--- /dev/null
+++ b/plugins/dun_gw.c
@@ -0,0 +1,189 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
+#include "bluetooth.h"
+
+#define DUN_GW_CHANNEL	1
+
+static struct server *server;
+static guint modemwatch_id;
+static guint channel_watch;
+
+static const gchar *dun_record =3D "<?xml version=3D\"1.0\" encoding=3D\"U=
TF-8\" ?>  \
+<record>                                                                  =
     \
+  <attribute id=3D\"0x0001\">                                             =
       \
+    <sequence>                                                            =
     \
+      <uuid value=3D\"0x1103\"/>                                          =
       \
+    </sequence>                                                           =
     \
+  </attribute>                                                            =
     \
+                                                                          =
     \
+  <attribute id=3D\"0x0004\">                                             =
       \
+    <sequence>                                                            =
     \
+      <sequence>                                                          =
     \
+        <uuid value=3D\"0x0100\"/>                                        =
       \
+      </sequence>                                                         =
     \
+      <sequence>                                                          =
     \
+        <uuid value=3D\"0x0003\"/>                                        =
       \
+        <uint8 value=3D\"1\" name=3D\"channel\"/>                         =
        \
+      </sequence>                                                         =
     \
+    </sequence>                                                           =
     \
+  </attribute>                                                            =
     \
+                                                                          =
     \
+  <attribute id=3D\"0x0009\">                                             =
       \
+    <sequence>                                                            =
     \
+      <sequence>                                                          =
     \
+        <uuid value=3D\"0x1103\"/>                                        =
       \
+        <uint16 value=3D\"0x0100\" name=3D\"version\"/>                   =
         \
+      </sequence>                                                         =
     \
+    </sequence>                                                           =
     \
+  </attribute>                                                            =
     \
+                                                                          =
     \
+  <attribute id=3D\"0x0100\">                                             =
       \
+    <text value=3D\"Dial-up Networking\" name=3D\"name\"/>                =
         \
+  </attribute>                                                            =
     \
+</record>";
+
+
+static gboolean dun_gw_disconnect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	g_io_channel_unref(io);
+
+	return FALSE;
+}
+
+static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+{
+	struct ofono_emulator *emulator =3D user_data;
+	int fd;
+
+	DBG("");
+
+	if (err) {
+		DBG("%s", err->message);
+		return;
+	}
+
+	fd =3D g_io_channel_unix_get_fd(io);
+	io =3D g_io_channel_ref(io);
+
+	if (ofono_emulator_enable(emulator, fd) < 0)
+		goto failed;
+
+	channel_watch =3D g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					dun_gw_disconnect_cb, NULL);
+
+	return;
+
+failed:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
+static int dun_gw_probe(struct ofono_emulator *emulator)
+{
+	if (server)
+		return -EEXIST;
+
+	DBG("");
+
+	server =3D bluetooth_register_server(DUN_GW_CHANNEL, dun_record,
+						dun_gw_connect_cb, emulator);
+
+	return 0;
+}
+
+static void dun_gw_remove(void)
+{
+	if (server =3D=3D NULL)
+		return;
+
+	DBG("");
+
+	bluetooth_unregister_server(server);
+	server =3D NULL;
+}
+
+static void gprs_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED)
+		return;
+
+	__ofono_emulator_probe_drivers(modem);
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
+					gprs_watch, modem, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
+}
+
+static struct ofono_emulator_driver emulator_driver =3D {
+	.name =3D "Dial-Up Networking",
+	.type =3D OFONO_ATOM_TYPE_EMULATOR_DUN,
+	.probe =3D dun_gw_probe,
+	.remove =3D dun_gw_remove,
+};
+
+static int dun_gw_init(void)
+{
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+	return ofono_emulator_driver_register(&emulator_driver);
+}
+
+static void dun_gw_exit(void)
+{
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	ofono_emulator_driver_unregister(&emulator_driver);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
-- =

1.7.4


--===============0446256104688267378==--

