Content-Type: multipart/mixed; boundary="===============5775074785409313689=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Do some polling on at_pin_query
Date: Thu, 12 Apr 2012 14:36:20 -0500
Message-ID: <4F872EB4.60207@gmail.com>
In-Reply-To: <1334240913-27063-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5775074785409313689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 04/12/2012 09:28 AM, Guillaume Zajac wrote:
> For some modem like ZTE MF180/190, we need to do some
> polling to check SIM state when it returns +CME ERROR: 14 busy.
> ---
>  drivers/atmodem/sim.c |   59 +++++++++++++++++++++++++++++++++++++++----=
-----
>  1 files changed, 48 insertions(+), 11 deletions(-)
> =


<snip>

> @@ -874,9 +878,22 @@ static void at_cpin_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>  	else
>  		decode_at_error(&error, final);
>  =

> -	if (!ok) {
> +	switch (error.type) {
> +	case OFONO_ERROR_TYPE_NO_ERROR:
> +		break;
> +	case OFONO_ERROR_TYPE_CME:
> +		/* Check for SIM busy - try again later */
> +		if (error.error =3D=3D 14) {
> +			if (sd->poll_count++ < 12) {
> +				sd->poll_source =3D g_timeout_add_seconds(2,
> +						sim_state_check, cbd);
> +				return;
> +			}
> +		}
> +		/* fall through */
> +	default:
>  		cb(&error, -1, cbd->data);
> -		return;
> +		goto done;
>  	}
>  =

>  	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM) {

Is there a reason we are not using at_util_sim_state_query_new?

<snip>

Regards,
-Denis

--===============5775074785409313689==--

