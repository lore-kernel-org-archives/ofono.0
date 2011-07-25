Content-Type: multipart/mixed; boundary="===============4110403506267412689=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: CDMA SIM atom
Date: Mon, 25 Jul 2011 21:13:26 +0200
Message-ID: <1311621207.8920.27.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E67F@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4110403506267412689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > > > We are working on CDMA to enable some USB dongle, and we need to =
get the
> > > > IMSI for the ConnMan interface, to create the interface name.
> > > > >
> > > > > We could use the AT SIM atom, since there should be no big differ=
ence
> > > > between a CDMA SIM and a GSM SIM (same kind of functionality for SIM
> > > > lock/unlock, same IMSI info).
> > > > >
> > > > > But we could also create a CDMA dedicated one. This will duplicat=
e some
> > > > code, but will be 'cleaner'.
> > > > >
> > > > > I would prefer the solution of a CDMA SIM atom, so CDMA plugins u=
se only
> > > > CDMA atom, but I would prefer to have the oFono community opinion b=
efore
> > going
> > > > into the code.
> > > >
> > > > you do not need an IMSI for ConnMan. You just need a proper unique
> > > > identifier that is consistent. Using the hardware serial number in =
case
> > > > of CDMA should be a good enough interim solution.
> > >
> > > The user can change its SIM card and put it in another dongle
> > >
> > > > We are using the IMSI for GSM since we wanna bind stored settings
> > > > towards the SIM card. So that hardware swapping has no effect on the
> > > > user experience.
> > >
> > > This is exactly what we also want to do with CDMA dongle.
> > =

> > I know CDMA dongles in theory have a SIM card, but not in practice. Or
> > are you telling me the CDMA dongles you have, have SIM cards? And these
> > SIM cards are used for anything?
> =

> The SpeedUp 7300 EVDA has a SIM card.
> And I also got a Huawei CDMA dongle with SIM card, but I do not remember =
the model, I will give it to you later.

are these SIM cards used for the subscriber identity. Meaning that if
you swap one dongle with the other one, it it still the same account?

> > > > With CDMA we could neglect this actually. So far all
> > > > CDMA account are still bound to the hardware itself.
> > >
> > > Why do you want to neglect this?
> > >
> > > We should be consistent have have the same behaviour for this. If som=
eone
> > unplug and replug its dongle, he do not want to re-insert the data call
> > parameter, as with a GSM dongle.
> > =

> > I still don't believe that any CDMA operator so far really uses SIM
> > cards. I heard about some cases with Verizon where they have CDMA + LTE
> > in deployment.
> =

> The SpeedUp 7300 cannot register to the network without the SIM, and so m=
ake a data call.
> =

> We can retrieve the IMSI on this dongle, the AT+CIMI command works correc=
tly.
> =

> I don't know if they are using it for anything else.
> =

> And SpeedUp AT spec for this dongle show CPIN command, but I do not have =
try them.

Seems like in Asia they are actually using the SIM card for your network
account. Compared to the US this is different. There the hardware ID is
used for network access.

> > > And what about PIN?
> > =

> > Good question. It is not a SIM PIN, it is a hardware PIN in the first
> > place. And only if you have a SIM, you have SIM PIN.
> =

> I do not have test this, but I will do this asap.
> =

> > So the same question stays, where is your SIM card in CDMA hardware that
> > you have right now?
> =

> I will send you some picture of those dongle and SIM card.

How close are these CDMA SIM cards to GSM SIM cards. Do they support EF
or other SIM specific details?

Regards

Marcel



--===============4110403506267412689==--

