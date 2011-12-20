Content-Type: multipart/mixed; boundary="===============2173898329594566406=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 16/16] dundee: Add Bluetooth DUN driver
Date: Tue, 20 Dec 2011 15:47:19 +0100
Message-ID: <1324392439-26508-17-git-send-email-wagi@monom.org>
In-Reply-To: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2173898329594566406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am        |    6 +-
 dundee/bluetooth.c |  347 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/dundee.h    |    4 +
 dundee/main.c      |    2 +
 4 files changed, 356 insertions(+), 3 deletions(-)
 create mode 100644 dundee/bluetooth.c

diff --git a/Makefile.am b/Makefile.am
index 817fdc0..7a2b904 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -651,10 +651,10 @@ if DUNDEE
 =

 sbin_PROGRAMS +=3D dundee/dundee
 =

-dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) \
-			src/log.c src/dbus.c \
+dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) $(btio_sourc=
es) \
+			src/log.c src/dbus.c plugins/bluetooth.c \
 			dundee/main.c dundee/dbus.c dundee/manager.c \
-			dundee/device.c
+			dundee/device.c dundee/bluetooth.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
new file mode 100644
index 0000000..759b26c
--- /dev/null
+++ b/dundee/bluetooth.c
@@ -0,0 +1,347 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "plugins/bluetooth.h"
+
+#include <gattty.h>
+
+#include "dundee.h"
+
+static GHashTable *bluetooth_hash;
+
+struct bluetooth_device {
+	struct dundee_device *device;
+
+	char *path;
+	char *address;
+	char *name;
+
+	char *tty;
+
+	DBusPendingCall *call;
+};
+
+static void bt_disconnect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	dundee_device_disconnect_cb_t cb =3D cbd->cb;
+	struct bluetooth_device *bt =3D cbd->user;
+	DBusMessage *reply;
+
+	DBG("%p", bt);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	dbus_message_unref(reply);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	g_free(bt->tty);
+	bt->tty =3D NULL;
+
+	bt->call =3D NULL;
+
+	g_free(cbd);
+}
+
+static void bt_disconnect(struct dundee_device *device,
+				dundee_device_disconnect_cb_t cb, void *data)
+{
+	struct bluetooth_device *bt =3D dundee_device_get_data(device);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	int status;
+
+	DBG("%p", bt);
+
+	cbd->user =3D bt;
+
+	status =3D bluetooth_send_with_reply(bt->path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					&bt->call, bt_disconnect_reply,
+					cbd, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &bt->tty,
+					DBUS_TYPE_INVALID);
+	if (status =3D=3D 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	dundee_device_connect_cb_t cb =3D cbd->cb;
+	struct bluetooth_device *bt =3D cbd->user;
+	DBusMessage *reply;
+	DBusError derr;
+	GIOChannel *io;
+	char *tty;
+	int fd;
+
+	DBG("%p", bt);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	bt->call =3D NULL;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Connection to bt serial returned with error: %s, %s",
+						derr.name, derr.message);
+
+		dbus_error_free(&derr);
+
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &tty,
+			DBUS_TYPE_INVALID);
+
+	DBG("%p tty %s", bt, tty);
+
+	bt->tty =3D g_strdup(tty);
+	if (bt->tty =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	io =3D g_at_tty_open(tty, NULL);
+	if (io =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+		goto done;
+	}
+
+	/*
+	 * XXX Should we take a ref on io and unref it on
+	 * bt_remove?
+	 */
+	fd =3D g_io_channel_unix_get_fd(io);
+
+	CALLBACK_WITH_SUCCESS(cb, fd, cbd->data);
+
+done:
+	dbus_message_unref(reply);
+	g_free(cbd);
+}
+
+static void bt_connect(struct dundee_device *device,
+			dundee_device_connect_cb_t cb, void *data)
+{
+	struct bluetooth_device *bt =3D dundee_device_get_data(device);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *profile =3D "dun";
+	int status;
+
+	DBG("%p", bt);
+
+	cbd->user =3D bt;
+
+	status =3D bluetooth_send_with_reply(bt->path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					&bt->call, bt_connect_reply,
+					cbd, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+	if (status =3D=3D 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+struct dundee_device_driver bluetooth_driver =3D {
+	.name =3D "bluetooth",
+	.connect =3D bt_connect,
+	.disconnect =3D bt_disconnect,
+};
+
+static int bt_probe(const char *path, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct bluetooth_device *bt;
+	struct dundee_device *device;
+	char buf[256];
+
+	DBG("");
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(bluetooth_hash, path) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			path, dev_addr, adapter_addr);
+
+	strcpy(buf, "dun/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	bt =3D g_try_new0(struct bluetooth_device, 1);
+	if (bt =3D=3D NULL)
+		return -ENOMEM;
+
+	DBG("%p", bt);
+
+	device =3D dundee_device_create(&bluetooth_driver);
+	if (device =3D=3D NULL)
+		goto free;
+
+	dundee_device_set_data(device, bt);
+
+	bt->path =3D g_strdup(path);
+	if (bt->path =3D=3D NULL)
+		goto free;
+
+	bt->address =3D g_strdup(dev_addr);
+	if (bt->address =3D=3D NULL)
+		goto free;
+
+	bt->name =3D g_strdup(alias);
+	if (bt->name =3D=3D NULL)
+		goto free;
+
+	dundee_device_set_name(device, bt->name);
+
+	if (dundee_device_register(device) < 0) {
+		g_free(device);
+		goto free;
+	}
+
+	bt->device =3D device;
+	g_hash_table_insert(bluetooth_hash, g_strdup(path), bt);
+
+	return 0;
+
+free:
+	g_free(bt->path);
+	g_free(bt->address);
+	g_free(bt->name);
+	g_free(bt);
+
+	return -ENOMEM;
+}
+
+static void destroy_device(gpointer user)
+{
+	struct bluetooth_device *bt =3D user;
+
+	DBG("%p", bt);
+
+	if (bt->call !=3D NULL)
+		dbus_pending_call_cancel(bt->call);
+
+	g_free(bt->path);
+	g_free(bt->address);
+	g_free(bt->tty);
+
+	g_free(bt);
+}
+
+static gboolean bt_remove_device(gpointer key, gpointer value,
+					gpointer user_data)
+{
+	struct bluetooth_device *bt =3D value;
+	const char *path =3D key;
+	const char *prefix =3D user_data;
+
+	DBG("%p", bt);
+
+	if (prefix && g_str_has_prefix(path, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	dundee_device_unregister(bt->device);
+
+	return TRUE;
+}
+
+static void bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (bluetooth_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(bluetooth_hash, bt_remove_device,
+							(gpointer) prefix);
+}
+
+static void bt_set_alias(const char *path, const char *alias)
+{
+	struct bluetooth_device *bt;
+
+	DBG("");
+
+	if (path =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	bt =3D g_hash_table_lookup(bluetooth_hash, path);
+	if (bt =3D=3D NULL)
+		return;
+
+	g_free(bt->name);
+	bt->name =3D g_strdup(alias);
+
+	dundee_device_set_name(bt->device, bt->name);
+}
+
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D bt_probe,
+	.remove		=3D bt_remove,
+	.set_alias	=3D bt_set_alias,
+};
+
+int __dundee_bluetooth_init(void)
+{
+	int err;
+
+	DBG("");
+
+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);
+	if (err < 0)
+		return err;
+
+	bluetooth_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, destroy_device);
+
+	return 0;
+}
+
+void  __dundee_bluetooth_cleanup(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+	g_hash_table_destroy(bluetooth_hash);
+}
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 9493122..a615e7f 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -139,3 +139,7 @@ void __dundee_device_foreach(dundee_device_foreach_func=
 cb, void *userdata);
 const char *__dundee_device_get_path(struct dundee_device *device);
 void __dundee_device_append_properties(struct dundee_device *device,
 					DBusMessageIter *dict);
+
+
+int __dundee_bluetooth_init(void);
+void  __dundee_bluetooth_cleanup(void);
diff --git a/dundee/main.c b/dundee/main.c
index 07abc74..9450269 100644
--- a/dundee/main.c
+++ b/dundee/main.c
@@ -234,9 +234,11 @@ int main(int argc, char **argv)
 =

 	__dundee_manager_init();
 	__dundee_device_init();
+	__dundee_bluetooth_init();
 =

 	g_main_loop_run(event_loop);
 =

+	__dundee_bluetooth_cleanup();
 	__dundee_device_cleanup();
 	__dundee_manager_cleanup();
 =

-- =

1.7.8.110.g4cb5d1


--===============2173898329594566406==--

