Content-Type: multipart/mixed; boundary="===============8094836848894567750=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/3] bluetooth: add HFP AG plugin
Date: Tue, 15 Feb 2011 16:06:31 +0100
Message-ID: <1297782393-9898-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1297782393-9898-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8094836848894567750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |    3 +
 plugins/hfp_ag.c |  171 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100644 plugins/hfp_ag.c

diff --git a/Makefile.am b/Makefile.am
index 1d7f32b..6657f4c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -324,6 +324,9 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
oth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_modules +=3D hfp_ag
+builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth.h
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
new file mode 100644
index 0000000..c43275b
--- /dev/null
+++ b/plugins/hfp_ag.c
@@ -0,0 +1,171 @@
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
+#define HFP_AG_CHANNEL	13
+
+static struct server *server;
+static guint modemwatch_id;
+static GList *modems;
+static guint channel_watch;
+
+static const gchar *hfp_ag_record =3D
+"<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>				\
+<record>								\
+  <attribute id=3D\"0x0001\">						\
+    <sequence>								\
+      <uuid value=3D\"0x111F\"/>						\
+      <uuid value=3D\"0x1203\"/>						\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=3D\"0x0004\">						\
+    <sequence>								\
+      <sequence>							\
+        <uuid value=3D\"0x0100\"/>					\
+      </sequence>							\
+      <sequence>							\
+        <uuid value=3D\"0x0003\"/>					\
+        <uint8 value=3D\"13\" name=3D\"channel\"/>				\
+      </sequence>							\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=3D\"0x0009\">						\
+    <sequence>								\
+      <sequence>							\
+        <uuid value=3D\"0x111E\"/>					\
+        <uint16 value=3D\"0x0105\" name=3D\"version\"/>			\
+      </sequence>							\
+    </sequence>								\
+  </attribute>								\
+									\
+  <attribute id=3D\"0x0100\">						\
+    <text value=3D\"Hands-Free Audio Gateway\" name=3D\"name\"/>		\
+  </attribute>								\
+									\
+  <attribute id=3D\"0x0301\">						\
+    <uint8 value=3D\"0x01\" />						\
+  </attribute>								\
+									\
+  <attribute id=3D\"0x0311\">						\
+    <uint16 value=3D\"0x0000\" />						\
+  </attribute>								\
+</record>";
+
+static gboolean hfp_ag_disconnect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	return FALSE;
+}
+
+static void hfp_ag_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
+{
+	DBG("");
+
+	if (err) {
+		DBG("%s", err->message);
+		goto failed;
+	}
+
+	channel_watch =3D g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+					hfp_ag_disconnect_cb, NULL);
+
+	return;
+
+failed:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
+static void voicecall_watch(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		modems =3D g_list_append(modems, modem);
+
+		if (modems->next =3D=3D NULL)
+			server =3D bluetooth_register_server(HFP_AG_CHANNEL,
+							hfp_ag_record,
+							hfp_ag_connect_cb,
+							NULL);
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
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_VOICECALL,
+					voicecall_watch, modem, NULL);
+}
+
+static void call_modemwatch(struct ofono_modem *modem, void *user)
+{
+	modem_watch(modem, TRUE, user);
+}
+
+static int hfp_ag_init()
+{
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
+	__ofono_modem_foreach(call_modemwatch, NULL);
+
+	return 0;
+}
+
+static void hfp_ag_exit()
+{
+	__ofono_modemwatch_remove(modemwatch_id);
+
+	if (server) {
+		bluetooth_unregister_server(server);
+		server =3D NULL;
+	}
+}
+
+OFONO_PLUGIN_DEFINE(hfp_ag, "Hands-Free Audio Gateway Profile Plugins", VE=
RSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_ag_init, hfp_ag_exit)
-- =

1.7.1


--===============8094836848894567750==--

