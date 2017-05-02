Content-Type: multipart/mixed; boundary="===============5923236350756571154=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 2/7] udevng/gobi: use subsystem as first identification
Date: Tue, 02 May 2017 07:26:19 +0200
Message-ID: <76538107-2a65-9e10-d7c7-bb1d6ecfd5c4@southpole.se>
In-Reply-To: <20170501205256.4205-2-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5923236350756571154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/01/2017 10:52 PM, Alexander Couzens wrote:
> Using kernel 4.10 with systemd 232 on archlinux the detection of
> a gobi 2000 doesn't detect the qmi/cdc-wdm interface.
>
> The device is detected as follows:
>
> [devnode interface number label sysattr subsystem]
> /dev/cdc-wdm1 255/255/255 00 (null) (null) usbmisc
> wwan1 255/255/255 00 (null) (null) net
> /dev/ttyUSB5 255/255/255 01 (null) (null) tty
> /dev/ttyUSB6 255/255/255 02 (null) (null) tty
> /dev/ttyUSB7 255/255/255 03 (null) (null) tty
> ---
>   plugins/udevng.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 47bc8910..e8b800c1 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -208,17 +208,19 @@ static gboolean setup_gobi(struct modem_info *modem)
>   						info->number, info->label,
>   						info->sysattr, info->subsystem);
>   =

> -		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
> -			if (info->number =3D=3D NULL)
> -				qmi =3D info->devnode;
> -			else if (g_strcmp0(info->number, "00") =3D=3D 0)
> -				net =3D info->devnode;
> -			else if (g_strcmp0(info->number, "01") =3D=3D 0)
> -				diag =3D info->devnode;
> -			else if (g_strcmp0(info->number, "02") =3D=3D 0)
> -				mdm =3D info->devnode;
> -			else if (g_strcmp0(info->number, "03") =3D=3D 0)
> -				gps =3D info->devnode;
> +		if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) /* cdc-wdm */
> +			qmi =3D info->devnode;
> +		else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) /* wwan */
> +			net =3D info->devnode;
> +		else if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> +			if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
> +				if (g_strcmp0(info->number, "01") =3D=3D 0)
> +					diag =3D info->devnode;
> +				else if (g_strcmp0(info->number, "02") =3D=3D 0)
> +					mdm =3D info->devnode;
> +				else if (g_strcmp0(info->number, "03") =3D=3D 0)
> +					gps =3D info->devnode;
> +			}

I also wondered about this code.  The original has a method of detecting =

the qmi and net interfaces that doesn't match the way things work with =

the qmiwwan driver.  I wonder if the proprietary gobi driver does things =

differently and wants the original incantation...???  Somebody with =

older hardware might have some insight here.

I suspect that we might want to separate the handling of the gobi and =

qmiwwan drivers:  setup_gobi for the 'gobi' driver and a new =

setup_qmiwwan function if the 'qmiwwan' driver is in use.

/Jonas

>   		}
>   	}
>   =




--===============5923236350756571154==--

