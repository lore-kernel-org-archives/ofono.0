Content-Type: multipart/mixed; boundary="===============3331517299131376585=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev 11/15] udevng: add legacy device handling functions
Date: Sun, 26 Mar 2017 22:24:39 -0500
Message-ID: <51961e21-7d40-2cec-970b-2d44e218a4a9@gmail.com>
In-Reply-To: <20170325165805.28166-12-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3331517299131376585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/25/2017 11:58 AM, Jonas Bonn wrote:
> This adds, but does not hook up, functionality to handle devices
> that are currently handled by the 'legacy' udev.c module.
>
> - legacy device is added by calling the add_legacy_device() function.
> - the function sets up a modem_info and device_info structure for
>   the legacy device
> - the device driver is set to "legacy" and the real driver type is
>   saved in the device_info structure
> - the extra udev information from the add_*() functions of the old
>   udev.c module is added to unused fields of the device_info structure
> - the "legacy" driver is set-up to use setup_legacy
> - setup_legacy extracts the device_info information and applies it
>   to the modem in the same way that the add_*() funtions did
> - the modem driver is switched to the real driver
>
> ...and off we go!
> ---
>  plugins/udevng.c | 255 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 255 insertions(+)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ce2bc28..4e464c2 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -830,6 +830,52 @@ static gboolean setup_quectel(struct modem_info *mod=
em)
>  	return TRUE;
>  }
>
> +static gboolean setup_legacy(struct modem_info *modem)
> +{
> +	const char* mdm =3D NULL;
> +	const char* driver =3D NULL;
> +	GSList *list;
> +
> +	/* These legacy device normally only have one device... */
> +	for (list =3D modem->devices; list; list =3D list->next) {
> +		struct device_info *info =3D list->data;
> +
> +		if (!g_strcmp0(modem->driver, "ifx")) {
> +			ofono_modem_set_string(modem->modem,
> +					"LineDiscipline", info->number);
> +			ofono_modem_set_string(modem->modem,
> +					"AudioSetting", info->label);
> +			ofono_modem_set_string(modem->modem,
> +					"AudioLoopback", info->interface);
> +		} else if (!g_strcmp0(modem->driver, "8500")) {
> +		} else if (!g_strcmp0(modem->driver, "n900")) {
> +			if (!info->interface)
> +				continue;
> +
> +			ofono_modem_set_integer(modem->modem,
> +				"Address", atoi(info->number));
> +			ofono_modem_set_string(modem->modem,
> +					"Interface", info->interface);
> +
> +		} else if (!g_strcmp0(modem->driver, "wavecom")) {
> +			ofono_modem_set_string(modem->modem,
> +					"Model", info->number);
> +		}
> +
> +		mdm =3D info->devnode;
> +		driver =3D info->sysattr;
> +	}
> +
> +	if (!mdm)
> +		return FALSE;
> +
> +	ofono_modem_set_driver(modem->modem, driver);
> +
> +	ofono_modem_set_string(modem->modem, "Device", mdm);	=

> +
> +	return TRUE;
> +}
> +
>  static gboolean setup_ublox(struct modem_info *modem)
>  {
>  	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
> @@ -959,6 +1005,7 @@ static struct {
>  	{ "quectel",	setup_quectel	},
>  	{ "ublox",	setup_ublox	},
>  	{ "gemalto",	setup_gemalto	},
> +	{ "legacy",	setup_legacy	},
>  	{ }
>  };
>
> @@ -1050,6 +1097,214 @@ static gint compare_device(gconstpointer a, gcons=
tpointer b)
>  	return g_strcmp0(info1->number, info2->number);
>  }
>
> +/*
> + * These add_*_info functions are part of the add_legacy_device()
> + * functionality.  Don't re-use them in anything new; ideally they will
> + * be able to go away when the hardware is deemed unavailable.
> + */
> +static void add_isi_info(struct device_info* info,
> +					struct udev_device *udev_device)
> +{
> +	const char *value;
> +	const char* type;
> +	const char* ifname;
> +
> +	/* Set info->interface if we want this device to be a modem;
> +	 * leave it as NULL to ignore it
> +	 */
> +	if (g_strcmp0(udev_device_get_subsystem(udev_device), "net") !=3D 0)
> +		return;
> +
> +	type =3D udev_device_get_sysattr_value(udev_device, "type");
> +	if (g_strcmp0(type, "820") !=3D 0)
> +		return;
> +
> +	/* OK, we want this device to be a modem */
> +	ifname =3D udev_device_get_sysname(udev_device);
> +	if (ifname)
> +		info->interface =3D g_strdup(ifname);
> +
> +	value =3D udev_device_get_property_value(udev_device,
> +						"OFONO_ISI_ADDRESS");
> +	if (value)
> +		info->number =3D g_strdup(value);
> +}
> +
> +
> +static void add_wavecom_info(struct device_info *info, struct udev_devic=
e *dev)
> +{
> +	const char *value;
> +
> +	value =3D udev_device_get_property_value(dev, "OFONO_WAVECOM_MODEL");
> +	if (value)
> +		info->number =3D g_strdup(value);
> +}
> +
> +static void add_ifx_info(struct device_info* info, struct udev_device *d=
ev)
> +{
> +	const char *value;
> +
> +	value =3D udev_device_get_property_value(dev, "OFONO_IFX_LDISC");
> +	if (value)
> +		info->number =3D g_strdup(value);
> +	value =3D udev_device_get_property_value(dev, "OFONO_IFX_AUDIO");
> +	if (value)
> +		info->label =3D g_strdup(value);
> +	value =3D udev_device_get_property_value(dev, "OFONO_IFX_LOOPBACK");
> +	if (value)
> +		info->interface =3D g_strdup(value);
> +}
> +
> +/*
> + * Here we try to find the "modem device".
> + *
> + * In this variant we identify the "modem device" as simply the device
> + * that has the OFONO_DRIVER property.  If the device node doesn't
> + * have this property itself, then we do a brute force search for it
> + * through the device hierarchy.
> + *
> + */
> +static struct udev_device* get_legacy_modem_device(struct udev_device *d=
ev)
> +{
> +	const char* driver;
> +
> +	while (dev) {
> +		driver =3D udev_device_get_property_value(dev, "OFONO_DRIVER");
> +		if (driver)
> +			return dev;
> +		dev =3D udev_device_get_parent(dev);
> +	}
> +
> +	return NULL;
> +}
> +
> +
> +/*
> + * Add 'legacy' device
> + *
> + * The term legacy is a bit misleading, but this adds devices according
> + * to the original ofono model.
> + *
> + * - We cannot assume that these are USB devices
> + * - The modem consists of only a single interface
> + * - The device must have an OFONO_DRIVER property from udev
> + */
> +static void add_legacy_device(struct udev_device *dev)
> +{
> +	const char *syspath, *devpath, *devname, *devnode;
> +	struct udev_device *usb_device;
> +	struct modem_info *modem;
> +	struct device_info *info;
> +	const char* vendor =3D NULL;
> +	const char* model =3D NULL;
> +	const char *subsystem;
> +	struct udev_device* mdev;
> +	const char* driver;
> +
> +	mdev =3D get_legacy_modem_device(dev);
> +	if (!mdev) {
> +		DBG("Device is missing required OFONO_DRIVER property");
> +		return;
> +	}
> +
> +	driver =3D udev_device_get_property_value(mdev, "OFONO_DRIVER");
> +	/* Check that this really is a legacy driver */
> +	if (!g_strcmp0(driver, "ifx")) goto start;
> +	if (!g_strcmp0(driver, "u8500")) goto start;
> +	if (!g_strcmp0(driver, "n900")) goto start;
> +	if (!g_strcmp0(driver, "calypso")) goto start;
> +	if (!g_strcmp0(driver, "cinterion")) goto start;
> +	if (!g_strcmp0(driver, "nokiacdma")) goto start;
> +	if (!g_strcmp0(driver, "sim900")) goto start;
> +	if (!g_strcmp0(driver, "wavecom")) goto start;

This might look better as a table

> +	if (!g_strcmp0(driver, "tc65")) {
> +		driver=3D "cinterion";
> +		goto start;
> +	}
> +	if (!g_strcmp0(driver, "ehs6")) {
> +		driver=3D "cinterion";
> +		goto start;
> +	}
> +
> +	/* Driver isn't something we recognize... */
> +	return;
> +start:
> +
> +	syspath =3D udev_device_get_syspath(mdev);
> +	devname =3D udev_device_get_devnode(mdev);
> +	devpath =3D udev_device_get_devpath(mdev);
> +
> +	devnode =3D udev_device_get_devnode(dev);
> +
> +	if (!syspath || !devname || !devpath || !devnode)
> +		return;
> +
> +	/* Maybe this is a USB device... in that case we can grab the
> +	 * vendor and model information
> +	 */
> +	usb_device =3D udev_device_get_parent_with_subsystem_devtype(mdev,
> +							"usb", "usb_device");
> +	if (usb_device) {
> +		vendor =3D udev_device_get_property_value(usb_device,
> +							"ID_VENDOR_ID");
> +		model =3D udev_device_get_property_value(usb_device,
> +							"ID_MODEL_ID");

Are you sure about this? I don't think there were any usb devices that =

udev still handled.  Maybe with the exception of some weird CDMA stuff, =

but that doesn't really work and should be handled via normal udevng =

mechanisms.

> +	}
> +
> +	modem =3D g_hash_table_lookup(modem_list, syspath);
> +	if (modem =3D=3D NULL) {
> +		modem =3D g_try_new0(struct modem_info, 1);
> +		if (modem =3D=3D NULL)
> +			return;
> +
> +		modem->syspath =3D g_strdup(syspath);
> +		modem->devname =3D g_strdup(devname);
> +		modem->driver =3D g_strdup("legacy");
> +		modem->vendor =3D g_strdup(vendor);
> +		modem->model =3D g_strdup(model);
> +
> +		g_hash_table_replace(modem_list, modem->syspath, modem);
> +	}
> +
> +	subsystem =3D udev_device_get_subsystem(dev);
> +
> +	DBG("%s", syspath);
> +	DBG("%s", devpath);
> +	DBG("%s (%s)", devnode, driver);
> +
> +	info =3D g_try_new0(struct device_info, 1);
> +	if (info =3D=3D NULL)
> +		return;
> +
> +	info->devpath =3D g_strdup(devpath);
> +	info->devnode =3D g_strdup(devnode);
> +	info->subsystem =3D g_strdup(subsystem);
> +
> +	/* Here we begin the abuse... we want to switch the modem driver
> +	 * from 'legacy' to it's real driver in the setup function, so
> +	 * we store the driver name here in the otherwise unused sysattr
> +	 * field
> +	 */
> +	info->sysattr =3D g_strdup(driver);

The hi-jacking of device_info attributes is not going to fly.  Why don't =

we simply get rid of sysattr, and invent a brand new structure to hold =

the info for 'legacy' (or really true serial port) devices.  The ideal =

situation would be for us to continue using ofono_modem_set_property for =

all the driver specific stuff.

Is there a reason why we can't create the modem object here?  The =

current logic enumerates all the devices and runs create_modem =

afterwards, but I see no reason why we can't suppress that logic for =

serial-only devices.

> +
> +	/* Here we abuse some unused device_info attributes to hold
> +	 * extra udev properties... this is ugly but this is all
> +	 * legacy stuff that hopefully disappears someday anyway.
> +	 */
> +	if (g_strcmp0(driver, "ifx")) {
> +		add_ifx_info(info, dev);
> +	} else if (g_strcmp0(driver, "u8500")) {
> +		add_isi_info(info, dev);
> +	} else if (g_strcmp0(driver, "n900")) {
> +		add_isi_info(info, dev);
> +	} else if (g_strcmp0(driver, "wavecom")) {
> +		add_wavecom_info(info, dev);
> +	}
> +
> +	modem->devices =3D g_slist_insert_sorted(modem->devices, info,
> +							compare_device);
> +}
> +
>  static void add_device(const char *syspath, const char *devname,
>  			const char *driver, const char *vendor,
>  			const char *model, struct udev_device *device)
>

Regards,
-Denis

--===============3331517299131376585==--

