Content-Type: multipart/mixed; boundary="===============8573891199553691975=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v4 2/3] udevng: find vendor and product id for child devices
Date: Fri, 24 Mar 2017 21:46:36 +0000
Message-ID: <1490391997-27077-3-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490391997-27077-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8573891199553691975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Some of the udev devices will not have vendor and product id
of their own, if they are children of real usb devices
(e.g. cdc-wdm0 which is a usbmisc subsystem of qmi_wwan).

If a device does not have its own vendor id, go up through
the parent tree to try to find one.
---
 plugins/udevng.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2279bbe..75e0126 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1229,6 +1229,7 @@ static void check_usb_device(struct udev_device *devi=
ce)
 	if (driver =3D=3D NULL) {
 		const char *drv, *vid, *pid;
 		unsigned int i;
+		struct udev_device *vendor_device;
 =

 		drv =3D udev_device_get_property_value(device, "ID_USB_DRIVER");
 		if (drv =3D=3D NULL) {
@@ -1246,8 +1247,17 @@ static void check_usb_device(struct udev_device *dev=
ice)
 			}
 		}
 =

-		vid =3D udev_device_get_property_value(device, "ID_VENDOR_ID");
-		pid =3D udev_device_get_property_value(device, "ID_MODEL_ID");
+		vendor_device =3D device;
+		vid =3D NULL;
+		while (vendor_device !=3D NULL) {
+			vid =3D udev_device_get_property_value(
+					vendor_device, "ID_VENDOR_ID");
+			pid =3D udev_device_get_property_value(
+					vendor_device, "ID_MODEL_ID");
+			if (vid !=3D NULL)
+				break;
+			vendor_device =3D udev_device_get_parent(vendor_device);
+		}
 =

 		DBG("%s [%s:%s]", drv, vid, pid);
 =

-- =

2.7.4


--===============8573891199553691975==--

