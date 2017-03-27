Content-Type: multipart/mixed; boundary="===============8404790147910813865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH udev 14/15] udevng: get properties from interface
Date: Sun, 26 Mar 2017 22:27:09 -0500
Message-ID: <727d2933-10aa-b886-3724-bae3ac2481de@gmail.com>
In-Reply-To: <20170325165805.28166-15-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8404790147910813865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/25/2017 11:58 AM, Jonas Bonn wrote:
> Device properties are generally on the device, on the USB interface
> descriptor, or the on the USB device descriptor.
> ---
>  plugins/udevng.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 8721447..98b4f98 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1365,6 +1365,9 @@ static void add_device(const char *syspath, const c=
har *devname,
>  	}
>
>  	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> +	if (!label) {
> +		label =3D udev_device_get_property_value(intf, "OFONO_LABEL");
> +	}

Okay, but not really our style.  See doc/coding-style.txt item M1

>  	subsystem =3D udev_device_get_subsystem(device);
>
>  	if (modem->sysattr !=3D NULL)
> @@ -1464,6 +1467,7 @@ static struct {
>  static void check_usb_device(struct udev_device *device)
>  {
>  	struct udev_device *usb_device;
> +	struct udev_device *intf;

This is better declared inside the if statement below.  Also intf is a =

horrible name.  Just name it usb_device or usb_parent or something.

>  	const char *syspath, *devname, *driver;
>  	const char *vendor =3D NULL, *model =3D NULL;
>
> @@ -1484,6 +1488,13 @@ static void check_usb_device(struct udev_device *d=
evice)
>  	model =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");
>
>  	driver =3D udev_device_get_property_value(usb_device, "OFONO_DRIVER");
> +	if (!driver) {
> +		intf =3D udev_device_get_parent_with_subsystem_devtype(device,
> +						"usb", "usb_interface");
> +		if (intf)
> +			driver =3D udev_device_get_property_value(
> +							intf, "OFONO_DRIVER");
> +	}

doc/coding-style.txt item M1

>  	if (driver =3D=3D NULL) {
>  		const char *drv;
>  		unsigned int i;
>

Regards,
-Denis

--===============8404790147910813865==--

