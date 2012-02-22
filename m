Content-Type: multipart/mixed; boundary="===============5114305438105611722=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 7/8] call-forwarding: Clear the conditional cache flag
Date: Wed, 22 Feb 2012 07:33:15 -0600
Message-ID: <4F44EE9B.8000407@gmail.com>
In-Reply-To: <1328531641-10612-8-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5114305438105611722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 02/06/2012 06:34 AM, Oleg Zhurakivskyy wrote:
> If there is an successful attempt to deactivate conditional cf
> while cfu is active, the conditional cache flag is cleared.
> ---
>  src/call-forwarding.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 2813005..a38a743 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -722,6 +722,14 @@ static void set_query_cf_callback(const struct ofono=
_error *error, int total,
>  	DBG("%s conditions:", cf_type_lut[cf->query_next]);
>  	cf_cond_list_print(l);
>  =

> +	/*
> +	 * If there is an successful attempt to deactivate conditional cf
> +	 * while cfu is active, the conditional cache flag is cleared.
> +	 */
> +	if (cf->query_next !=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
> +			is_cfu_enabled(cf))
> +		cf->flags &=3D ~CALL_FORWARDING_FLAG_CACHED;
> +
>  	if (cf->query_next !=3D cf->query_end) {
>  		cf->query_next++;
>  		set_query_next_cf_cond(cf);

This would cause us to re-query everything, which is a bit wasteful.
Also, you have to handle the same action that might occur during
supplementary services path, e.g. the user might deactivate / erase a
conditional service there (see cf_ss_control and
cf_ss_control_callback).  The DisableAll path also needs to be handled
properly.

Also, there is another path you need to take under consideration and
that is the supplementary service interrogation path.  That one can
update conditional settings erroneously if CFU is active.  See
ss_set_query_cf_callback.

We might need to track CFU and conditional caches separately to make
things easier.  Let me know if you have any questions.  CallForwarding
was one of the earliest implemented interfaces and turned out to be
quite a bit more complicated than originally thought ;)

Regards,
-Denis

--===============5114305438105611722==--

