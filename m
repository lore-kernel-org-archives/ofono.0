Content-Type: multipart/mixed; boundary="===============3900609335099361599=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 22/27] stkutil: Add Set Up Call response builder.
Date: Tue, 25 May 2010 16:38:41 -0500
Message-ID: <201005251638.41692.denkenz@gmail.com>
In-Reply-To: <1274018858-6968-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3900609335099361599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  src/stkutil.c |   33 +++++++++++++++++++++++++++++++++
>  src/stkutil.h |    9 +++++++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index cf22361..4e813ec 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -3129,6 +3129,20 @@ static gboolean build_dataobj_text(struct
>  stk_tlv_builder *tlv, return stk_tlv_close_container(tlv);
>  }
> =

> +/* Described in TS 102.223 Section 8.30 */
> +static gboolean build_dataobj_cc_requested_action(struct stk_tlv_builder
>  *tlv, +					const void *data, gboolean cr)
> +{
> +	const struct stk_common_byte_array *action =3D data;
> +
> +	return action->array =3D=3D NULL ||
> +		(stk_tlv_open_container(tlv, cr,
> +			STK_DATA_OBJECT_TYPE_CALL_CONTROL_REQUESTED_ACTION,
> +			FALSE) &&
> +		 stk_tlv_append_bytes(tlv, action->array, action->len) &&
> +		 stk_tlv_close_container(tlv));
> +}
> +

I really don't like this style, at the very least break up the tag into a =

variable so it is one open/append/close per line.  See how I did the others.

>  static gboolean build_dataobj(struct stk_tlv_builder *tlv, gboolean
>  				(*builder_func)(struct stk_tlv_builder *,
>  						const void *, gboolean), ...)
> @@ -3231,6 +3245,25 @@ unsigned int stk_pdu_from_response(const struct
>  stk_response *response, &response->select_item.item_id,
>  					NULL);
>  		break;
> +	case STK_COMMAND_TYPE_SETUP_CALL:
> +		if (response->set_up_call.modified_result.cc_modified)
> +			ok =3D build_dataobj(&builder,
> +					build_dataobj_cc_requested_action,
> +					DATAOBJ_FLAG_CR,
> +					&response->set_up_call.
> +					 cc_requested_action,
> +					build_dataobj_result, DATAOBJ_FLAG_CR,
> +					&response->set_up_call.modified_result.
> +					 result,
> +					NULL);
> +		else
> +			ok =3D build_dataobj(&builder,
> +					build_dataobj_cc_requested_action,
> +					DATAOBJ_FLAG_CR,
> +					&response->set_up_call.
> +					 cc_requested_action,
> +					NULL);
> +		break;

This really should be in a separate function, similar to how you did the lo=
cal =

info.

Regards,
-Denis

--===============3900609335099361599==--

