Content-Type: multipart/mixed; boundary="===============3921878170899940344=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 4/9] hsp_ag: Initial plugin commit
Date: Thu, 17 Mar 2011 19:55:43 +0100
Message-ID: <1300388148-925-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1300388148-925-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3921878170899940344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am      |    3 +
 plugins/hsp_ag.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 plugins/hsp_ag.c

diff --git a/Makefile.am b/Makefile.am
index 79bf364..50e7e96 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -335,6 +335,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D hsp_ag
+builtin_sources +=3D plugins/hsp_ag.c plugins/bluetooth.h
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/hsp_ag.c b/plugins/hsp_ag.c
new file mode 100644
index 0000000..a8e6f40
--- /dev/null
+++ b/plugins/hsp_ag.c
@@ -0,0 +1,115 @@
+/*
+ *
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
+
+#include <ofono/dbus.h>
+
+#include "bluetooth.h"
+
+#define HSP_RFCOMM_CHAN 17
+
+static struct server *hsp;
+
+static const gchar *hsp_record =3D
+"<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
+"<record>\n"
+" <attribute id=3D\"0x0000\">\n"
+"  <uint32 value=3D\"0x00010006\" />\n"
+" </attribute>\n"
+" <attribute id=3D\"0x0001\">\n"
+"  <sequence>\n"
+"   <uuid value=3D\"0x1112\" />\n"
+"   <uuid value=3D\"0x1203\" />\n"
+"  </sequence>\n"
+" </attribute>\n"
+" <attribute id=3D\"0x0004\">\n"
+"  <sequence>\n"
+"   <sequence>\n"
+"    <uuid value=3D\"0x0100\" />\n"
+"   </sequence>\n"
+"   <sequence>\n"
+"    <uuid value=3D\"0x0003\" />\n"
+"    <uint8 value=3D\"17\" name=3D\"channel\" />\n"
+"   </sequence>\n"
+"  </sequence>\n"
+" </attribute>\n"
+" <attribute id=3D\"0x0005\">\n"
+"  <sequence>\n"
+"   <uuid value=3D\"0x1002\" />\n"
+"  </sequence>\n"
+" </attribute>\n"
+" <attribute id=3D\"0x0009\">\n"
+"  <sequence>\n"
+"   <sequence>\n"
+"    <uuid value=3D\"0x1108\" />\n"
+"    <uint16 value=3D\"0x0102\" />\n"
+"   </sequence>\n"
+"   </sequence>\n"
+"  </attribute>\n"
+" <attribute id=3D\"0x0100\">\n"
+"   <text value=3D\"Headset Audio Gateway\" />\n"
+" </attribute>\n"
+"</record>\n";
+
+static void connect_cb(GIOChannel *channel, GError *err, gpointer user_dat=
a)
+{
+}
+
+static int hsp_ag_init(void)
+{
+	hsp =3D bluetooth_register_server(HSP_RFCOMM_CHAN, hsp_record, connect_cb=
, NULL);
+
+	if(!hsp)
+		return -1;
+
+	DBG("HSP Gateway profile starting");
+	return 0;
+}
+
+static void hsp_ag_exit(void)
+{
+	if(hsp)
+		bluetooth_unregister_server(hsp);
+}
+
+OFONO_PLUGIN_DEFINE(hsp_ag, "Headset Gateway Profile", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, hsp_ag_init, hsp_ag_exit)
-- =

1.7.1


--===============3921878170899940344==--

