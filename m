Content-Type: multipart/mixed; boundary="===============0499561633224975258=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 10/13] call-forwarding: CFU unset, update conditionals
Date: Mon, 23 Apr 2012 16:06:27 -0500
Message-ID: <4F95C453.6010504@gmail.com>
In-Reply-To: <1334060254-29547-11-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0499561633224975258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 04/10/2012 07:17 AM, Oleg Zhurakivskyy wrote:
> Also set the cached flag on CFU activation and
> re-querying of the conditionals.
> ---
>  src/call-forwarding.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 786d163..aa1ece7 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -659,6 +659,16 @@ static void set_query_cf_callback(const struct ofono=
_error *error, int total,
>  	DBG("%s conditions:", cf_type_lut[cf->query_next]);
>  	cf_cond_list_print(cf->cf_conditions[cf->query_next]);
>  =

> +	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL) {
> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;

I'm not quite following why we need to set this flag here?

> +
> +		/*
> +		 * CFU has been disabled, conditionals need to be updated
> +		 */
> +		if (is_cfu_enabled(cf) =3D=3D FALSE)
> +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;

Would it make more sense to make this decision in set_property_request()?

> +	}
> +
>  	if (cf->query_next =3D=3D cf->query_end)
>  		return;
>  =


Regards,
-Denis

--===============0499561633224975258==--

