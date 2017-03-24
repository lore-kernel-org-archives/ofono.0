Content-Type: multipart/mixed; boundary="===============1242010041149907760=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH v4 2/3] udevng: find vendor and product id for child
 devices
Date: Sat, 25 Mar 2017 00:30:56 +0100
Message-ID: <f9c88347-63a7-e3f6-951f-be7b316440b7@southpole.se>
In-Reply-To: <1490391997-27077-3-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1242010041149907760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 10:46 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Some of the udev devices will not have vendor and product id
> of their own, if they are children of real usb devices
> (e.g. cdc-wdm0 which is a usbmisc subsystem of qmi_wwan).
>
> If a device does not have its own vendor id, go up through
> the parent tree to try to find one.
> ---
>   plugins/udevng.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 2279bbe..75e0126 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1229,6 +1229,7 @@ static void check_usb_device(struct udev_device *de=
vice)
>   	if (driver =3D=3D NULL) {
>   		const char *drv, *vid, *pid;
>   		unsigned int i;
> +		struct udev_device *vendor_device;
>   =

>   		drv =3D udev_device_get_property_value(device, "ID_USB_DRIVER");
>   		if (drv =3D=3D NULL) {
> @@ -1246,8 +1247,17 @@ static void check_usb_device(struct udev_device *d=
evice)
>   			}
>   		}
>   =

> -		vid =3D udev_device_get_property_value(device, "ID_VENDOR_ID");
> -		pid =3D udev_device_get_property_value(device, "ID_MODEL_ID");
The ID_VENDOR_ID and ID_MODEL_ID properties should always be on the =

parent with devtype "usb_device" (which you have already searched for a =

couple of lines above this).  So the correct thing to do is probably:

- vid =3D udev_device_get_property_value(device, "ID_VENDOR_ID");
- pid =3D udev_device_get_property_value(device, "ID_MODEL_ID");
+ vid =3D udev_device_get_property_value(usb_device, "ID_VENDOR_ID");
+ pid =3D udev_device_get_property_value(usb_device, "ID_MODEL_ID");

Right?  I think that would work and save you trouble of iterating the =

parent device again below...

/Jonas

> +		vendor_device =3D device;
> +		vid =3D NULL;
> +		while (vendor_device !=3D NULL) {
> +			vid =3D udev_device_get_property_value(
> +					vendor_device, "ID_VENDOR_ID");
> +			pid =3D udev_device_get_property_value(
> +					vendor_device, "ID_MODEL_ID");
> +			if (vid !=3D NULL)
> +				break;
> +			vendor_device =3D udev_device_get_parent(vendor_device);
> +		}
>   =

>   		DBG("%s [%s:%s]", drv, vid, pid);
>   =




--===============1242010041149907760==--

