Content-Type: multipart/mixed; boundary="===============8906344615716782960=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 10/13] Add build_dataobj_ussd_text for ussd specific text
 string handling
Date: Fri, 10 Sep 2010 12:29:01 -0500
Message-ID: <4C8A6ADD.1030104@gmail.com>
In-Reply-To: <1284059164-15645-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8906344615716782960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 02:06 PM, Jeevaka Badrappan wrote:
> ---
>  src/stkutil.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index ae4cc32..c69ebba 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -4170,6 +4170,22 @@ static gboolean build_dataobj_text(struct stk_tlv_=
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
> +
> +	if (!text->text)
> +		return TRUE;

This still does not handle empty data.  We should do something like:

open_container()

if (text->len > 0) {
	append_byte(dcs);
	append_bytes(text);
}

close_container()

> +
> +	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
> +		stk_tlv_builder_append_byte(tlv, text->dcs) &&
> +		stk_tlv_builder_append_bytes(tlv, text->text, text->len) &&
> +		stk_tlv_builder_close_container(tlv);
> +}
> +

Regards,
-Denis

--===============8906344615716782960==--

