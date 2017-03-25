Content-Type: multipart/mixed; boundary="===============8677144574086556309=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 03/15] udev: remove extraneous subsystem check
Date: Sat, 25 Mar 2017 17:57:53 +0100
Message-ID: <20170325165805.28166-4-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8677144574086556309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The udev-monitor already guarantees that only devices with these
subsystems will be returned so we don't need to check again.
---
 plugins/udev.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 3c90e40..196c528 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -410,7 +410,7 @@ static gboolean udev_event(GIOChannel *channel, GIOCond=
ition cond,
 							gpointer user_data)
 {
 	struct udev_device *device;
-	const char *subsystem, *action;
+	const char *action;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
 		ofono_warn("Error with udev monitor channel");
@@ -422,30 +422,16 @@ static gboolean udev_event(GIOChannel *channel, GIOCo=
ndition cond,
 	if (device =3D=3D NULL)
 		return TRUE;
 =

-	subsystem =3D udev_device_get_subsystem(device);
-	if (subsystem =3D=3D NULL)
-		goto done;
-
 	action =3D udev_device_get_action(device);
 	if (action =3D=3D NULL)
 		goto done;
 =

-	DBG("subsystem %s %s", subsystem, action);
-
 	if (g_str_equal(action, "add") =3D=3D TRUE) {
-		if (g_strcmp0(subsystem, "tty") =3D=3D 0 ||
-				g_strcmp0(subsystem, "net") =3D=3D 0 ||
-					g_strcmp0(subsystem, "hsi") =3D=3D 0)
 			add_modem(device);
 	} else if (g_str_equal(action, "remove") =3D=3D TRUE) {
-		if (g_strcmp0(subsystem, "tty") =3D=3D 0 ||
-				g_strcmp0(subsystem, "net") =3D=3D 0 ||
-					g_strcmp0(subsystem, "hsi") =3D=3D 0)
 			remove_modem(device);
 	}
 =

-	DBG("subsystem %s finished", subsystem);
-
 done:
 	udev_device_unref(device);
 =

-- =

2.9.3


--===============8677144574086556309==--

