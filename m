Content-Type: multipart/mixed; boundary="===============5954159384871661541=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev v2 4/5] udevng: get properties from interface
Date: Tue, 28 Mar 2017 11:51:59 -0500
Message-ID: <785d2701-6c35-bb96-01cf-b8423bfb0056@gmail.com>
In-Reply-To: <20170328131824.13261-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5954159384871661541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/28/2017 08:18 AM, Jonas Bonn wrote:
> Device properties are generally on the device, on the USB interface
> descriptor, or the on the USB device descriptor.
> ---
>  plugins/udevng.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> @@ -1373,6 +1373,11 @@ static void add_device(const char *syspath, const =
char *devname,
>  	}
>
>  	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> +	if (!label) {
> +		label =3D udev_device_get_property_value(usb_interface,
> +							"OFONO_LABEL");
> +	}
> +

We prefer not to have {} for single expression if/while/do/for blocks

>  	subsystem =3D udev_device_get_subsystem(device);
>
>  	if (modem->sysattr !=3D NULL)
> @@ -1495,6 +1500,14 @@ static void check_usb_device(struct udev_device *d=
evice)
>  	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
>
>  	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
> +	if (!driver) {
> +		struct udev_device *usb_interface;
> +		usb_interface =3D udev_device_get_parent_with_subsystem_devtype(
> +					device, "usb", "usb_interface");
> +		if (usb_interface)
> +			driver =3D udev_device_get_property_value(
> +					usb_interface, "OFONO_DRIVER");

Might be cleaner written as:
		struct udev_device *usb_interface =3D
			udev_device_get_parent_with_subsystem_devtype(
					device, "usb", "usb_interface");

		if (usb_interface)
			driver =3D udev_device_get_property_value(
					usb_interface, "OFONO_DRIVER");

> +	}
>  	if (driver =3D=3D NULL) {

item M1.  Separate the two if statements

>  		const char *drv;
>  		unsigned int i;
>

Regards,
-Denis

--===============5954159384871661541==--

