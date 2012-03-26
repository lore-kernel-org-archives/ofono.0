Content-Type: multipart/mixed; boundary="===============3602585037574607613=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [RFC v2 02/12] hfp_hf: Update to org.bluez.Telephony interface
Date: Mon, 26 Mar 2012 11:25:19 +0200
Message-ID: <1332753929-9711-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1332753929-9711-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3602585037574607613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Bluez moves agent registration from a per device interface to
a per adapter interface.
Update hfp_hf modem to reflect this change.
---
 plugins/hfp_hf.c |  165 ++++++++++++++++++++------------------------------=
---
 1 files changed, 62 insertions(+), 103 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 48a734a..7c3747b 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -51,7 +51,7 @@
 =

 #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
 =

-#define HFP_AGENT_INTERFACE "org.bluez.HandsfreeAgent"
+#define HFP_AGENT_PATH "/hfp_hf"
 #define HFP_AGENT_ERROR_INTERFACE "org.bluez.Error"
 =

 #ifndef DBUS_TYPE_UNIX_FD
@@ -66,7 +66,6 @@ struct hfp_data {
 	char *handsfree_path;
 	char *handsfree_address;
 	DBusMessage *slc_msg;
-	gboolean agent_registered;
 	DBusPendingCall *call;
 };
 =

@@ -158,52 +157,6 @@ static int service_level_connection(struct ofono_modem=
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
-	ofono_modem_remove(modem);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static GDBusMethodTable agent_methods[] =3D {
-	{ "NewConnection", "hq", "", hfp_agent_new_connection,
-		G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Release", "", "", hfp_agent_release },
-	{ NULL, NULL, NULL, NULL }
-};
-
 static int hfp_hf_probe(const char *device, const char *dev_addr,
 				const char *adapter_addr, const char *alias)
 {
@@ -295,77 +248,23 @@ static void hfp_hf_set_alias(const char *device, cons=
t char *alias)
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
 static int hfp_probe(struct ofono_modem *modem)
 {
-	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 =

 	if (data =3D=3D NULL)
 		return -EINVAL;
 =

-	g_dbus_register_interface(connection, obj_path, HFP_AGENT_INTERFACE,
-			agent_methods, NULL, NULL, modem, NULL);
-
-	data->agent_registered =3D TRUE;
-
-	if (hfp_register_ofono_handsfree(modem) !=3D 0)
-		return -EINVAL;
-
 	return 0;
 }
 =

 static void hfp_remove(struct ofono_modem *modem)
 {
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
-	const char *obj_path =3D ofono_modem_get_path(modem);
 =

 	if (data->call !=3D NULL)
 		dbus_pending_call_cancel(data->call);
 =

-	if (g_dbus_unregister_interface(connection, obj_path,
-					HFP_AGENT_INTERFACE))
-		hfp_unregister_ofono_handsfree(modem);
-
 	g_hash_table_remove(modem_hash, data->handsfree_path);
 =

 	g_free(data->handsfree_address);
@@ -465,7 +364,7 @@ static int hfp_disable(struct ofono_modem *modem)
 	g_at_chat_unref(data->info.chat);
 	data->info.chat =3D NULL;
 =

-	if (data->agent_registered) {
+	if (ofono_modem_get_powered(modem)) {
 		status =3D bluetooth_send_with_reply(data->handsfree_path,
 					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
 					&data->call, hfp_power_down,
@@ -497,6 +396,59 @@ static void hfp_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 }
 =

+static DBusMessage *hfp_agent_new_connection(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	int fd, err;
+	struct ofono_modem *modem;
+	struct hfp_data *hfp_data;
+	const char *device, *uuid;
+	const char *path =3D NULL;
+	guint16 features =3D 0;
+	guint16 version =3D 0;
+
+	fd =3D bluetooth_parse_newconnection_message(msg, &device, &uuid,
+						&version, &features, &path);
+	if (fd < 0)
+		return __ofono_error_invalid_args(msg);
+
+	DBG("New connection for %s on %s (version 0x%04X, features 0x%02X, " \
+					"media transport path: %s)",
+					device, uuid, version, features, path);
+
+	modem =3D g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL)
+		return __ofono_error_invalid_args(msg);
+
+	hfp_data =3D ofono_modem_get_data(modem);
+
+	hfp_slc_info_init(&hfp_data->info, version);
+
+	err =3D service_level_connection(modem, fd);
+	if (err < 0 && err !=3D -EINPROGRESS)
+		return __ofono_error_failed(msg);
+
+	hfp_data->slc_msg =3D msg;
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *hfp_agent_release(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBG("");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable agent_methods[] =3D {
+	{ "NewConnection", "ha{sv}", "", hfp_agent_new_connection,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Release", "", "", hfp_agent_release },
+	{ NULL, NULL, NULL, NULL }
+};
+
 static struct ofono_modem_driver hfp_driver =3D {
 	.name		=3D "hfp",
 	.modem_type	=3D OFONO_MODEM_TYPE_HFP,
@@ -517,6 +469,8 @@ static struct bluetooth_profile hfp_hf =3D {
 =

 static int hfp_init(void)
 {
+	dbus_uint16_t features =3D HFP_HF_FEATURE_3WAY | HFP_HF_FEATURE_CLIP |
+					HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
 	int err;
 =

 	if (DBUS_TYPE_UNIX_FD < 0)
@@ -537,11 +491,16 @@ static int hfp_init(void)
 	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, NULL);
 =

+	bluetooth_register_telephony_agent(HFP_AGENT_PATH, HFP_HS_UUID,
+						HFP_VERSION_1_5, features,
+						agent_methods, NULL, NULL);
+
 	return 0;
 }
 =

 static void hfp_exit(void)
 {
+	bluetooth_unregister_telephony_agent(HFP_AGENT_PATH);
 	bluetooth_unregister_uuid(HFP_AG_UUID);
 	ofono_modem_driver_unregister(&hfp_driver);
 =

-- =

1.7.1


--===============3602585037574607613==--

