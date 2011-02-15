Content-Type: multipart/mixed; boundary="===============7258928407028243191=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] dun_gw: Add DUN server plugin for oFono
Date: Tue, 15 Feb 2011 16:21:03 -0300
Message-ID: <1297797663-29684-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7258928407028243191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server is probed when modem state changes to online. It registers
DUN record to Bluetooth adapter and wait for incoming DUN connection.

Based on a patch from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 Makefile.am      |    3 +
 plugins/dun_gw.c |  164 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_gw.c

diff --git a/Makefile.am b/Makefile.am
index 1d7f32b..47ebc8f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -324,6 +324,9 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
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
diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
new file mode 100644
index 0000000..2b6979a
--- /dev/null
+++ b/plugins/dun_gw.c
@@ -0,0 +1,164 @@
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
+static GList *modems;
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
+static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+{
+	struct ofono_emulator *em =3D user_data;
+	struct ofono_modem *modem;
+	int fd;
+
+	DBG("");
+
+	if (err) {
+		DBG("%s", err->message);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	/* Pick the first powered modem */
+	modem =3D modems->data;
+	DBG("Picked modem %p for emulator", modem);
+
+	em =3D ofono_emulator_create(modem, OFONO_EMULATOR_TYPE_DUN);
+	if (em =3D=3D NULL) {
+		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
+	}
+
+	fd =3D g_io_channel_unix_get_fd(io);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	ofono_emulator_register(em, fd);
+}
+
+static void gprs_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		modems =3D g_list_append(modems, modem);
+
+		if (modems->next =3D=3D NULL)
+			server =3D bluetooth_register_server(DUN_GW_CHANNEL,
+					dun_record,
+					dun_gw_connect_cb,
+					NULL);
+	} else {
+		modems =3D g_list_remove(modems, modem);
+		if (modems =3D=3D NULL &&  server !=3D NULL) {
+			bluetooth_unregister_server(server);
+			server =3D NULL;
+		}
+	}
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
+	DBG("");
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
+	__ofono_modemwatch_remove(modemwatch_id);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
-- =

1.7.4


--===============7258928407028243191==--

