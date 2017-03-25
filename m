Content-Type: multipart/mixed; boundary="===============2439049682487038542=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 07/15] udev: add common modem registration code
Date: Sat, 25 Mar 2017 17:57:57 +0100
Message-ID: <20170325165805.28166-8-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2439049682487038542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Many of these drivers do exactly the same setup when registering
the modem.  Consolidate these setup functions into common code.
---
 plugins/udev.c | 49 +++++--------------------------------------------
 1 file changed, 5 insertions(+), 44 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index 5d1080d..05945a0 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -154,7 +154,7 @@ static void add_isi(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

-static void add_calypso(struct ofono_modem *modem,
+static void __add_common(struct ofono_modem *modem,
 					struct udev_device *udev_device)
 {
 	const char *devnode;
@@ -192,45 +192,6 @@ static void add_wavecom(struct ofono_modem *modem,
 	ofono_modem_register(modem);
 }
 =

-static void add_cinterion(struct ofono_modem *modem,
-			struct udev_device *udev_device)
-{
-	const char *devnode;
-
-	DBG("modem %p", modem);
-
-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
-
-	ofono_modem_register(modem);
-}
-
-static void add_nokiacdma(struct ofono_modem *modem,
-					struct udev_device *udev_device)
-{
-	const char *devnode;
-
-	DBG("modem %p", modem);
-
-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
-
-	ofono_modem_register(modem);
-}
-
-static void add_sim900(struct ofono_modem *modem,
-					struct udev_device *udev_device)
-{
-	const char *devnode;
-
-	DBG("modem %p", modem);
-
-	devnode =3D udev_device_get_devnode(udev_device);
-	ofono_modem_set_string(modem, "Device", devnode);
-
-	ofono_modem_register(modem);
-}
-
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
@@ -282,13 +243,13 @@ static void add_modem(struct udev_device *udev_device)
 	else if (g_strcmp0(driver, "n900") =3D=3D 0)
 		add_isi(modem, udev_device);
 	else if (g_strcmp0(driver, "calypso") =3D=3D 0)
-		add_calypso(modem, udev_device);
+		__add_common(modem, udev_device);
 	else if (g_strcmp0(driver, "cinterion") =3D=3D 0)
-		add_cinterion(modem, udev_device);
+		__add_common(modem, udev_device);
 	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
-		add_nokiacdma(modem, udev_device);
+		__add_common(modem, udev_device);
 	else if (g_strcmp0(driver, "sim900") =3D=3D 0)
-		add_sim900(modem, udev_device);
+		__add_common(modem, udev_device);
 	else if (g_strcmp0(driver, "wavecom") =3D=3D 0)
 		add_wavecom(modem, udev_device);
 }
-- =

2.9.3


--===============2439049682487038542==--

