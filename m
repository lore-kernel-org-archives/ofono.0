Content-Type: multipart/mixed; boundary="===============1201997882517463472=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] avoid stk atom is removed when sim pin is blocked
Date: Mon, 16 Sep 2013 12:33:17 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141101D8701D@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <5231C25F.3090508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1201997882517463472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >>> When sim pin is blocked after input wrong pin code three times,
> >>> modem will change to pre-sim status, at this time, STK function
> >>> should be available. stk atoms shouldn't be removed.
> >>
> >> Can you please provide a reference to a 3GPP / ETSI document which
> >> states that this is the case?
> >
> > I don't see any spec states STK should be available or unavailable when=
 SIM
> PIN is blocked.
> > But all the modems of many different manufacturers I ever used keep STK
> available after SIM PIN is blocked.
> >
> > Here if we remove stk atom and recreate it after pin is reset, stk func=
tion will
> be unusable.
> =

> Again, please elaborate.  Much of Sim Toolkit depends on access to files =
that
> can only be accessed with PIN entered.  So leaving STK atom in a fully
> functional state is not the answer either.
> =

> Why would stk be unusuable.  Is it that we cannot recover the Main Menu
> state after re-creating it?

Yes. There is no way to retrieve the main menu again. It also may at that t=
ime SAT isn't
stay at the main menu.

Regards,
Caiwen



--===============1201997882517463472==--

