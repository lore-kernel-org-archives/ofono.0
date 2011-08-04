Content-Type: multipart/mixed; boundary="===============0867297905094574632=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 4/4] atmodem: Add support for the PIN counter command
 AT+CPNNUM
Date: Thu, 04 Aug 2011 16:56:10 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893905BCB1@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312472643.3373.35.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0867297905094574632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > >  drivers/atmodem/sim.c |   95
> > > +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 files changed, 95 insertions(+), 0 deletions(-)
> > >
> > > please include an OFONO_AT_DEBUG trace of this AT command.
> >
> > I have attached a full log from a SpeedUp dongle, but here is the AT
> command that we are looking at:
> >
> > ofonod[2534]: Aux: > AT+CPNNUM\r
> > ofonod[2534]: Aux: < \r\nPIN1=3D3; PUK1=3D10; PIN2=3D3; PUK2=3D10\r\r\n=
OK\r\n
> =

> this is so ugly. I sometimes really question the manufactures on why
> nobody can create proper AT commands. Also one fun fact, if you issue
> this one on the wrong TTY, you get the answer on the other one. That
> will screw up our parse big time ;)

AT command protocol is soooo complex :)

> Nevertheless, I added a patch for this now.

Thanks,

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


--===============0867297905094574632==--

