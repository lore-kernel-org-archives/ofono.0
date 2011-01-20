Content-Type: multipart/mixed; boundary="===============3726689911729697506=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
Date: Thu, 20 Jan 2011 13:10:47 -0600
Message-ID: <4D3888B7.9020606@gmail.com>
In-Reply-To: <1295502354-19270-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3726689911729697506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/19/2011 11:45 PM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
> event breaks PPP link, after IP package transmit for a while.
> Using default ACCM, the issue can be fixed.
> I tested it at China Unicom networks.

Does the Huawei NAK our ACCM by any chance?

> ---
>  gatchat/ppp_lcp.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> =

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index cc3e231..2264731 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -105,8 +105,7 @@ static void lcp_generate_config_options(struct lcp_da=
ta *lcp)
>  =

>  static void lcp_reset_config_options(struct lcp_data *lcp)
>  {
> -	lcp->req_options =3D REQ_OPTION_ACCM;
> -	lcp->accm =3D 0;
> +	/* Using the default ACCM */
>  =

>  	lcp_generate_config_options(lcp);
>  }
> @@ -155,7 +154,11 @@ static void lcp_rca(struct pppcp_data *pppcp, const =
struct pppcp_packet *packet)
>  			 * which control characters MUST remain mapped when
>  			 * the peer sends them.
>  			 */
> -			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
> +
> +			/*
> +			 * Using the default ACCM
> +			 * ppp_set_recv_accm(pppcp_get_ppp(pppcp), ~0U);
> +			 */

If you follow my advice for path 1, then this chunk isn't necessary.

>  			break;
>  		default:
>  			break;

Regards,
-Denis

--===============3726689911729697506==--

