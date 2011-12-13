Content-Type: multipart/mixed; boundary="===============1282926914106216293=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 13/16] elect: Add ppp callbacks to device
Date: Tue, 13 Dec 2011 16:00:07 +0100
Message-ID: <1323788410-9988-14-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1282926914106216293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 elect/device.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/elect/device.c b/elect/device.c
index b404546..b4cbbfc 100644
--- a/elect/device.c
+++ b/elect/device.c
@@ -59,6 +59,7 @@ struct elect_device {
 	struct ipv4_settings settings;
 =

 	char *tty;
+	struct elect_dial *dial;
 =

 	DBusPendingCall *call;
 	DBusMessage *pending;
@@ -165,6 +166,27 @@ void __elect_device_foreach(elect_device_foreach_func =
func, void *userdata)
 	}
 }
 =

+static void settings_changed(struct elect_device *device)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *key =3D "Settings";
+
+	signal =3D dbus_message_new_signal(device->elect_path,
+					ELECT_DEVICE_INTERFACE,
+					"PropertyChanged");
+
+	if (signal =3D=3D NULL)
+		return;
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
+
+	settings_append(device, &iter);
+
+	g_dbus_send_message(conn, signal);
+}
+
 static DBusMessage *device_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -230,6 +252,73 @@ static int bt_disconnect(struct elect_device *device)
 	return -EINPROGRESS;
 }
 =

+static void disconnect_cb(void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct elect_device *device =3D data;
+
+	DBG("%p", device);
+
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+
+	device->active =3D FALSE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(conn, device->elect_path,
+					ELECT_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	bt_disconnect(device);
+}
+
+static void connect_cb(const char *interface, const char *ip,
+			const char *peer, const char *dns1, const char *dns2,
+			void *data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct elect_device *device =3D data;
+	const char *dns[3] =3D { dns1, dns2, 0 };
+
+	DBG("%p", device);
+
+	g_free(device->settings.interface);
+	device->settings.interface =3D g_strdup(interface);
+	if (device->settings.interface =3D=3D NULL)
+		goto err;
+
+	g_free(device->settings.ip);
+	device->settings.ip =3D g_strdup(ip);
+	if (device->settings.ip =3D=3D NULL)
+		goto err;
+
+	g_strfreev(device->settings.nameservers);
+	device->settings.nameservers =3D g_strdupv((gchar **)dns);
+	if (device->settings.nameservers =3D=3D NULL)
+		goto err;
+
+	device->active =3D TRUE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(conn, device->elect_path,
+					ELECT_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	return;
+
+err:
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+}
+
 static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
 {
 	struct elect_device *device =3D user_data;
@@ -258,6 +347,10 @@ static void bt_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 	DBG("%p tty %s", device, tty);
 =

 	device->tty =3D g_strdup(tty);
+	if (device->tty =3D=3D NULL)
+		goto done;
+
+	__elect_dial_connect(device->dial, device->tty);
 =

 done:
 	dbus_message_unref(reply);
@@ -458,6 +551,10 @@ static int bt_probe(const char *path, const char *dev_=
addr,
 	if (device->name =3D=3D NULL)
 		goto free;
 =

+	device->dial =3D __elect_dial_create(connect_cb, disconnect_cb, device);
+	if (device->dial =3D=3D NULL)
+		goto free;
+
 	g_hash_table_insert(device_hash, g_strdup(path), device);
 =

 	register_device(device);
@@ -488,6 +585,9 @@ static gboolean bt_remove_device(gpointer key, gpointer=
 value,
 	if (device->call !=3D NULL)
 		dbus_pending_call_cancel(device->call);
 =

+	if (device->dial !=3D NULL)
+		__elect_dial_unref(device->dial);
+
 	if (prefix && g_str_has_prefix(path, prefix) =3D=3D FALSE)
 		return FALSE;
 =

@@ -541,6 +641,9 @@ static void destroy_device(gpointer user)
 	if (device->call)
 		dbus_pending_call_cancel(device->call);
 =

+	if (device->dial)
+		__elect_dial_unref(device->dial);
+
 	g_free(device->settings.interface);
 	g_free(device->settings.ip);
 	g_strfreev(device->settings.nameservers);
-- =

1.7.8.110.g4cb5d1


--===============1282926914106216293==--

