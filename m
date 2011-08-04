Content-Type: multipart/mixed; boundary="===============4003073339777377475=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] speedup: blacklist the NO CARRIER terminator for control
 channel
Date: Thu, 04 Aug 2011 17:30:50 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893905BCEA@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312475086.3373.41.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4003073339777377475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > > Some Speedup cards will send the NO CARRIER in the control
> channel.
> > >
> > > please include a trace. I am not sure how this effect anything
> since we
> > > are not supporting online/offline mode with these cards.
> >
> > Ok, no problem. What kind of test do you want me to do?
> >
> > I make a data call that failed and then I disable the modem?
> =

> you are proposing to blacklist this terminator. So you should know
> where
> it causes a problem. I only blacklisted it modems that were supporting
> online mode and where switching offline caused a problem that NO
> CARRIER
> came before OK. Do you have that problem?

No I don't, because as you said, speedup doesn't support offline/online mod=
e.

I have proposed to blacklist it, because this NO CARRIER has nothing to do =
in control channel, and I do not want it to cause any trouble. I know, this=
 is rude :)

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4003073339777377475==--

