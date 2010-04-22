Content-Type: multipart/mixed; boundary="===============9009094527438355697=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] Fix CTLV three-byte tag parsing.
Date: Thu, 22 Apr 2010 16:58:20 -0500
Message-ID: <201004221658.20759.denkenz@gmail.com>
In-Reply-To: <1271923876-3320-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9009094527438355697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  src/simutil.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index 9fb111f..822938c 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -210,7 +210,7 @@ void comprehension_tlv_iter_init(struct
>  comprehension_tlv_iter *iter, iter->data =3D 0;
>  }
> =

> -/* Comprehension TLVs defined in Section 7 of ETSI TS 102.220 */
> +/* Comprehension TLVs defined in Section 7 of ETSI TS 101.220 */
>  gboolean comprehension_tlv_iter_next(struct comprehension_tlv_iter *iter)
>  {
>  	const unsigned char *pdu =3D iter->pdu + iter->pos;
> @@ -230,18 +230,18 @@ gboolean comprehension_tlv_iter_next(struct
>  comprehension_tlv_iter *iter) return FALSE;
> =

>  	/*
> -	 * ETSI TS 102.220, Section 7.1.1.2
> +	 * ETSI TS 101.220, Section 7.1.1.2
>  	 *
>  	 * If byte 1 of the tag is equal to 0x7F, then the tag is encoded
> -	 * on the following two bytes, with bit 8 of the 2nd byte of the tag
> -	 * being the CR flag.
> +	 * on the following two bytes, with bit 8 of the 1st byte of the tag
> +	 * as the most significant bit.

Please keep the comment about the CR flag, I think that is useful. =


>  	 */
> -	if (tag =3D=3D 0x7F) {
> +	if (tag =3D=3D 0x7F && !cr) {

This isn't actually necessary.  However, the statement:

        if (tag =3D=3D 0x00 || tag =3D=3D 0xFF || tag =3D=3D 0x80)
                return FALSE;

Actually needs to be moved up and tag changed to *pdu.

>  		if ((pdu + 2) > end)
>  			return FALSE;
> =

>  		cr =3D bit_field(pdu[0], 7, 1);
> -		tag =3D ((pdu[0] & 0x7f) << 7) | pdu[1];
> +		tag =3D ((pdu[0] & 0x7f) << 8) | pdu[1];
> =

>  		if (tag < 0x0001 || tag > 0x7fff)
>  			return FALSE;
> =


Can you resubmit the patch with these changes?

Thanks,
-Denis

--===============9009094527438355697==--

