Content-Type: multipart/mixed; boundary="===============5990030302418671516=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Enable Dell 5540 AGPS interface
Date: Fri, 28 Jan 2011 10:18:49 +0100
Message-ID: <1296206329.1520.167.camel@aeonflux>
In-Reply-To: <1296190564-4450-1-git-send-email-zhigang.li@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5990030302418671516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhigang,

>  plugins/udev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 202b225..ce1efe6 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -135,7 +135,7 @@ static void add_mbm(struct ofono_modem *modem,
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
>  	} else if (g_str_has_suffix(desc, "Minicard GPS Port") ||
> -			g_str_has_suffix(desc, "Mini-Card GPRS Port") ||
> +			g_str_has_suffix(desc, "Mini-Card GPS Port") ||
>  			g_str_has_suffix(desc, "Broadband GPS Port")) {
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		ofono_modem_set_string(modem, GPS_DEVICE, devnode);

this looks like a typo. Patch has been applied. Next please prefix the
subject of such a patch with udev:

Regards

Marcel



--===============5990030302418671516==--

