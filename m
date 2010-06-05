Content-Type: multipart/mixed; boundary="===============8749782751493444649=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/5] Remove send_method_call from hfp.c
Date: Fri, 04 Jun 2010 23:40:02 -0300
Message-ID: <1275705604-8052-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275705604-8052-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8749782751493444649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

That function should be only in the bluetooth plugin, then we can avoid
code duplication. There is a plan to remove send_method_call_with_reply
too once the Bluetooth agent moves to the bluetooth plugin.
---
 plugins/hfp.c |   73 +++++++++++++++++++++++++----------------------------=
---
 1 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 01d56fa..6fd3464 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -178,33 +178,11 @@ static void cmer_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 		sevice_level_conn_established(modem);
 }
 =

-static int send_method_call(const char *dest, const char *path,
-				const char *interface, const char *method,
-				int type, ...)
-{
-	DBusMessage *msg;
-	va_list args;
-
-	msg =3D dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		ofono_error("Unable to allocate new D-Bus %s message", method);
-		return -ENOMEM;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return -EIO;
-	}
-
-	va_end(args);
-
-	g_dbus_send_message(connection, msg);
-	return 0;
-}
-
+/*
+ * FIXME: Group all agent stuff DBus calls in bluetooth.c
+ * then we can reuse common agent code for all Bluetooth plugins.
+ * That will remove this function from hfp.c
+ */
 static int send_method_call_with_reply(const char *dest, const char *path,
 				const char *interface, const char *method,
 				DBusPendingCallNotifyFunction cb,
@@ -578,26 +556,40 @@ static int hfp_register_ofono_handsfree(struct ofono_=
modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
 =

 	DBG("Registering oFono Agent to bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "RegisterAgent");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
 				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
 }
 =

 static int hfp_unregister_ofono_handsfree(struct ofono_modem *modem)
 {
 	const char *obj_path =3D ofono_modem_get_path(modem);
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
 =

 	DBG("Unregistering oFono Agent from bluetooth daemon");
 =

-	return send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent",
-				DBUS_TYPE_OBJECT_PATH, &obj_path,
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "UnregisterAgent");
+	if (!msg)
+		return -ENOMEM;
+
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &obj_path,
 				DBUS_TYPE_INVALID);
+
+	g_dbus_send_message(connection, msg);
+	return 0;
 }
 =

 static int hfp_probe(struct ofono_modem *modem)
@@ -641,8 +633,7 @@ static void hfp_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct hfp_data *data =3D ofono_modem_get_data(modem);
 	DBusError derr;
-	DBusMessage *reply;
-	int ret;
+	DBusMessage *reply, *msg;
 =

 	reply =3D dbus_pending_call_steal_reply(call);
 =

@@ -656,11 +647,13 @@ static void hfp_connect_reply(DBusPendingCall *call, =
gpointer user_data)
 	DBG("Connect reply: %s", derr.message);
 =

 	if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) {
-		ret =3D send_method_call(BLUEZ_SERVICE, data->handsfree_path,
-					BLUEZ_GATEWAY_INTERFACE, "Disconnect",
-					DBUS_TYPE_INVALID);
-		if (ret < 0)
-			ofono_error("Disconnect failed(%d)", ret);
+		msg =3D dbus_message_new_method_call(BLUEZ_SERVICE,
+				data->handsfree_path,
+				BLUEZ_GATEWAY_INTERFACE, "Disconnect");
+		if (!msg)
+			ofono_error("Disconnect failed");
+		else
+			g_dbus_send_message(connection, msg);
 	}
 =

 	ofono_modem_set_powered(modem, FALSE);
-- =

1.7.1


--===============8749782751493444649==--

