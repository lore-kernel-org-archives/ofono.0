Content-Type: multipart/mixed; boundary="===============5715900672130418800=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH] Add WSP_VALUE_TYPE_TEXT support in
 wsp_decode_application_id()
Date: Wed, 16 May 2012 17:45:24 +0200
Message-ID: <4FB3CB94.1000108@linux.intel.com>
In-Reply-To: <1337177005-7385-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5715900672130418800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 05/16/2012 04:03 PM, Jens Rehsack wrote:
> From: Jens Rehsack<sno@NetBSD.org>
>
> ---
>   src/wsputil.c |    6 ++++++
>   1 Datei ge=C3=A4ndert, 6 Zeilen hinzugef=C3=BCgt(+)
>
> diff --git a/src/wsputil.c b/src/wsputil.c
> index 1b2b2b7..c4c9d62 100644
> --- a/src/wsputil.c
> +++ b/src/wsputil.c
> @@ -496,6 +496,12 @@ gboolean wsp_decode_application_id(struct wsp_header=
_iter *iter,
>   	 */
>   	if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHORT) {
>   		val =3D *pdu_val&  0x7f;
> +	} else if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_TEX=
T) {
> +		val_len =3D wsp_header_iter_get_val_len(iter);
> +		val =3D -1;
> +
> +		if (out_value)
> +			*out_value =3D pdu_val;
>   	} else {
>   		val_len =3D wsp_header_iter_get_val_len(iter);
>

Unless I miss something, if the application_id is given as TEXT (in the =

pdu) the *out_value will always be NULL (it will be set to the result of =

get_text_entry()).

I think you don't need to set val_len and val, you can just return TRUE =

after doing *out_value =3D pdu_val.

Best regards,

Ronald

--===============5715900672130418800==--

