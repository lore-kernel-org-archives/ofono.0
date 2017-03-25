Content-Type: multipart/mixed; boundary="===============0450200917903700232=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 14/15] udevng: get properties from interface
Date: Sat, 25 Mar 2017 17:58:04 +0100
Message-ID: <20170325165805.28166-15-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0450200917903700232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Device properties are generally on the device, on the USB interface
descriptor, or the on the USB device descriptor.
---
 plugins/udevng.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8721447..98b4f98 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1365,6 +1365,9 @@ static void add_device(const char *syspath, const cha=
r *devname,
 	}
 =

 	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
+	if (!label) {
+		label =3D udev_device_get_property_value(intf, "OFONO_LABEL");
+	}
 	subsystem =3D udev_device_get_subsystem(device);
 =

 	if (modem->sysattr !=3D NULL)
@@ -1464,6 +1467,7 @@ static struct {
 static void check_usb_device(struct udev_device *device)
 {
 	struct udev_device *usb_device;
+	struct udev_device *intf;
 	const char *syspath, *devname, *driver;
 	const char *vendor =3D NULL, *model =3D NULL;
 =

@@ -1484,6 +1488,13 @@ static void check_usb_device(struct udev_device *dev=
ice)
 	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
 =

 	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
+	if (!driver) {
+		intf =3D udev_device_get_parent_with_subsystem_devtype(device,
+						"usb", "usb_interface");
+		if (intf)
+			driver =3D udev_device_get_property_value(
+							intf, "OFONO_DRIVER");
+	}
 	if (driver =3D=3D NULL) {
 		const char *drv;
 		unsigned int i;
-- =

2.9.3


--===============0450200917903700232==--

