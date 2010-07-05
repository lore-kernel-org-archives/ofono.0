Content-Type: multipart/mixed; boundary="===============8997700568554263955=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/6] dun_gw: Add DUN emulator plugin
Date: Mon, 05 Jul 2010 13:45:06 +0800
Message-ID: <1278308709-13908-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8997700568554263955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It implements DUN server role and register itself as agent to BlueZ
interface.
---
 Makefile.am      |    3 +
 plugins/dun_gw.c |  274 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 277 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_gw.c

diff --git a/Makefile.am b/Makefile.am
index 8ecb2d9..908e945 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -244,6 +244,9 @@ builtin_sources +=3D plugins/bluetooth.c plugins/blueto=
oth.h
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_gw
+builtin_sources +=3D plugins/dun_gw.c
+
 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
 =

diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
new file mode 100644
index 0000000..95b176c
--- /dev/null
+++ b/plugins/dun_gw.c
@@ -0,0 +1,274 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 Gustavo F. Padovan <gustavo@padovan.org>
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
+#define	BLUEZ_DUN_INTERFACE	BLUEZ_SERVICE ".SerialDUN"
+#define DUN_AGENT_INTERFACE	"org.bluez.DUNAgent"
+
+static DBusConnection *connection;
+static GHashTable *adapter_hash;
+
+struct dun_data {
+	char *adapter;
+	char *path;
+	gboolean agent_registered;
+	struct ofono_emulator *e;
+};
+
+static struct ofono_emulator_driver dun_gw_driver;
+
+static int dun_gw_create_adapter(const char *path, const char *dev_addr,
+				const char *adapter, const char *alias)
+{
+	GSList *l;
+	struct dun_data *data;
+
+	/* Ignore if we already have this adapter */
+	l =3D g_hash_table_lookup(adapter_hash, (char *)adapter);
+	if (l !=3D NULL)
+		return -EALREADY;
+
+	DBG("Adding adapter: %s", adapter);
+
+	data =3D g_try_new0(struct dun_data, 1);
+	if (!data)
+		return -ENOMEM;
+
+	data->adapter =3D g_strdup(adapter);
+	data->path =3D g_strdup(path);
+	data->agent_registered =3D FALSE;
+
+	g_hash_table_insert(adapter_hash, g_strdup(adapter), data);
+
+	return 0;
+}
+
+static gboolean remove_adapter(gpointer key, gpointer value, gpointer user=
_data)
+{
+	struct dun_data *data =3D value;
+
+	if (data) {
+		g_free(data->adapter);
+		g_free(data->path);
+		g_free(data);
+		data =3D NULL;
+	}
+
+	return TRUE;
+}
+
+static void dun_gw_remove_all_adapter()
+{
+	if (adapter_hash =3D=3D NULL)
+		return;
+
+	DBG("");
+
+	g_hash_table_foreach_remove(adapter_hash, remove_adapter, NULL);
+}
+
+static DBusMessage *dun_agent_new_connection(DBusConnection *conn,
+						DBusMessage *msg,
+						void *user_data)
+{
+	DBusMessage *reply;
+	int fd;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID)) {
+		reply =3D g_dbus_create_error(msg, DUN_AGENT_INTERFACE, ".Failed",
+						"Invalid File Descriptor");
+		goto error;
+	}
+
+	return dbus_message_new_method_return(msg);
+
+error:
+	return reply;
+}
+
+static DBusMessage *dun_agent_release(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct dun_data *data =3D user_data;
+	struct ofono_emulator *e =3D data->e;
+	const char *obj_path =3D ofono_emulator_get_path(e);
+
+	g_dbus_unregister_interface(connection, obj_path, DUN_AGENT_INTERFACE);
+	data->agent_registered =3D FALSE;
+
+	ofono_emulator_remove(e);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable agent_methods[] =3D {
+	{ "NewConnection", "h", "", dun_agent_new_connection,
+					G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Release", "", "", dun_agent_release },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static int dun_gw_probe(struct ofono_emulator *e)
+{
+	char *adapter =3D NULL;
+	struct dun_data *data =3D NULL;
+	const char *obj_path =3D ofono_emulator_get_path(e);
+	GHashTableIter hash_iter;
+	gpointer key, value;
+
+	DBG("%p", e);
+
+	if (g_hash_table_size(adapter_hash) =3D=3D 0) {
+		DBG("No Bluetooth adapater found in system");
+		return -EINVAL;
+	}
+
+	g_hash_table_iter_init(&hash_iter, adapter_hash);
+	while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
+		adapter =3D key;
+		data =3D value;
+
+		/* Find the adapter that has no DUN GW register yet */
+		if (data->agent_registered =3D=3D FALSE)
+			break;
+	}
+
+	if (!adapter || !data)
+		return -EINVAL;
+
+	/* Register dbus interface */
+	g_dbus_register_interface(connection, obj_path, DUN_AGENT_INTERFACE,
+			agent_methods, NULL, NULL, data, NULL);
+
+	data->e =3D e;
+	ofono_emulator_set_data(e, data);
+
+	return 0;
+}
+
+static void dun_gw_remove(struct ofono_emulator *e)
+{
+	struct dun_data *data =3D ofono_emulator_get_data(e);
+	const char *obj_path =3D ofono_emulator_get_path(e);
+
+	DBG("%p", e);
+
+	if (!data)
+		return;
+
+	g_dbus_unregister_interface(connection, obj_path, DUN_AGENT_INTERFACE);
+
+	g_hash_table_remove(adapter_hash, data->adapter);
+	remove_adapter(data->adapter, data, NULL);
+
+	ofono_emulator_set_data(e, NULL);
+
+	return;
+}
+
+static int dun_gw_enable(struct ofono_emulator *e, int fd)
+{
+	DBG("%p", e);
+
+	return 0;
+}
+
+static int dun_gw_disable(struct ofono_emulator *e)
+{
+	DBG("%p", e);
+
+	return 0;
+}
+
+static struct ofono_emulator_driver dun_gw_driver =3D {
+	.name		=3D "dun_gw",
+	.type		=3D OFONO_EMULATOR_TYPE_DUN,
+	.probe		=3D dun_gw_probe,
+	.remove		=3D dun_gw_remove,
+	.enable		=3D dun_gw_enable,
+	.disable	=3D dun_gw_disable,
+};
+
+static struct bluetooth_profile dun_gw_profile =3D {
+	.name		=3D "dun_gw",
+	.create		=3D dun_gw_create_adapter,
+	.remove_all	=3D dun_gw_remove_all_adapter,
+	.set_alias	=3D NULL,
+};
+
+static int dun_gw_init()
+{
+	int err;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_emulator_driver_register(&dun_gw_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_service(DUN_GATEWAY, &dun_gw_profile);
+	if (err < 0) {
+		ofono_emulator_driver_unregister(&dun_gw_driver);
+		return err;
+	}
+
+	adapter_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void dun_gw_exit()
+{
+	bluetooth_unregister_service(DUN_GATEWAY);
+	ofono_emulator_driver_unregister(&dun_gw_driver);
+	dun_gw_remove_all_adapter();
+	g_hash_table_destroy(adapter_hash);
+}
+
+OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
-- =

1.6.3.3


--===============8997700568554263955==--

