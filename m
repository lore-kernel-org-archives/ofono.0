Content-Type: multipart/mixed; boundary="===============3428250428539352856=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v3 02/23] sap: add basic SAP plugin
Date: Wed, 21 Sep 2011 16:25:18 -0300
Message-ID: <1316633118-21581-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3428250428539352856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 Makefile.am         |    3 +
 plugins/bluetooth.c |    1 -
 plugins/bluetooth.h |   12 ++
 plugins/hfp_hf.c    |    2 -
 plugins/sap.c       |  289 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/telit.c     |   10 ++
 6 files changed, 314 insertions(+), 3 deletions(-)
 create mode 100644 plugins/sap.c

diff --git a/Makefile.am b/Makefile.am
index 71962ea..8771cb2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -369,6 +369,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D sap
+builtin_sources +=3D plugins/sap.c plugins/bluetooth.h
+
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index a286dd4..274d25b 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -33,7 +33,6 @@
 #include <gdbus.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 =

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index 4056f0a..b21ab64 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -19,6 +19,9 @@
  *
  */
 =

+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+
 #define	BLUEZ_SERVICE "org.bluez"
 #define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
 #define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
@@ -30,6 +33,7 @@
 #define DUN_GW_UUID	"00001103-0000-1000-8000-00805f9b34fb"
 #define HFP_AG_UUID	"0000111f-0000-1000-8000-00805f9b34fb"
 #define HFP_HS_UUID	"0000111e-0000-1000-8000-00805f9b34fb"
+#define SAP_UUID	"0000112d-0000-1000-8000-00805f9b34fb"
 =

 struct bluetooth_profile {
 	const char *name;
@@ -39,6 +43,10 @@ struct bluetooth_profile {
 	void (*set_alias)(const char *device, const char *);
 };
 =

+struct bluetooth_sap_driver {
+	const char *name;
+};
+
 struct server;
 =

 typedef void (*ConnectFunc)(GIOChannel *io, GError *err, gpointer user_dat=
a);
@@ -60,3 +68,7 @@ int bluetooth_send_with_reply(const char *path, const cha=
r *interface,
 				void *user_data, DBusFreeFunction free_func,
 				int timeout, int type, ...);
 void bluetooth_parse_properties(DBusMessage *reply, const char *property, =
...);
+
+int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
+					struct ofono_modem *modem);
+void bluetooth_sap_client_unregister(struct ofono_modem *modem);
diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 0c6ed83..d5f26c0 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -45,8 +45,6 @@
 =

 #include <drivers/hfpmodem/slc.h>
 =

-#include <ofono/dbus.h>
-
 #include "bluetooth.h"
 =

 #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
diff --git a/plugins/sap.c b/plugins/sap.c
new file mode 100644
index 0000000..24345f5
--- /dev/null
+++ b/plugins/sap.c
@@ -0,0 +1,289 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010-2011  ProFUSION embedded systems
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include "bluetooth.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+static DBusConnection *connection;
+static GHashTable *modem_hash =3D NULL;
+static struct ofono_modem *sap_hw_modem =3D NULL;
+static struct bluetooth_sap_driver *sap_hw_driver =3D NULL;
+
+struct sap_data {
+	char *server_path;
+	struct ofono_modem *hw_modem;
+	struct bluetooth_sap_driver *sap_driver;
+};
+
+int bluetooth_sap_client_register(struct bluetooth_sap_driver *sap,
+					struct ofono_modem *modem)
+{
+	if (sap_hw_modem !=3D NULL)
+		return -EPERM;
+
+	sap_hw_modem =3D modem;
+	sap_hw_driver =3D sap;
+
+	return 0;
+}
+
+static gboolean _remove_modem(gpointer data)
+{
+	struct ofono_modem *modem =3D data;
+
+	ofono_modem_remove(modem);
+
+	return FALSE;
+}
+
+void bluetooth_sap_client_unregister(struct ofono_modem *modem)
+{
+	GHashTableIter iter;
+	gpointer key, value;
+
+	if (sap_hw_modem =3D=3D NULL || sap_hw_modem !=3D modem)
+		return;
+
+	g_hash_table_iter_init(&iter, modem_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		struct ofono_modem *sap_modem =3D value;
+		struct sap_data *data =3D ofono_modem_get_data(sap_modem);
+
+		if (sap_hw_modem !=3D data->hw_modem)
+			continue;
+
+		g_idle_add(_remove_modem, sap_modem);
+
+		break;
+	}
+
+	sap_hw_modem =3D NULL;
+	sap_hw_driver =3D NULL;
+}
+
+static int sap_probe(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static void sap_remove(struct ofono_modem *modem)
+{
+	struct sap_data *data =3D ofono_modem_get_data(modem);
+
+	g_hash_table_remove(modem_hash, data->server_path);
+
+	g_free(data->server_path);
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
+}
+
+/* power up hardware */
+static int sap_enable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static int sap_disable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static void sap_pre_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void sap_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static int bluetooth_sap_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct sap_data *data;
+	char buf[256];
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			device, dev_addr, adapter_addr);
+
+	strcpy(buf, "sap/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4,
+						sizeof(buf) - 4);
+
+	modem =3D ofono_modem_create(buf, "sap");
+	if (modem =3D=3D NULL)
+		return -ENOMEM;
+
+	data =3D g_try_new0(struct sap_data, 1);
+	if (data =3D=3D NULL)
+		goto free;
+
+	data->server_path =3D g_strdup(device);
+	if (data->server_path =3D=3D NULL)
+		goto free;
+
+	data->hw_modem =3D sap_hw_modem;
+	data->sap_driver =3D sap_hw_driver;
+
+	ofono_modem_set_data(modem, data);
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+
+	return 0;
+
+free:
+	g_free(data);
+	ofono_modem_remove(modem);
+
+	return -ENOMEM;
+}
+
+static gboolean sap_remove_modem(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct ofono_modem *modem =3D value;
+	const char *device =3D key;
+	const char *prefix =3D user_data;
+
+	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void bluetooth_sap_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, sap_remove_modem,
+							(gpointer) prefix);
+}
+
+static void bluetooth_sap_set_alias(const char *device, const char *alias)
+{
+	struct ofono_modem *modem;
+
+	if (device =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL)
+		return;
+
+	ofono_modem_set_name(modem, alias);
+}
+
+static struct ofono_modem_driver sap_driver =3D {
+	.name		=3D "sap",
+	.probe		=3D sap_probe,
+	.remove		=3D sap_remove,
+	.enable		=3D sap_enable,
+	.disable	=3D sap_disable,
+	.pre_sim	=3D sap_pre_sim,
+	.post_sim	=3D sap_post_sim,
+};
+
+static struct bluetooth_profile sap =3D {
+	.name		=3D "sap",
+	.probe		=3D bluetooth_sap_probe,
+	.remove		=3D bluetooth_sap_remove,
+	.set_alias	=3D bluetooth_sap_set_alias,
+};
+
+static int sap_init(void)
+{
+	int err;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_modem_driver_register(&sap_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_uuid(SAP_UUID, &sap);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&sap_driver);
+		return err;
+	}
+
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void sap_exit(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(SAP_UUID);
+	ofono_modem_driver_unregister(&sap_driver);
+	g_hash_table_destroy(modem_hash);
+	modem_hash =3D NULL;
+}
+
+OFONO_PLUGIN_DEFINE(sap, "Sim Access Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, sap_init, sap_exit)
diff --git a/plugins/telit.c b/plugins/telit.c
index 9c8eb0d..18cf0c4 100644
--- a/plugins/telit.c
+++ b/plugins/telit.c
@@ -54,6 +54,8 @@
 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#include "bluetooth.h"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *qss_prefix[] =3D { "#QSS:", NULL };
 =

@@ -63,6 +65,10 @@ struct telit_data {
 	guint sim_inserted_source;
 };
 =

+static struct bluetooth_sap_driver sap_driver =3D {
+	.name =3D "telit",
+};
+
 static void telit_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -82,6 +88,8 @@ static int telit_probe(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, data);
 =

+	bluetooth_sap_client_register(&sap_driver, modem);
+
 	return 0;
 }
 =

@@ -91,6 +99,8 @@ static void telit_remove(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

+	bluetooth_sap_client_unregister(modem);
+
 	ofono_modem_set_data(modem, NULL);
 =

 	if (data->sim_inserted_source > 0)
-- =

1.7.6.2


--===============3428250428539352856==--

