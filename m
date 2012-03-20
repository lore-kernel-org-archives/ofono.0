Content-Type: multipart/mixed; boundary="===============6376940946948585542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 04/12] call-forwarding: Refactor cf_find_unconditional()
Date: Tue, 20 Mar 2012 18:51:47 -0500
Message-ID: <4F691813.3070803@gmail.com>
In-Reply-To: <1331646393-5249-5-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6376940946948585542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/13/2012 08:46 AM, Oleg Zhurakivskyy wrote:
> Re-use cf_find() instead.
> ---
>  src/call-forwarding.c |   28 ++++++----------------------
>  1 files changed, 6 insertions(+), 22 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 5a2ab28..b1a1a72 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -44,6 +44,12 @@
>  =

>  #define CFC(_x) ((struct ofono_call_forwarding_condition *)(_x))
>  =

> +#define cf_find_unconditional(_cf)					\
> +({									\
> +	cf_find((_cf)->cf_conditions[CALL_FORWARDING_TYPE_UNCONDITIONAL],\
> +		BEARER_CLASS_VOICE);					\
> +})
> +

Actually I'd prefer if we made this an inline function rather than a
macro.  A bit easier to read that way.

Regards,
-Denis

--===============6376940946948585542==--

