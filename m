Content-Type: multipart/mixed; boundary="===============8258001297783428943=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: [PATCH 1/4] udevng: the "usb" class has been renamed to "usbmisc"
Date: Sun, 03 Feb 2013 22:39:44 +0100
Message-ID: <1359927587-24353-2-git-send-email-bjorn@mork.no>
In-Reply-To: <1359927587-24353-1-git-send-email-bjorn@mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8258001297783428943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 plugins/udevng.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..a4da374 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1139,6 +1139,7 @@ static void enumerate_devices(struct udev *context)
 =

 	udev_enumerate_add_match_subsystem(enumerate, "tty");
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
+	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
 =

 	udev_enumerate_scan_devices(enumerate);
@@ -1261,6 +1262,7 @@ static int detect_init(void)
 =

 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "tty", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "usb", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "usbmisc", NULL=
);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "net", NULL);
 =

 	udev_monitor_filter_update(udev_mon);
-- =

1.7.10.4


--===============8258001297783428943==--

