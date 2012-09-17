Content-Type: multipart/mixed; boundary="===============8985989315823856801=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/3] smsutil: <CR> is not necessarily a CBS padding
 character
Date: Mon, 17 Sep 2012 11:58:10 -0500
Message-ID: <505756A2.6040102@gmail.com>
In-Reply-To: <1346425438-12220-2-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8985989315823856801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 08/31/2012 10:03 AM, Philippe Nunes wrote:
> ---
>   src/smsutil.c |   36 +++++++++++++++++++++++++++++-------
>   1 file changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/src/smsutil.c b/src/smsutil.c
> index b4d129f..7569c63 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -4090,7 +4090,7 @@ char *cbs_decode_text(GSList *cbs_list, char *iso63=
9_lang)
>   			unsigned char unpacked[CBS_MAX_GSM_CHARS];
>   			long written;
>   			int max_chars;
> -			int i;
> +			int i, j;
>
>   			max_chars =3D
>   				sms_text_capacity_gsm(CBS_MAX_GSM_CHARS, taken);
> @@ -4102,12 +4102,24 @@ char *cbs_decode_text(GSList *cbs_list, char *iso=
639_lang)
>   			i =3D iso639 ? 3 : 0;
>
>   			/*
> -			 * CR is a padding character, which means we can
> -			 * safely discard everything afterwards
> +			 * CR can be used as a padding character, which means
> +			 * we can safely discard everything afterwards
>   			 */
> +
>   			for (; i<  written; i++, bufsize++) {
> -				if (unpacked[i] =3D=3D '\r')
> -					break;
> +				if (unpacked[i] =3D=3D '\r') {
> +					/*
> +					 * check if this is a padding character
> +					 * or if it is a wanted<CR>
> +					 */
> +					for (j =3D i + 1; j<  written; j++)
> +						if (unpacked[j] !=3D '\r')
> +							break;
> +
> +					if (j =3D=3D written)
> +						break;
> +				}
> +
>
>   				buf[bufsize] =3D unpacked[i];
>   			}

I skipped the first two chunks and fixed this slightly differently.

> @@ -4135,8 +4147,18 @@ char *cbs_decode_text(GSList *cbs_list, char *iso6=
39_lang)
>   			}
>
>   			while (i<  max_offset) {
> -				if (ud[i] =3D=3D 0x00&&  ud[i+1] =3D=3D '\r')
> -					break;
> +				if (ud[i] =3D=3D 0x00&&  ud[i+1] =3D=3D '\r') {
> +					int j =3D i + 2;
> +
> +					for (; j<  max_offset; j =3D j + 2)
> +						if (ud[j] !=3D 0x00 ||
> +								ud[j + 1] !=3D
> +									'\r')
> +							break;
> +
> +					if (j =3D=3D max_offset)
> +						break;
> +				}
>
>   				buf[bufsize] =3D ud[i];
>   				buf[bufsize + 1] =3D ud[i + 1];

The last chunk has been applied, thanks.

Regards,
-Denis

--===============8985989315823856801==--

