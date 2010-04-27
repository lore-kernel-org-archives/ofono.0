Content-Type: multipart/mixed; boundary="===============6506837843986309461=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] ppp: silently discard packets if needed
Date: Tue, 27 Apr 2010 14:45:04 -0700
Message-ID: <20100427144504.5798b28b@kcaccard-MOBL3>
In-Reply-To: <20100427211203.GD5070@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6506837843986309461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Apr 2010 18:12:03 -0300
"Gustavo F. Padovan" <gustavo@padovan.org> wrote:

> Hi Kristen,
> =

> * Kristen Carlson Accardi <kristen@linux.intel.com> [2010-04-27 13:26:4=
9 -0700]:
> =

> > When receiving a packet, check the protocol and the phase to see
> > if the packet should be dropped.
> > ---
> >  gatchat/gatppp.c |   31 ++++++++++++++++++++++++++-----
> >  1 files changed, 26 insertions(+), 5 deletions(-)
> > =

> > diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
> > index c7bf089..933cbec 100644
> > --- a/gatchat/gatppp.c
> > +++ b/gatchat/gatppp.c
> > @@ -173,17 +173,38 @@ static struct frame_buffer *ppp_encode(GAtPPP *pp=
p, guint8 *data, int len)
> >  	return fb;
> >  }
> >  =

> > +/*
> > + * Silently discard packets which are received when they shouldn't be
> > + */
> > +static inline gboolean drop_packet(GAtPPP *ppp, guint16 protocol)
> > +{
> > +	switch (ppp->phase) {
> > +	case PPP_PHASE_ESTABLISHMENT:
> > +	case PPP_PHASE_TERMINATION:
> > +		if (protocol !=3D LCP_PROTOCOL)
> > +			return TRUE;
> > +		break;
> > +	case PPP_PHASE_AUTHENTICATION:
> > +		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL)
> > +			return TRUE;
> > +		break;
> > +	case PPP_PHASE_DEAD:
> > +		return TRUE;
> > +		break;
> =

> You have a return and a break on the same case. You'll never reach the
> break here.

whoops - forgot to delete that.  Thanks, will resend.

--===============6506837843986309461==--

