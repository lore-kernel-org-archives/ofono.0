Content-Type: multipart/mixed; boundary="===============0381387719554157969=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/9] Make sim operations return sim error codes to core.
Date: Thu, 01 Jul 2010 14:16:54 -0500
Message-ID: <4C2CE9A6.1040508@gmail.com>
In-Reply-To: <1277806448-5322-4-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0381387719554157969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 06/29/2010 05:14 AM, Andrzej Zaborowski wrote:
> ---
>  drivers/atmodem/stk.c |   20 ++++++++++++--------
>  include/types.h       |    1 +

When you're touching more than two directories, always break the patches
up / directory.  In this case resubmit two patches, one for types.h and
separate patch for stk.c

>  2 files changed, 13 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/atmodem/stk.c b/drivers/atmodem/stk.c
> index 8cff4a2..aede668 100644
> --- a/drivers/atmodem/stk.c
> +++ b/drivers/atmodem/stk.c
> @@ -74,11 +74,13 @@ static void at_csim_envelope_cb(gboolean ok, GAtResul=
t *result,
>  	if (rlen !=3D len * 2 || len < 2)
>  		goto error;
>  =

> -	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
> -		goto error;
> +	if ((response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91) ||
> +			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)) {
> +		memset(&error, 0, sizeof(error));
>  =

> -	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
> -		goto error;
> +		error.type =3D OFONO_ERROR_TYPE_SIM;
> +		error.error =3D (response[len - 2] << 8) | response[len - 1];
> +	}
>  =

>  	DBG("csim_envelope_cb: %i", len);
>  =

> @@ -157,11 +159,13 @@ static void at_csim_terminal_response_cb(gboolean o=
k, GAtResult *result,
>  	if (rlen !=3D len * 2 || len < 2)
>  		goto error;
>  =

> -	if (response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91)
> -		goto error;
> +	if ((response[len - 2] !=3D 0x90 && response[len - 2] !=3D 0x91) ||
> +			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)) {
> +		memset(&error, 0, sizeof(error));
>  =

> -	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
> -		goto error;
> +		error.type =3D OFONO_ERROR_TYPE_SIM;
> +		error.error =3D (response[len - 2] << 8) | response[len - 1];
> +	}
>  =

>  	DBG("csim_terminal_response_cb: %i", len);
>  =


Do you think it is a good idea to do this for all SIM elementary file
operations as well?

Regards,
-Denis

--===============0381387719554157969==--

