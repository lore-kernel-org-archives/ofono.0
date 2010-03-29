Content-Type: multipart/mixed; boundary="===============7083473377446641654=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/9] Add parser for items next action indicator objects
Date: Mon, 29 Mar 2010 17:12:43 -0500
Message-ID: <201003291712.44314.denkenz@gmail.com>
In-Reply-To: <1269879884-12741-2-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7083473377446641654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   38 ++++++++++++++++++++++++++++++++++++++
>  src/stkutil.h |    5 +++++
>  2 files changed, 43 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 9a02658..b997752 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -67,6 +67,34 @@ static gboolean parse_dataobj_common_bool(struct
>  comprehension_tlv_iter *iter, return TRUE;
>  }
> =

> +/* For data object that only has a byte array with variable length */
> +static gboolean parse_dataobj_common_byte_array(
> +		struct comprehension_tlv_iter *iter, void *user,

Can we have this function take two arguments, namely the array and the len?=
  I =

don't like introducing stk_common_byte_array as an exported data type.

> +		enum stk_data_object_type type)
> +{
> +	struct stk_common_byte_array *array =3D user;
> +	const unsigned char *data;
> +	unsigned int len;
> +
> +	if (comprehension_tlv_iter_get_tag(iter) !=3D type)
> +		return FALSE;
> +
> +	len =3D comprehension_tlv_iter_get_length(iter);
> +	if (len < 1)
> +		return FALSE;
> +
> +	data =3D comprehension_tlv_iter_get_data(iter);
> +	array->len =3D len;
> +
> +	array->array =3D g_try_malloc(len);
> +	if (array->array =3D=3D NULL)
> +		return FALSE;
> +
> +	memcpy(array->array, data, len);
> +
> +	return TRUE;
> +}
> +
>  /* Defined in TS 102.223 Section 8.1 */
>  static gboolean parse_dataobj_address(struct comprehension_tlv_iter *ite=
r,
>  					void *user)
> @@ -643,6 +671,14 @@ static gboolean
>  parse_dataobj_network_measurement_results( return TRUE;
>  }
> =

> +/* Defined in TS 102.223 Section 8.24 */
> +static gboolean parse_dataobj_items_next_action_indicator(
> +		struct comprehension_tlv_iter *iter, void *user)
> +{
> +	return parse_dataobj_common_byte_array(iter, user,
> +			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR);
> +}
> +

So in theory this object does not need to be malloced.  We know that it is =
max =

of 127 bytes long according to the rules of comprehension tlvs.  Might as w=
ell =

treat it that way.  I seriously want to avoid g_malloc / g_free unless =

absolutely necessary.

>  /* Defined in TS 102.223 Section 8.31 */
>  static gboolean parse_dataobj_icon_id(struct comprehension_tlv_iter *ite=
r,
>  					void *user)
> @@ -760,6 +796,8 @@ static dataobj_handler handler_for_type(enum
>  stk_data_object_type type) return parse_dataobj_help_request;
>  	case STK_DATA_OBJECT_TYPE_NETWORK_MEASUREMENT_RESULTS:
>  		return parse_dataobj_network_measurement_results;
> +	case STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR:
> +		return parse_dataobj_items_next_action_indicator;
>  	case STK_DATA_OBJECT_TYPE_ICON_ID:
>  		return parse_dataobj_icon_id;
>  	case STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE:
> diff --git a/src/stkutil.h b/src/stkutil.h
> index a9495de..cd43ae2 100644
> --- a/src/stkutil.h
> +++ b/src/stkutil.h
> @@ -266,6 +266,11 @@ enum stk_tone_type {
>  	STK_TONE_TYPE_MELODY_8 =3D	0x47
>  };
> =

> +struct stk_common_byte_array {
> +	unsigned int len;
> +	unsigned char *array;
> +};
> +
>  /* Defined in TS 102.223 Section 8.1 */
>  struct stk_address {
>  	unsigned char ton_npi;
>=20

--===============7083473377446641654==--

