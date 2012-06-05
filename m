Content-Type: multipart/mixed; boundary="===============7646174798189907302=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v0 4/4] dundee: Add Type property
Date: Tue, 05 Jun 2012 15:48:19 +0200
Message-ID: <1338904099-13612-5-git-send-email-wagi@monom.org>
In-Reply-To: <1338904099-13612-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7646174798189907302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 dundee/bluetooth.c |    1 +
 dundee/device.c    |   17 +++++++++++++++++
 dundee/dundee.h    |    6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/dundee/bluetooth.c b/dundee/bluetooth.c
index 0fb00a4..c124f60 100644
--- a/dundee/bluetooth.c
+++ b/dundee/bluetooth.c
@@ -137,6 +137,7 @@ static const char *bt_serial(struct dundee_device *devi=
ce)
 =

 struct dundee_device_driver bluetooth_driver =3D {
 	.name =3D "bluetooth",
+	.type =3D DUNDEE_DEVICE_TYPE_BLUETOOTH,
 	.connect =3D bt_connect,
 	.disconnect =3D bt_disconnect,
 	.serial =3D bt_serial,
diff --git a/dundee/device.c b/dundee/device.c
index 9733b09..fa549e1 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -62,6 +62,18 @@ struct dundee_device {
 	void *data;
 };
 =

+static const char *device_type_to_string(enum dundee_device_type type)
+{
+	switch (type) {
+	case DUNDEE_DEVICE_TYPE_BLUETOOTH:
+		return "bluetooth";
+	case DUNDEE_DEVICE_TYPE_USB:
+		return "usb";
+	}
+
+	return "unknown";
+}
+
 const char *__dundee_device_get_path(struct dundee_device *device)
 {
 	return device->path;
@@ -130,6 +142,7 @@ void __dundee_device_append_properties(struct dundee_de=
vice *device,
 					DBusMessageIter *dict)
 {
 	const char *serial;
+	const char *type;
 =

 	settings_append_dict(device, dict);
 =

@@ -146,6 +159,10 @@ void __dundee_device_append_properties(struct dundee_d=
evice *device,
 	if (serial)
 		ofono_dbus_dict_append(dict, "Serial", DBUS_TYPE_STRING,
 					&serial);
+
+	type =3D device_type_to_string(device->driver->type);
+	ofono_dbus_dict_append(dict, "Type", DBUS_TYPE_STRING,
+				&type);
 }
 =

 void __dundee_device_foreach(dundee_device_foreach_func func, void *userda=
ta)
diff --git a/dundee/dundee.h b/dundee/dundee.h
index ca53c88..b954a91 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -33,6 +33,11 @@ enum dundee_error_type {
 	DUNDEE_ERROR_TYPE_FAILURE,
 };
 =

+enum dundee_device_type {
+	DUNDEE_DEVICE_TYPE_BLUETOOTH =3D 0,
+	DUNDEE_DEVICE_TYPE_USB,
+};
+
 struct dundee_error {
 	enum dundee_error_type type;
 	int error;
@@ -113,6 +118,7 @@ typedef void (*dundee_device_disconnect_cb_t)(const str=
uct dundee_error *error,
 =

 struct dundee_device_driver {
 	const char *name;
+	enum dundee_device_type type;
 =

 	/* Connect and dial */
 	void (*connect)(struct dundee_device *device,
-- =

1.7.10.130.g36e6c


--===============7646174798189907302==--

