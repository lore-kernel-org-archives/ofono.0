Content-Type: multipart/mixed; boundary="===============5668661457384758545=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv4 12/13] call-forwarding: Cache ss TYPE_ALL modifications
Date: Mon, 23 Apr 2012 16:38:11 -0500
Message-ID: <4F95CBC3.60808@gmail.com>
In-Reply-To: <1334060254-29547-13-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5668661457384758545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 04/10/2012 07:17 AM, Oleg Zhurakivskyy wrote:
> ---
>  src/call-forwarding.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> =

> diff --git a/src/call-forwarding.c b/src/call-forwarding.c
> index 204ecc7..a22fb1f 100644
> --- a/src/call-forwarding.c
> +++ b/src/call-forwarding.c
> @@ -1184,6 +1184,7 @@ static gboolean cf_ss_control(int type, const char =
*sc,
>  =

>  	switch (cf->ss_req->cf_type) {
>  	case CALL_FORWARDING_TYPE_ALL:
> +		cf->flags |=3D CALL_FORWARDING_FLAG_CACHED;
>  		cf->query_next =3D CALL_FORWARDING_TYPE_UNCONDITIONAL;
>  		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
>  		break;

I don't believe this would work for non-queries.  For example, lets say
the user runs a registration operation on CALL_FORWARDING_TYPE_ALL and
that fails for whatever reason.  Now the cached flag is set (perhaps
erroneously)

Regards,
-Denis

--===============5668661457384758545==--

