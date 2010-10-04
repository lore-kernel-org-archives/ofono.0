Content-Type: multipart/mixed; boundary="===============8378280205875774154=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-udev PATCH 1/3] udev: do not use post-143 libudev features
Date: Mon, 04 Oct 2010 16:11:04 +0300
Message-ID: <1286197866-19572-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1286197866-19572-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8378280205875774154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

There is no udev_device_get_property_value() in libudev version 143.
---
 plugins/udev.c |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 3c2c09c..d506234 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -55,38 +55,34 @@ static struct ofono_modem *find_modem(const char *devpa=
th)
 	return NULL;
 }
 =

-static const char *get_driver(struct udev_device *udev_device)
+static const char *get_property(struct udev_device *device,
+				char const *property_name)
 {
 	struct udev_list_entry *entry;
-	const char *driver =3D NULL;
 =

-	entry =3D udev_device_get_properties_list_entry(udev_device);
+	entry =3D udev_device_get_properties_list_entry(device);
 	while (entry) {
 		const char *name =3D udev_list_entry_get_name(entry);
 =

-		if (g_strcmp0(name, "OFONO_DRIVER") =3D=3D 0)
-			driver =3D udev_list_entry_get_value(entry);
+		if (g_strcmp0(name, property_name) =3D=3D 0)
+			return udev_list_entry_get_value(entry);
 =

 		entry =3D udev_list_entry_get_next(entry);
 	}
 =

-	return driver;
+	return NULL;
 }
 =

-static const char *get_serial(struct udev_device *udev_device)
+static const char *get_driver(struct udev_device *udev_device)
 {
-	struct udev_list_entry *entry;
-	const char *serial =3D NULL;
-
-	entry =3D udev_device_get_properties_list_entry(udev_device);
-	while (entry) {
-		const char *name =3D udev_list_entry_get_name(entry);
+	return get_property(udev_device, "OFONO_DRIVER");
+}
 =

-		if (g_strcmp0(name, "ID_SERIAL_SHORT") =3D=3D 0)
-			serial =3D udev_list_entry_get_value(entry);
+static const char *get_serial(struct udev_device *udev_device)
+{
+	const char *serial;
 =

-		entry =3D udev_list_entry_get_next(entry);
-	}
+	serial =3D get_property(udev_device, "ID_SERIAL_SHORT");
 =

 	if (serial !=3D NULL) {
 		unsigned int i, len =3D strlen(serial);
@@ -147,8 +143,7 @@ static void add_mbm(struct ofono_modem *modem,
 			g_str_has_suffix(desc, "Mini-Card Network Adapter") ||
 			g_str_has_suffix(desc, "Broadband Network Adapter") ||
 			g_str_has_suffix(desc, "Minicard NetworkAdapter")) {
-		devnode =3D udev_device_get_property_value(udev_device,
-								"INTERFACE");
+		devnode =3D get_property(udev_device, "INTERFACE");
 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
 	} else {
 		return;
@@ -194,8 +189,7 @@ static void add_hso(struct ofono_modem *modem,
 		else if (g_str_has_suffix(type, "Control") =3D=3D TRUE)
 			ofono_modem_set_string(modem, CONTROL_PORT, devnode);
 	} else if (g_str_equal(subsystem, "net") =3D=3D TRUE) {
-		devnode =3D udev_device_get_property_value(udev_device,
-								"INTERFACE");
+		devnode =3D get_property(udev_device, "INTERFACE");
 		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);
 	} else {
 		return;
@@ -435,7 +429,7 @@ static void add_isi(struct ofono_modem *modem,
 =

 	DBG("interface %s", ifname);
 =

-	addr =3D udev_device_get_property_value(udev_device, "OFONO_ISI_ADDRESS");
+	addr =3D get_property(udev_device, "OFONO_ISI_ADDRESS");
 	if (addr !=3D NULL)
 		ofono_modem_set_integer(modem, "Address", atoi(addr));
 =

-- =

1.7.0.4


--===============8378280205875774154==--

