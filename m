Content-Type: multipart/mixed; boundary="===============3297203865891768752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] util: Fix GSM to UTF8 conversion mechanism
Date: Sun, 15 Jul 2012 19:49:37 -0500
Message-ID: <50036521.4030005@gmail.com>
In-Reply-To: <1342449278-26294-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3297203865891768752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 07/16/2012 09:34 AM, Guillaume Zajac wrote:
> ---
>   src/util.c |   17 ++++++++++++++---
>   1 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/src/util.c b/src/util.c
> index aecc790..41ef3d4 100644
> --- a/src/util.c
> +++ b/src/util.c
> @@ -628,8 +628,16 @@ char *convert_gsm_to_utf8_with_lang(const unsigned c=
har *text, long len,
>
>   			c =3D gsm_single_shift_lookup(&t, text[i]);
>
> +			/*
> +			 * According to the 3GPP specifications 23.038
> +			 * section 6.2.1.1:
> +			 * In the case there is no character in the extension
> +			 * table, the character of the main default alphabet
> +			 * table or the character from the National Language
> +			 * Locking Shift Table should be displayed.
> +			 */

What version of 23.038 are you using? I cannot find such wording in R9 =

or R10 specs.

>   			if (c =3D=3D GUND)
> -				goto error;
> +				c =3D gsm_locking_shift_lookup(&t, text[i]);
>   		} else {
>   			c =3D gsm_locking_shift_lookup(&t, text[i]);
>   		}
> @@ -647,9 +655,12 @@ char *convert_gsm_to_utf8_with_lang(const unsigned c=
har *text, long len,
>   	while (out<  res + res_length) {
>   		unsigned short c;
>
> -		if (text[i] =3D=3D 0x1b)
> +		if (text[i] =3D=3D 0x1b) {
>   			c =3D gsm_single_shift_lookup(&t, text[++i]);
> -		else
> +			/* See 3GPP 23.038 section 6.2.1.1 */
> +			if (c =3D=3D GUND)
> +				c =3D gsm_locking_shift_lookup(&t, text[i]);
> +		} else
>   			c =3D gsm_locking_shift_lookup(&t, text[i]);
>
>   		out +=3D g_unichar_to_utf8(c, out);

Regards,
-Denis

--===============3297203865891768752==--

