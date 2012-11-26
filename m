Content-Type: multipart/mixed; boundary="===============7302891643929818506=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v1 06/15] hfp_hf: Remove HandsfreeAgent and HandsfreeGateway
Date: Mon, 26 Nov 2012 10:27:00 -0300
Message-ID: <1353936429-9997-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353936429-9997-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7302891643929818506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch removes the deprecated HandsfreeAgent and HandsfreeGateway
interfaces. New connections are now being managed by a BlueZ external
Profile handler.
---
 plugins/hfp_hf.c | 215 ++-------------------------------------------------=
----
 1 file changed, 7 insertions(+), 208 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index c536691..dc00227 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -49,11 +49,6 @@
 =

 #include "bluetooth.h"
 =

-#define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
-
-#define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
-#define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
-
 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

 #ifndef DBUS_TYPE_UNIX_FD
@@ -65,11 +60,8 @@ static GHashTable *modem_hash =3D NULL;
 =

 struct hfp_data {
 	struct hfp_slc_info info;
-	char *handsfree_path;
 	char *handsfree_address;
 	DBusMessage *slc_msg;
-	gboolean agent_registered;
-	DBusPendingCall *call;
 };
 =

 static void hfp_debug(const char *str, void *user_data)
@@ -161,54 +153,6 @@ static int service_level_connection(struct ofono_modem=
 *modem, int fd)
 	return -EINPROGRESS;
 }
 =

-static DBusMessage *hfp_agent_new_connection(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	int fd, err;
-	struct ofono_modem *modem =3D data;
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-	guint16 version;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
-				DBUS_TYPE_UINT16, &version, DBUS_TYPE_INVALID))
-		return __ofono_error_invalid_args(msg);
-
-	hfp_slc_info_init(&hfp_data->info, version);
-
-	err =3D service_level_connection(modem, fd);
-	if (err < 0 && err !=3D -EINPROGRESS)
-		return __ofono_error_failed(msg);
-
-	hfp_data->slc_msg =3D msg;
-	dbus_message_ref(msg);
-
-	return NULL;
-}
-
-static DBusMessage *hfp_agent_release(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct ofono_modem *modem =3D data;
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-	const char *obj_path =3D ofono_modem_get_path(modem);
-
-	g_dbus_unregister_interface(connection, obj_path, HFP_AGENT_INTERFACE);
-	hfp_data->agent_registered =3D FALSE;
-
-	g_hash_table_remove(modem_hash, hfp_data->handsfree_path);
-	ofono_modem_remove(modem);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static const GDBusMethodTable agent_methods[] =3D {
-	{ GDBUS_ASYNC_METHOD("NewConnection",
-				GDBUS_ARGS({ "fd", "h" }, { "version", "q" }),
-				NULL, hfp_agent_new_connection) },
-	{ GDBUS_METHOD("Release", NULL, NULL, hfp_agent_release) },
-	{ }
-};
-
 static int hfp_hf_probe(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -234,10 +178,6 @@ static int hfp_hf_probe(const char *device, const char=
 *dev_addr,
 	if (data =3D=3D NULL)
 		goto free;
 =

-	data->handsfree_path =3D g_strdup(device);
-	if (data->handsfree_path =3D=3D NULL)
-		goto free;
-
 	data->handsfree_address =3D g_strdup(dev_addr);
 	if (data->handsfree_address =3D=3D NULL)
 		goto free;
@@ -251,9 +191,6 @@ static int hfp_hf_probe(const char *device, const char =
*dev_addr,
 	return 0;
 =

 free:
-	if (data !=3D NULL)
-		g_free(data->handsfree_path);
-
 	g_free(data);
 	ofono_modem_remove(modem);
 =

@@ -300,46 +237,6 @@ static void hfp_hf_set_alias(const char *device, const=
 char *alias)
 	ofono_modem_set_name(modem, alias);
 }
 =

-static int hfp_register_ofono_handsfree(struct ofono_modem *modem)
-{
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	DBG("Registering oFono Agent to bluetooth daemon");
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent");
-	if (msg =3D=3D NULL)
-		return -ENOMEM;
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
-static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
-{
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *msg;
-
-	DBG("Unregistering oFono Agent from bluetooth daemon");
-
-	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent");
-	if (msg =3D=3D NULL)
-		return -ENOMEM;
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
-				DBUS_TYPE_INVALID);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -433,19 +330,7 @@ static const GDBusMethodTable profile_methods[] =3D {
 =

 static int hfp_probe(struct ofono_modem *modem)
 {
-	const char *obj_path =3D ofono_modem_get_path(modem);
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-
-	if (data =3D=3D NULL)
-		return -EINVAL;
-
-	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
-			agent_methods, NULL, NULL, modem, NULL);
-
-	data->agent_registered =3D TRUE;
-
-	if (hfp_register_ofono_handsfree(modem) !=3D 0)
-		return -EINVAL;
+	DBG("modem: %p", modem);
 =

 	return 0;
 }
@@ -453,124 +338,38 @@ static int hfp_probe(struct ofono_modem *modem)
 static void hfp_remove(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	const char *obj_path =3D ofono_modem_get_path(modem);
-
-	if (data->call !=3D NULL)
-		dbus_pending_call_cancel(data->call);
 =

-	if (g_dbus_unregister_interface(connection, obj_path,
-					HFP_AGENT_INTERFACE))
-		hfp_unregister_ofono_handsfree(modem);
+	DBG("modem: %p", modem);
 =

 	g_free(data->handsfree_address);
-	g_free(data->handsfree_path);
 	g_free(data);
 =

 	ofono_modem_set_data(modem, NULL);
 }
 =

-static void hfp_connect_reply(DBusPendingCall *call, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusError derr;
-	DBusMessage *reply, *msg;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	if (ofono_modem_get_powered(modem))
-		goto done;
-
-	dbus_error_init(&derr);
-	if (!dbus_set_error_from_message(&derr, reply))
-		goto done;
-
-	DBG("Connect reply: %s", derr.message);
-
-	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
-		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
-				data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "Disconnect");
-		if (msg =3D=3D NULL)
-			ofono_error("Disconnect failed");
-		else
-			g_dbus_send_message(connection, msg);
-	}
-
-	ofono_modem_set_powered(modem, FALSE);
-
-	dbus_error_free(&derr);
-
-done:
-	dbus_message_unref(reply);
-	data->call =3D NULL;
-}
-
 /* power up hardware */
 static int hfp_enable(struct ofono_modem *modem)
 {
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
-
 	DBG("%p", modem);
 =

-	status =3D bluetooth_send_with_reply(data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Connect",
-					&data->call, hfp_connect_reply,
-					modem, NULL,
-					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
-
-	if (status < 0)
-		return -EINVAL;
-
-	return -EINPROGRESS;
-}
-
-static void hfp_power_down(DBusPendingCall *call, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	DBusMessage *reply;
-	DBusError derr;
-
-	reply =3D dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		DBG("Disconnect reply: %s", derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	ofono_modem_set_powered(modem, FALSE);
+	if (ofono_modem_get_powered(modem))
+		return 0;
 =

-done:
-	dbus_message_unref(reply);
-	data->call =3D NULL;
+	return -ENOTCONN;
 }
 =

 static int hfp_disable(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	int status;
 =

 	DBG("%p", modem);
 =

 	g_at_chat_unref(data->info.chat);
 	data->info.chat =3D NULL;
 =

-	if (data->agent_registered) {
-		status =3D bluetooth_send_with_reply(data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					&data->call, hfp_power_down,
-					modem, NULL,
-					DBUS_TIMEOUT, DBUS_TYPE_INVALID);
-
-		if (status < 0)
-			return -EINVAL;
-	}
+	ofono_modem_set_powered(modem, FALSE);
 =

-	return -EINPROGRESS;
+	return 0;
 }
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
-- =

1.7.11.7


--===============7302891643929818506==--

