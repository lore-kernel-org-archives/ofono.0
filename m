Content-Type: multipart/mixed; boundary="===============0881647323425570692=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH] Add WSP_VALUE_TYPE_TEXT support in
 wsp_decode_application_id()
Date: Mon, 21 May 2012 18:23:32 +0200
Message-ID: <4FBA6C04.1060303@linux.intel.com>
In-Reply-To: <1337597654-26049-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0881647323425570692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 05/21/2012 12:54 PM, Jens Rehsack wrote:
> From: Jens Rehsack<sno@NetBSD.org>
>
> ---
>   src/wsputil.c |   43 ++++++++++++++++++++++++++-----------------
>   1 Datei ge=C3=A4ndert, 26 Zeilen hinzugef=C3=BCgt(+), 17 Zeilen entfern=
t(-)
>
> diff --git a/src/wsputil.c b/src/wsputil.c
> index 1b2b2b7..5611ed2 100644
> --- a/src/wsputil.c
> +++ b/src/wsputil.c
> @@ -486,28 +486,37 @@ gboolean wsp_decode_application_id(struct wsp_heade=
r_iter *iter,
>   							const void **out_value)
>   {
>   	const unsigned char *pdu_val =3D wsp_header_iter_get_val(iter);
> -	unsigned int val;
> -	unsigned int val_len;
> -	unsigned int i;
>
> -	/*
> -	 * Well-known field values MUST be encoded using the
> -	 * compact binary formats
> -	 */
> -	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
> -		val =3D *pdu_val&  0x7f;
> +	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT) {
> +		wsp_header_iter_get_val_len(iter);
> +
> +		if (out_value)
> +			*out_value =3D pdu_val;

Why not just returning if the type is TEXT ?
Something like :

	const unsigned char *pdu_val =3D wsp_header_iter_get_val(iter);
	unsigned int val;
	unsigned int val_len;
	unsigned int i;

+	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEXT) {
+		if (out_value)
+			*out_value =3D pdu_val;
+
+		return TRUE;
+	}
+
	/*
	 * Well-known field values MUST be encoded using the
	 * compact binary formats
	 */
	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {


I think it does the same thing but more readable (you don't break the 80 =

col. limit).

Best regards,

Ronald


>   	} else {
> -		val_len =3D wsp_header_iter_get_val_len(iter);
> +		unsigned int val;
>
> -		if (val_len>  2)
> -			return FALSE;
> +		/*
> +		 * Well-known field values MUST be encoded using the
> +		 * compact binary formats
> +		 */
> +		if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
> +			val =3D *pdu_val&  0x7f;
> +		} else  {
> +			unsigned int val_len;
> +			unsigned int i;
>
> -		for (i =3D 0, val =3D 0; i<  val_len&&  i<  sizeof(val); i++)
> -			val =3D (val<<  8) | pdu_val[i];
> -	}
> +			val_len =3D wsp_header_iter_get_val_len(iter);
>
> -	if (out_value)
> -		*out_value =3D get_text_entry(val, app_id);
> +			if (val_len>  2)
> +				return FALSE;
> +
> +			for (i =3D 0, val =3D 0; i<  val_len&&  i<  sizeof(val); i++)
> +				val =3D (val<<  8) | pdu_val[i];
> +		}
> +
> +		if (out_value)
> +			*out_value =3D get_text_entry(val, app_id);
> +	}
>
>   	return TRUE;
>   }

--===============0881647323425570692==--

