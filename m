Content-Type: multipart/mixed; boundary="===============1321804166719481325=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v2 3/5] udevng: hook up legacy devices
Date: Tue, 28 Mar 2017 15:18:22 +0200
Message-ID: <20170328131824.13261-4-jonas@southpole.se>
In-Reply-To: <20170328131824.13261-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1321804166719481325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and disable old udev code by shorting it out in it's init() function.

The check_device function is augmented to differentiate between USB
and serial devices:

- if the device sits on a USB bus, the device is handled as before
- if not, an attempt is made to handle the device as a serial device
---
 plugins/udev.c   | 2 ++
 plugins/udevng.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/plugins/udev.c b/plugins/udev.c
index 92451d2..564ede9 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -365,6 +365,8 @@ static void udev_start(void)
 =

 static int udev_init(void)
 {
+	return 0;
+
 	devpath_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 	if (devpath_list =3D=3D NULL) {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4ff91d5..1e84aa4 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1556,6 +1556,9 @@ static void check_device(struct udev_device *device)
 	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
 			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
 		check_usb_device(device);
+	else
+		add_serial_device(device);
+
 }
 =

 static gboolean create_modem(gpointer key, gpointer value, gpointer user_d=
ata)
-- =

2.9.3


--===============1321804166719481325==--

