Content-Type: multipart/mixed; boundary="===============3174942888026008790=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: CDMA SIM atom
Date: Mon, 25 Jul 2011 18:34:17 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F4E67F@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311613268.8920.24.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3174942888026008790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > > We are working on CDMA to enable some USB dongle, and we need to ge=
t the
> > > IMSI for the ConnMan interface, to create the interface name.
> > > >
> > > > We could use the AT SIM atom, since there should be no big differen=
ce
> > > between a CDMA SIM and a GSM SIM (same kind of functionality for SIM
> > > lock/unlock, same IMSI info).
> > > >
> > > > But we could also create a CDMA dedicated one. This will duplicate =
some
> > > code, but will be 'cleaner'.
> > > >
> > > > I would prefer the solution of a CDMA SIM atom, so CDMA plugins use=
 only
> > > CDMA atom, but I would prefer to have the oFono community opinion bef=
ore
> going
> > > into the code.
> > >
> > > you do not need an IMSI for ConnMan. You just need a proper unique
> > > identifier that is consistent. Using the hardware serial number in ca=
se
> > > of CDMA should be a good enough interim solution.
> >
> > The user can change its SIM card and put it in another dongle
> >
> > > We are using the IMSI for GSM since we wanna bind stored settings
> > > towards the SIM card. So that hardware swapping has no effect on the
> > > user experience.
> >
> > This is exactly what we also want to do with CDMA dongle.
> =

> I know CDMA dongles in theory have a SIM card, but not in practice. Or
> are you telling me the CDMA dongles you have, have SIM cards? And these
> SIM cards are used for anything?

The SpeedUp 7300 EVDA has a SIM card.
And I also got a Huawei CDMA dongle with SIM card, but I do not remember th=
e model, I will give it to you later.

> > > With CDMA we could neglect this actually. So far all
> > > CDMA account are still bound to the hardware itself.
> >
> > Why do you want to neglect this?
> >
> > We should be consistent have have the same behaviour for this. If someo=
ne
> unplug and replug its dongle, he do not want to re-insert the data call
> parameter, as with a GSM dongle.
> =

> I still don't believe that any CDMA operator so far really uses SIM
> cards. I heard about some cases with Verizon where they have CDMA + LTE
> in deployment.

The SpeedUp 7300 cannot register to the network without the SIM, and so mak=
e a data call.

We can retrieve the IMSI on this dongle, the AT+CIMI command works correctl=
y.

I don't know if they are using it for anything else.

And SpeedUp AT spec for this dongle show CPIN command, but I do not have tr=
y them.

> =

> > And what about PIN?
> =

> Good question. It is not a SIM PIN, it is a hardware PIN in the first
> place. And only if you have a SIM, you have SIM PIN.

I do not have test this, but I will do this asap.

> So the same question stays, where is your SIM card in CDMA hardware that
> you have right now?

I will send you some picture of those dongle and SIM card.

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


--===============3174942888026008790==--

