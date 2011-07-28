Content-Type: multipart/mixed; boundary="===============9112593047320823654=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 14:46:41 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938FA9B1A@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311860664.8920.111.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9112593047320823654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > Some other comments along the lines for this modem:
> > >
> > > ofonod[26439]: Aux: > AT+CSCB=3D?\r
> > > ofonod[26439]: Aux: < \r\nERROR\r\n
> > > ofonod[26439]: CSCB not supported
> > >
> > > Since CBS is not supported, do not even bother creating that atom.
> >
> > As I explained, all those errors are due to the CPIN=3D1. If we are in =
CFUN=3D4,
> it seems that we have to wait after sending the CFUN=3D1 to goes online.
> >
> > I have attached a full log with only CFUN=3D1 and no CFUN=3D4. I have r=
eplaced
> the CFUN=3D4 by a CFUN=3D1.
> >
> > You will see that CBS is supported, USSD also...
> =

> if this hardware can not deal with online/offline mode changes proper
> then just remove the set_online modem driver callback and treat it like
> a really dumb stupid device.
> =

> Only then you can go directly into CFUN=3D1 and stay there. Otherwise you
> are violating online/offline semantics of oFono.

Ok, I will do this.

Thanks for your support,

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


--===============9112593047320823654==--

