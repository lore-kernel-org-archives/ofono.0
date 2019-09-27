Content-Type: multipart/mixed; boundary="===============3306770235095182444=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udev: Adding PCIe as a subsystem in udev
Date: Thu, 26 Sep 2019 20:20:02 -0500
Message-ID: <3373e7a4-c1a6-cddf-f186-a960cd33d065@gmail.com>
In-Reply-To: <1569489577-5992-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3306770235095182444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

<snip>

> @@ -1612,16 +1631,8 @@ static void add_device(const char *syspath, const =
char *devname,
>   	if (devpath =3D=3D NULL)
>   		return;
>   =

> -	devnode =3D udev_device_get_devnode(device);
> -	if (devnode =3D=3D NULL) {
> -		devnode =3D udev_device_get_property_value(device, "INTERFACE");
> -		if (devnode =3D=3D NULL)
> -			return;
> -	}
> -
> -	usb_interface =3D udev_device_get_parent_with_subsystem_devtype(device,
> -						"usb", "usb_interface");
> -	if (usb_interface =3D=3D NULL)
> +	subsystem =3D udev_device_get_subsystem(device);
> +	if (subsystem =3D=3D NULL)
>   		return;

Lets just make the modem type into an argument to this function, since =

check_pci_device and check_usb_device already know this.

>   =

>   	modem =3D g_hash_table_lookup(modem_list, syspath);
> @@ -1630,7 +1641,12 @@ static void add_device(const char *syspath, const =
char *devname,
>   		if (modem =3D=3D NULL)
>   			return;
>   =

> -		modem->type =3D MODEM_TYPE_USB;
> +		if ((g_str_equal(subsystem, "usb") =3D=3D TRUE) ||
> +				(g_str_equal(subsystem, "usbmisc") =3D=3D TRUE))
> +			modem->type =3D MODEM_TYPE_USB;
> +		else if (g_str_equal(subsystem, "pci") =3D=3D TRUE)
> +			modem->type =3D MODEM_TYPE_PCIE;
> +
>   		modem->syspath =3D g_strdup(syspath);
>   		modem->devname =3D g_strdup(devname);
>   		modem->driver =3D g_strdup(driver);
> @@ -1642,30 +1658,60 @@ static void add_device(const char *syspath, const=
 char *devname,
>   		g_hash_table_replace(modem_list, modem->syspath, modem);
>   	}
>   =

> -	interface =3D udev_device_get_property_value(usb_interface, "INTERFACE"=
);
> -	number =3D udev_device_get_property_value(device, "ID_USB_INTERFACE_NUM=
");
> +	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
>   =

> -	/* If environment variable is not set, get value from attributes (or pa=
rent's ones) */
> -	if (number =3D=3D NULL) {
> -		number =3D udev_device_get_sysattr_value(device,
> +	if (modem->type =3D=3D MODEM_TYPE_USB) {
> +		devnode =3D udev_device_get_devnode(device);
> +		if (devnode =3D=3D NULL) {
> +			devnode =3D udev_device_get_property_value(device,
> +							"INTERFACE");
> +			if (devnode =3D=3D NULL)
> +				return;
> +		}
> +
> +		usb_interface =3D udev_device_get_parent_with_subsystem_devtype(
> +							device, "usb",
> +							"usb_interface");
> +		if (usb_interface =3D=3D NULL)
> +			return;
> +
> +		interface =3D udev_device_get_property_value(usb_interface,
> +							"INTERFACE");
> +		number =3D udev_device_get_property_value(device,
> +						"ID_USB_INTERFACE_NUM");
> +
> +		if (number =3D=3D NULL)
> +			number =3D udev_device_get_sysattr_value(device,
>   							"bInterfaceNumber");
>   =

> -		if (number =3D=3D NULL) {
> -			parent =3D udev_device_get_parent(device);
> -			number =3D udev_device_get_sysattr_value(parent,
> +		if (!label)
> +			label =3D udev_device_get_property_value(usb_interface,
> +							"OFONO_LABEL");
> +	} else {
> +		devnode =3D NULL;
> +		interface =3D udev_device_get_property_value(device,
> +							"INTERFACE");
> +		number =3D udev_device_get_sysattr_value(device,
>   							"bInterfaceNumber");
> -		}
> -	}
>   =

> -	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> -	if (!label)
> -		label =3D udev_device_get_property_value(usb_interface,
> +		if (!label)
> +			label =3D udev_device_get_property_value(device,
>   							"OFONO_LABEL");
> +	}

You can drop OFONO_LABEL handling for pci devices completely.  I don't =

even remember why that was used but it definitely should not be needed =

unless you're trying to be backward compatible with some legacy things, =

which you're not.

>   =

> -	subsystem =3D udev_device_get_subsystem(device);
> +	/*
> +	 *If environment variable is not set, get value from attributes
> +	 *(or parent's ones)
> +	 */
> +	if (number =3D=3D NULL) {
> +		parent =3D udev_device_get_parent(device);
> +		number =3D udev_device_get_sysattr_value(parent,
> +							"bInterfaceNumber");
> +	}
>   =

>   	if (modem->sysattr !=3D NULL)
> -		sysattr =3D udev_device_get_sysattr_value(device, modem->sysattr);
> +		sysattr =3D udev_device_get_sysattr_value(device,
> +							modem->sysattr);
>   	else
>   		sysattr =3D NULL;
>   =

<snip>

Regards,
-Denis

--===============3306770235095182444==--

