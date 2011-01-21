Content-Type: multipart/mixed; boundary="===============0403237269602509448=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting issue
Date: Fri, 21 Jan 2011 10:09:59 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD34F6CD39@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4D38883E.6000606@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0403237269602509448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:
> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Friday, January 21, 2011 3:09 AM
> To: ofono(a)ofono.org
> Cc: Xu, Martin
> Subject: Re: [PATCH 1/3] PPP: Fix transmit ACCM and receive ACCM setting
> issue
> =

> Hi Martin,
> =

> On 01/19/2011 11:45 PM, martin.xu(a)intel.com wrote:
> > From: Martin Xu <martin.xu@intel.com>
> >
> > Tramsmit ACCM and receive ACCM is mixed up.
> > According to RFC1662 Section 7.1, ACCM Configuration Option is
> > used to inform the peer which control characters MUST remain
> > mapped when the peer sends them.
> > ---
> >  gatchat/ppp_lcp.c |   16 ++++++++++++++--
> >  1 files changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
> > index 3a80a62..cc3e231 100644
> > --- a/gatchat/ppp_lcp.c
> > +++ b/gatchat/ppp_lcp.c
> > @@ -149,7 +149,13 @@ static void lcp_rca(struct pppcp_data *pppcp, const
> struct pppcp_packet *packet)
> >  	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
> >  		switch (ppp_option_iter_get_type(&iter)) {
> >  		case ACCM:
> > -			ppp_set_xmit_accm(pppcp_get_ppp(pppcp), 0);
> > +			/*
> > +			 * RFC1662 Section 7.1
> > +			 * The Configuration Option is used to inform the peer
> > +			 * which control characters MUST remain mapped when
> > +			 * the peer sends them.
> > +			 */
> > +			ppp_set_recv_accm(pppcp_get_ppp(pppcp), 0);
> =

> You still forgot to apply my earlier comment.  The recv ACCM should be
> set to what is acked by the peer.  e.g.:
That is not this patch want to resolve. This patch is just used to fix the =
mixing up of setting recv ACCM and transit ACCM, And fix Huawei modem issue.

1. Currently, it is just ACKed by peer. You know It is called at lcp_rca, a=
nd here the code always use ACCM as 0x0. So that is just the acked ACCM.

2. I think current implementation of negotiation of ACCM needs enhancement:
1. we needs to set ACCM according to each modem
2. We needs to use ACKed ACCM as you mentioned. =



--===============0403237269602509448==--

