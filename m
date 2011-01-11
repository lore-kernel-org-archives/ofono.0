Content-Type: multipart/mixed; boundary="===============4624243787406137753=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Inform Huawei modem using ACCM 0xffffffff to trasmit
 package. Using my Huawei modem (EM770W) if set ACCM as 0x00000000,
 the RXJ- event will happend, and PPP link down,
 when IP package transmit for a while. After I set ACCM as 0xffffffff,
 the RXJ- event never happen,
 and the modem can work quite stable. I tested the modem at China Unicom
 networks.
Date: Tue, 11 Jan 2011 11:11:05 -0600
Message-ID: <4D2C8F29.70604@gmail.com>
In-Reply-To: <1294656017-825-3-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4624243787406137753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/10/2011 04:40 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> ---
>  gatchat/ppp_lcp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =


Can you please fix up your subject?  It is simply too long.  Make the
subject short and use the description field to describe the rest.

Do you have (or can you generate) a pppdump of this happening?  What
protocol is RXJ- happening on?  Does LCP layer accept our ACCM of 0 and
then later sends an RXJ-?

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index bc97257..181bc14 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -106,7 +106,7 @@ static void lcp_generate_config_options(struct lcp_da=
ta *lcp)
>  static void lcp_reset_config_options(struct lcp_data *lcp)
>  {
>  	lcp->req_options =3D REQ_OPTION_ACCM;
> -	lcp->accm =3D 0;
> +	lcp->accm =3D ~0U;
>  =


Strictly speaking, RFC 1662 says this about the default ACCM:

"For other types of links, the default value is 0, since there is
      no need for mapping."

In theory we fall into the 'other type' category.

>  	lcp_generate_config_options(lcp);
>  }
> @@ -153,7 +153,7 @@ static void lcp_rca(struct pppcp_data *pppcp, const s=
truct pppcp_packet *packet)
>  		 * The Configuration Option is used to inform the peer which control
>  		 * characters MUST remain mapped when the peer sends them.
>  		 */
> -			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
> +			ppp_set_recv_accm(pppcp_get_ppp(pppcp), ~0U);

See my comment for the previous patch.  This part should not be needed.

>  			break;
>  		default:
>  			break;

Regards,
-Denis

--===============4624243787406137753==--

