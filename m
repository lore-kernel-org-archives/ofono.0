Content-Type: multipart/mixed; boundary="===============4876035428786166326=="
MIME-Version: 1.0
From: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH v3 07/13] dundee: Listen to devices property changes
Date: Wed, 20 Mar 2013 19:26:36 -0300
Message-ID: <1363818402-17710-8-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1363818402-17710-1-git-send-email-paulo.borges@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4876035428786166326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a bluetooth device property change and this property is Alias,
we need to refresh our representation of this device.
---
 dundee/bluez5.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/dundee/bluez5.c b/dundee/bluez5.c
index 3688753..f0c51df 100644
--- a/dundee/bluez5.c
+++ b/dundee/bluez5.c
@@ -133,6 +133,20 @@ static gboolean has_dun_uuid(DBusMessageIter *array)
 	return FALSE;
 }
 =

+static void alias_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *alias;
+	struct bluetooth_device *bt_device =3D user_data;
+
+	if (!g_str_equal("Alias", name))
+		return;
+
+	dbus_message_iter_get_basic(iter, &alias);
+
+	bt_device->name =3D g_strdup(alias);
+}
+
 static void bluetooth_device_removed(GDBusProxy *proxy, void *user_data)
 {
 	struct bluetooth_device *bt_device =3D user_data;
@@ -161,6 +175,7 @@ static void proxy_added(GDBusProxy *proxy, void *user_d=
ata)
 		return;
 =

 	bt_device =3D bluetooth_device_register(proxy);
+	g_dbus_proxy_set_property_watch(proxy, alias_changed, bt_device);
 	g_dbus_proxy_set_removed_watch(proxy, bluetooth_device_removed,
 								bt_device);
 }
-- =

1.7.9.5


--===============4876035428786166326==--

