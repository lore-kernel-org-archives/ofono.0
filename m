Content-Type: multipart/mixed; boundary="===============2423474111420915344=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH V2 5/5] dun_gw: Add DUN server plugin for oFono
Date: Tue, 14 Sep 2010 22:44:50 +0800
Message-ID: <1284475490-32727-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284475490-32727-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2423474111420915344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server is probed when modem state changes to online. It registers
DUN record to Bluetooth adapter and wait for incoming DUN connection.
---
 Makefile.am      |    3 +
 plugins/dun_gw.c |  113 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_gw.c

diff --git a/Makefile.am b/Makefile.am
index 62cdb60..ca1988a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -255,6 +255,9 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
oth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_gw
+builtin_sources +=3D $(btio_sources) plugins/dun_gw.c plugins/bluetooth.h
+
 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
 =

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
new file mode 100644
index 0000000..4e33d75
--- /dev/null
+++ b/plugins/dun_gw.c
@@ -0,0 +1,113 @@
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
+
+static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+{
+	struct ofono_emulator *emulator =3D user_data;
+
+	DBG("");
+
+	if (err) {
+		DBG("%s", err->message);
+		goto failed;
+	}
+
+	if (ofono_emulator_enable(emulator, io) < 0)
+		goto failed;
+
+	return;
+
+failed:
+	g_io_channel_shutdown(io, TRUE, NULL);
+	ofono_emulator_remove(emulator);
+	bluetooth_unregister_server(server);
+	server =3D NULL;
+}
+
+static int dun_gw_probe(struct ofono_emulator *emulator,
+				struct ofono_modem *modem)
+{
+	struct ofono_atom *gprs;
+
+	if (server)
+		return -1;
+
+	DBG("");
+
+	gprs =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	/* Make sure the modem has GPRS atom */
+	if (!gprs)
+		return -1;
+
+	server =3D bluetooth_register_server(DUN_GW, "Dial-Up Networking",
+				DUN_GW_CHANNEL, dun_gw_connect_cb, emulator);
+}
+
+static void dun_gw_remove()
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
+static struct ofono_emulator_driver emulator_driver =3D {
+	.name =3D "Dial-Up Networking",
+	.type =3D OFONO_ATOM_TYPE_EMULATOR_DUN,
+	.probe =3D dun_gw_probe,
+	.remove =3D dun_gw_remove,
+};
+
+static int dun_gw_init()
+{
+	return ofono_emulator_driver_register(&emulator_driver);
+}
+
+static void dun_gw_exit()
+{
+	ofono_emulator_driver_unregister(&emulator_driver);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
-- =

1.7.0.4


--===============2423474111420915344==--

