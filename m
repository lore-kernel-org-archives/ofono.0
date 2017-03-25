Content-Type: multipart/mixed; boundary="===============6229169627427160445=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 13/15] udevng: hook up legacy devices
Date: Sat, 25 Mar 2017 17:58:03 +0100
Message-ID: <20170325165805.28166-14-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6229169627427160445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and disable old udev code by shorting it out in it's init() function.
---
 plugins/udev.c   | 2 ++
 plugins/udevng.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/plugins/udev.c b/plugins/udev.c
index 02cc67a..38ddeea 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -366,6 +366,8 @@ static void udev_start(void)
 =

 static int udev_init(void)
 {
+	return 0;
+
 	devpath_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 	if (devpath_list =3D=3D NULL) {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index 640a221..8721447 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1607,6 +1607,7 @@ static void enumerate_devices(struct udev *context)
 		device =3D udev_device_new_from_syspath(context, syspath);
 		if (device !=3D NULL) {
 			check_device(device);
+			add_legacy_device(device);
 			udev_device_unref(device);
 		}
 =

@@ -1659,6 +1660,7 @@ static gboolean udev_event(GIOChannel *channel, GIOCo=
ndition cond,
 			g_source_remove(udev_delay);
 =

 		check_device(device);
+		add_legacy_device(device);
 =

 		udev_delay =3D g_timeout_add_seconds(1, check_modem_list, NULL);
 	} else if (g_str_equal(action, "remove") =3D=3D TRUE)
-- =

2.9.3


--===============6229169627427160445==--

