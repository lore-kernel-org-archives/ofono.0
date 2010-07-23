Content-Type: multipart/mixed; boundary="===============0832649619079588042=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/5] emulator: Add emulator atom in oFono
Date: Fri, 23 Jul 2010 17:40:34 +0800
Message-ID: <1279878034-12971-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1279878034-12971-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0832649619079588042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

DUN server could create emulator and use GAtServer to talk AT commands
to DUN client side.
---
 Makefile.am        |    4 +-
 include/emulator.h |   41 ++++++++++++++++++
 plugins/dun_gw.c   |    8 +++
 src/emulator.c     |  121 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |    3 +
 5 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 include/emulator.h
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 2e08ff2..1ec04f3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -13,7 +13,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
-			include/nettime.h
+			include/nettime.h include/emulator.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -274,7 +274,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c
+			src/nettime.c src/emulator.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..1033e59
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,41 @@
+/*
+ *
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
+#ifndef __OFONO_EMULATOR_H
+#define __OFONO_EMULATOR_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <ofono/types.h>
+
+struct ofono_emulator;
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+						enum ofono_atom_type type,
+						GIOChannel *io);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 56bd03d..840d22d 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -48,6 +48,9 @@ static int modem_watch;
 =

 static void dun_gw_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
 {
+	struct ofono_modem *modem =3D user_data;
+	struct ofono_emulator *emulator;
+
 	DBG("");
 =

 	if (err) {
@@ -55,6 +58,11 @@ static void dun_gw_connect_cb(GIOChannel *io, GError *er=
r, gpointer user_data)
 		goto failed;
 	}
 =

+	emulator =3D ofono_emulator_create(modem, OFONO_ATOM_TYPE_EMULATOR_DUN,
+						io);
+	if (!emulator)
+		goto failed;
+
 	return;
 =

 failed:
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..6219bb1
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,121 @@
+/*
+ *
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
+
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "common.h"
+#include "gatserver.h"
+
+struct ofono_emulator {
+	struct ofono_modem *modem;
+	struct ofono_atom *atom;
+	enum ofono_atom_type type;
+	unsigned int id;
+	GAtServer *server;
+};
+
+static unsigned int ofono_emulator_ids;
+
+static void ofono_emulator_debug(const char *str, void *data)
+{
+	g_print("%s: %s\n", (char *)data, str);
+}
+
+static unsigned int ofono_emulator_next_id()
+{
+	unsigned int i;
+
+	for (i =3D 1; i < sizeof(ofono_emulator_ids) * 8; i++) {
+		if (ofono_emulator_ids & (0x1 << i))
+			continue;
+
+		ofono_emulator_ids |=3D (0x1 << i);
+
+		return i;
+	}
+
+	return 0;
+}
+
+static void ofono_emulator_release_id(int id)
+{
+	ofono_emulator_ids &=3D ~(0x1 << id);
+}
+
+static void emulator_remove(struct ofono_atom *atom)
+{
+	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
+
+	DBG("");
+
+	g_at_server_shutdown(e->server);
+	g_at_server_unref(e->server);
+	e->server =3D NULL;
+
+	ofono_emulator_release_id(e->id);
+	g_free(e);
+	e =3D NULL;
+}
+
+static void emulator_disconnect(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	__ofono_atom_free(e->atom);
+}
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+						enum ofono_atom_type type,
+						GIOChannel *channel)
+{
+	struct ofono_emulator *e;
+
+	DBG("");
+
+	e =3D g_try_new0(struct ofono_emulator, 1);
+	if (!e)
+		return NULL;
+
+	e->server =3D g_at_server_new(channel);
+	if (!e->server) {
+		g_free(e);
+		return NULL;
+	}
+
+	g_at_server_set_debug(e->server, ofono_emulator_debug, "Server");
+	g_at_server_set_disconnect_function(e->server, emulator_disconnect, e);
+
+	e->modem =3D modem;
+	e->type =3D type;
+	e->id =3D ofono_emulator_next_id();
+	e->atom =3D __ofono_modem_add_atom(modem, type, emulator_remove, e);
+
+	return e;
+}
diff --git a/src/ofono.h b/src/ofono.h
index aaa01d9..8982a95 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -117,6 +117,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
 	OFONO_ATOM_TYPE_STK =3D 19,
 	OFONO_ATOM_TYPE_NETTIME =3D 20,
+	OFONO_ATOM_TYPE_EMULATOR_DUN =3D 21,
 };
 =

 enum ofono_atom_watch_condition {
@@ -289,3 +290,5 @@ void __ofono_nettime_probe_drivers(struct ofono_modem *=
modem);
 =

 void __ofono_nettime_info_received(struct ofono_modem *modem,
 					struct ofono_network_time *info);
+
+#include <ofono/emulator.h>
-- =

1.7.0.4


--===============0832649619079588042==--

