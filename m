Content-Type: multipart/mixed; boundary="===============2340639399608494676=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 3/3] sim800: add udev detection.
Date: Wed, 07 Nov 2018 14:30:43 +0100
Message-ID: <eb9c5530-801e-b33b-a1e2-aefa726839df@norrbonn.se>
In-Reply-To: <1541585670-3551-3-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2340639399608494676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,

On 07/11/2018 11:14, Clement Viel wrote:
> ---
>   plugins/udevng.c | 92 +++++++++++++++++++++++++++++++++++++++++--------=
-------
>   1 file changed, 68 insertions(+), 24 deletions(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index ff6e1fc..ee6f9e8 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -711,8 +711,56 @@ static gboolean setup_telitqmi(struct modem_info *mo=
dem)
>   	return TRUE;
>   }
>   =

> -/* TODO: Not used as we have no simcom driver */
> -static gboolean setup_simcom(struct modem_info *modem)
> +
> +static gboolean setup_sim800(struct modem_info *modem)
> +{
> +	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
> +	GSList *list;
> +
> +	DBG("%s", modem->syspath);
> +
> +	for (list =3D modem->devices; list; list =3D list->next) {
> +		struct device_info *info =3D list->data;
> +
> +		DBG("%s %s %s %s", info->devnode, info->interface,
> +						info->number, info->label);
> +
> +		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
> +			DBG("setting aux as info->devnode");
> +			aux =3D info->devnode;
> +			if (mdm !=3D NULL)
> +				break;
> +		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
> +			mdm =3D info->devnode;
> +			if (aux !=3D NULL)
> +				break;
> +		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +				mdm =3D info->devnode;
> +			else if (g_strcmp0(info->number, "01") =3D=3D 0)
> +				gps =3D info->devnode;
> +			else if (g_strcmp0(info->number, "02") =3D=3D 0)
> +				aux =3D info->devnode;
> +			else if (g_strcmp0(info->number, "03") =3D=3D 0)
> +				mdm =3D info->devnode;
> +		}
> +	}
> +	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
> +

gps is unused.


> +	if (mdm =3D=3D NULL) {
> +		DBG("modem did not set up");
> +		return FALSE;
> +	}
> +
> +	ofono_modem_set_string(modem->modem, "Device", mdm);

You probably mean 'aux' here.

> +	ofono_modem_set_string(modem->modem, "Modem", mdm);
> +
> +	return TRUE;
> +}
> +
> +
> +
> +static gboolean setup_sim900(struct modem_info *modem)
>   {
>   	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
>   	GSList *list;
> @@ -962,6 +1010,8 @@ static gboolean setup_mbim(struct modem_info *modem)
>   	ofono_modem_set_string(modem->modem, "Device", ctl);
>   	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
>   	ofono_modem_set_string(modem->modem, "DescriptorFile", descriptors);
> +	ofono_modem_set_string(modem->modem, "Vendor", modem->vendor);
> +	ofono_modem_set_string(modem->modem, "Model", modem->model);

I don't see that these strings are being used anywhere in the modem driver.

>   =

>   	return TRUE;
>   }
> @@ -1193,22 +1243,12 @@ static gboolean setup_xmm7xxx(struct modem_info *=
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
> -			}
> -		} else {
> -			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "02") =3D=3D 0)
> -					mdm =3D info->devnode;
> -			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -				if (g_strcmp0(info->number, "00") =3D=3D 0)
> -					net =3D info->devnode;
> -			}
> +		if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "02") =3D=3D 0)
> +				mdm =3D info->devnode;
> +		} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +				net =3D info->devnode;
>   		}
>   	}
>  =


This change doesn't look like it belongs to this patch.


> @@ -1290,7 +1330,8 @@ static struct {
>   	{ "nokia",	setup_nokia	},
>   	{ "telit",	setup_telit,	"device/interface"	},
>   	{ "telitqmi",	setup_telitqmi	},
> -	{ "simcom",	setup_simcom	},
> +	{ "sim800",	setup_sim800	},
> +	{ "sim900",	setup_sim900	},

Is the sim900 not a serial modem?  These setup routines are really only =

for USB devices.

>   	{ "sim7100",	setup_sim7100	},
>   	{ "zte",	setup_zte	},
>   	{ "icera",	setup_icera	},
> @@ -1308,7 +1349,9 @@ static struct {
>   	{ "calypso",	setup_serial_modem	},
>   	{ "cinterion",	setup_serial_modem	},
>   	{ "nokiacdma",	setup_serial_modem	},
> +	{ "sim800",	setup_serial_modem	},
>   	{ "sim900",	setup_serial_modem	},
> +	{ "sim800",	setup_serial_modem	},

You've added the same line twice.  Furthermore, the sim800 is a USB =

modem (???) so it should not be set up in this way.

>   	{ "wavecom",	setup_wavecom		},
>   	{ "tc65",	setup_tc65		},
>   	{ "ehs6",	setup_ehs6		},
> @@ -1471,7 +1514,7 @@ static void add_serial_device(struct udev_device *d=
ev)
>   	const char *subsystem;
>   	struct udev_device* mdev;
>   	const char* driver;
> -
> +	DBG("adding %s interface", udev_device_get_devpath(dev));
>   	mdev =3D get_serial_modem_device(dev);
>   	if (!mdev) {
>   		DBG("Device is missing required OFONO_DRIVER property");
> @@ -1663,7 +1706,8 @@ static struct {
>   	{ "alcatel",	"option",	"1bbb", "0017"	},
>   	{ "novatel",	"option",	"1410"		},
>   	{ "zte",	"option",	"19d2"		},
> -	{ "simcom",	"option",	"05c6", "9000"	},
> +	{ "sim800",	"option",	"05c6", "9000"	}
> +	{ "sim900",	"option",	"05c6", "9000"	},


The sim900 is a serial modem... there is no vendor id nor product id.


>   	{ "sim7100",	"option",	"1e0e", "9001"	},
>   	{ "telit",	"usbserial",	"1bc7"		},
>   	{ "telit",	"option",	"1bc7"		},
> @@ -1693,7 +1737,6 @@ static struct {
>   	{ "xmm7xxx",	"cdc_ncm",	"8087"		},
>   	{ }
>   };
> -
>   static void check_usb_device(struct udev_device *device)
>   {
>   	struct udev_device *usb_device;
> @@ -1722,9 +1765,10 @@ static void check_usb_device(struct udev_device *d=
evice)
>   			udev_device_get_parent_with_subsystem_devtype(
>   				device, "usb", "usb_interface");
>   =

> -		if (usb_interface)
> +		if (usb_interface) {
>   			driver =3D udev_device_get_property_value(
>   					usb_interface, "OFONO_DRIVER");
> +		}
>   	}

No.

>   =

>   	if (driver =3D=3D NULL) {
> @@ -1801,7 +1845,7 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
>   	struct modem_info *modem =3D value;
>   	const char *syspath =3D key;
>   	unsigned int i;
> -
> +	DBG("");
>   	if (modem->modem !=3D NULL)
>   		return FALSE;
>   =


Doesn't belong to this patch, if at all.

> =


/Jonas

--===============2340639399608494676==--

