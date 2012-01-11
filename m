Content-Type: multipart/mixed; boundary="===============1121291130119519719=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 2/3] Add SIM900 detection support.
Date: Wed, 11 Jan 2012 15:54:15 +0100
Message-ID: <1326293655.6454.236.camel@aeonflux>
In-Reply-To: <1326290343-21973-2-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1121291130119519719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Renat,

> This allows for detection of SIM900 modem module in case of
> appropriate driver specified in udev rules.
> =

> Example rule:
> KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"

you could also use the 27.010 support that is included in oFono itself
and set it up from within the plugin. I assume you have a reason for
using N_GSM.

> =

> ---
>  plugins/udev.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index d0673f7..f05af48 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -193,6 +193,19 @@ static void add_nokiacdma(struct ofono_modem *modem,
>  	ofono_modem_register(modem);
>  }
>  =

> +static void add_sim900(struct ofono_modem *modem,
> +                       struct udev_device *udev_device)
> +{
> +        const char *devnode;
> +
> +        DBG("modem %p", modem);
> +
> +        devnode =3D udev_device_get_devnode(udev_device);
> +        ofono_modem_set_string(modem, "Device", devnode);
> +
> +        ofono_modem_register(modem);
> +}
> +
>  static void add_modem(struct udev_device *udev_device)
>  {
>  	struct ofono_modem *modem;
> @@ -271,6 +284,8 @@ done:
>  		add_tc65(modem, udev_device);
>  	else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>  		add_nokiacdma(modem, udev_device);
> +        else if (g_strcmp0(driver, "sim900") =3D=3D 0)
> +                add_sim900(modem, udev_device);
>  }

Something went wrong here. Spaces?

Regards

Marcel



--===============1121291130119519719==--

