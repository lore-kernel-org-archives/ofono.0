Content-Type: multipart/mixed; boundary="===============2850788973681404489=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 12/15] udevng: match on the hsi subsystem for legacy
 devices
Date: Sat, 25 Mar 2017 17:58:02 +0100
Message-ID: <20170325165805.28166-13-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2850788973681404489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4e464c2..640a221 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1595,6 +1595,7 @@ static void enumerate_devices(struct udev *context)
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
 	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
+	udev_enumerate_add_match_subsystem(enumerate, "hsi");
 =

 	udev_enumerate_scan_devices(enumerate);
 =

@@ -1719,6 +1720,7 @@ static int detect_init(void)
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon,
 							"usbmisc", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "net", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "hsi", NULL);
 =

 	udev_monitor_filter_update(udev_mon);
 =

-- =

2.9.3


--===============2850788973681404489==--

