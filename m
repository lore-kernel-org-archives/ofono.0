Content-Type: multipart/mixed; boundary="===============5644315744819354217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Fix the quirk handling of CPIN for Wavecom Q2XXX
Date: Wed, 31 Oct 2012 16:16:16 -0500
Message-ID: <50919520.8090600@gmail.com>
In-Reply-To: <1351726211-10255-1-git-send-email-holger@freyther.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5644315744819354217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Holger,

On 10/31/2012 06:30 PM, Holger Hans Peter Freyther wrote:
> From: Holger Hans Peter Freyther<hfreyther@sysmocom.de>
>
> Commit 1ccecfe01eb7f9f4d1d931814deb66ef37840b73 added the quirk
> handling for the Q2XXX module but it missed the first part of
> the Wavecom quirk handling.
>
> If decode_at_error is not fed with OK the error variable will be
> set to an error and the sim_pin_query_cb will exit before doing
> any notifications. This started to happen after git commit
> 72ce19bf3e87b5e73c053f7ea1095a5006f1aea9).
> ---
>   drivers/atmodem/sim.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index cf3345c..89445bb 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -980,7 +980,8 @@ static void at_cpin_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
>   	int len =3D sizeof(at_sim_name) / sizeof(*at_sim_name);
>   	const char *final =3D g_at_result_final_response(result);
>
> -	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM&&  ok&&  strlen(final)>  7)
> +	if ((sd->vendor =3D=3D OFONO_VENDOR_WAVECOM ||
> +			sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q2XXX)&&  ok&&  strlen(final)>=
  7)

Patch looks good to me, but can you please make sure this line doesn't =

go above 80 characters per our coding guidelines?  See doc/coding-style.txt

>   		decode_at_error(&error, "OK");
>   	else
>   		decode_at_error(&error, final);

Regards,
-Denis

--===============5644315744819354217==--

