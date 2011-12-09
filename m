Content-Type: multipart/mixed; boundary="===============4233304297950321462=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v2 08/11] elect: Add ppp callbacks to device
Date: Fri, 09 Dec 2011 17:35:43 +0100
Message-ID: <1323448546-2728-9-git-send-email-wagi@monom.org>
In-Reply-To: <1323448546-2728-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4233304297950321462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am    |    2 +-
 elect/device.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/elect.h  |   15 +++++++++
 3 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 045ea2e..3e36d4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,7 +653,7 @@ sbin_PROGRAMS +=3D elect/electd
 =

 elect_electd_SOURCES =3D $(gdbus_sources) $(btio_sources) \
 			src/log.c src/dbus.c plugins/bluetooth.c \
-			elect/main.c elect/manager.c elect/device.c
+			elect/main.c elect/manager.c elect/device.c elect/dun.c
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
 =

diff --git a/elect/device.c b/elect/device.c
index 13f2c70..e804eac 100644
--- a/elect/device.c
+++ b/elect/device.c
@@ -61,6 +61,7 @@ struct elect_device {
 	struct ipv4_settings settings;
 =

 	char *tty;
+	struct elect_dun *dun;
 =

 	DBusPendingCall *call;
 	DBusMessage *pending;
@@ -167,6 +168,26 @@ void __elect_device_foreach(elect_device_foreach_func =
func, void *userdata)
 	}
 }
 =

+static void settings_changed(struct elect_device *device)
+{
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
+	g_dbus_send_message(connection, signal);
+}
+
 static DBusMessage *device_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -206,6 +227,9 @@ static void bt_disconnect_reply(DBusPendingCall *call, =
gpointer user_data)
 =

 	g_free(device->tty);
 	device->tty =3D NULL;
+
+	__elect_dun_unref(device->dun);
+	device->dun =3D NULL;
 }
 =

 static int bt_disconnect(struct elect_device *device)
@@ -232,6 +256,71 @@ static int bt_disconnect(struct elect_device *device)
 	return -EINPROGRESS;
 }
 =

+static void disconnect_cb(void *data)
+{
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
+	ofono_dbus_signal_property_changed(connection, device->elect_path,
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
+	ofono_dbus_signal_property_changed(connection, device->elect_path,
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
@@ -261,6 +350,10 @@ static void bt_connect_reply(DBusPendingCall *call, gp=
ointer user_data)
 =

 	device->tty =3D g_strdup(tty);
 =

+	device->dun =3D __elect_dun_create(device->tty, connect_cb,
+						disconnect_cb, device);
+	__elect_dun_connect(device->dun);
+
 done:
 	dbus_message_unref(reply);
 =

@@ -544,6 +637,9 @@ static void destroy_device(gpointer user)
 	if (device->call)
 		dbus_pending_call_cancel(device->call);
 =

+	if (device->dun)
+		__elect_dun_unref(device->dun);
+
 	g_free(device->settings.interface);
 	g_free(device->settings.ip);
 	g_strfreev(device->settings.nameservers);
diff --git a/elect/elect.h b/elect/elect.h
index b9ead99..fc1222c 100644
--- a/elect/elect.h
+++ b/elect/elect.h
@@ -83,3 +83,18 @@ void __elect_device_foreach(elect_device_foreach_func cb=
, void *userdata);
 const char *__elect_device_get_path(struct elect_device *device);
 void __elect_device_append_properties(struct elect_device *device,
 					DBusMessageIter *dict);
+
+
+typedef void (*elect_dun_connect_cb_t)(const char *interface, const char *=
ip,
+				const char *peer,
+				const char *dns1, const char *dns2,
+				void *data);
+typedef void (*elect_dun_disconnect_cb_t)(void *data);
+
+struct elect_dun *__elect_dun_create(const char *path,
+				elect_dun_connect_cb_t connect_cb,
+				elect_dun_disconnect_cb_t disconnect_cb,
+				void *data);
+int __elect_dun_connect(struct elect_dun *dun);
+int __elect_dun_disconnect(struct elect_dun *dun);
+void __elect_dun_unref(struct elect_dun *dun);
-- =

1.7.8.110.g4cb5d1


--===============4233304297950321462==--

