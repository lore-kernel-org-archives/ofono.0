Content-Type: multipart/mixed; boundary="===============1658658405129224963=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 12/20] stkutil: Add the Call Control envelope builder
Date: Wed, 09 Jun 2010 17:57:48 -0500
Message-ID: <201006091757.48688.denkenz@gmail.com>
In-Reply-To: <1275905322-14768-12-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1658658405129224963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> ---
>  src/stkutil.c |  178
>  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++- =

src/stkutil.h | =

>   31 ++++++++++
>  2 files changed, 207 insertions(+), 2 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 83ff5c7..b9a152a 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -319,8 +319,6 @@ static gboolean parse_dataobj_subaddress(struct
>  comprehension_tlv_iter *iter, unsigned int len;
> =

>  	len =3D comprehension_tlv_iter_get_length(iter);
> -	if (len < 1)
> -		return FALSE;

This seems wrong.  Can you point me to the test that uses empty subaddresse=
s?

> +/* Used both in the ENVELOPE message to UICC and response from UICC */
> +struct stk_envelope_call_control {
> +	/* Exactly one of the following 5 fields must be present */

Why are we not using a union then?

> +	struct stk_address address;
> +	struct stk_address ss_string;
> +	struct stk_ussd_string {
> +		unsigned char dcs;
> +		const unsigned char *string;

Please don't do that.  These objects will be passed around like candy and I =

don't want to deal with dangling pointers.

> +		int len;
> +	} ussd_string;

The ussd string is limited to 160 bytes according to 23.038.  So breaking t=
his =

out into a proper stk datatype like:
struct stk_ussd_string {
	unsigned char dcs;
	unsigned char ussd[160];
	int len;
};
would be better

> +	struct stk_common_byte_array pdp_ctx_params;
> +	struct stk_common_byte_array eps_pdn_params;
> +	/* At least one of the following two fields must be present in a
> +	 * response indicating modification of the call.
> +	 * In an EVELOPE message, only allowed for a call setup. */
> +	struct stk_ccp ccp1;
> +	struct stk_subaddress subaddress;
> +	struct stk_location_info location;
> +	/* Only allowed when ccp1 is present */
> +	struct stk_ccp ccp2;
> +	char *alpha_id;
> +	/* Only allowed when both ccp1 and ccp2 are present */
> +	struct stk_bc_repeat {
> +		ofono_bool_t has_bc_repeat;
> +		unsigned char value;
> +	} bc_repeat;

Can we break this out into a proper datatype as well, not nested in this =

struct.

Regards,
-Denis

--===============1658658405129224963==--

