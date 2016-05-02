Content-Type: multipart/mixed; boundary="===============3824106023457605633=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: [PATCH 1/3] udevng: Add usbmisc scan for QMI devices
Date: Mon, 02 May 2016 16:42:41 +0200
Message-ID: <1462200163-15827-1-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3824106023457605633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

cdc-wdm0 are now usbmisc devices
---
 plugins/udevng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index e43d045..9643b0a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1217,7 +1217,7 @@ static void check_device(struct udev_device *device)
 			return;
 	}
 =

-	if (g_str_equal(bus, "usb") =3D=3D TRUE)
+	if ((g_str_equal(bus, "usb") =3D=3D TRUE) || (g_str_equal(bus, "usbmisc")=
 =3D=3D TRUE))
 		check_usb_device(device);
 }
 =

@@ -1267,6 +1267,7 @@ static void enumerate_devices(struct udev *context)
 =

 	udev_enumerate_add_match_subsystem(enumerate, "tty");
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
+	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
 =

 	udev_enumerate_scan_devices(enumerate);
@@ -1389,6 +1390,7 @@ static int detect_init(void)
 =

 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "tty", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "usb", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "usbmisc", NULL=
);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "net", NULL);
 =

 	udev_monitor_filter_update(udev_mon);
-- =

1.9.1


--===============3824106023457605633==--

