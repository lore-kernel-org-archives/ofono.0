Content-Type: multipart/mixed; boundary="===============1590867201694658920=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 10/15] udev: remove extraneous subsystem check
Date: Sat, 25 Mar 2017 17:58:00 +0100
Message-ID: <20170325165805.28166-11-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1590867201694658920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The enumeration construct is already set up with matches for these
subsystems.
---
 plugins/udev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 13cef32..02cc67a 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -292,14 +292,7 @@ static void enumerate_devices(struct udev *context)
 =

 		device =3D udev_device_new_from_syspath(context, syspath);
 		if (device !=3D NULL) {
-			const char *subsystem;
-
-			subsystem =3D udev_device_get_subsystem(device);
-
-			if (g_strcmp0(subsystem, "tty") =3D=3D 0 ||
-					g_strcmp0(subsystem, "net") =3D=3D 0 ||
-					g_strcmp0(subsystem, "hsi") =3D=3D 0)
-				add_modem(device);
+			add_modem(device);
 =

 			udev_device_unref(device);
 		}
-- =

2.9.3


--===============1590867201694658920==--

