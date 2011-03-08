Content-Type: multipart/mixed; boundary="===============5511375604592511237=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 09:12:39 -0800
Message-ID: <1299604359.2497.5.camel@aeonflux>
In-Reply-To: <1299573784-21478-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5511375604592511237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

>  drivers/atmodem/network-registration.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 4913611..2d589f0 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -722,6 +722,8 @@ static void ifx_ctzv_notify(GAtResult *result, gpoint=
er user_data)
>  	nd->time.mday =3D mday;
>  	nd->time.mon =3D mon;
>  	nd->time.year =3D 2000 + year;
> +
> +	ofono_netreg_time_notify(netreg, &nd->time);
>  }
>  =

>  static void ifx_ctzdst_notify(GAtResult *result, gpointer user_data)

actually this time notification is a bad idea since you will notify
twice now. With the firmware that I tested this with, it is guaranteed
to always get CTZV and CTZDST and in that order.

Regards

Marcel



--===============5511375604592511237==--

