Content-Type: multipart/mixed; boundary="===============5212440555270411236=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 01/15] udevng: simplify logic in check_usb_device
Date: Sat, 25 Mar 2017 17:57:51 +0100
Message-ID: <20170325165805.28166-2-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5212440555270411236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch simplifies and cleans up the check_usb_device function a bit
by doing the two following (slightly intertwined) things:

1)  The parent "usb_device" is searched for early in this function and this
device will always have the ID_VENDOR_ID and ID_MODEL_ID properties.
As such, we can get them from this device and thereby be certain that
we _always_ have them available.

2)  The logic of iterating the vendor_list table is cleaned up.  It's
easier to follow and won't be any less efficient.
---
 plugins/udevng.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2279bbe..ce2bc28 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1225,9 +1225,12 @@ static void check_usb_device(struct udev_device *dev=
ice)
 	if (devname =3D=3D NULL)
 		return;
 =

+	vendor =3D udev_device_get_property_value(usb_device, "ID_VENDOR_ID");
+	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
+
 	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
 	if (driver =3D=3D NULL) {
-		const char *drv, *vid, *pid;
+		const char *drv;
 		unsigned int i;
 =

 		drv =3D udev_device_get_property_value(device, "ID_USB_DRIVER");
@@ -1246,40 +1249,24 @@ static void check_usb_device(struct udev_device *de=
vice)
 			}
 		}
 =

-		vid =3D udev_device_get_property_value(device, "ID_VENDOR_ID");
-		pid =3D udev_device_get_property_value(device, "ID_MODEL_ID");
 =

-		DBG("%s [%s:%s]", drv, vid, pid);
+		DBG("%s [%s:%s]", drv, vendor, model);
 =

 		for (i =3D 0; vendor_list[i].driver; i++) {
 			if (g_str_equal(vendor_list[i].drv, drv) =3D=3D FALSE)
 				continue;
 =

-			if (vendor_list[i].vid =3D=3D NULL) {
-				driver =3D vendor_list[i].driver;
-				vendor =3D vid;
-				model =3D pid;
-				continue;
+			if (vendor_list[i].vid) {
+				if (!g_str_equal(vendor_list[i].vid, vendor))
+					continue;
 			}
 =

-			if (vid =3D=3D NULL || pid =3D=3D NULL)
-				continue;
-
-			if (g_str_equal(vendor_list[i].vid, vid) =3D=3D TRUE) {
-				if (vendor_list[i].pid =3D=3D NULL) {
-					driver =3D vendor_list[i].driver;
-					vendor =3D vid;
-					model =3D pid;
+			if (vendor_list[i].pid) {
+				if (!g_str_equal(vendor_list[i].pid, model))
 					continue;
-				}
-
-				if (g_strcmp0(vendor_list[i].pid, pid) =3D=3D 0) {
-					driver =3D vendor_list[i].driver;
-					vendor =3D vid;
-					model =3D pid;
-					break;
-				}
 			}
+
+			driver =3D vendor_list[i].driver;
 		}
 =

 		if (driver =3D=3D NULL)
-- =

2.9.3


--===============5212440555270411236==--

