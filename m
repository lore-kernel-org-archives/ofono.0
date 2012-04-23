Content-Type: multipart/mixed; boundary="===============5651232792492781642=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 11/13] call-forwarding: Re-run ss path queries on CFU
 unset
Date: Mon, 23 Apr 2012 16:28:12 -0500
Message-ID: <4F95C96C.5070508@gmail.com>
In-Reply-To: <1334060254-29547-12-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5651232792492781642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 04/10/2012 07:17 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/call-forwarding.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index aa1ece7..204ecc7 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -1004,6 +1004,16 @@ static void ss_set_query_cf_callback(const struct =
ofono_error *error, int total,
>  =

>  	set_new_cond_list(cf, cf->query_next, l);
>  =

> +	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +			cf->query_next =3D=3D cf->query_end) {
> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
> +		/*
> +		 * CFU has been disabled, conditionals need to be updated
> +		 */
> +		if (is_cfu_enabled(cf) =3D=3D FALSE)
> +			cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;

So a bit of background, the original set + query logic did not mess with
the CACHED flag.  The assumption was that we're modifying a single
property.  If the CACHED flag was already set, then the modification was
queried and the CACHED flag was still valid.  If the CACHED flag was not
set, then we'd re-query the entire thing anyway.

Now we have a somewhat funny situation where when we clear CFU, we are
essentially forced into querying everything.  The immediate problem with
your approach is that we can't return from the method call until all
settings have been queried.  By convention the core can have only a
single outstanding call into the driver at a time.  We bend the rules
somewhat, but in general we need to stick to this rule.  This is why you
see busy error conditions everywhere.  So likely this needs a specific
code path ...

Also, there is an optimization we can make here, e.g. if we queried the
conditional forwarding settings prior to CFU being enabled, then we can
keep those around.  This is why the TODO item refers to the 'conditional
cache.'  In the case of CFU being flipped to enabled and then disabled,
we do not need to query.

> +	}
> +
>  	if (cf->query_next !=3D cf->query_end) {
>  		cf->query_next++;
>  		ss_set_query_next_cf_cond(cf);

Regards,
-Denis

--===============5651232792492781642==--

