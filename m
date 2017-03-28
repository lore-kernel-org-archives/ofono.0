Content-Type: multipart/mixed; boundary="===============7557858090950452049=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH udev v3 1/5] udevng: add serial device handling functions
Date: Tue, 28 Mar 2017 23:54:11 +0200
Message-ID: <20170328215416.20119-2-jonas@southpole.se>
In-Reply-To: <20170328215416.20119-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7557858090950452049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds, but does not hook up, support for simple serial modems.  These
modems generally have only a single device node so are simpler than the
USB devices which generally have different device nodes for different
functions.  These modems are currently handled by udev.c, but this
functionality will allow to remove that module completely in a later patch.

- A new "device_info" type is created called serial_device_info
- the function add_serial_device sets up a modem_info structure and a
  serial_device_info for the device
- A reference to the device's udev node is saved in the device info
- The device driver is retrieved from the OFONO_DRIVER environment variable
  which needs to be set up by some udev rule
- Setup functions are added for these types of devices: a common function
  setup_serial_modem covers the generic (simple) case, whereas modems
  with special requirements are given their own setup functions to handle
  the special bits
- Modem destroy needs to know the "device_info" type in order to clean
  up properly, so a 'type' value is set on the modem_info structure to
  guide selection of the proper cleanup function
---
 plugins/udevng.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 249 insertions(+), 16 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2cd32c7..d33c5f1 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -37,13 +37,22 @@
 #include <ofono/modem.h>
 #include <ofono/log.h>
 =

+typedef enum {
+	MODEM_TYPE_USB,
+	MODEM_TYPE_SERIAL,
+} ModemType;
+
 struct modem_info {
 	char *syspath;
 	char *devname;
 	char *driver;
 	char *vendor;
 	char *model;
-	GSList *devices;
+	ModemType type;
+	union {
+		GSList *devices;
+		struct serial_device_info* serial;
+	};
 	struct ofono_modem *modem;
 	const char *sysattr;
 };
@@ -58,6 +67,14 @@ struct device_info {
 	char *subsystem;
 };
 =

+struct serial_device_info {
+	char *devpath;
+	char *devnode;
+	char *subsystem;
+	struct udev_device* dev;
+};
+
+
 static gboolean setup_isi(struct modem_info *modem)
 {
 	const char *node =3D NULL;
@@ -867,6 +884,100 @@ static gboolean setup_quectel(struct modem_info *mode=
m)
 	return TRUE;
 }
 =

+static gboolean setup_serial_modem(struct modem_info* modem)
+{
+	struct serial_device_info* info;
+
+	info =3D modem->serial;
+
+	ofono_modem_set_string(modem->modem, "Device", info->devnode);
+
+	return TRUE;
+}
+
+static gboolean setup_tc65(struct modem_info* modem)
+{
+	ofono_modem_set_driver(modem->modem, "cinterion");
+
+	return setup_serial_modem(modem);
+}
+
+static gboolean setup_ehs6(struct modem_info* modem)
+{
+	ofono_modem_set_driver(modem->modem, "cinterion");
+
+	return setup_serial_modem(modem);
+}
+
+static gboolean setup_ifx(struct modem_info* modem)
+{
+	struct serial_device_info* info;
+	const char *value;
+
+	info =3D modem->serial;
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_LDISC");
+	if (value)
+		ofono_modem_set_string(modem->modem, "LineDiscipline", value);
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_AUDIO");
+	if (value)
+		ofono_modem_set_string(modem->modem, "AudioSetting", value);
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_LOOPBACK");
+	if (value)
+		ofono_modem_set_string(modem->modem, "AudioLoopback", value);
+
+	ofono_modem_set_string(modem->modem, "Device", info->devnode);
+
+	return TRUE;
+}
+
+static gboolean setup_wavecom(struct modem_info* modem)
+{
+	struct serial_device_info* info;
+	const char *value;
+
+	info =3D modem->serial;
+
+	value =3D udev_device_get_property_value(info->dev,
+						"OFONO_WAVECOM_MODEL");
+	if (value)
+		ofono_modem_set_string(modem->modem, "Model", value);
+
+	ofono_modem_set_string(modem->modem, "Device", info->devnode);
+
+	return TRUE;
+}
+
+static gboolean setup_isi_serial(struct modem_info* modem)
+{
+	struct serial_device_info* info;
+	const char *value;
+
+	info =3D modem->serial;
+
+	if (g_strcmp0(udev_device_get_subsystem(info->dev), "net") !=3D 0)
+		return FALSE;
+
+	value =3D udev_device_get_sysattr_value(info->dev, "type");
+	if (g_strcmp0(value, "820") !=3D 0)
+		return FALSE;
+
+	/* OK, we want this device to be a modem */
+	value =3D udev_device_get_sysname(info->dev);
+	if (value)
+		ofono_modem_set_string(modem->modem, "Interface", value);
+
+	value =3D udev_device_get_property_value(info->dev, "OFONO_ISI_ADDRESS");
+	if (value)
+		ofono_modem_set_integer(modem->modem, "Address", atoi(value));
+
+	ofono_modem_set_string(modem->modem, "Device", info->devnode);
+
+	return TRUE;
+}
+
 static gboolean setup_ublox(struct modem_info *modem)
 {
 	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
@@ -997,6 +1108,17 @@ static struct {
 	{ "quectel",	setup_quectel	},
 	{ "ublox",	setup_ublox	},
 	{ "gemalto",	setup_gemalto	},
+	/* Following are non-USB modems */
+	{ "ifx",	setup_ifx		},
+	{ "u8500",	setup_isi_serial	},
+	{ "n900",	setup_isi_serial	},
+	{ "calypso",	setup_serial_modem	},
+	{ "cinterion",	setup_serial_modem	},
+	{ "nokiacdma",	setup_serial_modem	},
+	{ "sim900",	setup_serial_modem	},
+	{ "wavecom",	setup_wavecom		},
+	{ "tc65",	setup_tc65		},
+	{ "ehs6",	setup_ehs6		},
 	{ }
 };
 =

@@ -1014,6 +1136,27 @@ static const char *get_sysattr(const char *driver)
 	return NULL;
 }
 =

+static void device_info_free(struct device_info* info)
+{
+	g_free(info->devpath);
+	g_free(info->devnode);
+	g_free(info->interface);
+	g_free(info->number);
+	g_free(info->label);
+	g_free(info->sysattr);
+	g_free(info->subsystem);
+	g_free(info);
+}
+
+static void serial_device_info_free(struct serial_device_info* info)
+{
+	g_free(info->devpath);
+	g_free(info->devnode);
+	g_free(info->subsystem);
+	udev_device_unref(info->dev);
+	g_free(info);
+}
+
 static void destroy_modem(gpointer data)
 {
 	struct modem_info *modem =3D data;
@@ -1023,25 +1166,22 @@ static void destroy_modem(gpointer data)
 =

 	ofono_modem_remove(modem->modem);
 =

-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s", info->devnode);
+	switch (modem->type) {
+	case MODEM_TYPE_USB:
+		for (list =3D modem->devices; list; list =3D list->next) {
+			struct device_info *info =3D list->data;
 =

-		g_free(info->devpath);
-		g_free(info->devnode);
-		g_free(info->interface);
-		g_free(info->number);
-		g_free(info->label);
-		g_free(info->sysattr);
-		g_free(info->subsystem);
-		g_free(info);
+			DBG("%s", info->devnode);
+			device_info_free(info);
+		}
 =

-		list->data =3D NULL;
+		g_slist_free(modem->devices);
+		break;
+	case MODEM_TYPE_SERIAL:
+		serial_device_info_free(modem->serial);
+		break;
 	}
 =

-	g_slist_free(modem->devices);
-
 	g_free(modem->syspath);
 	g_free(modem->devname);
 	g_free(modem->driver);
@@ -1088,6 +1228,98 @@ static gint compare_device(gconstpointer a, gconstpo=
inter b)
 	return g_strcmp0(info1->number, info2->number);
 }
 =

+/*
+ * Here we try to find the "modem device".
+ *
+ * In this variant we identify the "modem device" as simply the device
+ * that has the OFONO_DRIVER property.  If the device node doesn't
+ * have this property itself, then we do a brute force search for it
+ * through the device hierarchy.
+ *
+ */
+static struct udev_device* get_serial_modem_device(struct udev_device *dev)
+{
+	const char* driver;
+
+	while (dev) {
+		driver =3D udev_device_get_property_value(dev, "OFONO_DRIVER");
+		if (driver)
+			return dev;
+
+		dev =3D udev_device_get_parent(dev);
+	}
+
+	return NULL;
+}
+
+/*
+ * Add 'legacy' device
+ *
+ * The term legacy is a bit misleading, but this adds devices according
+ * to the original ofono model.
+ *
+ * - We cannot assume that these are USB devices
+ * - The modem consists of only a single interface
+ * - The device must have an OFONO_DRIVER property from udev
+ */
+static void add_serial_device(struct udev_device *dev)
+{
+	const char *syspath, *devpath, *devname, *devnode;
+	struct modem_info *modem;
+	struct serial_device_info *info;
+	const char *subsystem;
+	struct udev_device* mdev;
+	const char* driver;
+
+	mdev =3D get_serial_modem_device(dev);
+	if (!mdev) {
+		DBG("Device is missing required OFONO_DRIVER property");
+		return;
+	}
+
+	driver =3D udev_device_get_property_value(mdev, "OFONO_DRIVER");
+
+	syspath =3D udev_device_get_syspath(mdev);
+	devname =3D udev_device_get_devnode(mdev);
+	devpath =3D udev_device_get_devpath(mdev);
+
+	devnode =3D udev_device_get_devnode(dev);
+
+	if (!syspath || !devname || !devpath || !devnode)
+		return;
+
+	modem =3D g_hash_table_lookup(modem_list, syspath);
+	if (modem =3D=3D NULL) {
+		modem =3D g_try_new0(struct modem_info, 1);
+		if (modem =3D=3D NULL)
+			return;
+
+		modem->type =3D MODEM_TYPE_SERIAL;
+		modem->syspath =3D g_strdup(syspath);
+		modem->devname =3D g_strdup(devname);
+		modem->driver =3D g_strdup("legacy");
+
+		g_hash_table_replace(modem_list, modem->syspath, modem);
+	}
+
+	subsystem =3D udev_device_get_subsystem(dev);
+
+	DBG("%s", syspath);
+	DBG("%s", devpath);
+	DBG("%s (%s)", devnode, driver);
+
+	info =3D g_try_new0(struct serial_device_info, 1);
+	if (info =3D=3D NULL)
+		return;
+
+	info->devpath =3D g_strdup(devpath);
+	info->devnode =3D g_strdup(devnode);
+	info->subsystem =3D g_strdup(subsystem);
+	info->dev =3D udev_device_ref(dev);
+
+	modem->devices =3D g_slist_append(modem->devices, info);
+}
+
 static void add_device(const char *syspath, const char *devname,
 			const char *driver, const char *vendor,
 			const char *model, struct udev_device *device)
@@ -1121,6 +1353,7 @@ static void add_device(const char *syspath, const cha=
r *devname,
 		if (modem =3D=3D NULL)
 			return;
 =

+		modem->type =3D MODEM_TYPE_USB;
 		modem->syspath =3D g_strdup(syspath);
 		modem->devname =3D g_strdup(devname);
 		modem->driver =3D g_strdup(driver);
-- =

2.9.3


--===============7557858090950452049==--

