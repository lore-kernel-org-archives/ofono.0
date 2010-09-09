Content-Type: multipart/mixed; boundary="===============7746829099192983322=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 10/12] Add build_dataobj_ussd_text for ussd specific text
 string handling
Date: Thu, 09 Sep 2010 10:31:10 -0500
Message-ID: <4C88FDBE.70706@gmail.com>
In-Reply-To: <1284035516-21359-11-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7746829099192983322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 07:31 AM, Jeevaka Badrappan wrote:
> ---
>  src/stkutil.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index ae4cc32..e953ead 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4170,6 +4170,34 @@ static gboolean build_dataobj_text(struct stk_tlv_=
builder *tlv,
>  	return stk_tlv_builder_close_container(tlv);
>  }
>  =

> +/* Defined in TS 102.223 Section 8.15 - USSD specific case*/
> +static gboolean build_dataobj_ussd_text(struct stk_tlv_builder *tlv,
> +					const void *data, gboolean cr)
> +{
> +	const struct stk_ussd_text *text =3D data;
> +	unsigned char tag =3D STK_DATA_OBJECT_TYPE_TEXT;
> +	gboolean ret;
> +
> +	if (!text->text || !text->len)
> +		return TRUE;

You have to be a bit careful here.  Text does support the notion of
NULL/empty strings.  E.g. the CTLV is present, and the length is set to
0.  Refer to ETSI 102.223 Section 8.15.

> +
> +	if (stk_tlv_builder_open_container(tlv, cr, tag, TRUE) !=3D TRUE)
> +		return FALSE;
> +
> +	if (text->dcs !=3D -1) {
> +		if (stk_tlv_builder_append_byte(tlv, text->dcs) !=3D TRUE)
> +			return FALSE;
> +		=

> +		ret =3D stk_tlv_builder_append_bytes(tlv, text->text, text->len);
> +	} else
> +		ret =3D stk_tlv_builder_append_text(tlv, -1, (const char *) text->text=
);

I prefer that we assume dcs will always be 0x00, 0x04 or 0x08.

> +
> +	if (ret !=3D TRUE)
> +		return ret;
> +
> +	return stk_tlv_builder_close_container(tlv);
> +}
> +
>  /* Described in TS 131.111 Section 8.17 */
>  static gboolean build_dataobj_ussd_string(struct stk_tlv_builder *tlv,
>  					const void *data, gboolean cr)
> @@ -5459,6 +5487,13 @@ const unsigned char *stk_pdu_from_response(const s=
truct stk_response *response,
>  	case STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION:
>  	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
>  		break;
> +	case STK_COMMAND_TYPE_SEND_USSD:
> +		ok =3D build_dataobj(&builder,
> +					build_dataobj_ussd_text,
> +					DATAOBJ_FLAG_CR,
> +					&response->send_ussd.text,
> +					NULL);
> +		break;
>  	default:
>  		return NULL;
>  	};

Regards,
-Denis

--===============7746829099192983322==--

