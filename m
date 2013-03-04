Content-Type: multipart/mixed; boundary="===============5487917287200523522=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 07/13] dundee: Listen to devices property changes
Date: Mon, 04 Mar 2013 16:33:08 -0300
Message-ID: <1362425590-26075-8-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1362425590-26075-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5487917287200523522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a bluetooth device property change and this property is Alias
or UUIDs, we need to refresh our representation of this device.
---
 dundee/bluez5.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 8d8e656..623201f 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -169,11 +169,35 @@ static void property_changed(GDBusProxy *proxy, const=
 char *name,
 {
 	const char *path =3D g_dbus_proxy_get_path(proxy);
 	const char *interface =3D g_dbus_proxy_get_interface(proxy);
+	const char *alias;
+	struct bluetooth_device *bt_device;
+	gboolean uuid;
 =

 	if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
 		return;
 =

-	DBG("%s %s.%s", path, interface, name);
+	bt_device =3D g_hash_table_lookup(registered_devices, path);
+
+	if (g_str_equal(name, "Alias") =3D=3D TRUE) {
+		if (bt_device =3D=3D NULL)
+			return;
+
+		dbus_message_iter_get_basic(iter, &alias);
+
+		DBG("%s alias changed: %s", path, alias);
+
+		bt_device->name =3D g_strdup(alias);
+	} else if (g_str_equal(name, "UUIDs") =3D=3D TRUE) {
+		DBG("%s uuids changed", path);
+
+		uuid =3D has_dun_uuid(iter);
+
+		if (bt_device !=3D NULL && uuid =3D=3D FALSE)
+			bluetooth_device_unregister(path);
+
+		else if (bt_device =3D=3D NULL && uuid =3D=3D TRUE)
+			bluetooth_device_register(proxy);
+	}
 }
 =

 static void connect_handler(DBusConnection *conn, void *user_data)
-- =

1.7.9.5


--===============5487917287200523522==--

