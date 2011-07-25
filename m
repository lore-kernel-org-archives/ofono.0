Content-Type: multipart/mixed; boundary="===============1076312628611752150=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: CDMA SIM atom
Date: Mon, 25 Jul 2011 19:01:03 +0200
Message-ID: <1311613268.8920.24.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E5B1@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1076312628611752150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > We are working on CDMA to enable some USB dongle, and we need to get =
the
> > IMSI for the ConnMan interface, to create the interface name.
> > >
> > > We could use the AT SIM atom, since there should be no big difference
> > between a CDMA SIM and a GSM SIM (same kind of functionality for SIM
> > lock/unlock, same IMSI info).
> > >
> > > But we could also create a CDMA dedicated one. This will duplicate so=
me
> > code, but will be 'cleaner'.
> > >
> > > I would prefer the solution of a CDMA SIM atom, so CDMA plugins use o=
nly
> > CDMA atom, but I would prefer to have the oFono community opinion befor=
e going
> > into the code.
> > =

> > you do not need an IMSI for ConnMan. You just need a proper unique
> > identifier that is consistent. Using the hardware serial number in case
> > of CDMA should be a good enough interim solution.
> =

> The user can change its SIM card and put it in another dongle
> =

> > We are using the IMSI for GSM since we wanna bind stored settings
> > towards the SIM card. So that hardware swapping has no effect on the
> > user experience.
> =

> This is exactly what we also want to do with CDMA dongle.

I know CDMA dongles in theory have a SIM card, but not in practice. Or
are you telling me the CDMA dongles you have, have SIM cards? And these
SIM cards are used for anything?
 =

> > With CDMA we could neglect this actually. So far all
> > CDMA account are still bound to the hardware itself.
> =

> Why do you want to neglect this?
> =

> We should be consistent have have the same behaviour for this. If someone=
 unplug and replug its dongle, he do not want to re-insert the data call pa=
rameter, as with a GSM dongle.

I still don't believe that any CDMA operator so far really uses SIM
cards. I heard about some cases with Verizon where they have CDMA + LTE
in deployment.

> And what about PIN?

Good question. It is not a SIM PIN, it is a hardware PIN in the first
place. And only if you have a SIM, you have SIM PIN.

So the same question stays, where is your SIM card in CDMA hardware that
you have right now?

Regards

Marcel



--===============1076312628611752150==--

