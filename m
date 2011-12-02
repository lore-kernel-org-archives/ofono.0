Content-Type: multipart/mixed; boundary="===============2591336015634545659=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH_v0 1/3] doc: Add RoamingAllowed property
Date: Fri, 02 Dec 2011 08:48:42 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E07EC7B@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <4ED51917.9010808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2591336015634545659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +		boolean RoamingAllowed [readwrite]
> > +
> > +			Contains whether data roaming is allowed.  In the off
> > +			setting, if the packet radio registration state
> > +			indicates that the modem is roaming, oFono will
> > +			automatically shutdown connection and no further
> > +			connection establishment will be possible.
> > +
> =

> I'm still not convinced this is really needed.  Can you discuss a specifi=
c usecase
> you are trying to take care of here?

This is the same use case as with GSM/3G network. During our testing in Ind=
onesia, we have seen some situation where we were in roaming mode.
So roaming mode is supported in CDMA, and I guess that this would have inci=
dence on the billing (I will try to get some confirmation about this).

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


--===============2591336015634545659==--

