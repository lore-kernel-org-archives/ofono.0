Content-Type: multipart/mixed; boundary="===============3275051183157784673=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] udev: Handle Linktop data card
Date: Mon, 14 Feb 2011 13:55:50 -0600
Message-ID: <4D5988C6.6060701@gmail.com>
In-Reply-To: <1297314940-4315-2-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3275051183157784673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 02/09/2011 11:15 PM, Amit Mendapara wrote:
> Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>
> ---
>  plugins/udev.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Some comments on further improvements:

> +static void add_linktop(struct ofono_modem *modem,
> +					struct udev_device *udev_device)
> +{
> +	const char *devnode, *intfnum;
> +	struct udev_device *parent;
> +	int registered;
> +
> +	DBG("modem %p", modem);
> +
> +	registered =3D ofono_modem_get_integer(modem, "Registered");
> +	if (registered !=3D 0)
> +		return;
> +
> +	parent =3D udev_device_get_parent(udev_device);
> +	intfnum =3D udev_device_get_sysattr_value(parent, "bInterfaceNumber");
> +
> +	DBG("intfnum %s", intfnum);
> +
> +	if (g_strcmp0(intfnum, "01") =3D=3D 0) {
> +		devnode =3D udev_device_get_devnode(udev_device);
> +		ofono_modem_set_string(modem, "Modem", devnode);
> +	} else if (g_strcmp0(intfnum, "03") =3D=3D 0) {
> +		devnode =3D udev_device_get_devnode(udev_device);
> +		ofono_modem_set_string(modem, "Control", devnode);
> +
> +		ofono_modem_set_integer(modem, "Registered", 1);
> +		ofono_modem_register(modem);
> +	}

Instead of hardcoding this info, you might want to use an approach
similar to how the Huawei udev rules are structured.  However, this
really depends on how many variations of this Linktop card there are.
Since there's only 1 right now, this is fine.

Regards,
-Denis

--===============3275051183157784673==--

