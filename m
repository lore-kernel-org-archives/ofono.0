Content-Type: multipart/mixed; boundary="===============8897808986663231840=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 8/9] udev: Add cdmagen
Date: Sat, 18 Dec 2010 19:29:27 +0100
Message-ID: <1292696967.2658.12.camel@aeonflux>
In-Reply-To: <1292627481-9109-9-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8897808986663231840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

>  	struct ofono_modem *modem;
> @@ -533,6 +552,8 @@ done:
>  		add_isi(modem, udev_device);
>  	else if (g_strcmp0(driver, "n900") =3D=3D 0)
>  		add_isi(modem, udev_device);
> +	else if (g_strcmp0(driver, "cdmagen") =3D=3D 0)
> +		add_cdmagen(modem, udev_device);
>  }

this is actually wrong. The generic drivers running against phonesim
should not be done via udev. We did remove atgen for a reason actually
since it was not really useful.

Even the isigen driver needs to be renamed into isiusb or usbpn in the
long term.

Regards

Marcel



--===============8897808986663231840==--

