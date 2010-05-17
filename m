Content-Type: multipart/mixed; boundary="===============6693215432232838706=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 6/6] Bluetooth DUN modem prototype
Date: Sun, 16 May 2010 23:11:39 -0300
Message-ID: <1274062299-4938-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274062299-4938-5-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6693215432232838706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a still dummy DUN code, now it can only creates and removes modems.
The DUN plugin follows the HFP one a lot, the is basics a copy of some
HFP plugin's parts.
---
 Makefile.am                 |    6 +
 drivers/dunmodem/dunmodem.c |   51 ++++++++++
 drivers/dunmodem/dunmodem.h |   29 ++++++
 plugins/bluetooth.c         |    5 +
 plugins/dun.c               |  214 +++++++++++++++++++++++++++++++++++++++=
++++
 5 files changed, 305 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dunmodem/dunmodem.c
 create mode 100644 drivers/dunmodem/dunmodem.h
 create mode 100644 plugins/dun.c

diff --git a/Makefile.am b/Makefile.am
index 8bb934a..fca3407 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -171,6 +171,9 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/network-registration.c \
 			drivers/hfpmodem/call-volume.c
 =

+builtin_modules +=3D dunmodem
+builtin_sources +=3D drivers/dunmodem/dunmodem.h drivers/dunmodem/dunmodem=
.c
+
 builtin_modules +=3D mbmmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
@@ -236,6 +239,9 @@ builtin_sources +=3D plugins/bluetooth.c
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c
 =

+builtin_modules +=3D dun
+builtin_sources +=3D plugins/dun.c
+
 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
 =

diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
new file mode 100644
index 0000000..8658bee
--- /dev/null
+++ b/drivers/dunmodem/dunmodem.c
@@ -0,0 +1,51 @@
+/*
+ *
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
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include "dunmodem.h"
+
+static int dunmodem_init(void)
+{
+	return 0;
+}
+
+static void dunmodem_exit(void)
+{
+}
+
+OFONO_PLUGIN_DEFINE(dunmodem, "Dial-up Networking Driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, dunmodem_init, dunmodem_exit)
+
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
new file mode 100644
index 0000000..6bbf7b9
--- /dev/null
+++ b/drivers/dunmodem/dunmodem.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
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
+#ifndef __DUN_MODEM_H__
+#define __DUN_MODEM_H__
+
+struct dun_data {
+	char *dun_path;
+};
+
+#endif
+
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 49d1b5e..6f42ac7 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -275,6 +275,11 @@ static void device_properties_cb(DBusPendingCall *call=
, gpointer user_data)
 		profile->create(path, device_addr, adapter_addr, alias);
 	}
 =

+	if ((have_uuid & DUN_GW) && device_addr && adapter_addr) {
+		profile =3D g_hash_table_lookup(uuid_hash, DUN_GW_UUID);
+		profile->create(path, device_addr, adapter_addr, alias);
+	}
+
 done:
 	dbus_message_unref(reply);
 }
diff --git a/plugins/dun.c b/plugins/dun.c
new file mode 100644
index 0000000..9c8d9ce
--- /dev/null
+++ b/plugins/dun.c
@@ -0,0 +1,214 @@
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
+#include <drivers/dunmodem/dunmodem.h>
+
+#include <ofono/dbus.h>
+
+#include "bluetooth.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+static DBusConnection *connection;
+static GHashTable *modem_hash =3D NULL;
+
+static int dun_create_modem(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct dun_data *data;
+	char buf[256];
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			device, dev_addr, adapter_addr);
+
+	strcpy(buf, "dun/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	modem =3D ofono_modem_create(buf, "dun");
+	if (modem =3D=3D NULL)
+		return -ENOMEM;
+
+	data =3D g_try_new0(struct dun_data, 1);
+	if (!data)
+		goto free;
+
+	data->dun_path =3D g_strdup(device);
+	if (data->dun_path =3D=3D NULL)
+		goto free;
+
+	ofono_modem_set_data(modem, data);
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+	return 0;
+
+free:
+	g_free(data);
+	ofono_modem_remove(modem);
+
+	return -ENOMEM;
+}
+
+static gboolean dun_remove_each_modem(gpointer key, gpointer value, gpoint=
er user_data)
+{
+	struct ofono_modem *modem =3D value;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void dun_remove_all_modem()
+{
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, dun_remove_each_modem, NULL);
+}
+
+static void dun_set_alias(const char *device, const char *alias)
+{
+	struct ofono_modem *modem;
+
+	if (!device || !alias)
+		return;
+
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (!modem)
+		return;
+
+	ofono_modem_set_name(modem, alias);
+}
+
+static int dun_probe(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+	return 0;
+}
+
+static void dun_remove(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	g_hash_table_remove(modem_hash, data->dun_path);
+
+	g_free(data->dun_path);
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
+}
+
+static int dun_enable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+	return 0;
+}
+
+static int dun_disable(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+	return 0;
+}
+
+static void dun_pre_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void dun_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver dun_driver =3D {
+	.name		=3D "dun",
+	.probe		=3D dun_probe,
+	.remove		=3D dun_remove,
+	.enable		=3D dun_enable,
+	.disable	=3D dun_disable,
+	.pre_sim	=3D dun_pre_sim,
+	.post_sim	=3D dun_post_sim,
+};
+
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun",
+	.create		=3D dun_create_modem,
+	.remove_all	=3D dun_remove_all_modem,
+	.set_alias	=3D dun_set_alias,
+};
+
+static int dun_init()
+{
+	int err;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_modem_driver_register(&dun_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&dun_driver);
+		return err;
+	}
+
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void dun_exit()
+{
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+	ofono_modem_driver_unregister(&dun_driver);
+
+	g_hash_table_destroy(modem_hash);
+}
+
+OFONO_PLUGIN_DEFINE(dun, "Dial-up Networking Profile Plugins", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_init, dun_exit)
-- =

1.7.1


--===============6693215432232838706==--

