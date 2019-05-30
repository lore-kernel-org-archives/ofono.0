Content-Type: multipart/mixed; boundary="===============4009054166388184504=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ppp: Allow to set-up ppp connection without
 authentification
Date: Thu, 30 May 2019 11:55:33 -0500
Message-ID: <ca4656c1-5506-93bd-26da-5c497d6c1970@gmail.com>
In-Reply-To: <20190530162628.30041-1-philippe.deswert@digitalistgroup.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4009054166388184504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/30/2019 11:26 AM, Philippe De Swert wrote:
> When using RCR_REJECT no ppp connection will be established. It used to w=
ork before, and
> this was a side-effect of commit 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
> =

> See also this thread: https://lists.ofono.org/pipermail/ofono/2019-Januar=
y/019067.html
> ---
>   gatchat/ppp_lcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index 3fe38217..252b3cdc 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -281,7 +281,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data *ppp=
cp,
>   				return RCR_NAK;
>   =

>   			case G_AT_PPP_AUTH_METHOD_NONE:
> -				return RCR_REJECT;
> +				break;

What this in effect does is ignore whatever setting we told GAtPPP to =

use and uses the one from the server.  You're effectively doing what I =

suggested in =

https://lists.ofono.org/pipermail/ofono/2019-January/019074.html but in =

a "lets hack this until it works for me" kind of way.

Essentially it seems that your firmware blindly negotiates CHAP even =

though it has no intention of actually using it.  So just tell GAtPPP =

that it should configure itself for CHAP and be done with it instead of =

trying to set G_AT_PPP_AUTH_METHOD_NONE.

Maybe we should just revert that patch completely instead and force PPP =

based drivers to always use CHAP even if no authentication is =

configured, the way it used to be.

>   			}
>   			break;
>   		}
> =


Regards,
-Denis

--===============4009054166388184504==--

