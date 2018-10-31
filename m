Content-Type: multipart/mixed; boundary="===============1881120997820338913=="
MIME-Version: 1.0
From: Navik, Ankit P <ankit.p.navik@intel.com>
Subject: RE: [PATCH] udev: udpate udev to detect new 7xxx modems
Date: Wed, 31 Oct 2018 07:38:02 +0000
Message-ID: <2F886D5F95ED3A47BC8C177EADCD1CC7282DEE9F@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <1540968962-14314-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1881120997820338913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nandini, =


> -----Original Message-----
> From: ofono [mailto:ofono-bounces(a)ofono.org] On Behalf Of Nandini Rebel=
lo
> Sent: Wednesday, October 31, 2018 12:26 PM
> To: ofono(a)ofono.org
> Cc: Borwankar, Antara <antara.borwankar@intel.com>; Gargi, Anirudh
> <anirudh.gargi@intel.com>; Rebello, Nandini <nandini.rebello@intel.co=
m>
> Subject: [PATCH] udev: udpate udev to detect new 7xxx modems
> =

> Newer intel modems enumerate with different subsystem numbers, adding code
> to detect newer 7xxx modules.
> =

> Plan to add patch for backward compatibility of intels modems soon, to ba=
sed
> on interface number instead of subsystem name string.
> ---
>  plugins/udevng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/udevng.c b/plugins/udevng.c index 11338f7..bf0b1c4 1=
00644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -1194,10 +1194,10 @@ static gboolean setup_xmm7xxx(struct
> modem_info *modem)
>  				info->sysattr, info->subsystem);
> =

>  		if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
> -			if (g_strcmp0(info->number, "02") =3D=3D 0)
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
>  				mdm =3D info->devnode;
>  		} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
> -			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +			if (g_strcmp0(info->number, "06") =3D=3D 0)
Can this be maintained as separate patch in board support package ?
The reason is, this will be keep on getting change with different series of=
 xmm modem.

Regards, =

Ankit

>  				net =3D info->devnode;
>  		}
>  	}
> --
> 2.7.4
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============1881120997820338913==--

