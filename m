Content-Type: multipart/mixed; boundary="===============4576616667417387328=="
MIME-Version: 1.0
From: Borwankar, Antara <antara.borwankar@intel.com>
Subject: RE: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Thu, 26 Sep 2019 09:46:42 +0000
Message-ID: <9BCC1739A7EADA4790E1FFF4123FB3268BB6557C@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <831ee39c-625b-9232-6c18-7a4471100a25@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4576616667417387328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Regarding your below query

- Can you tell me why this new addition uses vid/pid with a 0x prefix while=
 the rest of the table does not?  It seems weird & inconsistent.
Actually in case of pci device vendor and device id read using libudev API =
is returning as "0x8086" and "0x7560" strings respectively. So I have added=
 the same values in vendor_list table. =

In case of usb device the vendor and device strings returned by same libude=
v API does not have "0x" prefix. I don=E2=80=99t have any idea why it is so.

If you insist I can remove this prefix 0x from vendor_list table and change=
 the implementation of check_pci_device() function to handle comparison of =
vendor and model strings with vid, pid form vendor_list.

Regards
Antara

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Thursday, September 26, 2019 7:55 AM
To: Borwankar, Antara <antara.borwankar@intel.com>; ofono(a)ofono.org
Subject: Re: [PATCH] udev: Adding PCIe as a subsystem in udev

Hi Antara,

On 9/25/19 4:55 AM, Antara Borwankar wrote:
> Adding support for enumerating PCIe types of modems in ofono
> ---
>   plugins/udevng.c | 195 ++++++++++++++++++++++++++++++++++++++++++++++++=
+------
>   1 file changed, 174 insertions(+), 21 deletions(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c index =

> 1b54b4a..bebbc2d 100644
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
> @@ -1229,26 +1230,43 @@ static gboolean setup_xmm7xxx(struct modem_info *=
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
> +		if (g_strcmp0(info->subsystem, "pci") =3D=3D 0) {
> +			if ((g_strcmp0(modem->vendor,"0x8086") =3D=3D 0) &&
> +					(g_strcmp0(modem->model,"0x7560") =3D=3D 0)) {
> +				mdm =3D "/dev/iat";
> +				net =3D "inm0";
> +				net2 =3D "inm1";
> +				net3 =3D "inm2";
> +				ofono_modem_set_string(modem->modem,
> +						"CtrlPath", "/PCIE/IOSM/CTRL/1");
> +				ofono_modem_set_string(modem->modem, "DataPath",
> +						"/PCIE/IOSM/IPS/");
>   			}
> -		} else {
> -			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "02") =3D=3D 0)
> -					mdm =3D info->devnode;
> -			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "00") =3D=3D 0)
> -					net =3D info->devnode;
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
> +
> +			ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
> +			ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");

Lines > 80 characters, please see doc/coding-style.txt

>   		}
>   	}
>   =

> @@ -1266,9 +1284,6 @@ static gboolean setup_xmm7xxx(struct modem_info *mo=
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

> @@ -1437,6 +1452,7 @@ static void destroy_modem(gpointer data)
>   =

>   	switch (modem->type) {
>   	case MODEM_TYPE_USB:
> +	case MODEM_TYPE_PCIE:
>   		for (list =3D modem->devices; list; list =3D list->next) {
>   			struct device_info *info =3D list->data;
>   =

> @@ -1467,6 +1483,7 @@ static gboolean check_remove(gpointer key, =

> gpointer value, gpointer user_data)
>   =

>   	switch (modem->type) {
>   	case MODEM_TYPE_USB:
> +	case MODEM_TYPE_PCIE:
>   		for (list =3D modem->devices; list; list =3D list->next) {
>   			struct device_info *info =3D list->data;
>   =

> @@ -1597,6 +1614,91 @@ static void add_serial_device(struct udev_device *=
dev)
>   	modem->serial =3D info;
>   }
>   =

> +static void add_pci_device(const char *syspath, const char *devname,
> +			const char *driver, const char *vendor,
> +			const char *model, struct udev_device *device) {
> +	const char *devpath, *devnode, *interface, *number;
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
> +		DBG("devnode =3D %s", devnode);
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
> +
> +	/*
> +	 * If environment variable is not set, get value from attributes
> +	 *  (or parent's ones)
> +	 */
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

This seems to be an almost verbatim copy-paste of add_device.  Can you not =
use that instead with some modifications?  Or factor out the common operati=
ons into a separate function?
> +}
> +
>   static void add_device(const char *syspath, const char *devname,
>   			const char *driver, const char *vendor,
>   			const char *model, struct udev_device *device) @@ -1625,8 =

> +1727,10 @@ static void add_device(const char *syspath, const char *devna=
me,
>   		return;
>   =

>   	modem =3D g_hash_table_lookup(modem_list, syspath);
> +
>   	if (modem =3D=3D NULL) {
>   		modem =3D g_try_new0(struct modem_info, 1);
> +
>   		if (modem =3D=3D NULL)
>   			return;
>   =


These changes seem to be superfluous and unrelated to this patch?

> @@ -1772,6 +1876,7 @@ static struct {
>   	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
>   	{ "xmm7xxx",	"cdc_acm",	"8087"		},
>   	{ "xmm7xxx",	"cdc_ncm",	"8087"		},
> +	{ "xmm7xxx",	"imc_ipc",	"0x8086", "0x7560"},

Can you tell me why this new addition uses vid/pid with a 0x prefix while t=
he rest of the table does not?  It seems weird & inconsistent.

>   	{ }
>   };
>   =

> @@ -1858,6 +1963,51 @@ static void check_usb_device(struct udev_device *d=
evice)
>   	add_device(syspath, devname, driver, vendor, model, device);
>   }
>   =

> +static void check_pci_device(struct udev_device *device) {
> +	const char *syspath, *devname, *driver;
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

So should you be adding drv =3D=3D NULL check above as well?

> +
> +	for (i =3D 0; vendor_list[i].driver; i++) {
> +		if ((drv !=3D NULL) && (g_str_equal(vendor_list[i].drv, drv) =3D=3D =

> +TRUE))

That way you can avoid looping here and simplify your logic considerably

> +			DBG("vendor_list[%d].drv =3D %s", i, vendor_list[i].drv);

Did you intend to leave this DBG in here?

> +		else
> +			continue;
> +
> +		if (vendor_list[i].vid) {
> +			if (!g_str_equal(vendor_list[i].vid, vendor))
> +				continue;
> +		}
> +
> +		if (vendor_list[i].pid) {
> +			if (!g_str_equal(vendor_list[i].pid, model))
> +				continue;
> +		}
> +
> +		driver =3D vendor_list[i].driver;
> +	}
> +
> +	if (driver =3D=3D NULL)
> +		return;
> +
> +	add_pci_device(syspath, devname, driver, vendor, model, device); }
>   static void check_device(struct udev_device *device)
>   {
>   	const char *bus;
> @@ -1872,6 +2022,8 @@ static void check_device(struct udev_device *device)
>   	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
>   			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
>   		check_usb_device(device);
> +	else if (g_str_equal(bus, "pci") =3D=3D TRUE)
> +		check_pci_device(device);
>   	else
>   		add_serial_device(device);
>   =

> @@ -1932,6 +2084,7 @@ static void enumerate_devices(struct udev *context)
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

--===============4576616667417387328==--

