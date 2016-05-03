Content-Type: multipart/mixed; boundary="===============6349779659547145357=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Udevng: Improve modem properties detection
Date: Mon, 02 May 2016 22:23:19 -0500
Message-ID: <572819A7.5030407@gmail.com>
In-Reply-To: <1462206794-14322-2-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6349779659547145357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 05/02/2016 11:33 AM, Martin Chaplet wrote:
>   * Add driver's subsystem information (net, usb, tty, ...)
>   * Improve interface number extraction by scanning also device and
>   parent attributes
>
> Signed-off-by: Martin Chaplet <m.chaplet@kerlink.fr>

No signed-off-by please.  See HACKING, 'Submitting Patches' section.

> ---
>   plugins/udevng.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 9643b0a..8ca4471 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -55,6 +55,7 @@ struct device_info {
>   	char *number;
>   	char *label;
>   	char *sysattr;
> +	char *subsystem;
>   };
>
>   static gboolean setup_isi(struct modem_info *modem)
> @@ -939,6 +940,7 @@ static void destroy_modem(gpointer data)
>   		g_free(info->number);
>   		g_free(info->label);
>   		g_free(info->sysattr);
> +		g_free(info->subsystem);
>   		g_free(info);
>
>   		list->data =3D NULL;
> @@ -997,9 +999,10 @@ static void add_device(const char *syspath, const ch=
ar *devname,
>   			const char *model, struct udev_device *device)
>   {
>   	struct udev_device *intf;
> -	const char *devpath, *devnode, *interface, *number, *label, *sysattr;
> +	const char *devpath, *devnode, *interface, *number, *label, *sysattr, *=
subsystem;
>   	struct modem_info *modem;
>   	struct device_info *info;
> +	struct udev_device *parent;
>
>   	devpath =3D udev_device_get_syspath(device);
>   	if (devpath =3D=3D NULL)
> @@ -1037,7 +1040,19 @@ static void add_device(const char *syspath, const =
char *devname,
>   	interface =3D udev_device_get_property_value(intf, "INTERFACE");
>   	number =3D udev_device_get_property_value(device, "ID_USB_INTERFACE_NU=
M");
>
> +	/* If environment variable is not set, get value from attributes (or pa=
rent's ones) */
> +	if(number =3D=3D NULL)
> +	{

Not our style.  oFono uses the Linux Kernel coding style, so the '{' =

should be on the same line as the if.

> +		number =3D udev_device_get_sysattr_value(device, "bInterfaceNumber");
> +		if(number =3D=3D NULL)
> +		{

as above

> +			parent =3D udev_device_get_parent(device);
> +			number =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
> +		}
> +	}
> +
>   	label =3D udev_device_get_property_value(device, "OFONO_LABEL");
> +	subsystem =3D udev_device_get_subsystem(device);
>
>   	if (modem->sysattr !=3D NULL)
>   		sysattr =3D udev_device_get_sysattr_value(device, modem->sysattr);
> @@ -1059,6 +1074,7 @@ static void add_device(const char *syspath, const c=
har *devname,
>   	info->number =3D g_strdup(number);
>   	info->label =3D g_strdup(label);
>   	info->sysattr =3D g_strdup(sysattr);
> +	info->subsystem =3D g_strdup(subsystem);
>
>   	modem->devices =3D g_slist_insert_sorted(modem->devices, info,
>   							compare_device);
>

Regards,
-Denis

--===============6349779659547145357==--

