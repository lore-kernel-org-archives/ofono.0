Content-Type: multipart/mixed; boundary="===============7225144899592024227=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v3 2/5] udevng: match on the hsi subsystem for legacy
 devices
Date: Tue, 28 Mar 2017 23:54:12 +0200
Message-ID: <20170328215416.20119-3-jonas@southpole.se>
In-Reply-To: <20170328215416.20119-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7225144899592024227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d33c5f1..46b185a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1613,6 +1613,7 @@ static void enumerate_devices(struct udev *context)
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
 	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
+	udev_enumerate_add_match_subsystem(enumerate, "hsi");
 =

 	udev_enumerate_scan_devices(enumerate);
 =

@@ -1737,6 +1738,7 @@ static int detect_init(void)
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon,
 							"usbmisc", NULL);
 	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "net", NULL);
+	udev_monitor_filter_add_match_subsystem_devtype(udev_mon, "hsi", NULL);
 =

 	udev_monitor_filter_update(udev_mon);
 =

-- =

2.9.3


--===============7225144899592024227==--

