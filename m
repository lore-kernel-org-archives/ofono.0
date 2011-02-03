Content-Type: multipart/mixed; boundary="===============6926722699615663212=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] smsutil: Remove dialect checks from caller
Date: Thu, 03 Feb 2011 14:01:23 -0600
Message-ID: <4D4B0993.1010607@gmail.com>
In-Reply-To: <1296739236-24391-3-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6926722699615663212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 02/03/2011 07:20 AM, Aki Niemi wrote:
> ---
>  src/smsutil.c |   10 ----------
>  1 files changed, 0 insertions(+), 10 deletions(-)
> =

> diff --git a/src/smsutil.c b/src/smsutil.c
> index 1762391..5c1ae4c 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -2267,16 +2267,6 @@ char *sms_decode_text(GSList *sms_list)
>  			sms_extract_language_variant(sms, &locking_shift,
>  								&single_shift);
>  =

> -			/*
> -			 * If language is not defined in 3GPP TS 23.038,
> -			 * implementations are instructed to ignore it
> -			 */
> -			if (locking_shift >=3D GSM_DIALECT_INVALID)
> -				locking_shift =3D GSM_DIALECT_DEFAULT;
> -
> -			if (single_shift >=3D GSM_DIALECT_INVALID)
> -				single_shift =3D GSM_DIALECT_DEFAULT;
> -
>  			converted =3D convert_gsm_to_utf8_with_lang(buf, written,
>  								NULL, NULL, 0,
>  								locking_shift,

I'm pretty sure you want to leave this check in, otherwise you will not
be compliant with 23.040.  If the dialect used is not understood, we
have to fall-back to the default, not ignore the message.

Regards,
-Denis

--===============6926722699615663212==--

