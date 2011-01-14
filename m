Content-Type: multipart/mixed; boundary="===============1520014893174840142=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] stemodem: Incorrect string length in dtmf buf.
Date: Fri, 14 Jan 2011 11:34:32 +0100
Message-ID: <1295001272.3873.116.camel@aeonflux>
In-Reply-To: <1294999445-10274-1-git-send-email-clemson.helen@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1520014893174840142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Helen,

> Strlen includes a NULL character. This change affects both stemodem and h=
fpmodem.
> ---
>  drivers/hfpmodem/voicecall.c |    4 ++--
>  drivers/stemodem/voicecall.c |    5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)

please break this down into two patches. We always use separate patches
per driver directory. In addition it also then makes your subject line
correct.

> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index 4c8ee37..1aefc53 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -590,8 +590,8 @@ static void hfp_send_dtmf(struct ofono_voicecall *vc,=
 const char *dtmf,
>  	req->data =3D data;
>  	req->affected_types =3D 0;
>  =

> -	/* strlen("AT+VTS=3D") =3D 7 */
> -	buf =3D g_try_new(char, strlen(dtmf) + 7);
> +	/* strlen("AT+VTS=3D) =3D 7 + NULL */
> +	buf =3D g_try_new(char, strlen(dtmf) + 8);
>  =


While you are modifying this anyway, please also remove this extra empty
line. We try not to have that one if we check the result right away.

>  	if (buf =3D=3D NULL)
>  		goto error;

Regards

Marcel



--===============1520014893174840142==--

