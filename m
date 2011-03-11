Content-Type: multipart/mixed; boundary="===============4809167335848826919=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Isimodem: Crash while setting SCA
Date: Fri, 11 Mar 2011 13:59:46 -0600
Message-ID: <4D7A7F32.5040408@gmail.com>
In-Reply-To: <1299847795-9935-1-git-send-email-ext-arun.1.ravindran@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4809167335848826919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

On 03/11/2011 06:49 AM, ext-arun.1.ravindran(a)nokia.com wrote:
> From: Arun Ravindran <ext-arun.1.ravindran@nokia.com>
> =

> ---
>  drivers/isimodem/sms.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =


I applied the patch, however...

> diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
> index 957b342..c90c06d 100644
> --- a/drivers/isimodem/sms.c
> +++ b/drivers/isimodem/sms.c
> @@ -292,7 +292,7 @@ static void isi_sca_set(struct ofono_sms *sms,
>  		{ &sd->params, sizeof(sd->params) },
>  	};
>  =

> -	if (cbd =3D=3D NULL || sd =3D=3D NULL)
> +	if (cbd =3D=3D NULL || sd =3D=3D NULL || sd->sim =3D=3D NULL)

The check for sd =3D=3D NULL is too late since sd->params is being used up
above for initialization of iov...

>  		goto error;
>  =

>  	bcd =3D sd->params.sca;

Regards,
-Denis

--===============4809167335848826919==--

