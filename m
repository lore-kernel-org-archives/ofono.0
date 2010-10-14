Content-Type: multipart/mixed; boundary="===============7964287574245612459=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 4/8] atmodem: returns file-status of SIM EF-file
Date: Thu, 14 Oct 2010 05:57:21 -0500
Message-ID: <4CB6E211.3040500@gmail.com>
In-Reply-To: <1286896694-3054-5-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7964287574245612459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/12/2010 10:18 AM, Petteri Tikander wrote:
> ---
>  drivers/atmodem/sim.c |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index d0a7148..d44b7d2 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -64,11 +64,13 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	int flen, rlen;
>  	int str;
>  	unsigned char access[3];
> +	unsigned char file_status;
>  =

>  	decode_at_error(&error, g_at_result_final_response(result));
>  =

>  	if (!ok) {
> -		cb(&error, -1, -1, -1, NULL, cbd->data);
> +		cb(&error, -1, -1, -1, NULL,
> +			SIM_FILE_STATUS_NOT_AVAILABLE, cbd->data);

In the cases where an error occurs, I suggest passing in -1 for the
file_status.

>  		return;
>  	}
>  =

> @@ -88,27 +90,33 @@ static void at_crsm_info_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  		error.type =3D OFONO_ERROR_TYPE_SIM;
>  		error.error =3D (sw1 << 8) | sw2;
>  =

> -		cb(&error, -1, -1, -1, NULL, cbd->data);
> +		cb(&error, -1, -1, -1, NULL,
> +			SIM_FILE_STATUS_NOT_AVAILABLE, cbd->data);
>  		return;
>  	}
>  =

>  	DBG("crsm_info_cb: %02x, %02x, %i", sw1, sw2, len);
>  =

> -	if (response[0] =3D=3D 0x62)
> +	if (response[0] =3D=3D 0x62) {
>  		ok =3D sim_parse_3g_get_response(response, len, &flen, &rlen,
>  						&str, access, NULL);
> +
> +		file_status =3D SIM_FILE_STATUS_NOT_AVAILABLE;

For this case, file_status should be 0.  From what I remember of ETSI
102.221 3G sims do not return response data for invalidated files.  But
please double check this, or perhaps someone on the list knows.

> +	}
>  	else
>  		ok =3D sim_parse_2g_get_response(response, len, &flen, &rlen,
> -						&str, access);
> +						&str, access, &file_status);
>  =

>  	if (!ok)
>  		goto error;
>  =

> -	cb(&error, flen, str, rlen, access, cbd->data);
> +	cb(&error, flen, str, rlen, access, file_status, cbd->data);
> +
>  	return;
>  =

>  error:
> -	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, cbd->data);
> +	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL,
> +				SIM_FILE_STATUS_NOT_AVAILABLE, cbd->data);
>  }
>  =

>  static void at_sim_read_info(struct ofono_sim *sim, int fileid,
> @@ -123,7 +131,7 @@ static void at_sim_read_info(struct ofono_sim *sim, i=
nt fileid,
>  		unsigned char access[3] =3D { 0x00, 0x00, 0x00 };
>  =

>  		if (fileid =3D=3D SIM_EFAD_FILEID) {
> -			CALLBACK_WITH_SUCCESS(cb, 4, 0, 0, access, data);
> +			CALLBACK_WITH_SUCCESS(cb, 4, 0, 0, access, 0x01, data);
>  			return;
>  		}
>  	}
> @@ -142,7 +150,7 @@ static void at_sim_read_info(struct ofono_sim *sim, i=
nt fileid,
>  		return;
>  =

>  error:
> -	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
> +	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0xFF, data);

>  }
>  =

>  static void at_crsm_read_cb(gboolean ok, GAtResult *result,

Regards,
-Denis

--===============7964287574245612459==--

