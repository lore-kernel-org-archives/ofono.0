Content-Type: multipart/mixed; boundary="===============0845051599968730601=="
MIME-Version: 1.0
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Subject: [PATCH] udevng: match vendorId and productId from parent usb_device.
Date: Fri, 18 Jan 2013 10:07:06 +0100
Message-ID: <1358500026-14578-1-git-send-email-cedric.jehasse@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0845051599968730601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Cedric Jehasse <cedric.jehasse@softathome.com>

cdc_wdm device doesn't have ID_VENDOR_ID and ID_MODEL_ID properties,
read these properties from the parent usb_device.
---
 plugins/udevng.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..7d7f4f6 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1035,8 +1035,10 @@ static void check_usb_device(struct udev_device *dev=
ice)
 			}
 		}
 =

-		vid =3D udev_device_get_property_value(device, "ID_VENDOR_ID");
-		pid =3D udev_device_get_property_value(device, "ID_MODEL_ID");
+		vid =3D udev_device_get_property_value(usb_device,
+				"ID_VENDOR_ID");
+		pid =3D udev_device_get_property_value(usb_device,
+				"ID_MODEL_ID");
 =

 		DBG("%s [%s:%s]", drv, vid, pid);
 =

-- =

1.7.9.5


--===============0845051599968730601==--

