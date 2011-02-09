Content-Type: multipart/mixed; boundary="===============6752087748300796755=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [RFCv2] doc: Proposal for LTE/IMS API
Date: Wed, 09 Feb 2011 09:02:43 +0200
Message-ID: <201102090902.43928.remi.denis-courmont@nokia.com>
In-Reply-To: <AANLkTi=Jt0w-UqJ8MtqDae83A6U6baAbzhh6YtR5+mc5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6752087748300796755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday 08 February 2011 18:22:43 ext Sjur Br=C3=A6ndeland, you wrote:
> > > +             boolean PreConditionCheck(string Type, string
> > > PeerAddress, +                                     uint16 PeerPort,
> > >  uint16 LocalPort) +
> > =

> > That stuff is per context. Should it not be in the context object rather
> > than in the IMS manager?
> =

> oFono should only consider QoS information from the IMS
> Default and Dedicated bearers when checking the precondition.
> =

> In theory there might be more than one IMS APN for a operator,
> but I really don't see this as a real life scenario for this.
> If anyone disagrees please speak out and explain...

Well, I don't care if it is part of the normal context interface, or if it =
is =

an extra IMS-specific interface on the IMS context object path. But this is =

clearly a per-context thing so it should be in the context.

I don't want to end up in a 'woops' situation down the line. And I don't tr=
ust =

operators not to actually implement those useless in real life scenarii...

> > > +             array{string} PcscfAddresses [readonly]
> > =

> > Should this be in the context object? The AT command is per CID. Would =
it
> > make any sense for a network to have different P-CSCF based on the
> > bearer?
> =

> As mentioned above, I don't see why an operator would ever have more than
> one IMS APN. If we only have one IMS APN, then we might as well present
> this information here in the IMS API.

How do you cope with two connections to the same APN?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6752087748300796755==--

