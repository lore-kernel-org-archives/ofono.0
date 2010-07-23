Content-Type: multipart/mixed; boundary="===============4055523959235724158=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/5] dun_gw: Add DUN server plugin for oFono
Date: Fri, 23 Jul 2010 17:40:33 +0800
Message-ID: <1279878034-12971-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1279878034-12971-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4055523959235724158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server plug-in watches ofono modem status. When the modem comes to
ONLINE state, it registers itself on Bluetooth adapter and want for
incoming DUN connection.
---
 Makefile.am      |    4 ++
 plugins/dun_gw.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 147 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_gw.c

diff --git a/Makefile.am b/Makefile.am
index e256841..2e08ff2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,6 +242,10 @@ builtin_sources +=3D plugins/bluetooth.c plugins/bluet=
ooth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_gw
+builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h plugins/btio.c \
+			plugins/btio.h
+
 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
 =

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
new file mode 100644
index 0000000..56bd03d
--- /dev/null
+++ b/plugins/dun_gw.c
@@ -0,0 +1,143 @@
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
+
+#include <ofono/dbus.h>
+
+#include "gdbus.h"
+#include "bluetooth.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+#define DUN_GW_CHANNEL	1
+
+static struct server *server;
+static int modem_watch;
+
+static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+{
+	DBG("");
+
+	if (err) {
+		DBG("%s", err->message);
+		goto failed;
+	}
+
+	return;
+
+failed:
+	g_io_channel_shutdown(io, TRUE, NULL);
+	bluetooth_unregister_server(server);
+	server =3D NULL;
+}
+
+static gboolean property_changed(DBusConnection *connection, DBusMessage *=
msg,
+					void *user_data)
+{
+	const char *property;
+	DBusMessageIter iter, var;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+
+	if (g_str_equal(property, "Online") =3D=3D TRUE) {
+		const char *path =3D dbus_message_get_path(msg);
+		struct ofono_modem *modem;
+		struct ofono_atom *gprs;
+		gboolean online;
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &var);
+
+		dbus_message_iter_get_basic(&var, &online);
+
+		if (online =3D=3D FALSE) {
+			bluetooth_unregister_server(server);
+			server =3D NULL;
+			goto done;
+		}
+
+		/* Create DUN server */
+		modem =3D ofono_modem_get_modem_by_path(path);
+		gprs =3D __ofono_modem_find_atom(modem,
+						OFONO_ATOM_TYPE_GPRS);
+		/* Make sure the modem has GPRS atom */
+		if (!gprs)
+			goto done;
+
+		server =3D bluetooth_register_server(DUN_GW,
+				"Dial-Up Networking", DUN_GW_CHANNEL,
+				dun_gw_connect_cb, modem);
+	}
+
+done:
+	return TRUE;
+}
+
+static int dun_gw_init()
+{
+	DBusConnection *connection =3D ofono_dbus_get_connection();
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	modem_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						OFONO_MODEM_INTERFACE,
+						"PropertyChanged",
+						property_changed, NULL, NULL);
+
+	return 0;
+}
+
+static void dun_gw_exit()
+{
+	if (server)
+		bluetooth_unregister_server(server);
+
+	if (modem_watch)
+		g_source_remove(modem_watch);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
-- =

1.7.0.4


--===============4055523959235724158==--

