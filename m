Content-Type: multipart/mixed; boundary="===============7686812183121581583=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v2 4/5] udevng: get properties from interface
Date: Tue, 28 Mar 2017 15:18:23 +0200
Message-ID: <20170328131824.13261-5-jonas@southpole.se>
In-Reply-To: <20170328131824.13261-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7686812183121581583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Device properties are generally on the device, on the USB interface
descriptor, or the on the USB device descriptor.
---
 plugins/udevng.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1e84aa4..6b76d30 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1317,7 +1317,7 @@ static void add_device(const char *syspath, const cha=
r *devname,
 			const char *driver, const char *vendor,
 			const char *model, struct udev_device *device)
 {
-	struct udev_device *intf;
+	struct udev_device *usb_interface;
 	const char *devpath, *devnode, *interface, *number;
 	const char *label, *sysattr, *subsystem;
 	struct modem_info *modem;
@@ -1335,9 +1335,9 @@ static void add_device(const char *syspath, const cha=
r *devname,
 			return;
 	}
 =

-	intf =3D udev_device_get_parent_with_subsystem_devtype(device,
+	usb_interface =3D udev_device_get_parent_with_subsystem_devtype(device,
 						"usb", "usb_interface");
-	if (intf =3D=3D NULL)
+	if (usb_interface =3D=3D NULL)
 		return;
 =

 	modem =3D g_hash_table_lookup(modem_list, syspath);
@@ -1373,6 +1373,11 @@ static void add_device(const char *syspath, const ch=
ar *devname,
 	}
 =

 	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
+	if (!label) {
+		label =3D udev_device_get_property_value(usb_interface,
+							"OFONO_LABEL");
+	}
+
 	subsystem =3D udev_device_get_subsystem(device);
 =

 	if (modem->sysattr !=3D NULL)
@@ -1495,6 +1500,14 @@ static void check_usb_device(struct udev_device *dev=
ice)
 	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
 =

 	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
+	if (!driver) {
+		struct udev_device *usb_interface;
+		usb_interface =3D udev_device_get_parent_with_subsystem_devtype(
+					device, "usb", "usb_interface");
+		if (usb_interface)
+			driver =3D udev_device_get_property_value(
+					usb_interface, "OFONO_DRIVER");
+	}
 	if (driver =3D=3D NULL) {
 		const char *drv;
 		unsigned int i;
-- =

2.9.3


--===============7686812183121581583==--

