Content-Type: multipart/mixed; boundary="===============0126030179373962319=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] handle werid mbm card network name
Date: Wed, 04 Nov 2009 14:54:38 +0900
Message-ID: <1257314078.3420.128.camel@localhost.localdomain>
In-Reply-To: <1257312820-8860-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0126030179373962319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

>  plugins/udev.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index c2e9c41..345613b 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -120,7 +120,8 @@ static void add_mbm(struct ofono_modem *modem,
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
>  	} else if (g_str_has_suffix(desc, "Minicard Network Adapter") ||
> -			g_str_has_suffix(desc, "Broadband Network Adapter")) {
> +			g_str_has_suffix(desc, "Broadband Network Adapter") ||
> +				g_str_has_suffix(desc, "Minicard NetworkAdapter")) {
>  		devnode =3D udev_device_get_property_value(udev_device,
>  								"INTERFACE");
>  		ofono_modem_set_string(modem, NETWORK_INTERFACE, devnode);

are you serious? They forgot the space in one of their USB interface
descriptions.

Do me a favor and just add it between these two and don't bother with
the extra indentation. Two are enough.

Regards

Marcel



--===============0126030179373962319==--

