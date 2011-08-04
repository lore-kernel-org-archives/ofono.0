Content-Type: multipart/mixed; boundary="===============4144614929332352071=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [RFC 2/2] dun_dt: Add baseline for dun_dt plug-in.
Date: Thu, 04 Aug 2011 18:08:27 +0200
Message-ID: <1312474107-8729-3-git-send-email-mario@tokarz.eu>
In-Reply-To: <1312474107-8729-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4144614929332352071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 Makefile.am      |    3 +
 plugins/dun_dt.c |  375 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 378 insertions(+), 0 deletions(-)
 create mode 100644 plugins/dun_dt.c

diff --git a/Makefile.am b/Makefile.am
index fbc85d4..778310b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,6 +362,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_dt
+builtin_sources +=3D plugins/dun_dt.c plugins/bluetooth.h
+
 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
 =

diff --git a/plugins/dun_dt.c b/plugins/dun_dt.c
new file mode 100644
index 0000000..ce642cf
--- /dev/null
+++ b/plugins/dun_dt.c
@@ -0,0 +1,375 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010  Gustavo Padovan <gustavo@padovan.org>
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
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs.h>
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
+struct dun_data {
+	char *dun_path;
+	char *tty;
+	GAtChat *chat;
+};
+
+static void dun_debug(const char *str, void *data)
+{
+	ofono_info("%s: %s", (const char *) data, str);
+}
+
+static int dun_probe(struct ofono_modem *modem)
+{
+	DBG("modem: %p", modem);
+
+	return 0;
+}
+
+static GAtChat* open_chat(struct dun_data *dd)
+{
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	DBG("");
+
+	io =3D g_at_tty_open(dd->tty, NULL);
+	if (io =3D=3D NULL) {
+		ofono_error("Connection failed: %s (%d)",
+				strerror(errno), errno);
+		return NULL;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(io);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, dun_debug, "DunModem:");
+
+	return chat;
+}
+
+static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *dd =3D ofono_modem_get_data(modem);
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	char *tty;
+	GAtChat *chat;
+
+	DBG("modem: %p", modem);
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Connection to bt serial returned with error: %s, %s",
+						derr.name, derr.message);
+
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &tty,
+			DBUS_TYPE_INVALID);
+
+	DBG("modem: %p, tty %s", modem, tty);
+
+	dd->tty =3D g_strdup(tty);
+
+	chat =3D open_chat(dd);
+	if (chat =3D=3D NULL)
+		goto done;
+
+	dd->chat =3D chat;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static int dun_enable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	char *profile =3D "dun";
+
+	DBG("modem: %p", modem);
+
+	bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					bt_connect_reply, modem,
+					NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+
+	return -EINPROGRESS;
+}
+
+static void bt_disconnect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *dd =3D ofono_modem_get_data(modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_free(dd->tty);
+	dd->tty =3D NULL;
+}
+
+static int dun_disable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("modem: %p", modem);
+
+	bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					bt_disconnect_reply, modem,
+					NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &data->tty,
+					DBUS_TYPE_INVALID);
+
+	return -EINPROGRESS;
+}
+
+static void dun_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t cb, void *data) {
+	DBG("modem: %p, online: %d", modem, online);
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void dun_pre_sim(struct ofono_modem *modem)
+{
+	DBG("modem: %p", modem);
+}
+
+static void dun_post_online(struct ofono_modem *modem)
+{
+	DBG("modem: %p", modem);
+}
+
+static void dun_post_sim(struct ofono_modem *modem)
+{
+	struct dun_data *dd =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+
+	DBG("%p, %s", modem, dd->tty);
+
+	ofono_netreg_create(modem, 0, "dunmodem", dd->chat);
+
+	gprs =3D ofono_gprs_create(modem, 0, "dunmodem", dd->chat);
+
+	ofono_gprs_set_cid_range(gprs, 1, 1);
+
+	gc =3D ofono_gprs_context_create(modem, 0, "dunmodem", dd->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static struct ofono_modem_driver dun_driver =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_probe,
+	.enable		=3D dun_enable,
+	.disable	=3D dun_disable,
+	.set_online	=3D dun_set_online,
+	.pre_sim	=3D dun_pre_sim,
+	.post_sim	=3D dun_post_sim,
+	.post_online	=3D dun_post_online
+};
+
+static int dun_bt_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct dun_data *data;
+	char buf[256];
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
+	DBG("modem: %p", modem);
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
+}
+
+static gboolean dun_bt_remove_modem(gpointer key, gpointer value,
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
+static void dun_bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, dun_bt_remove_modem,
+							(gpointer) prefix);
+}
+
+static void dun_bt_set_alias(const char *device, const char *alias)
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
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_bt_probe,
+	.remove		=3D dun_bt_remove,
+	.set_alias	=3D dun_bt_set_alias,
+};
+
+static int dun_init(void)
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
+static void dun_exit(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+	ofono_modem_driver_unregister(&dun_driver);
+
+	g_hash_table_destroy(modem_hash);
+}
+
+OFONO_PLUGIN_DEFINE(dun_dt, "Dial-up Networking Data Terminal Profile Plug=
ins",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			dun_init, dun_exit)
-- =

1.7.4.1


--===============4144614929332352071==--

