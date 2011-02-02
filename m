Content-Type: multipart/mixed; boundary="===============2562502559231284417=="
MIME-Version: 1.0
From: Predon, Frederic <frederic.predon@intel.com>
Subject: RE: [PATCH] ifx: remove setting to offline during modem enable
Date: Wed, 02 Feb 2011 18:17:40 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934F1C6006@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1296670068.1520.335.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2562502559231284417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > > I toughth we talked about CFUN=3D4 in ifx_disable on IRC. This one is
> > > needed to bring the modem up in offline mode. I'd rather not remove
> > > this
> > > one.
> >
> > In a ideal world, the CFUN=3D4 in the dlc_setup will not be needed
> because the modem remembers is last state and will remain in offline
> mode because we have sent CFUN=3D4 in the ifx_disable function.
> > But, we could have some error cases where we are not able to send
> this command anymore because of modem crash or SPI broken, etc..  so we
> might have to keep the forced CFUN=3D4 in the dlc_setup
> =

> I agree. I do wanna keep the CFUN=3D4 in ifx_enable() to make the sure
> the
> modem is in init state and offline.
> =

> Jeevaka and I discussed on IRC, or at least what I thought we
> discussed ;), using CFUN=3D0 in ifx_disable().

CFUN=3D0 is different because it will shutdown the modem. This is something=
 we are willing to add in the ifx_disable but before that, we have to modif=
y the spi driver to be able to start the modem and have a symmetric enable/=
disable modem functionality.
If disable shutdown the modem then enable should start it.
I'll send you some diagrams in that direction during the week to have your =
opinion.

Regards

Fred
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


--===============2562502559231284417==--

