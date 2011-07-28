Content-Type: multipart/mixed; boundary="===============0741322996893012888=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] speedup: during enable, we have to go offline first.
Date: Thu, 28 Jul 2011 15:44:23 +0200
Message-ID: <1311860664.8920.111.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938FA9B0B@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0741322996893012888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > Some other comments along the lines for this modem:
> > =

> > ofonod[26439]: Aux: > AT+CSCB=3D?\r
> > ofonod[26439]: Aux: < \r\nERROR\r\n
> > ofonod[26439]: CSCB not supported
> > =

> > Since CBS is not supported, do not even bother creating that atom.
> =

> As I explained, all those errors are due to the CPIN=3D1. If we are in CF=
UN=3D4, it seems that we have to wait after sending the CFUN=3D1 to goes on=
line.
> =

> I have attached a full log with only CFUN=3D1 and no CFUN=3D4. I have rep=
laced the CFUN=3D4 by a CFUN=3D1.
> =

> You will see that CBS is supported, USSD also...

if this hardware can not deal with online/offline mode changes proper
then just remove the set_online modem driver callback and treat it like
a really dumb stupid device.

Only then you can go directly into CFUN=3D1 and stay there. Otherwise you
are violating online/offline semantics of oFono.

Regards

Marcel



--===============0741322996893012888==--

