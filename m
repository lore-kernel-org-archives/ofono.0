Content-Type: multipart/mixed; boundary="===============2548690951051541449=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: CDMA SIM atom
Date: Mon, 25 Jul 2011 16:42:47 +0200
Message-ID: <1311604968.8920.17.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E588@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2548690951051541449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> We are working on CDMA to enable some USB dongle, and we need to get the =
IMSI for the ConnMan interface, to create the interface name.
> =

> We could use the AT SIM atom, since there should be no big difference bet=
ween a CDMA SIM and a GSM SIM (same kind of functionality for SIM lock/unlo=
ck, same IMSI info).
> =

> But we could also create a CDMA dedicated one. This will duplicate some c=
ode, but will be 'cleaner'.
> =

> I would prefer the solution of a CDMA SIM atom, so CDMA plugins use only =
CDMA atom, but I would prefer to have the oFono community opinion before go=
ing into the code.

you do not need an IMSI for ConnMan. You just need a proper unique
identifier that is consistent. Using the hardware serial number in case
of CDMA should be a good enough interim solution.

We are using the IMSI for GSM since we wanna bind stored settings
towards the SIM card. So that hardware swapping has no effect on the
user experience. With CDMA we could neglect this actually. So far all
CDMA account are still bound to the hardware itself.

Regards

Marcel



--===============2548690951051541449==--

