Content-Type: multipart/mixed; boundary="===============6601426713445056426=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev 06/15] udev: simplify add_modem
Date: Sat, 25 Mar 2017 17:57:56 +0100
Message-ID: <20170325165805.28166-7-jonas@southpole.se>
In-Reply-To: <20170325165805.28166-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6601426713445056426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding a modem boils down to finding the device in the hierarchy with
the OFONO_DRIVER property.  The original code special-cased the property
being on the device itself rather than on a parent device.  This patch
combines the two cases.
---
 plugins/udev.c | 72 ++++++++++++++++++++++++++----------------------------=
----
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/plugins/udev.c b/plugins/udev.c
index dc07fc6..5d1080d 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -55,9 +55,27 @@ static struct ofono_modem *find_modem(const char *devpat=
h)
 	return NULL;
 }
 =

-static const char *get_driver(struct udev_device *udev_device)
+/*
+ * Here we try to find the "modem device".
+ *
+ * In this variant we identify the "modem device" as simply the device
+ * that has the OFONO_DRIVER property.  If the device node doesn't
+ * have this property itself, then we do a brute force search for it
+ * through the device hierarchy. =

+ *
+ */
+static struct udev_device* get_modem_device(struct udev_device *dev)
 {
-	return udev_device_get_property_value(udev_device, "OFONO_DRIVER");
+	const char* driver;
+
+	while (dev) {
+		driver =3D udev_device_get_property_value(dev, "OFONO_DRIVER");
+		if (driver)
+			return dev;
+		dev =3D udev_device_get_parent(dev);
+	}
+
+	return NULL; =

 }
 =

 static const char *get_serial(struct udev_device *udev_device)
@@ -216,54 +234,29 @@ static void add_sim900(struct ofono_modem *modem,
 static void add_modem(struct udev_device *udev_device)
 {
 	struct ofono_modem *modem;
-	struct udev_device *parent;
 	const char *devpath, *curpath, *driver;
+	struct udev_device *mdev;
 =

-	driver =3D get_driver(udev_device);
-	if (driver !=3D NULL) {
-		devpath =3D udev_device_get_devpath(udev_device);
-		if (devpath =3D=3D NULL)
-			return;
-
-		if(g_strcmp0(driver, "tc65") =3D=3D 0)
-			driver =3D "cinterion";
-		if(g_strcmp0(driver, "ehs6") =3D=3D 0)
-			driver =3D "cinterion";
-
-		modem =3D ofono_modem_create(NULL, driver);
-		if (modem =3D=3D NULL)
-			return;
-
-		ofono_modem_set_string(modem, "Path", devpath);
-
-		modem_list =3D g_slist_prepend(modem_list, modem);
-
-		goto done;
+	mdev =3D get_modem_device(udev_device);
+	if (!mdev) {
+		DBG("Device has no OFONO_DRIVER property");
+		return;
 	}
 =

-	parent =3D udev_device_get_parent(udev_device);
-	if (parent =3D=3D NULL)
-		return;
+	driver =3D udev_device_get_property_value(mdev, "OFONO_DRIVER");
 =

-	driver =3D get_driver(parent);
-	if (driver =3D=3D NULL) {
-		parent =3D udev_device_get_parent(parent);
-		driver =3D get_driver(parent);
-		if (driver =3D=3D NULL) {
-			parent =3D udev_device_get_parent(parent);
-			driver =3D get_driver(parent);
-			if (driver =3D=3D NULL)
-				return;
-		}
-	}
+	if(g_strcmp0(driver, "tc65") =3D=3D 0)
+		driver =3D "cinterion";
+	if(g_strcmp0(driver, "ehs6") =3D=3D 0)
+		driver =3D "cinterion";
 =

-	devpath =3D udev_device_get_devpath(parent);
+	devpath =3D udev_device_get_devpath(mdev);
 	if (devpath =3D=3D NULL)
 		return;
 =

 	modem =3D find_modem(devpath);
 	if (modem =3D=3D NULL) {
-		const char *serial =3D get_serial(parent);
+		const char *serial =3D get_serial(mdev);
 =

 		modem =3D ofono_modem_create(serial, driver);
 		if (modem =3D=3D NULL)
@@ -274,7 +267,6 @@ static void add_modem(struct udev_device *udev_device)
 		modem_list =3D g_slist_prepend(modem_list, modem);
 	}
 =

-done:
 	curpath =3D udev_device_get_devpath(udev_device);
 	if (curpath =3D=3D NULL)
 		return;
-- =

2.9.3


--===============6601426713445056426==--

