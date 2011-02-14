Content-Type: multipart/mixed; boundary="===============7554340424069783674=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [V3 PATCH 2/3] PPP: Use default ACCM (0xffffffff) to trasmit
 package
Date: Mon, 14 Feb 2011 14:26:23 -0600
Message-ID: <4D598FEF.1040503@gmail.com>
In-Reply-To: <1297503675-32491-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7554340424069783674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 02/12/2011 03:41 AM, martin.xu(a)intel.com wrote:
> From: Martin Xu <martin.xu@intel.com>
> =

> Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
> event breaks PPP link, after IP package transmit for a while.
> Using default ACCM, the issue can be fixed.
> I tested it at China Unicom networks.
> ---
>  gatchat/ppp_lcp.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> =

> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> index cc3e231..91a8b67 100644
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
> @@ -147,6 +146,7 @@ static void lcp_rca(struct pppcp_data *pppcp, const s=
truct pppcp_packet *packet)
>  	ppp_option_iter_init(&iter, packet);
>  =

>  	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
> +		const guint8 *data =3D ppp_option_iter_get_data(&iter);
>  		switch (ppp_option_iter_get_type(&iter)) {
>  		case ACCM:
>  			/*
> @@ -155,7 +155,9 @@ static void lcp_rca(struct pppcp_data *pppcp, const s=
truct pppcp_packet *packet)
>  			 * which control characters MUST remain mapped when
>  			 * the peer sends them.
>  			 */
> -			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
> +
> +			ppp_set_recv_accm(pppcp_get_ppp(pppcp),
> +					pppcpget_host_long(data));

make --no-print-directory all-am
  CC     gatchat/ppp_lcp.o
cc1: warnings being treated as errors
gatchat/ppp_lcp.c: In function =E2=80=98lcp_rca=E2=80=99:
gatchat/ppp_lcp.c:160: error: implicit declaration of function
=E2=80=98pppcpget_host_long=E2=80=99
make[1]: *** [gatchat/ppp_lcp.o] Error 1
make: *** [all] Error 2


>  			break;
>  		default:
>  			break;

Regards,
-Denis

--===============7554340424069783674==--

