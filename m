Content-Type: multipart/mixed; boundary="===============3822840221646444998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev v2 1/5] udevng: add serial device handling functions
Date: Tue, 28 Mar 2017 11:46:28 -0500
Message-ID: <8bc81e2d-340d-6e73-0e2a-a3d72b07dbbf@gmail.com>
In-Reply-To: <20170328131824.13261-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3822840221646444998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2017 08:18 AM, Jonas Bonn wrote:
> This adds, but does not hook up, support for simple serial modems.  These
> modems generally have only a single device node so are simpler than the
> USB devices which generally have different device nodes for different
> features.  These modems are currently handled by udev.c, but this
> functionality will allow to remove that module completely.
>
> - A new "device_info" type is created called serial_device_info
> - the function add_serial_device sets up a modem_info structure and a
>   serial_device_info for the device
> - A reference to the device's udev node is saved in the device info
> - The device driver is retrieved from the OFONO_DRIVER environment variab=
le
>   which needs to be set up by some udev rule
> - Setup functions are added for these types of devices: a common function
>   setup_serial_modem covers the generic (simple) case, whereas modems
>   with special requirements are given their own setup functions to handle
>   the special bits
> - Modem destroy needs to know the "device_info" type in order to clean
>   up properly, so a 'type' value is set on these structures for this
>   purpose
> ---
>  plugins/udevng.c | 242 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 234 insertions(+), 8 deletions(-)

Just FYI, when applying I get:
Applying: udevng: add serial device handling functions
.git/rebase-apply/patch:201: trailing whitespace.
  * through the device hierarchy.
.git/rebase-apply/patch:215: trailing whitespace.
	return NULL;
fatal: 2 lines add whitespace errors.
Patch failed at 0001 udevng: add serial device handling functions
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Please configure your editor to squash these

>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 7a29be6..7ac185c 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -48,7 +48,13 @@ struct modem_info {
>  	const char *sysattr;
>  };
>
> +enum {
> +	DEVICE_TYPE_USB,
> +	DEVICE_TYPE_SERIAL,
> +} DeviceType;
> +
>  struct device_info {
> +	int type;
>  	char *devpath;
>  	char *devnode;
>  	char *interface;
> @@ -58,6 +64,14 @@ struct device_info {
>  	char *subsystem;
>  };
>
> +struct serial_modem_info {

serial_device_info

> +	int type;
> +	char *devpath;
> +	char *devnode;
> +	char *subsystem;
> +	struct udev_device* dev;
> +};
> +

Also, instead of the casting ugliness you have, why don't you just make =

this into a proper abstraction.  E.g. something like:

enum modem_type {
	MODEM_TYPE_USB,
	MODEM_TYPE_SERIAL
},

struct modem_info {
	...
	enum modem_type type;
	union {
		GSList *devices;
		struct serial_device_info *serial;
	}
};

>  static gboolean setup_isi(struct modem_info *modem)
>  {
>  	const char *node =3D NULL;
> @@ -867,6 +881,100 @@ static gboolean setup_quectel(struct modem_info *mo=
dem)
>  	return TRUE;
>  }
>
> +static gboolean setup_serial_modem(struct modem_info* modem)
> +{
> +	struct serial_modem_info* info;
> +
> +	info =3D modem->devices->data;

Then this simply becomes modem->serial

> +
> +	ofono_modem_set_string(modem->modem, "Device", info->devnode);
> +
> +	return TRUE;
> +}
> +
> +static gboolean setup_tc65(struct modem_info* modem)
> +{
> +	ofono_modem_set_driver(modem->modem, "cinterion");
> +
> +	return setup_serial_modem(modem);
> +}
> +
> +static gboolean setup_ehs6(struct modem_info* modem)
> +{
> +	ofono_modem_set_driver(modem->modem, "cinterion");
> +
> +	return setup_serial_modem(modem);
> +}
> +
> +static gboolean setup_ifx(struct modem_info* modem)
> +{
> +	struct serial_modem_info* info;
> +	const char *value;
> +
> +	info =3D modem->devices->data;
> +
> +	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_LDISC");
> +	if (value)
> +		ofono_modem_set_string(modem->modem, "LineDiscipline", value);
> +
> +	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_AUDIO");
> +	if (value)
> +		ofono_modem_set_string(modem->modem, "AudioSetting", value);
> +
> +	value =3D udev_device_get_property_value(info->dev, "OFONO_IFX_LOOPBACK=
");
> +	if (value)
> +		ofono_modem_set_string(modem->modem, "AudioLoopback", value);
> +
> +	ofono_modem_set_string(modem->modem, "Device", info->devnode);
> +
> +	return TRUE;
> +}
> +
> +static gboolean setup_wavecom(struct modem_info* modem)
> +{
> +	struct serial_modem_info* info;
> +	const char *value;
> +
> +	info =3D modem->devices->data;
> +
> +	value =3D udev_device_get_property_value(info->dev,
> +						"OFONO_WAVECOM_MODEL");
> +	if (value)
> +		ofono_modem_set_string(modem->modem, "Model", value);
> +
> +	ofono_modem_set_string(modem->modem, "Device", info->devnode);
> +
> +	return TRUE;
> +}
> +
> +static gboolean setup_isi_serial(struct modem_info* modem)
> +{
> +	struct serial_modem_info* info;
> +	const char *value;
> +
> +	info =3D modem->devices->data;
> +
> +	if (g_strcmp0(udev_device_get_subsystem(info->dev), "net") !=3D 0)
> +		return FALSE;
> +
> +	value =3D udev_device_get_sysattr_value(info->dev, "type");
> +	if (g_strcmp0(value, "820") !=3D 0)
> +		return FALSE;
> +
> +	/* OK, we want this device to be a modem */
> +	value =3D udev_device_get_sysname(info->dev);
> +	if (value)
> +		ofono_modem_set_string(modem->modem, "Interface", value);
> +
> +	value =3D udev_device_get_property_value(info->dev, "OFONO_ISI_ADDRESS"=
);
> +	if (value)
> +		ofono_modem_set_integer(modem->modem, "Address", atoi(value));
> +
> +	ofono_modem_set_string(modem->modem, "Device", info->devnode);
> +
> +	return TRUE;
> +}
> +
>  static gboolean setup_ublox(struct modem_info *modem)
>  {
>  	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
> @@ -997,6 +1105,17 @@ static struct {
>  	{ "quectel",	setup_quectel	},
>  	{ "ublox",	setup_ublox	},
>  	{ "gemalto",	setup_gemalto	},
> +	/* Following are non-USB modems */
> +	{ "ifx",	setup_ifx		},
> +	{ "u8500",	setup_isi_serial	},
> +	{ "n900",	setup_isi_serial	},
> +	{ "calypso",	setup_serial_modem	},
> +	{ "cinterion",	setup_serial_modem	},
> +	{ "nokiacdma",	setup_serial_modem	},
> +	{ "sim900",	setup_serial_modem	},
> +	{ "wavecom",	setup_wavecom		},
> +	{ "tc65",	setup_tc65		},
> +	{ "ehs6",	setup_ehs6		},
>  	{ }
>  };
>
> @@ -1028,14 +1147,25 @@ static void destroy_modem(gpointer data)
>
>  		DBG("%s", info->devnode);
>
> -		g_free(info->devpath);
> -		g_free(info->devnode);
> -		g_free(info->interface);
> -		g_free(info->number);
> -		g_free(info->label);
> -		g_free(info->sysattr);
> -		g_free(info->subsystem);
> -		g_free(info);
> +		if (info->type =3D=3D DEVICE_TYPE_USB) {
> +			g_free(info->devpath);
> +			g_free(info->devnode);
> +			g_free(info->interface);
> +			g_free(info->number);
> +			g_free(info->label);
> +			g_free(info->sysattr);
> +			g_free(info->subsystem);
> +			g_free(info);

This needs to be put into a separate function, e.g. device_info_free()

> +		} else if (info->type =3D=3D DEVICE_TYPE_SERIAL) {
> +			struct serial_modem_info* sinfo;
> +			sinfo =3D (struct serial_modem_info*) info;
> +			g_free(sinfo->devpath);
> +			g_free(sinfo->devnode);
> +			g_free(sinfo->subsystem);
> +			udev_device_unref(sinfo->dev);
> +			g_free(sinfo);

serial_device_info_free()

> +		}
> +
>
>  		list->data =3D NULL;
>  	}
> @@ -1088,6 +1218,101 @@ static gint compare_device(gconstpointer a, gcons=
tpointer b)
>  	return g_strcmp0(info1->number, info2->number);
>  }
>
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

item M1

> +	}
> +
> +	return NULL;
> +}
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
> +static void add_serial_device(struct udev_device *dev)
> +{
> +	const char *syspath, *devpath, *devname, *devnode;
> +	struct modem_info *modem;
> +	struct serial_modem_info *info;
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
> +	info =3D g_try_new0(struct serial_modem_info, 1);
> +	if (info =3D=3D NULL)
> +		return;
> +
> +	info->type =3D DEVICE_TYPE_SERIAL;
> +	info->devpath =3D g_strdup(devpath);
> +	info->devnode =3D g_strdup(devnode);
> +	info->subsystem =3D g_strdup(subsystem);
> +	info->dev =3D udev_device_ref(dev);
> +
> +	modem->devices =3D g_slist_append(modem->devices, info);
> +}
> +
>  static void add_device(const char *syspath, const char *devname,
>  			const char *driver, const char *vendor,
>  			const char *model, struct udev_device *device)
> @@ -1164,6 +1389,7 @@ static void add_device(const char *syspath, const c=
har *devname,
>  	if (info =3D=3D NULL)
>  		return;
>
> +	info->type =3D DEVICE_TYPE_USB;
>  	info->devpath =3D g_strdup(devpath);
>  	info->devnode =3D g_strdup(devnode);
>  	info->interface =3D g_strdup(interface);
>

Regards,
-Denis

--===============3822840221646444998==--

