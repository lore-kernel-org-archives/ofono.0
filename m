Content-Type: multipart/mixed; boundary="===============7391208002540557116=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: CDMA SIM atom
Date: Mon, 25 Jul 2011 16:03:26 +0100
Message-ID: <568DE01DA537804BA73470071BAC288938F4E5B1@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1311604968.8920.17.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7391208002540557116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > We are working on CDMA to enable some USB dongle, and we need to get the
> IMSI for the ConnMan interface, to create the interface name.
> >
> > We could use the AT SIM atom, since there should be no big difference
> between a CDMA SIM and a GSM SIM (same kind of functionality for SIM
> lock/unlock, same IMSI info).
> >
> > But we could also create a CDMA dedicated one. This will duplicate some
> code, but will be 'cleaner'.
> >
> > I would prefer the solution of a CDMA SIM atom, so CDMA plugins use only
> CDMA atom, but I would prefer to have the oFono community opinion before =
going
> into the code.
> =

> you do not need an IMSI for ConnMan. You just need a proper unique
> identifier that is consistent. Using the hardware serial number in case
> of CDMA should be a good enough interim solution.

The user can change its SIM card and put it in another dongle

> We are using the IMSI for GSM since we wanna bind stored settings
> towards the SIM card. So that hardware swapping has no effect on the
> user experience.

This is exactly what we also want to do with CDMA dongle.
 =

> With CDMA we could neglect this actually. So far all
> CDMA account are still bound to the hardware itself.

Why do you want to neglect this?

We should be consistent have have the same behaviour for this. If someone u=
nplug and replug its dongle, he do not want to re-insert the data call para=
meter, as with a GSM dongle.

And what about PIN?

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


--===============7391208002540557116==--

