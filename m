Content-Type: multipart/mixed; boundary="===============8264385302085163030=="
MIME-Version: 1.0
From: Berthier, Emmanuel <emmanuel.berthier@intel.com>
Subject: RE: Ofono and BT interaction
Date: Fri, 10 Sep 2010 15:35:05 +0100
Message-ID: <2A84145621092446B6659B8A0F28E26F46D581EF8D@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1284106045.20451.10.camel@aeonflux.t-mobile.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8264385302085163030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> > > If you power on the HFP modem. If not, then oFono will do nothing.
> > =

> > Yes, that's one solution. How to do that at BlueZ level?
>
> no idea actually.
>
> > > You can always start ofonod with -P hfp and then the HFP support shou=
ld be
> > > ignored. At least that works for testing.
> > =

> > Very interesting.
> > I've not found "-P" option in ofono 0.25, nor in the last 0.28 source t=
ree.
> > Did I miss something?
>
> No you didn't. It is a ConnMan feature that we never ported over to
> oFono. Not a big deal to add, but so far nobody did the work.

So, the question is still open:
How can I cut the link between ofono and BlueZ?

Emmanuel.
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

--===============8264385302085163030==--

