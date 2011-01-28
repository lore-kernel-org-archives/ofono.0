Content-Type: multipart/mixed; boundary="===============1035709561676321176=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Enable hs 2330 MBM modem
Date: Fri, 28 Jan 2011 10:16:47 +0100
Message-ID: <1296206207.1520.165.camel@aeonflux>
In-Reply-To: <1296191123-4529-1-git-send-email-zhigang.li@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1035709561676321176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhigang,

> diff --git a/plugins/udev.c b/plugins/udev.c
> index 202b225..810049a 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -123,6 +123,7 @@ static void add_mbm(struct ofono_modem *modem,
>  			g_str_has_suffix(desc, "Minicard Modem 2") ||
>  			g_str_has_suffix(desc, "Mini-Card Modem") ||
>  			g_str_has_suffix(desc, "Broadband Modem") ||
> +			g_str_has_suffix(desc, "Module Modem") ||
>  			g_str_has_suffix(desc, "Broadband USB Modem")) {
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		if (ofono_modem_get_string(modem, MODEM_DEVICE) =3D=3D NULL)
> @@ -131,16 +132,19 @@ static void add_mbm(struct ofono_modem *modem,
>  			ofono_modem_set_string(modem, DATA_DEVICE, devnode);
>  	} else if (g_str_has_suffix(desc, "Minicard Data Modem") ||
>  			g_str_has_suffix(desc, "Mini-Card Data Modem") ||
> +			g_str_has_suffix(desc, "Data Modem") ||

I think this should be "Module Data Modem".

>  			g_str_has_suffix(desc, "Broadband Data Modem")) {
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		ofono_modem_set_string(modem, DATA_DEVICE, devnode);
>  	} else if (g_str_has_suffix(desc, "Minicard GPS Port") ||
>  			g_str_has_suffix(desc, "Mini-Card GPRS Port") ||
> +			g_str_has_suffix(desc, "Module NMEA") ||
>  			g_str_has_suffix(desc, "Broadband GPS Port")) {
>  		devnode =3D udev_device_get_devnode(udev_device);
>  		ofono_modem_set_string(modem, GPS_DEVICE, devnode);
>  	} else if (g_str_has_suffix(desc, "Minicard Network Adapter") ||
>  			g_str_has_suffix(desc, "Mini-Card Network Adapter") ||
> +			g_str_has_suffix(desc, "Module Network Adapter") ||
>  			g_str_has_suffix(desc, "Broadband Network Adapter") ||
>  			g_str_has_suffix(desc, "Minicard NetworkAdapter")) {
>  		devnode =3D get_property(udev_device, "INTERFACE");

Rest seems fine to me.

Regards

Marcel



--===============1035709561676321176==--

