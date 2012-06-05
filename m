Content-Type: multipart/mixed; boundary="===============9209069360867640856=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 3/4] dundee: Add Serial property
Date: Tue, 05 Jun 2012 15:48:18 +0200
Message-ID: <1338904099-13612-4-git-send-email-wagi@monom.org>
In-Reply-To: <1338904099-13612-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9209069360867640856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/bluetooth.c |   10 ++++++++++
 dundee/device.c    |   10 ++++++++++
 dundee/dundee.h    |    3 +++
 3 files changed, 23 insertions(+)

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
index e2e2bca..0fb00a4 100644
--- a/dundee/bluetooth.c
+++ b/dundee/bluetooth.c
@@ -126,10 +126,20 @@ static void bt_connect(struct dundee_device *device,
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

+static const char *bt_serial(struct dundee_device *device)
+{
+	struct bluetooth_device *bt =3D dundee_device_get_data(device);
+
+	DBG("%p", bt);
+
+	return bt->address;
+}
+
 struct dundee_device_driver bluetooth_driver =3D {
 	.name =3D "bluetooth",
 	.connect =3D bt_connect,
 	.disconnect =3D bt_disconnect,
+	.serial =3D bt_serial,
 };
 =

 static int bt_probe(const char *path, const char *dev_addr,
diff --git a/dundee/device.c b/dundee/device.c
index 709919a..9733b09 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -129,6 +129,8 @@ static void settings_append_dict(struct dundee_device *=
device,
 void __dundee_device_append_properties(struct dundee_device *device,
 					DBusMessageIter *dict)
 {
+	const char *serial;
+
 	settings_append_dict(device, dict);
 =

 	ofono_dbus_dict_append(dict, "Name", DBUS_TYPE_STRING,
@@ -136,6 +138,14 @@ void __dundee_device_append_properties(struct dundee_d=
evice *device,
 =

 	ofono_dbus_dict_append(dict, "Active", DBUS_TYPE_BOOLEAN,
 				&device->active);
+
+	if (device->driver =3D=3D NULL)
+		return;
+
+	serial =3D device->driver->serial(device);
+	if (serial)
+		ofono_dbus_dict_append(dict, "Serial", DBUS_TYPE_STRING,
+					&serial);
 }
 =

 void __dundee_device_foreach(dundee_device_foreach_func func, void *userda=
ta)
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 8866007..ca53c88 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -121,6 +121,9 @@ struct dundee_device_driver {
 	/* Hangup and disconnect */
 	void (*disconnect)(struct dundee_device *device,
 			dundee_device_disconnect_cb_t cb, void *data);
+
+	/* Get device information */
+	const char *(*serial)(struct dundee_device *device);
 };
 =

 struct dundee_device *dundee_device_create(struct dundee_device_driver *d);
-- =

1.7.10.130.g36e6c


--===============9209069360867640856==--

