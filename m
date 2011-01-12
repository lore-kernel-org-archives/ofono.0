Content-Type: multipart/mixed; boundary="===============2085908841482075432=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@intel.com>
Subject: [PATCH 04/21] emulator: Add emulator atom in oFono
Date: Wed, 12 Jan 2011 18:15:47 +0100
Message-ID: <1294852564-1258-5-git-send-email-frederic.dalleau@intel.com>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2085908841482075432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Zhenhua Zhang <zhenhua.zhang@intel.com>

Create emulator atom when modem state changes to online. The emulator
driver probes each driver to create specific emulator like DUN, HFP AG,
etc. Once get client connection request, create GAtServer to talk AT
commands with client side.
---
 Makefile.am        |    4 +-
 include/emulator.h |   54 +++++++++++++++
 src/emulator.c     |  189 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c        |    1 +
 src/ofono.h        |    5 ++
 5 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100644 include/emulator.h
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 2a9f340..5dcf253 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
-			include/cdma-sms.h
+			include/cdma-sms.h include/emulator.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -342,7 +342,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/emulator.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ \
 			@BLUEZ_LIBS@ -ldl
diff --git a/include/emulator.h b/include/emulator.h
new file mode 100644
index 0000000..2691928
--- /dev/null
+++ b/include/emulator.h
@@ -0,0 +1,54 @@
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
+struct ofono_emulator_driver {
+	const char *name;
+	enum ofono_atom_type type;
+	int (*probe)(struct ofono_emulator *emulator,
+			struct ofono_modem *modem);
+	void (*remove)();
+};
+
+int ofono_emulator_enable(struct ofono_emulator *emulator, GIOChannel *cha=
nnel);
+void ofono_emulator_remove(gpointer user_data);
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver);
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver);
+void ofono_emulator_driver_unregister(
+				const struct ofono_emulator_driver *driver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_EMULATOR_H */
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..1ede79a
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,189 @@
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
+	unsigned int id;
+	GAtServer *server;
+	struct ofono_emulator_driver *driver;
+};
+
+static GSList *emulator_drivers =3D NULL;
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
+void ofono_emulator_remove(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	if (e =3D=3D NULL)
+		return;
+
+	__ofono_atom_free(e->atom);
+}
+
+static void ofono_emulator_release_id(int id)
+{
+	ofono_emulator_ids &=3D ~(0x1 << id);
+}
+
+int ofono_emulator_enable(struct ofono_emulator *e, GIOChannel *channel)
+{
+	if (channel =3D=3D NULL)
+		return -1;
+
+	e->server =3D g_at_server_new(channel);
+	if (!e->server) {
+		g_free(e);
+		return -1;
+	}
+
+	g_at_server_set_debug(e->server, ofono_emulator_debug, "Server");
+	g_at_server_set_disconnect_function(e->server, ofono_emulator_remove,
+						e);
+
+	return 0;
+}
+
+static void emulator_disable(struct ofono_emulator *e)
+{
+	DBG("");
+
+	g_at_server_shutdown(e->server);
+	g_at_server_unref(e->server);
+	e->server =3D NULL;
+}
+
+static void emulator_remove(struct ofono_atom *atom)
+{
+	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
+
+	DBG("");
+
+	if (e->server)
+		emulator_disable(e);
+
+	ofono_emulator_release_id(e->id);
+
+	if (e->driver->remove)
+		e->driver->remove();
+
+	g_free(e);
+	e =3D NULL;
+}
+
+struct ofono_emulator *ofono_emulator_create(struct ofono_modem *modem,
+					struct ofono_emulator_driver *driver)
+{
+	struct ofono_emulator *e;
+
+	DBG("");
+
+	if (driver->probe =3D=3D NULL)
+		return NULL;
+
+	e =3D g_try_new0(struct ofono_emulator, 1);
+	if (!e)
+		return NULL;
+
+	e->modem =3D modem;
+	e->driver =3D driver;
+
+	if (driver->probe(e, modem) < 0) {
+		g_free(e);
+		return NULL;
+	}
+
+	e->id =3D ofono_emulator_next_id();
+
+	return e;
+}
+
+void __ofono_emulator_probe_drivers(struct ofono_modem *modem)
+{
+	struct ofono_emulator_driver *driver;
+	GSList *l;
+
+	for (l =3D emulator_drivers; l; l =3D l->next) {
+		struct ofono_emulator *e;
+
+		driver =3D l->data;
+
+		e =3D ofono_emulator_create(modem, driver);
+		if (!e)
+			continue;
+
+		e->atom =3D __ofono_modem_add_atom(modem, driver->type,
+							emulator_remove, e);
+	}
+}
+
+int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	emulator_drivers =3D g_slist_prepend(emulator_drivers, (void *)driver);
+
+	return 0;
+}
+
+void ofono_emulator_driver_unregister(
+				const struct ofono_emulator_driver *driver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	emulator_drivers =3D g_slist_remove(emulator_drivers, driver);
+}
diff --git a/src/modem.c b/src/modem.c
index 953d6c3..f117e5e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -434,6 +434,7 @@ static void modem_change_state(struct ofono_modem *mode=
m,
 			driver->post_online(modem);
 =

 		notify_online_watches(modem);
+		__ofono_emulator_probe_drivers(modem);
 		break;
 	}
 }
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..64ea625 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_EMULATOR_DUN =3D 24,
 };
 =

 enum ofono_atom_watch_condition {
@@ -418,3 +419,7 @@ void __ofono_nettime_info_received(struct ofono_modem *=
modem,
 					struct ofono_network_time *info);
 =

 #include <ofono/cdma-voicecall.h>
+
+#include <ofono/emulator.h>
+
+void __ofono_emulator_probe_drivers(struct ofono_modem *modem);
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2085908841482075432==--

