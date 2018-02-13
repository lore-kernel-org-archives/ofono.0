Content-Type: multipart/mixed; boundary="===============7566036814692552035=="
MIME-Version: 1.0
From: Pau Espin Pedrol <pespin@sysmocom.de>
Subject: [PATCH] udevng: Add OFONO_PATHNAME property to set modem dbus path
 name
Date: Tue, 13 Feb 2018 20:53:38 +0100
Message-ID: <20180213195338.30077-1-pespin@sysmocom.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7566036814692552035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current udevng.c implementation sets dbus path names for modems
based on type and a number incremented seuqntially for each new modem
found. As a result, the dbus path for a given device is non
deterministic, since it depends on the devices available during ofono
startup.

Furthermore, if a modem crashes and reboots while in operation, then
udev will trigger a remove event followed by a create event, and the
same modem will now be given a different name (as the sequence number is
bigger).

This is non suitable for systems handling several modems which want to
identify them easily based on its path.

This patch introduces a way to be able to set persistent names for
specific devices while still permitting previous dynamic naming
methodology.

One can set a persistent name using udev rules for the target device
which set the OFONO_PATHNAME env property. If ofono finds this property
set, it will use its value as the dbus path name for the modem.

Example:
$ cat /etc/udev/rules.d/90-local.rules
SUBSYSTEMS=3D=3D"usb", DEVPATH=3D=3D"/devices/pci0000:00/0000:00:1a.0/usb3/=
3-1/3-1.1/3-1.1.4/3-1.1.4.1/3-1.1.4.1.1", ENV{OFONO_PATHNAME}=3D"foo"

$ udevadm info -p /devices/pci0000:00/0000:00:1a.0/usb3/3-1/3-1.1/3-1.1.4/3=
-1.1.4.1/3-1.1.4.1.1
...
E: OFONO_PATHNAME=3Dfoo
...

$ mdbus2 -s org.ofono
/
/bluetooth
/bluetooth/profile
/bluetooth/profile/dun_gw
/bluetooth/profile/hfp_ag
/bluetooth/profile/hfp_hf
/foo
/mbm_0
---
 plugins/udevng.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 9b78ab47..e9f27977 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -46,6 +46,7 @@ enum modem_type {
 struct modem_info {
 	char *syspath;
 	char *devname;
+	char *pathname;
 	char *driver;
 	char *vendor;
 	char *model;
@@ -1302,6 +1303,7 @@ static void destroy_modem(gpointer data)
 =

 	g_free(modem->syspath);
 	g_free(modem->devname);
+	g_free(modem->pathname);
 	g_free(modem->driver);
 	g_free(modem->vendor);
 	g_free(modem->model);
@@ -1382,7 +1384,7 @@ static struct udev_device* get_serial_modem_device(st=
ruct udev_device *dev)
  */
 static void add_serial_device(struct udev_device *dev)
 {
-	const char *syspath, *devpath, *devname, *devnode;
+	const char *syspath, *devpath, *devname, *devnode, *pathname;
 	struct modem_info *modem;
 	struct serial_device_info *info;
 	const char *subsystem;
@@ -1396,6 +1398,7 @@ static void add_serial_device(struct udev_device *dev)
 	}
 =

 	driver =3D udev_device_get_property_value(mdev, "OFONO_DRIVER");
+	pathname =3D udev_device_get_property_value(mdev, "OFONO_PATHNAME");
 =

 	syspath =3D udev_device_get_syspath(mdev);
 	devname =3D udev_device_get_devnode(mdev);
@@ -1415,6 +1418,7 @@ static void add_serial_device(struct udev_device *dev)
 		modem->type =3D MODEM_TYPE_SERIAL;
 		modem->syspath =3D g_strdup(syspath);
 		modem->devname =3D g_strdup(devname);
+		modem->pathname =3D g_strdup(pathname);
 		modem->driver =3D g_strdup(driver);
 =

 		g_hash_table_replace(modem_list, modem->syspath, modem);
@@ -1440,7 +1444,8 @@ static void add_serial_device(struct udev_device *dev)
 =

 static void add_device(const char *syspath, const char *devname,
 			const char *driver, const char *vendor,
-			const char *model, struct udev_device *device)
+			const char *model, const char *pathname,
+			struct udev_device *device)
 {
 	struct udev_device *usb_interface;
 	const char *devpath, *devnode, *interface, *number;
@@ -1477,6 +1482,7 @@ static void add_device(const char *syspath, const cha=
r *devname,
 		modem->driver =3D g_strdup(driver);
 		modem->vendor =3D g_strdup(vendor);
 		modem->model =3D g_strdup(model);
+		modem->pathname =3D g_strdup(pathname);
 =

 		modem->sysattr =3D get_sysattr(driver);
 =

@@ -1512,8 +1518,8 @@ static void add_device(const char *syspath, const cha=
r *devname,
 =

 	DBG("%s", syspath);
 	DBG("%s", devpath);
-	DBG("%s (%s) %s [%s] =3D=3D> %s %s", devnode, driver,
-					interface, number, label, sysattr);
+	DBG("%s (%s) %s [%s] =3D=3D> %s %s %s",
+		devnode, driver, interface, number, label, sysattr, pathname);
 =

 	info =3D g_try_new0(struct device_info, 1);
 	if (info =3D=3D NULL)
@@ -1611,7 +1617,7 @@ static struct {
 static void check_usb_device(struct udev_device *device)
 {
 	struct udev_device *usb_device;
-	const char *syspath, *devname, *driver;
+	const char *syspath, *devname, *driver, *pathname;
 	const char *vendor =3D NULL, *model =3D NULL;
 =

 	usb_device =3D udev_device_get_parent_with_subsystem_devtype(device,
@@ -1630,6 +1636,8 @@ static void check_usb_device(struct udev_device *devi=
ce)
 	vendor =3D udev_device_get_property_value(usb_device, "ID_VENDOR_ID");
 	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
 =

+	pathname =3D udev_device_get_property_value(usb_device, "OFONO_PATHNAME");
+
 	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
 	if (!driver) {
 		struct udev_device *usb_interface =3D
@@ -1685,7 +1693,7 @@ static void check_usb_device(struct udev_device *devi=
ce)
 			return;
 	}
 =

-	add_device(syspath, devname, driver, vendor, model, device);
+	add_device(syspath, devname, driver, vendor, model, pathname, device);
 }
 =

 static void check_device(struct udev_device *device)
@@ -1723,7 +1731,7 @@ static gboolean create_modem(gpointer key, gpointer v=
alue, gpointer user_data)
 =

 	DBG("driver=3D%s", modem->driver);
 =

-	modem->modem =3D ofono_modem_create(NULL, modem->driver);
+	modem->modem =3D ofono_modem_create(modem->pathname, modem->driver);
 	if (modem->modem =3D=3D NULL)
 		return TRUE;
 =

-- =

2.16.1


--===============7566036814692552035==--

