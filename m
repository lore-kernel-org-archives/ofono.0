Content-Type: multipart/mixed; boundary="===============7599559495286860629=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Fri, 27 Sep 2019 11:21:20 +0530
Message-ID: <1569563480-16711-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7599559495286860629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support for enumerating PCIe types of modems in ofono
---
 plugins/udevng.c | 178 +++++++++++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 135 insertions(+), 43 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1b54b4a..89bbdf3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -41,6 +41,7 @@
 enum modem_type {
 	MODEM_TYPE_USB,
 	MODEM_TYPE_SERIAL,
+	MODEM_TYPE_PCIE,
 };
 =

 struct modem_info {
@@ -1229,26 +1230,47 @@ static gboolean setup_xmm7xxx(struct modem_info *mo=
dem)
 				info->interface, info->number, info->label,
 				info->sysattr, info->subsystem);
 =

-		if (g_strcmp0(modem->model,"095a") =3D=3D 0) {
-			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
-				if (g_strcmp0(info->number, "00") =3D=3D 0)
-					mdm =3D info->devnode;
-			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
-				if (g_strcmp0(info->number, "06") =3D=3D 0)
-					net =3D info->devnode;
-				if (g_strcmp0(info->number, "08") =3D=3D 0)
-					net2 =3D info->devnode;
-				if (g_strcmp0(info->number, "0a") =3D=3D 0)
-					net3 =3D info->devnode;
+		if (g_strcmp0(info->subsystem, "pci") =3D=3D 0) {
+			if ((g_strcmp0(modem->vendor, "0x8086") =3D=3D 0) &&
+				(g_strcmp0(modem->model, "0x7560") =3D=3D 0)) {
+				mdm =3D "/dev/iat";
+				net =3D "inm0";
+				net2 =3D "inm1";
+				net3 =3D "inm2";
+				ofono_modem_set_string(modem->modem,
+					"CtrlPath", "/PCIE/IOSM/CTRL/1");
+				ofono_modem_set_string(modem->modem, "DataPath",
+					"/PCIE/IOSM/IPS/");
 			}
-		} else {
-			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
-				if (g_strcmp0(info->number, "02") =3D=3D 0)
-					mdm =3D info->devnode;
-			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
-				if (g_strcmp0(info->number, "00") =3D=3D 0)
-					net =3D info->devnode;
+		} else { /* For USB */
+			if (g_strcmp0(modem->model, "095a") =3D=3D 0) {
+				if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+					if (g_strcmp0(info->number, "00") =3D=3D 0)
+						mdm =3D info->devnode;
+				} else if (g_strcmp0(info->subsystem, "net")
+									=3D=3D 0) {
+					if (g_strcmp0(info->number, "06") =3D=3D 0)
+						net =3D info->devnode;
+					if (g_strcmp0(info->number, "08") =3D=3D 0)
+						net2 =3D info->devnode;
+					if (g_strcmp0(info->number, "0a") =3D=3D 0)
+						net3 =3D info->devnode;
+				}
+			} else {
+				if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+					if (g_strcmp0(info->number, "02") =3D=3D 0)
+						mdm =3D info->devnode;
+				} else if (g_strcmp0(info->subsystem, "net")
+									=3D=3D 0) {
+					if (g_strcmp0(info->number, "00") =3D=3D 0)
+						net =3D info->devnode;
+				}
 			}
+
+			ofono_modem_set_string(modem->modem, "CtrlPath",
+								"/USBCDC/0");
+			ofono_modem_set_string(modem->modem, "DataPath",
+								"/USBHS/NCM/");
 		}
 	}
 =

@@ -1266,9 +1288,6 @@ static gboolean setup_xmm7xxx(struct modem_info *mode=
m)
 	if (net3)
 		ofono_modem_set_string(modem->modem, "NetworkInterface3", net3);
 =

-	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
-	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
-
 	return TRUE;
 }
 =

@@ -1437,6 +1456,7 @@ static void destroy_modem(gpointer data)
 =

 	switch (modem->type) {
 	case MODEM_TYPE_USB:
+	case MODEM_TYPE_PCIE:
 		for (list =3D modem->devices; list; list =3D list->next) {
 			struct device_info *info =3D list->data;
 =

@@ -1467,6 +1487,7 @@ static gboolean check_remove(gpointer key, gpointer v=
alue, gpointer user_data)
 =

 	switch (modem->type) {
 	case MODEM_TYPE_USB:
+	case MODEM_TYPE_PCIE:
 		for (list =3D modem->devices; list; list =3D list->next) {
 			struct device_info *info =3D list->data;
 =

@@ -1599,7 +1620,8 @@ static void add_serial_device(struct udev_device *dev)
 =

 static void add_device(const char *syspath, const char *devname,
 			const char *driver, const char *vendor,
-			const char *model, struct udev_device *device)
+			const char *model, struct udev_device *device,
+			enum modem_type type)
 {
 	struct udev_device *usb_interface;
 	const char *devpath, *devnode, *interface, *number;
@@ -1612,25 +1634,13 @@ static void add_device(const char *syspath, const c=
har *devname,
 	if (devpath =3D=3D NULL)
 		return;
 =

-	devnode =3D udev_device_get_devnode(device);
-	if (devnode =3D=3D NULL) {
-		devnode =3D udev_device_get_property_value(device, "INTERFACE");
-		if (devnode =3D=3D NULL)
-			return;
-	}
-
-	usb_interface =3D udev_device_get_parent_with_subsystem_devtype(device,
-						"usb", "usb_interface");
-	if (usb_interface =3D=3D NULL)
-		return;
-
 	modem =3D g_hash_table_lookup(modem_list, syspath);
 	if (modem =3D=3D NULL) {
 		modem =3D g_try_new0(struct modem_info, 1);
 		if (modem =3D=3D NULL)
 			return;
 =

-		modem->type =3D MODEM_TYPE_USB;
+		modem->type =3D type;
 		modem->syspath =3D g_strdup(syspath);
 		modem->devname =3D g_strdup(devname);
 		modem->driver =3D g_strdup(driver);
@@ -1642,8 +1652,37 @@ static void add_device(const char *syspath, const ch=
ar *devname,
 		g_hash_table_replace(modem_list, modem->syspath, modem);
 	}
 =

-	interface =3D udev_device_get_property_value(usb_interface, "INTERFACE");
-	number =3D udev_device_get_property_value(device, "ID_USB_INTERFACE_NUM");
+	if (modem->type =3D=3D MODEM_TYPE_USB) {
+		devnode =3D udev_device_get_devnode(device);
+		if (devnode =3D=3D NULL) {
+			devnode =3D udev_device_get_property_value(device,
+							"INTERFACE");
+			if (devnode =3D=3D NULL)
+				return;
+		}
+
+		usb_interface =3D udev_device_get_parent_with_subsystem_devtype(
+							device, "usb",
+							"usb_interface");
+		if (usb_interface =3D=3D NULL)
+			return;
+
+		interface =3D udev_device_get_property_value(usb_interface,
+							"INTERFACE");
+		number =3D udev_device_get_property_value(device,
+						"ID_USB_INTERFACE_NUM");
+
+		label =3D udev_device_get_property_value(device, "OFONO_LABEL");
+		if (!label)
+			label =3D udev_device_get_property_value(usb_interface,
+							"OFONO_LABEL");
+	} else {
+		devnode =3D NULL;
+		interface =3D udev_device_get_property_value(device,
+							"INTERFACE");
+		number =3D NULL;
+		label =3D NULL;
+	}
 =

 	/* If environment variable is not set, get value from attributes (or pare=
nt's ones) */
 	if (number =3D=3D NULL) {
@@ -1657,11 +1696,6 @@ static void add_device(const char *syspath, const ch=
ar *devname,
 		}
 	}
 =

-	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
-	if (!label)
-		label =3D udev_device_get_property_value(usb_interface,
-							"OFONO_LABEL");
-
 	subsystem =3D udev_device_get_subsystem(device);
 =

 	if (modem->sysattr !=3D NULL)
@@ -1855,9 +1889,64 @@ static void check_usb_device(struct udev_device *dev=
ice)
 			return;
 	}
 =

-	add_device(syspath, devname, driver, vendor, model, device);
+	add_device(syspath, devname, driver, vendor, model, device,
+			MODEM_TYPE_USB);
 }
 =

+static struct {
+	const char *driver;
+	const char *drv;
+	const char *vid;
+	const char *pid;
+} pci_driver_list[] =3D {
+	{ "xmm7xxx",	"imc_ipc",	"0x8086",	"0x7560"},
+	{ }
+};
+
+static void check_pci_device(struct udev_device *device)
+{
+	const char *syspath, *devname, *driver;
+	const char *vendor =3D NULL, *model =3D NULL, *drv =3D NULL;
+	unsigned int i;
+
+	syspath =3D udev_device_get_syspath(device);
+
+	if (syspath =3D=3D NULL)
+		return;
+
+	devname =3D udev_device_get_devnode(device);
+	vendor =3D udev_device_get_sysattr_value(device, "vendor");
+	model =3D udev_device_get_sysattr_value(device, "device");
+	driver =3D udev_device_get_property_value(device, "OFONO_DRIVER");
+	drv =3D udev_device_get_property_value(device, "DRIVER");
+	DBG("%s [%s:%s]", drv, vendor, model);
+
+	if (vendor =3D=3D NULL || model =3D=3D NULL || drv =3D=3D NULL)
+		return;
+
+	for (i =3D 0; pci_driver_list[i].driver; i++) {
+		if (g_str_equal(pci_driver_list[i].drv, drv) =3D=3D FALSE)
+			continue;
+
+		if (pci_driver_list[i].vid) {
+			if (!g_str_equal(pci_driver_list[i].vid, vendor))
+				continue;
+		}
+
+		if (pci_driver_list[i].pid) {
+			if (!g_str_equal(pci_driver_list[i].pid, model))
+				continue;
+		}
+
+		driver =3D pci_driver_list[i].driver;
+	}
+
+	if (driver =3D=3D NULL)
+		return;
+
+	add_device(syspath, devname, driver, vendor, model, device,
+			MODEM_TYPE_PCIE);
+}
 static void check_device(struct udev_device *device)
 {
 	const char *bus;
@@ -1872,6 +1961,8 @@ static void check_device(struct udev_device *device)
 	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
 			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
 		check_usb_device(device);
+	else if (g_str_equal(bus, "pci") =3D=3D TRUE)
+		check_pci_device(device);
 	else
 		add_serial_device(device);
 =

@@ -1932,6 +2023,7 @@ static void enumerate_devices(struct udev *context)
 	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
 	udev_enumerate_add_match_subsystem(enumerate, "hsi");
+	udev_enumerate_add_match_subsystem(enumerate, "pci");
 =

 	udev_enumerate_scan_devices(enumerate);
 =

-- =

1.9.1


--===============7599559495286860629==--

