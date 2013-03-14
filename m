Content-Type: multipart/mixed; boundary="===============4512332071721539453=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v2 13/13] dundee: Handle Profile connect and disconnect
Date: Thu, 14 Mar 2013 10:32:54 -0300
Message-ID: <1363267974-13518-14-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363267974-13518-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4512332071721539453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 dundee/bluez5.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 2d10e5a..d859eae 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -41,16 +41,63 @@ struct bluetooth_device {
 	char *path;
 	char *address;
 	char *name;
+
+	struct cb_data *connect_cbd;
+
+	int fd;
 };
 =

 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	DBG("");
+	struct bluetooth_device *bt_device;
+	dundee_device_connect_cb_t cb;
+	DBusMessageIter iter;
+	const char *path;
+	int fd;
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-						".NotImplemented",
-						"Implementation not provided");
+	if (!dbus_message_iter_init(msg, &iter))
+		goto error;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto error;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	bt_device =3D g_hash_table_lookup(registered_devices, path);
+	if (bt_device =3D=3D NULL)
+		goto error;
+
+	cb =3D bt_device->connect_cbd->cb;
+
+	dbus_message_iter_next(&iter);
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_UNIX_FD)
+		goto call_failure;
+
+	dbus_message_iter_get_basic(&iter, &fd);
+	if (fd < 0)
+		goto call_failure;
+
+	DBG("%s %d", bt_device->path, fd);
+
+	bt_device->fd =3D fd;
+
+	CALLBACK_WITH_SUCCESS(cb, fd, bt_device->connect_cbd->data);
+
+	g_free(bt_device->connect_cbd);
+	bt_device->connect_cbd =3D NULL;
+
+	return dbus_message_new_method_return(msg);
+
+call_failure:
+	CALLBACK_WITH_FAILURE(cb, -1, bt_device->connect_cbd->data);
+
+	g_free(bt_device->connect_cbd);
+	bt_device->connect_cbd =3D NULL;
+
+error:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static DBusMessage *profile_release(DBusConnection *conn,
@@ -76,11 +123,31 @@ static DBusMessage *profile_cancel(DBusConnection *con=
n,
 static DBusMessage *profile_disconnection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	DBG("");
+	struct bluetooth_device *bt_device;
+	DBusMessageIter iter;
+	const char *path;
 =

-	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
-						".NotImplemented",
-						"Implementation not provided");
+	if (!dbus_message_iter_init(msg, &iter))
+		goto error;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_OBJECT_PATH)
+		goto error;
+
+	dbus_message_iter_get_basic(&iter, &path);
+
+	bt_device =3D g_hash_table_lookup(registered_devices, path);
+	if (bt_device =3D=3D NULL)
+		goto error;
+
+	DBG("%s", bt_device->path);
+
+	CALLBACK_WITH_SUCCESS(dundee_device_disconnect, bt_device->device);
+
+	return dbus_message_new_method_return(msg);
+
+error:
+	return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE ".Rejected",
+					"Invalid arguments in method call");
 }
 =

 static const GDBusMethodTable profile_methods[] =3D {
@@ -105,27 +172,55 @@ static void bluetooth_device_destroy(gpointer user_da=
ta)
 	if (bt_device->device !=3D NULL)
 		dundee_device_unregister(bt_device->device);
 =

+	if (bt_device->connect_cbd !=3D NULL)
+		g_free(bt_device->connect_cbd);
+
 	g_free(bt_device->path);
 	g_free(bt_device->address);
 	g_free(bt_device->name);
 	g_free(bt_device);
 }
 =

+static void bluetooth_device_connect_callback(gboolean success,
+							gpointer user_data)
+{
+	struct bluetooth_device *bt_device =3D user_data;
+
+	if (success) {
+		DBG("Success");
+		return;
+	}
+
+	DBG("ConnectProfile() returned an error");
+
+	g_free(bt_device->connect_cbd);
+	bt_device->connect_cbd =3D NULL;
+}
+
 static void bluetooth_device_connect(struct dundee_device *device,
 			dundee_device_connect_cb_t cb, void *data)
 {
 	struct bluetooth_device *bt_device =3D dundee_device_get_data(device);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	DBG("%s", bt_device->path);
 =

+	cbd->user =3D bt_device;
+	bt_device->connect_cbd =3D cbd;
+
 	bt_connect_profile(ofono_dbus_get_connection(), bt_device->path,
-						DUN_DT_UUID, NULL, NULL);
+		DUN_UUID, bluetooth_device_connect_callback, bt_device);
 }
 =

 static void bluetooth_device_disconnect(struct dundee_device *device,
 				dundee_device_disconnect_cb_t cb, void *data)
 {
-	DBG("");
+	struct bluetooth_device *bt_device =3D dundee_device_get_data(device);
+
+	DBG("%s", bt_device->path);
+
+	shutdown(bt_device->fd, SHUT_RDWR);
+	CALLBACK_WITH_SUCCESS(cb, data);
 }
 =

 struct dundee_device_driver bluetooth_driver =3D {
-- =

1.7.9.5


--===============4512332071721539453==--

