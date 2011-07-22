Content-Type: multipart/mixed; boundary="===============7865903153171104232=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] udev: add support for SpeedUp CDMA dongles.
Date: Fri, 22 Jul 2011 11:22:13 +0200
Message-ID: <1311326540.21109.295.camel@aeonflux>
In-Reply-To: <1311307040-10346-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7865903153171104232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

>  plugins/udev.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/udev.c b/plugins/udev.c
> index a28bea7..b50ca2f 100644
> --- a/plugins/udev.c
> +++ b/plugins/udev.c
> @@ -793,6 +793,8 @@ done:
>  		add_linktop(modem, udev_device);
>          else if (g_strcmp0(driver, "speedup") =3D=3D 0)
>  		add_speedup(modem, udev_device);
> +	else if (g_strcmp0(driver, "speedupcdma") =3D=3D 0)
> +		add_speedup(modem, udev_device);
>  =


patch has been applied, but I had to cleanup the whitespace damage from
the previous patch ;)

Regards

Marcel



--===============7865903153171104232==--

