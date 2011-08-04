Content-Type: multipart/mixed; boundary="===============2370299872795581818=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 4/4] atmodem: Add support for the PIN counter command
 AT+CPNNUM
Date: Thu, 04 Aug 2011 17:44:02 +0200
Message-ID: <1312472643.3373.35.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288939006D29@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2370299872795581818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > >  drivers/atmodem/sim.c |   95
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 95 insertions(+), 0 deletions(-)
> > =

> > please include an OFONO_AT_DEBUG trace of this AT command.
> =

> I have attached a full log from a SpeedUp dongle, but here is the AT comm=
and that we are looking at:
> =

> ofonod[2534]: Aux: > AT+CPNNUM\r
> ofonod[2534]: Aux: < \r\nPIN1=3D3; PUK1=3D10; PIN2=3D3; PUK2=3D10\r\r\nOK=
\r\n

this is so ugly. I sometimes really question the manufactures on why
nobody can create proper AT commands. Also one fun fact, if you issue
this one on the wrong TTY, you get the answer on the other one. That
will screw up our parse big time ;)

Nevertheless, I added a patch for this now.

Regards

Marcel



--===============2370299872795581818==--

