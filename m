Content-Type: multipart/mixed; boundary="===============3261655359247735002=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 5/8] emulator: Add emulator atom in oFono
Date: Mon, 31 Jan 2011 18:51:59 -0200
Message-ID: <1296507122-10936-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296507122-10936-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3261655359247735002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Create emulator atom when modem state changes to online. The emulator
driver probes each driver to create specific emulator like DUN, HFP AG,
etc. Once get client connection request, create GAtServer to talk AT
commands with client side.

Based on a patch from Zhenhua Zhang <zhenhua.zhang@intel.com>
---
 Makefile.am        |    5 +-
 include/emulator.h |    5 +-
 src/emulator.c     |  281 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/ofono.h        |    5 +
 4 files changed, 291 insertions(+), 5 deletions(-)
 create mode 100644 src/emulator.c

diff --git a/Makefile.am b/Makefile.am
index 77b1453..1ca08e9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h include/sim-auth.h \
-			include/gprs-provision.h
+			include/gprs-provision.h include/emulator.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -363,7 +363,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
-			src/message.h src/message.c src/gprs-provision.c
+			src/message.h src/message.c src/gprs-provision.c \
+			src/emulator.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/emulator.h b/include/emulator.h
index 1287b47..bc89071 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -33,9 +33,8 @@ struct ofono_emulator;
 struct ofono_emulator_driver {
 	const char *name;
 	enum ofono_atom_type type;
-	int (*probe)(struct ofono_emulator *emulator,
-			struct ofono_modem *modem);
-	void (*remove)();
+	int (*probe)(struct ofono_emulator *emulator);
+	void (*remove)(void);
 };
 =

 int ofono_emulator_enable(struct ofono_emulator *emulator, int fd);
diff --git a/src/emulator.c b/src/emulator.c
new file mode 100644
index 0000000..aa71e21
--- /dev/null
+++ b/src/emulator.c
@@ -0,0 +1,281 @@
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
+	GAtServer *server;
+	struct ofono_emulator_driver *driver;
+};
+
+static GSList *emulator_drivers =3D NULL;
+
+static void ofono_emulator_debug(const char *str, void *data)
+{
+	g_print("%s: %s\n", (char *)data, str);
+}
+
+void ofono_emulator_remove(struct ofono_emulator *emulator)
+{
+	if (emulator =3D=3D NULL)
+		return;
+
+	__ofono_atom_free(emulator->atom);
+}
+
+static void ppp_connect(const char *iface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Remote IP Address: %s\n", remote);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	DBG("");
+
+	g_at_ppp_unref(e->ppp);
+	e->ppp =3D NULL;
+
+	if (e->server =3D=3D NULL)
+		return;
+
+	g_at_server_resume(e->server);
+
+	g_at_server_send_final(e->server, G_AT_SERVER_RESULT_NO_CARRIER);
+}
+
+static gboolean setup_ppp(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtIO *io;
+
+	DBG("");
+
+	io =3D g_at_server_get_io(server);
+
+	g_at_server_suspend(server);
+
+	e->ppp =3D g_at_ppp_server_new_from_io(io, DUN_SERVER_ADDRESS);
+	if (e->ppp =3D=3D NULL) {
+		g_at_server_resume(server);
+		return FALSE;
+	}
+
+	g_at_ppp_set_server_info(e->ppp, DUN_PEER_ADDRESS,
+					DUN_DNS_SERVER_1, DUN_DNS_SERVER_2);
+
+	g_at_ppp_set_credentials(e->ppp, "", "");
+	g_at_ppp_set_debug(e->ppp, ofono_emulator_debug, "PPP");
+
+	g_at_ppp_set_connect_function(e->ppp, ppp_connect, e);
+	g_at_ppp_set_disconnect_function(e->ppp, ppp_disconnect, e);
+
+	return FALSE;
+}
+
+static gboolean dial_call(struct ofono_emulator *e, const char *dial_str)
+{
+	char c =3D *dial_str;
+
+	DBG("dial call %s", dial_str);
+
+	if (c =3D=3D '*' || c =3D=3D '#' || c =3D=3D 'T' || c =3D=3D 't') {
+
+		g_at_server_send_intermediate(e->server, "CONNECT");
+		g_idle_add(setup_ppp, e);
+	}
+
+	return TRUE;
+}
+
+static void dial_cb(GAtServerRequestType type, GAtResult *result,
+					gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+	GAtServer *server =3D e->server;
+	GAtResultIter iter;
+	const char *dial_str;
+
+	DBG("");
+
+	if (type !=3D G_AT_SERVER_REQUEST_TYPE_SET)
+		goto error;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "D"))
+		goto error;
+
+	dial_str =3D g_at_result_iter_raw_line(&iter);
+	if (!dial_str)
+		goto error;
+
+	if (e->ppp)
+		goto error;
+
+	if (!dial_call(e, dial_str))
+		goto error;
+
+	return;
+
+error:
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+}
+
+void ofono_emulator_disable(struct ofono_emulator *e)
+{
+	DBG("");
+
+	g_at_server_shutdown(e->server);
+	g_at_server_unref(e->server);
+	e->server =3D NULL;
+}
+
+static void emulator_disconnect_cb(gpointer user_data)
+{
+	struct ofono_emulator *e =3D user_data;
+
+	if (e =3D=3D NULL)
+		return;
+
+	ofono_emulator_disable(e);
+}
+
+int ofono_emulator_enable(struct ofono_emulator *e, int fd)
+{
+	GIOChannel *io;
+
+	if (fd < 0)
+		return -EIO;
+
+	io =3D g_io_channel_unix_new(fd);
+
+	e->server =3D g_at_server_new(io);
+	if (!e->server) {
+		g_free(e);
+		return -ENOMEM;
+	}
+
+	g_at_server_set_debug(e->server, ofono_emulator_debug, "Server");
+	g_at_server_set_disconnect_function(e->server,
+						emulator_disconnect_cb, e);
+
+	return 0;
+}
+
+static void emulator_remove(struct ofono_atom *atom)
+{
+	struct ofono_emulator *e =3D  __ofono_atom_get_data(atom);
+
+	DBG("");
+
+	if (e->server)
+		ofono_emulator_disable(e);
+
+	if (e->driver->remove)
+		e->driver->remove();
+
+	g_free(e);
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
+	if (driver->probe(e) < 0) {
+		g_free(e);
+		return NULL;
+	}
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
diff --git a/src/ofono.h b/src/ofono.h
index 6ba0187..64d13e7 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -128,6 +128,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_CTM,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
 	OFONO_ATOM_TYPE_SIM_AUTH,
+	OFONO_ATOM_TYPE_EMULATOR_DUN,
 };
 =

 enum ofono_atom_watch_condition {
@@ -430,3 +431,7 @@ ofono_bool_t __ofono_gprs_provision_get_settings(const =
char *mcc,
 void __ofono_gprs_provision_free_settings(
 				struct ofono_gprs_provision_data *settings,
 				int count);
+
+#include <ofono/emulator.h>
+
+void __ofono_emulator_probe_drivers(struct ofono_modem *modem);
-- =

1.7.4.rc3


--===============3261655359247735002==--

