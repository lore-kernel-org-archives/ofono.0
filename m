Content-Type: multipart/mixed; boundary="===============1664678474980970011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] PPP: Fix Transmit ACCM and Receive ACCM setting error
Date: Tue, 11 Jan 2011 11:06:58 -0600
Message-ID: <4D2C8E32.2070609@gmail.com>
In-Reply-To: <1294656017-825-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1664678474980970011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/10/2011 04:40 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> ---
>  gatchat/ppp_lcp.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Can you write a better description of this patch?  The subject is not
enough...

> =

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index 3a80a62..bc97257 100644
> --- a/gatchat/ppp_lcp.c
> +++ b/gatchat/ppp_lcp.c
> @@ -149,7 +149,11 @@ static void lcp_rca(struct pppcp_data *pppcp, const =
struct pppcp_packet *packet)
>  	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>  		switch (ppp_option_iter_get_type(&iter)) {
>  		case ACCM:
> -			ppp_set_xmit_accm(pppcp_get_ppp(pppcp), 0);
> +		/* RFC1662 Section 7.1
> +		 * The Configuration Option is used to inform the peer which control
> +		 * characters MUST remain mapped when the peer sends them.
> +		 */
> +			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
>  			break;

Hah, so I actually managed to mix up the xmit and recv accms :P

Can you please align the comment with the code and follow item M2 from
doc/coding-style.txt?

Currently we always request 0 as the peer's xmit ACCM, so the present
code should work either way.  However, it might be safer to use the recv
ACCM that was eventually accepted by the peer.  This would also make
chunk 2 of patch 2 unnecessary.

>  		default:
>  			break;
> @@ -263,7 +267,12 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pp=
pcp,
>  	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
>  		switch (ppp_option_iter_get_type(&iter)) {
>  		case ACCM:
> -			ppp_set_recv_accm(ppp,
> +		/* RFC1662 Section 7.1
> +		 * The Configuration Option is used to inform the peer which control
> +		 * characters MUST remain mapped when the peer sends them.
> +		 */

Same comment as above about the comment formatting

> +

Please remove this empty line

> +			ppp_set_xmit_accm(ppp,
>  				get_host_long(ppp_option_iter_get_data(&iter)));
>  			break;
>  		case AUTH_PROTO:

Regards,
-Denis

--===============1664678474980970011==--

