Content-Type: multipart/mixed; boundary="===============1523856758857736281=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] avoid stk atom is removed when sim pin is blocked
Date: Thu, 12 Sep 2013 01:14:17 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141101D85F53@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <5230AB65.2030704@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1523856758857736281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,

> > When sim pin is blocked after input wrong pin code three times, modem
> > will change to pre-sim status, at this time, STK function should be
> > available. stk atoms shouldn't be removed.
> =

> Can you please provide a reference to a 3GPP / ETSI document which states
> that this is the case?

I don't see any spec states STK should be available or unavailable when SIM=
 PIN is blocked.
But all the modems of many different manufacturers I ever used keep STK ava=
ilable after SIM PIN is blocked.

Here if we remove stk atom and recreate it after pin is reset, stk function=
 will be unusable.

> > ---
> >   src/modem.c |    7 ++++++-
> >   src/stk.c   |    4 ++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
> >
> =


Regards,
Caiwen


--===============1523856758857736281==--

