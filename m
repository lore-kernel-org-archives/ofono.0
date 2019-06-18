Content-Type: multipart/mixed; boundary="===============4128495793923972004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Tue, 18 Jun 2019 14:45:53 -0500
Message-ID: <25d4addd-e431-6a2c-7e6f-a102fda8605b@gmail.com>
In-Reply-To: <1560863133-3137-1-git-send-email-varun.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4128495793923972004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Varun,

On 06/18/2019 08:05 AM, Varun Gargi wrote:
> Adding support for enumerating PCIe types of modems in ofono
> ---
>   plugins/udevng.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++++=
-------
>   1 file changed, 168 insertions(+), 22 deletions(-)
>   mode change 100644 =3D> 100755 plugins/udevng.c

Please don't touch the mode

> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> old mode 100644
> new mode 100755
> index 4b420dc..79eec42
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -41,6 +41,7 @@
>   enum modem_type {
>   	MODEM_TYPE_USB,
>   	MODEM_TYPE_SERIAL,
> +	MODEM_TYPE_PCIE,
>   };
>   =

>   struct modem_info {
> @@ -1198,26 +1199,39 @@ static gboolean setup_xmm7xxx(struct modem_info *=
modem)
>   				info->interface, info->number, info->label,
>   				info->sysattr, info->subsystem);
>   =

> -		if (g_strcmp0(modem->model,"095a") =3D=3D 0) {
> -			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "00") =3D=3D 0)
> -					mdm =3D info->devnode;
> -			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "06") =3D=3D 0)
> -					net =3D info->devnode;
> -				if (g_strcmp0(info->number, "08") =3D=3D 0)
> -					net2 =3D info->devnode;
> -				if (g_strcmp0(info->number, "0a") =3D=3D 0)
> -					net3 =3D info->devnode;
> -			}
> -		} else {
> -			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "02") =3D=3D 0)
> -					mdm =3D info->devnode;
> -			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "00") =3D=3D 0)
> -					net =3D info->devnode;
> +		if (g_strcmp0(info->subsystem, "pci") =3D=3D 0) {
> +			mdm =3D "/dev/iat";
> +			net =3D "/dev/inm0";
> +			net2 =3D "/dev/inm1";
> +			net3 =3D "/dev/inm2";

These seem to be quite hardcoded, what if multiple modems are inserted?

> +			ofono_modem_set_string(modem->modem,
> +					"CtrlPath", "/PCIE/IOSM/CTRL/1");
> +			ofono_modem_set_string(modem->modem, "DataPath",
> +					"/PCIE/IOSM/IPS/");

This seems to treat all PCIE modems the same way.  Is there a =

possibility of this changing in the future?  E.g. should you actually =

check the vid/pid or limit which devices this applies to some other way? =

   It would be preferable if we had to 'opt-in' devices along the way, =

rather than having to deal with a new device being detected and =

categorized incorrectly.

> +		} else { /* For USB */
> +			if (g_strcmp0(modem->model,"095a") =3D=3D 0) {
> +				if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> +					if (g_strcmp0(info->number, "00") =3D=3D 0)
> +						mdm =3D info->devnode;
> +				} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> +					if (g_strcmp0(info->number, "06") =3D=3D 0)
> +						net =3D info->devnode;
> +					if (g_strcmp0(info->number, "08") =3D=3D 0)
> +						net2 =3D info->devnode;
> +					if (g_strcmp0(info->number, "0a") =3D=3D 0)
> +						net3 =3D info->devnode;
> +				}
> +			} else {
> +				if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> +					if (g_strcmp0(info->number, "02") =3D=3D 0)
> +						mdm =3D info->devnode;
> +				} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> +					if (g_strcmp0(info->number, "00") =3D=3D 0)
> +						net =3D info->devnode;
> +				}
>   			}
> +		ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
> +		ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");

Coding style is all wrong here

>   		}
>   	}
>   =

> @@ -1235,9 +1249,6 @@ static gboolean setup_xmm7xxx(struct modem_info *mo=
dem)
>   	if (net3)
>   		ofono_modem_set_string(modem->modem, "NetworkInterface3", net3);
>   =

> -	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
> -	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
> -
>   	return TRUE;
>   }
>   =

> @@ -1406,6 +1417,7 @@ static void destroy_modem(gpointer data)
>   =

>   	switch (modem->type) {
>   	case MODEM_TYPE_USB:
> +	case MODEM_TYPE_PCIE:
>   		for (list =3D modem->devices; list; list =3D list->next) {
>   			struct device_info *info =3D list->data;
>   =

> @@ -1436,6 +1448,7 @@ static gboolean check_remove(gpointer key, gpointer=
 value, gpointer user_data)
>   =

>   	switch (modem->type) {
>   	case MODEM_TYPE_USB:
> +	case MODEM_TYPE_PCIE:
>   		for (list =3D modem->devices; list; list =3D list->next) {
>   			struct device_info *info =3D list->data;
>   =

> @@ -1565,6 +1578,86 @@ static void add_serial_device(struct udev_device *=
dev)
>   =

>   	modem->serial =3D info;
>   }
> +static void add_pci_device(const char *syspath, const char *devname,
> +			const char *driver, const char *vendor,
> +			const char *model, struct udev_device *device)
> +{
> +	const char *devpath, *devnode , *interface , *number;
> +	const char *label, *sysattr, *subsystem;
> +	struct modem_info *modem;
> +	struct device_info *info;
> +	struct udev_device *parent;
> +
> +	devpath =3D udev_device_get_syspath(device);
> +
> +	if (devpath =3D=3D NULL)
> +		return;
> +
> +	devnode =3D udev_device_get_devnode(device);
> +
> +	if (devnode =3D=3D NULL) {
> +		devnode =3D udev_device_get_property_value(device, "INTERFACE");
> +		DBG("devnode =3D %s", devnode );
> +	}
> +
> +	modem =3D g_hash_table_lookup(modem_list, syspath);
> +
> +	if (modem =3D=3D NULL) {
> +		modem =3D g_try_new0(struct modem_info, 1);
> +
> +		if (modem =3D=3D NULL)
> +			return;
> +
> +		modem->type =3D MODEM_TYPE_PCIE;
> +		modem->syspath =3D g_strdup(syspath);
> +		modem->devname =3D g_strdup(devname);
> +		modem->driver =3D g_strdup(driver);
> +		modem->vendor =3D g_strdup(vendor);
> +		modem->model =3D g_strdup(model);
> +		modem->sysattr =3D get_sysattr(driver);
> +
> +		g_hash_table_replace(modem_list, modem->syspath, modem);
> +	}
> +
> +	interface =3D udev_device_get_property_value(device, "INTERFACE");
> +	/* If environment variable is not set, get value from attributes (or pa=
rent's ones) */
> +	number =3D udev_device_get_sysattr_value(device, "bInterfaceNumber");
> +
> +	if (number =3D=3D NULL) {
> +		parent =3D udev_device_get_parent(device);
> +		number =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
> +	}
> +
> +	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> +
> +	if (!label)
> +		label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> +
> +	subsystem =3D udev_device_get_subsystem(device);
> +
> +	if (modem->sysattr !=3D NULL)
> +		sysattr =3D udev_device_get_sysattr_value(device, modem->sysattr);
> +	else
> +		sysattr =3D NULL;
> +
> +	DBG("%s (%s) %s [%s] =3D=3D> %s %s", devnode, driver,
> +					interface, number, label, sysattr);
> +	info =3D g_try_new0(struct device_info, 1);
> +
> +	if (info =3D=3D NULL)
> +		return;
> +
> +	info->devpath =3D g_strdup(devpath);
> +	info->devnode =3D g_strdup(devnode);
> +	info->interface =3D g_strdup(interface);
> +	info->number =3D g_strdup(number);
> +	info->label =3D g_strdup(label);
> +	info->sysattr =3D g_strdup(sysattr);
> +	info->subsystem =3D g_strdup(subsystem);
> +
> +	modem->devices =3D g_slist_insert_sorted(modem->devices, info,
> +							compare_device);

This function seems to be mostly copy-pasted version of add_device with =

a few minor variations.  Can we commonize any code between these two?

> +}
>   =

>   static void add_device(const char *syspath, const char *devname,
>   			const char *driver, const char *vendor,
> @@ -1594,8 +1687,10 @@ static void add_device(const char *syspath, const =
char *devname,
>   		return;
>   =

>   	modem =3D g_hash_table_lookup(modem_list, syspath);
> +
>   	if (modem =3D=3D NULL) {
>   		modem =3D g_try_new0(struct modem_info, 1);
> +
>   		if (modem =3D=3D NULL)
>   			return;

Superfluous changes?

>   =

> @@ -1739,6 +1834,7 @@ static struct {
>   	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
>   	{ "xmm7xxx",	"cdc_acm",	"8087"		},
>   	{ "xmm7xxx",	"cdc_ncm",	"8087"		},
> +    { "xmm7xxx",	"imc_ipc",	"0x8086", "0x7560"},

Something is funky with the formatting here

>   	{ }
>   };
>   =

> @@ -1825,6 +1921,53 @@ static void check_usb_device(struct udev_device *d=
evice)
>   	add_device(syspath, devname, driver, vendor, model, device);
>   }
>   =

> +static void check_pci_device(struct udev_device *device)
> +{
> +	const char *syspath, *devname , *driver;
> +	const char *vendor =3D NULL, *model =3D NULL, *drv =3D NULL;
> +	unsigned int i;
> +
> +	syspath =3D udev_device_get_syspath(device);
> +
> +	if (syspath =3D=3D NULL)
> +		return;
> +
> +	devname =3D udev_device_get_devnode(device);
> +	vendor =3D udev_device_get_sysattr_value(device, "vendor");
> +	model =3D udev_device_get_sysattr_value(device, "device");
> +	driver =3D udev_device_get_property_value(device, "OFONO_DRIVER");
> +	drv =3D udev_device_get_property_value(device, "DRIVER");
> +	DBG("%s [%s:%s]", drv, vendor, model);
> +
> +	if (vendor =3D=3D NULL || model =3D=3D NULL)
> +		return;
> +
> +	for (i =3D 0; vendor_list[i].driver; i++) {
> +		if (( drv !=3D NULL) && (g_str_equal(vendor_list[i].drv, drv) =3D=3D T=
RUE)) {
> +			DBG("vendor_list[%d].drv =3D %s",i, vendor_list[i].drv );
> +		} else {
> +			 continue;
> +		}

Not our style, also {} are not needed

> +
> +		if (vendor_list[i].vid) {
> +			if (!g_str_equal(vendor_list[i].vid, vendor))
> +				continue;
> +		}
> +
> +		if (vendor_list[i].pid) {
> +			if (!g_str_equal(vendor_list[i].pid, model))
> +				continue;
> +			}
> +			driver =3D vendor_list[i].driver;

Not our style

> +		}
> +
> +		if (driver =3D=3D NULL)
> +			return;
> +		else
> +			DBG("Driver Found %s", driver);
> +
> +	add_pci_device(syspath, devname, driver, vendor, model, device);
> +}

doc/coding-style.txt item M1

>   static void check_device(struct udev_device *device)
>   {
>   	const char *bus;
> @@ -1839,6 +1982,8 @@ static void check_device(struct udev_device *device)
>   	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
>   			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
>   		check_usb_device(device);
> +	else if (g_str_equal(bus, "pci") =3D=3D TRUE)
> +		check_pci_device(device);
>   	else
>   		add_serial_device(device);
>   =

> @@ -1899,6 +2044,7 @@ static void enumerate_devices(struct udev *context)
>   	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
>   	udev_enumerate_add_match_subsystem(enumerate, "net");
>   	udev_enumerate_add_match_subsystem(enumerate, "hsi");
> +	udev_enumerate_add_match_subsystem(enumerate, "pci");
>   =

>   	udev_enumerate_scan_devices(enumerate);
>   =

> =


Regards,
-Denis

--===============4128495793923972004==--

