Content-Type: multipart/mixed; boundary="===============4756651186688297007=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting issue
Date: Thu, 20 Jan 2011 13:08:46 -0600
Message-ID: <4D38883E.6000606@gmail.com>
In-Reply-To: <1295502354-19270-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4756651186688297007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/19/2011 11:45 PM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Tramsmit ACCM and receive ACCM is mixed up.
> According to RFC1662 Section 7.1, ACCM Configuration Option is
> used to inform the peer which control characters MUST remain
> mapped when the peer sends them.
> ---
>  gatchat/ppp_lcp.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> =

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index 3a80a62..cc3e231 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -149,7 +149,13 @@ static void lcp_rca(struct pppcp_data *pppcp, const =
struct pppcp_packet *packet)
>  	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>  		switch (ppp_option_iter_get_type(&iter)) {
>  		case ACCM:
> -			ppp_set_xmit_accm(pppcp_get_ppp(pppcp), 0);
> +			/*
> +			 * RFC1662 Section 7.1
> +			 * The Configuration Option is used to inform the peer
> +			 * which control characters MUST remain mapped when
> +			 * the peer sends them.
> +			 */
> +			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);

You still forgot to apply my earlier comment.  The recv ACCM should be
set to what is acked by the peer.  e.g.:

ppp_set_recv_accm(pppcp, get_host_long());

>  			break;
>  		default:
>  			break;

Regards,
-Denis

--===============4756651186688297007==--

