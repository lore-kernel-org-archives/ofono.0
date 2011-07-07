Content-Type: multipart/mixed; boundary="===============2011604597805119577=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: [RFC 3/3] dun_dt: Add baseline for dun_dt plug-in.
Date: Thu, 07 Jul 2011 10:45:23 +0200
Message-ID: <1310028323-29180-4-git-send-email-mario@tokarz.eu>
In-Reply-To: <1310028323-29180-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2011604597805119577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 Makefile.am      |    3 +
 plugins/dun_dt.c |  337 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 340 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_dt.c

diff --git a/Makefile.am b/Makefile.am
index c77a793..97698df 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -351,6 +351,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_dt
+builtin_sources +=3D plugins/dun_dt.c plugins/bluetooth.h
+
 builtin_sources +=3D $(btio_sources)
 builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
diff --git a/plugins/dun_dt.c b/plugins/dun_dt.c
new file mode 100644
index 0000000..98e2214
--- /dev/null
+++ b/plugins/dun_dt.c
@@ -0,0 +1,337 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  ProFUSION embedded systems
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <ofono/gprs.h>
+#include <ofono/gprs-context.h>
+#include <ofono/call-volume.h>
+
+#include <drivers/dunmodem/dunmodem.h>
+
+#include <ofono/dbus.h>
+
+#include "bluetooth.h"
+
+#define BLUEZ_SERIAL_INTERFACE BLUEZ_SERVICE ".Serial"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+static DBusConnection *connection;
+static GHashTable *modem_hash;
+
+static int dun_dt_bt_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct dun_data *data;
+	char buf[256];
+	char alias_buf[256];
+
+	DBG("");
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
+	modem =3D ofono_modem_create(buf, "dun_dt");
+	if (modem =3D=3D NULL) {
+		DBG("Failed to create modem");
+		return -ENOMEM;
+	}
+
+	DBG("Modem %p", modem);
+
+	data =3D g_try_new0(struct dun_data, 1);
+	if (data =3D=3D NULL)
+		goto free;
+
+	data->dun_path =3D g_strdup(device);
+	if (data->dun_path =3D=3D NULL)
+		goto free;
+
+	ofono_modem_set_data(modem, data);
+
+	strcpy(alias_buf, "DUN ");
+	strcat(alias_buf, alias);
+	ofono_modem_set_name(modem, alias_buf);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+	return 0;
+
+free:
+	g_free(data->dun_path);
+	data->dun_path =3D NULL;
+	g_free(data);
+	ofono_modem_remove(modem);
+
+	return -ENOMEM;
+
+}
+
+static gboolean dun_dt_remove_modem(gpointer key, gpointer value,
+				      gpointer user_data)
+{
+	struct ofono_modem *modem =3D value;
+	const char *device =3D key;
+	const char *prefix =3D user_data;
+
+	DBG("");
+
+	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void dun_dt_bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, dun_dt_remove_modem,
+							(gpointer) prefix);
+}
+
+static void dun_dt_bt_set_alias(const char *device, const char *alias)
+{
+	struct ofono_modem *modem;
+
+	DBG("");
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
+
+static void dun_dt_pre_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static int dun_dt_probe(struct ofono_modem *modem)
+{
+	DBG("Probe %p", modem);
+
+	return 0;
+}
+
+
+static void dun_dt_post_sim(struct ofono_modem *modem)
+{
+	struct dun_data *dd =3D ofono_modem_get_data(modem);
+
+	DBG("%p, path %s, tty %s", modem, dd->dun_path, dd->tty);
+
+	ofono_netreg_create(modem, 0, "dunmodem", dd);
+
+	dd->gprs =3D ofono_gprs_create(modem, 0, "dunmodem", dd);
+	ofono_gprs_set_cid_range(dd->gprs, 1, 16);
+
+	dd->gc =3D ofono_gprs_context_create(modem, 0, "dunmodem", dd);
+
+	ofono_gprs_add_context(dd->gprs, dd->gc);
+}
+
+static void dun_dt_post_online(struct ofono_modem *modem)
+{
+	DBG("");
+}
+
+
+static void dun_dt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	char *tty;
+
+
+	DBG("%p", modem);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Connection to bt serial returned with error: %s, %s",
+			derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &tty,
+			DBUS_TYPE_INVALID);
+
+	DBG("BT via tty %s", tty);
+
+	data->tty =3D g_strdup(tty);
+
+	ofono_modem_set_powered(modem, TRUE);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static int dun_dt_enable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	char *profile =3D "dun";
+
+	DBG("Open Bluetooth Networking");
+
+	bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					dun_dt_connect_reply, modem,
+					NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+
+	return -EINPROGRESS;
+}
+
+static void dun_dt_disconnect_reply(DBusPendingCall *call, gpointer user_d=
ata)
+{
+	struct ofono_modem *modem =3D user_data;
+
+	/* handle errors. */
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static int dun_dt_disable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("Disconnect Bluetooth Networking");
+
+	bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					dun_dt_disconnect_reply, modem,
+					NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &data->tty,
+					DBUS_TYPE_INVALID);
+
+	return -EINPROGRESS;
+}
+
+static void dun_dt_set_online(struct ofono_modem *modem, ofono_bool_t onli=
ne,
+			ofono_modem_online_cb_t cb, void *data) {
+	DBG("modem %p, online %d", modem, online);
+
+	CALLBACK_WITH_SUCCESS(cb, modem);
+}
+
+
+static struct ofono_modem_driver dun_dt_driver =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_dt_probe,
+	.enable	=3D dun_dt_enable,
+	.disable	=3D dun_dt_disable,
+	.set_online	=3D dun_dt_set_online,
+	.pre_sim	=3D dun_dt_pre_sim,
+	.post_sim	=3D dun_dt_post_sim,
+	.post_online	=3D dun_dt_post_online
+};
+
+static struct bluetooth_profile dun_dt_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_dt_bt_probe,
+	.remove	=3D dun_dt_bt_remove,
+	.set_alias	=3D dun_dt_bt_set_alias,
+};
+
+static int dun_dt_init(void)
+{
+	int err;
+
+	DBG("");
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_modem_driver_register(&dun_dt_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_dt_profile);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&dun_dt_driver);
+		return err;
+	}
+
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void dun_dt_exit(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+	ofono_modem_driver_unregister(&dun_dt_driver);
+
+	g_hash_table_destroy(modem_hash);
+}
+
+OFONO_PLUGIN_DEFINE(dun_dt, "Dial-up Networking Data Terminal Profile Plug=
ins",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			dun_dt_init, dun_dt_exit)
-- =

1.7.4.1


--===============2011604597805119577==--

