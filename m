Content-Type: multipart/mixed; boundary="===============4980738743516686873=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 11/16] elect: Dis/Connect Serial interface
Date: Tue, 13 Dec 2011 16:00:05 +0100
Message-ID: <1323788410-9988-12-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4980738743516686873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 elect/device.c |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/elect/device.c b/elect/device.c
index f9a01fd..b404546 100644
--- a/elect/device.c
+++ b/elect/device.c
@@ -58,7 +58,10 @@ struct elect_device {
 	gboolean active;
 	struct ipv4_settings settings;
 =

+	char *tty;
+
 	DBusPendingCall *call;
+	DBusMessage *pending;
 };
 =

 const char *__elect_device_get_path(struct elect_device *device)
@@ -187,11 +190,116 @@ static DBusMessage *device_get_properties(DBusConnec=
tion *conn,
 	return reply;
 }
 =

+static void bt_disconnect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct elect_device *device =3D user_data;
+	DBusMessage *reply;
+
+	DBG("%p", device);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	dbus_message_unref(reply);
+
+	device->call =3D NULL;
+
+	g_free(device->tty);
+	device->tty =3D NULL;
+}
+
+static int bt_disconnect(struct elect_device *device)
+{
+	DBusPendingCall *call;
+	int status;
+
+	DBG("%p", device);
+
+	if (device->tty =3D=3D NULL)
+		return 0;
+
+	status =3D bluetooth_send_with_reply(device->path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					&call, bt_disconnect_reply,
+					device, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &device->tty,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	device->call =3D call;
+
+	return -EINPROGRESS;
+}
+
+static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct elect_device *device =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+	char *tty;
+
+	DBG("%p", device);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	device->call =3D NULL;
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
+	DBG("%p tty %s", device, tty);
+
+	device->tty =3D g_strdup(tty);
+
+done:
+	dbus_message_unref(reply);
+
+	if (device->tty !=3D NULL)
+		reply =3D dbus_message_new_method_return(device->pending);
+	else
+		reply =3D __elect_error_failed(device->pending);
+
+	__ofono_dbus_pending_reply(&device->pending, reply);
+
+	device->pending =3D NULL;
+}
+
+static int bt_connect(struct elect_device *device)
+{
+	DBusPendingCall *call;
+	int status;
+	char *profile =3D "dun";
+
+	DBG("%p", device);
+
+	status =3D bluetooth_send_with_reply(device->path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					&call, bt_connect_reply,
+					device, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	device->call =3D call;
+
+	return -EINPROGRESS;
+}
+
 static DBusMessage *set_property_active(struct elect_device *device,
 					DBusMessage *msg,
 					DBusMessageIter *var)
 {
 	ofono_bool_t active;
+	int err;
 =

 	DBG("%p elect_path %s", device, device->elect_path);
 =

@@ -200,9 +308,17 @@ static DBusMessage *set_property_active(struct elect_d=
evice *device,
 =

 	dbus_message_iter_get_basic(var, &active);
 =

-	device->active =3D active;
+	if (active)
+		err =3D bt_connect(device);
+	else
+		err =3D bt_disconnect(device);
 =

-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	if (err !=3D -EINPROGRESS && err < 0)
+		return __elect_error_failed(msg);
+
+	device->pending =3D dbus_message_ref(msg);
+
+	return NULL;
 }
 =

 static DBusMessage *device_set_property(DBusConnection *conn,
@@ -419,6 +535,9 @@ static void destroy_device(gpointer user)
 {
 	struct elect_device *device =3D user;
 =

+	if (device->pending)
+		dbus_message_unref(device->pending);
+
 	if (device->call)
 		dbus_pending_call_cancel(device->call);
 =

@@ -430,6 +549,7 @@ static void destroy_device(gpointer user)
 	g_free(device->path);
 	g_free(device->address);
 	g_free(device->name);
+	g_free(device->tty);
 =

 	g_free(device);
 }
-- =

1.7.8.110.g4cb5d1


--===============4980738743516686873==--

