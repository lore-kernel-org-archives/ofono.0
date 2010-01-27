Content-Type: multipart/mixed; boundary="===============6876321596656935641=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Add HFP support through BlueZ
Date: Wed, 27 Jan 2010 17:12:49 -0200
Message-ID: <1264619569-12448-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1264619569-12448-3-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6876321596656935641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It uses BlueZ through to get HFP working following the
org.bluez.HandsfreeGateway and org.bluez.HandsfreeAgent from the BlueZ
D-Bus API.

You need the HFP suport into BlueZ and the new dbus 1.3 with fd-passing
support.

Many thanks to Zhenhua Zhang <zhenhua.zhang@intel.com> for its prototype
on this code.
---
 drivers/hfpmodem/hfpmodem.h |    4 +
 plugins/hfp.c               |  477 +++++++++++++++++++++++++++++++++++++++=
++--
 plugins/modemconf.c         |    1 -
 3 files changed, 466 insertions(+), 16 deletions(-)

diff --git a/drivers/hfpmodem/hfpmodem.h b/drivers/hfpmodem/hfpmodem.h
index 509846b..6f0ab1f 100644
--- a/drivers/hfpmodem/hfpmodem.h
+++ b/drivers/hfpmodem/hfpmodem.h
@@ -22,6 +22,7 @@
 #define __BLUETOOTH_H__
 =

 #include <drivers/atmodem/atutil.h>
+#include <ofono/dbus.h>
 =

 /* AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
 #define AG_FEATURE_3WAY 0x1
@@ -63,11 +64,14 @@ enum hfp_indicator {
 =

 struct hfp_data {
 	GAtChat *chat;
+	char *handsfree_path;
+	DBusMessage *slc_msg;
 	unsigned int ag_features;
 	unsigned int ag_mpty_features;
 	unsigned int hf_features;
 	unsigned char cind_pos[HFP_INDICATOR_LAST];
 	unsigned int cind_val[HFP_INDICATOR_LAST];
+	unsigned int at_timeout;
 };
 =

 extern void hfp_netreg_init();
diff --git a/plugins/hfp.c b/plugins/hfp.c
index 3bbd922..12b7f0a 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -30,6 +30,8 @@
 #include <glib.h>
 #include <gatchat.h>
 #include <gattty.h>
+#include <gdbus.h>
+#include <ofono.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -52,12 +54,31 @@
 =

 #include <drivers/hfpmodem/hfpmodem.h>
 =

+#include <ofono/dbus.h>
+
+#define	BLUEZ_SERVICE "org.bluez"
+#define	BLUEZ_MANAGER_INTERFACE		BLUEZ_SERVICE ".Manager"
+#define	BLUEZ_ADAPTER_INTERFACE		BLUEZ_SERVICE ".Adapter"
+#define	BLUEZ_DEVICE_INTERFACE		BLUEZ_SERVICE ".Device"
+#define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
+
+#define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
+
+#define HFP_AG_UUID	"0000111F-0000-1000-8000-00805F9B34FB"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
 static const char *brsf_prefix[] =3D { "+BRSF:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *chld_prefix[] =3D { "+CHLD:", NULL };
 =

+static DBusConnection *connection;
+
 static int hfp_disable(struct ofono_modem *modem);
+static void hfp_remove(struct ofono_modem *modem);
 =

 static void hfp_debug(const char *str, void *user_data)
 {
@@ -66,11 +87,17 @@ static void hfp_debug(const char *str, void *user_data)
 =

 static void sevice_level_conn_established(struct ofono_modem *modem)
 {
+	DBusMessage *msg;
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

-	ofono_info("Service level connection established");
 	ofono_modem_set_powered(modem, TRUE);
 =

+	msg =3D dbus_message_new_method_return(data->slc_msg);
+	g_dbus_send_message(connection, msg);
+	dbus_message_unref(data->slc_msg);
+
+	ofono_info("Service level connection established");
+
 	g_at_chat_send(data->chat, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
 }
 =

@@ -135,6 +162,60 @@ static void cmer_cb(gboolean ok, GAtResult *result, gp=
ointer user_data)
 		sevice_level_conn_established(modem);
 }
 =

+static int send_method_call(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		ofono_error("Unable to allocate new D-Bus %s message", method);
+		return -ENOMEM;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		va_end(args);
+		return -EIO;
+	}
+
+	va_end(args);
+
+	if (!cb) {
+		g_dbus_send_message(connection, msg);
+		return 0;
+	}
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		ofono_error("Sending %s failed", method);
+		dbus_message_unref(msg);
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, NULL);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return 0;
+}
+
+static gboolean hfp_enable_timeout(gpointer user)
+{
+	struct ofono_modem *modem =3D user;
+
+	if (ofono_modem_get_powered(modem))
+		return FALSE;
+
+	hfp_disable(modem);
+	return FALSE;
+}
+
 static void cind_status_cb(gboolean ok, GAtResult *result,
 				gpointer user_data)
 {
@@ -260,8 +341,7 @@ error:
 }
 =

 /* either oFono or Phone could request SLC connection */
-static int service_level_connection(struct ofono_modem *modem,
-				const char *tty)
+static int service_level_connection(struct ofono_modem *modem, int fd)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	GIOChannel *io;
@@ -269,7 +349,7 @@ static int service_level_connection(struct ofono_modem =
*modem,
 	GAtChat *chat;
 	char buf[64];
 =

-	io =3D g_at_tty_open(tty, NULL);
+	io =3D g_io_channel_unix_new(fd);
 	if (!io) {
 		ofono_error("Service level connection failed: %s (%d)",
 			strerror(errno), errno);
@@ -288,7 +368,6 @@ static int service_level_connection(struct ofono_modem =
*modem,
 		g_at_chat_set_debug(chat, hfp_debug, NULL);
 =

 	sprintf(buf, "AT+BRSF=3D%d", data->hf_features);
-
 	g_at_chat_send(chat, buf, brsf_prefix,
 				brsf_cb, modem, NULL);
 	data->chat =3D chat;
@@ -296,10 +375,52 @@ static int service_level_connection(struct ofono_mode=
m *modem,
 	return -EINPROGRESS;
 }
 =

-static int hfp_probe(struct ofono_modem *modem)
+static DBusMessage *hfp_agent_new_connection(DBusConnection *conn, DBusMes=
sage *msg, void *data)
+{
+	int fd;
+	struct ofono_modem *modem =3D data;
+	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	service_level_connection(modem, fd);
+
+	hfp_data->slc_msg =3D msg;
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *hfp_agent_release(DBusConnection *conn, DBusMessage *m=
sg, void *data)
 {
+	struct ofono_modem *modem =3D data;
+
+	if (ofono_modem_get_powered(modem))
+		hfp_disable(modem);
+
+	ofono_modem_remove(modem);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable agent_methods[] =3D {
+	{ "NewConnection", "h", "", hfp_agent_new_connection,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Release", "", "", hfp_agent_release },
+	{NULL, NULL, NULL, NULL}
+};
+
+static int hfp_create_modem(const char *device)
+{
+	struct ofono_modem *modem;
 	struct hfp_data *data;
 =

+	ofono_info("Using device: %s", device);
+
+	modem =3D ofono_modem_create(NULL, "hfp");
+
 	data =3D g_try_new0(struct hfp_data, 1);
 	if (!data)
 		return -ENOMEM;
@@ -310,14 +431,282 @@ static int hfp_probe(struct ofono_modem *modem)
 	data->hf_features |=3D HF_FEATURE_ENHANCED_CALL_STATUS;
 	data->hf_features |=3D HF_FEATURE_ENHANCED_CALL_CONTROL;
 =

+	data->handsfree_path =3D g_strdup(device);
+
 	ofono_modem_set_data(modem, data);
 =

+	ofono_modem_register(modem);
+
+	return 0;
+}
+
+static void parse_uuids(DBusMessageIter *i, const char *device)
+{
+	DBusMessageIter variant, ai;
+	const char *value;
+
+	dbus_message_iter_recurse(i, &variant);
+	dbus_message_iter_recurse(&variant, &ai);
+
+	while (dbus_message_iter_get_arg_type(&ai) !=3D DBUS_TYPE_INVALID) {
+		dbus_message_iter_get_basic(&ai, &value);
+		if (!strcasecmp(value, HFP_AG_UUID))
+			hfp_create_modem(device);
+
+		if (!dbus_message_iter_next(&ai))
+			return;
+	}
+}
+
+static void parse_get_properties(DBusMessage *reply, const char *device)
+{
+	DBusMessageIter arg, element, variant;
+	const char *key;
+
+	if (!dbus_message_iter_init(reply, &arg)) {
+		ofono_debug("GetProperties reply has no arguments.");
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(&arg) !=3D DBUS_TYPE_ARRAY) {
+		ofono_debug("GetProperties argument is not an array.");
+		return;
+	}
+
+	dbus_message_iter_recurse(&arg, &element);
+	while (dbus_message_iter_get_arg_type(&element) !=3D DBUS_TYPE_INVALID) {
+		if (dbus_message_iter_get_arg_type(&element) =3D=3D
+				DBUS_TYPE_DICT_ENTRY) {
+			DBusMessageIter dict;
+
+			dbus_message_iter_recurse(&element, &dict);
+
+			if (dbus_message_iter_get_arg_type(&dict) !=3D
+					DBUS_TYPE_STRING) {
+				ofono_debug("Property name not a string.");
+				return;
+			}
+
+			dbus_message_iter_get_basic(&dict, &key);
+
+			if (!dbus_message_iter_next(&dict))  {
+				ofono_debug("Property value missing");
+				return;
+			}
+
+			if (dbus_message_iter_get_arg_type(&dict) !=3D
+					DBUS_TYPE_VARIANT) {
+				ofono_debug("Property value not a variant.");
+				return;
+			}
+
+			if (!strcmp(key, "UUIDs"))
+				parse_uuids(&dict, device);
+
+			dbus_message_iter_recurse(&dict, &variant);
+		}
+
+		if (!dbus_message_iter_next(&element))
+			return;
+	}
+}
+
+static void get_properties_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply;
+	const char *device =3D user_data;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		ofono_debug("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	if (dbus_message_get_type(reply) =3D=3D DBUS_MESSAGE_TYPE_ERROR) {
+		if (!dbus_message_is_error(reply, DBUS_ERROR_UNKNOWN_METHOD))
+			ofono_info("Error from GetProperties reply: %s",
+					dbus_message_get_error_name(reply));
+
+		goto done;
+	}
+
+	parse_get_properties(reply, device);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void list_devices_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	const char **device =3D NULL;
+	int num, ret, i;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		ofono_debug("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	dbus_error_init(&err);
+	if (dbus_message_get_args(reply, &err, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH, &device,
+				&num, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		if (device =3D=3D NULL) {
+			dbus_error_free(&err);
+			goto done;
+		}
+
+		if (dbus_error_is_set(&err) =3D=3D TRUE) {
+			ofono_error("%s", err.message);
+			dbus_error_free(&err);
+		}
+		goto done;
+	}
+
+	for (i =3D 0 ; i < num ; i++) {
+		ret =3D send_method_call(BLUEZ_SERVICE, device[i],
+				BLUEZ_DEVICE_INTERFACE, "GetProperties",
+				get_properties_cb, (void *)device[i],
+				DBUS_TYPE_INVALID);
+		if (ret < 0)
+			ofono_error("GetProperties failed(%d)", ret);
+	}
+
+done:
+	dbus_message_unref(reply);
+}
+
+static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
+				void *user_data)
+{
+	const char *path;
+	int ret;
+
+	dbus_message_get_args(message, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID);
+
+	ret =3D send_method_call(BLUEZ_SERVICE, path,
+			BLUEZ_ADAPTER_INTERFACE, "ListDevices",
+			list_devices_cb, NULL,
+			DBUS_TYPE_INVALID);
+
+	if (ret < 0)
+		ofono_error("ListDevices failed(%d)", ret);
+
+	return TRUE;
+}
+
+static void list_adapters_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	char **adapter =3D NULL;
+	int num, ret, i;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	if (dbus_message_is_error(reply, DBUS_ERROR_SERVICE_UNKNOWN)) {
+		ofono_debug("Bluetooth daemon is apparently not available.");
+		goto done;
+	}
+
+	dbus_error_init(&err);
+	if (dbus_message_get_args(reply, &err, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH, &adapter,
+				&num, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		if (adapter =3D=3D NULL) {
+			dbus_error_free(&err);
+			goto done;
+		}
+
+		if (dbus_error_is_set(&err) =3D=3D TRUE) {
+			ofono_error("%s", err.message);
+			dbus_error_free(&err);
+		}
+		goto done;
+	}
+
+	for (i =3D 0 ; i < num ; i++) {
+		ret =3D send_method_call(BLUEZ_SERVICE, adapter[i],
+				BLUEZ_ADAPTER_INTERFACE, "ListDevices",
+				list_devices_cb, NULL,
+				DBUS_TYPE_INVALID);
+
+		if (ret < 0)
+			ofono_error("ListDevices failed(%d)", ret);
+	}
+
+	g_strfreev(adapter);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static int hfp_load_modems()
+{
+	return send_method_call(BLUEZ_SERVICE, "/",
+				BLUEZ_MANAGER_INTERFACE, "ListAdapters",
+				list_adapters_cb, NULL,
+				DBUS_TYPE_INVALID);
+}
+
+static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_debug("Registering oFono Agent to bluetooth daemon");
+
+	if (!data->handsfree_path)
+		return -EINVAL;
+
+	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
+				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
+				&obj_path, DBUS_TYPE_INVALID);
+}
+
+static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_debug("Unregistering oFono Agent from bluetooth daemon");
+
+	if (!data->handsfree_path)
+		return -EINVAL;
+
+	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
+				NULL, NULL, DBUS_TYPE_OBJECT_PATH,
+				&obj_path, DBUS_TYPE_INVALID);
+}
+
+static int hfp_probe(struct ofono_modem *modem)
+{
+	const char *obj_path =3D ofono_modem_get_path(modem);
+
+	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
+			agent_methods, NULL, NULL, modem, NULL);
+
+	if (hfp_register_ofono_handsfree(modem) !=3D 0)
+		return -EINVAL;
+
 	return 0;
 }
 =

 static void hfp_remove(struct ofono_modem *modem)
 {
-	gpointer data =3D ofono_modem_get_data(modem);
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	hfp_unregister_ofono_handsfree(modem);
+
+	if (data->handsfree_path)
+		g_free(data->handsfree_path);
 =

 	if (data)
 		g_free(data);
@@ -325,21 +714,46 @@ static void hfp_remove(struct ofono_modem *modem)
 	ofono_modem_set_data(modem, NULL);
 }
 =

+static int hfp_connect_ofono_handsfree(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	ofono_debug("Connect to bluetooth daemon");
+
+	if (!data->handsfree_path || !connection)
+		return -EINVAL;
+
+	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Connect",
+				NULL, NULL, DBUS_TYPE_INVALID);
+}
+
 /* power up hardware */
 static int hfp_enable(struct ofono_modem *modem)
 {
-	const char *tty;
-	int ret;
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	DBG("%p", modem);
 =

-	tty =3D ofono_modem_get_string(modem, "Device");
-	if (tty =3D=3D NULL)
+	data->at_timeout =3D
+		g_timeout_add_seconds(10, hfp_enable_timeout, modem);
+
+	if (hfp_connect_ofono_handsfree(modem) < 0)
 		return -EINVAL;
 =

-	ret =3D service_level_connection(modem, tty);
+	return -EINPROGRESS;
+}
+
+static int hfp_disconnect_ofono_handsfree(struct ofono_modem *modem)
+{
+	struct hfp_data *data =3D ofono_modem_get_data(modem);
+
+	if (!data->handsfree_path || !connection)
+		return -EINVAL;
 =

-	return ret;
+	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Disconnect",
+				NULL, NULL, DBUS_TYPE_INVALID);
 }
 =

 static int hfp_disable(struct ofono_modem *modem)
@@ -357,8 +771,11 @@ static int hfp_disable(struct ofono_modem *modem)
 	memset(data->cind_val, 0, sizeof(data->cind_val));
 	memset(data->cind_pos, 0, sizeof(data->cind_pos));
 =

+	g_source_remove(data->at_timeout);
+
 	ofono_modem_set_powered(modem, FALSE);
 =

+	hfp_disconnect_ofono_handsfree(modem);
 	return 0;
 }
 =

@@ -388,14 +805,44 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static guint added_watch;
+
 static int hfp_init(void)
 {
-	DBG("");
-	return ofono_modem_driver_register(&hfp_driver);
+	int err;
+
+	connection =3D ofono_dbus_get_connection();
+
+	added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_MANAGER_INTERFACE,
+						"AdapterAdded",
+						adapter_added, NULL, NULL);
+
+	if (added_watch =3D=3D 0) {
+		err =3D -EIO;
+		goto remove;
+	}
+
+	err =3D ofono_modem_driver_register(&hfp_driver);
+	if (err < 0)
+		goto remove;
+
+	hfp_load_modems();
+
+	return 0;
+
+remove:
+	g_dbus_remove_watch(connection, added_watch);
+
+	dbus_connection_unref(connection);
+
+	return err;
 }
 =

 static void hfp_exit(void)
 {
+	g_dbus_remove_watch(connection, added_watch);
+
 	ofono_modem_driver_unregister(&hfp_driver);
 }
 =

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index c8c261f..932d610 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -129,7 +129,6 @@ static struct ofono_modem *create_modem(GKeyFile *keyfi=
le, const char *group)
 =

 	if (!g_strcmp0(driver, "atgen") || !g_strcmp0(driver, "g1") ||
 						!g_strcmp0(driver, "calypso") ||
-						!g_strcmp0(driver, "hfp") ||
 						!g_strcmp0(driver, "palmpre"))
 		set_device(modem, keyfile, group);
 =

-- =

1.6.4.4


--===============6876321596656935641==--

