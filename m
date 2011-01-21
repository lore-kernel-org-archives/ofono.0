Content-Type: multipart/mixed; boundary="===============6476290350361319606=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
Date: Fri, 21 Jan 2011 09:51:46 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD34F6CD0C@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4D3888B7.9020606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6476290350361319606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, January 21, 2011 3:11 AM
> To: ofono(a)ofono.org
> Cc: Xu, Martin
> Subject: Re: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
> =

> Hi Martin,
> =

> On 01/19/2011 11:45 PM, martin.xu(a)intel.com wrote:
> > From: Martin Xu <martin.xu@intel.com>
> >
> > Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
> > event breaks PPP link, after IP package transmit for a while.
> > Using default ACCM, the issue can be fixed.
> > I tested it at China Unicom networks.
> =

> Does the Huawei NAK our ACCM by any chance?
The modem can accept our 0x0 ACCM. But with the ACCM, PPP does not work.
If there is not any issue at the modem firmware, can we understand it as:
Modem can transmit ACCM with 0x0, but we have no capability to receive it, =
so we can't ask modem transmit as 0x0 ACCM?

> =

> > ---
> >  gatchat/ppp_lcp.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> > index cc3e231..2264731 100644
> > --- a/gatchat/ppp_lcp.c
> > +++ b/gatchat/ppp_lcp.c
> > @@ -105,8 +105,7 @@ static void lcp_generate_config_options(struct
> lcp_data *lcp)
> >
> >  static void lcp_reset_config_options(struct lcp_data *lcp)
> >  {
> > -	lcp->req_options =3D REQ_OPTION_ACCM;
> > -	lcp->accm =3D 0;
> > +	/* Using the default ACCM */
> >
> >  	lcp_generate_config_options(lcp);
> >  }
> > @@ -155,7 +154,11 @@ static void lcp_rca(struct pppcp_data *pppcp, const
> struct pppcp_packet *packet)
> >  			 * which control characters MUST remain mapped when
> >  			 * the peer sends them.
> >  			 */
> > -			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
> > +
> > +			/*
> > +			 * Using the default ACCM
> > +			 * ppp_set_recv_accm(pppcp_get_ppp(pppcp), ~0U);
> > +			 */
> =

> If you follow my advice for path 1, then this chunk isn't necessary.
> =

> >  			break;
> >  		default:
> >  			break;
> =

> Regards,
> -Denis

--===============6476290350361319606==--

