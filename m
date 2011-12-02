Content-Type: multipart/mixed; boundary="===============8174812285539643800=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH_v0 1/3] doc: Add RoamingAllowed property
Date: Fri, 02 Dec 2011 10:54:59 +0000
Message-ID: <ED4DEEB78293B34A9D0EAC02A474A46E07EEB5@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <7737754.vMuGffl7lN@hector>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8174812285539643800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > +		boolean RoamingAllowed [readwrite]
> > > +
> > > +			Contains whether data roaming is allowed.  In the off
> > > +			setting, if the packet radio registration state
> > > +			indicates that the modem is roaming, oFono will
> > > +			automatically shutdown connection and no further
> > > +			connection establishment will be possible.
> > > +
> >
> > I'm still not convinced this is really needed.  Can you discuss a
> > specific usecase you are trying to take care of here?
> =

> I do not know CDMA but I do not see why this would be needed at all at the
> ConnectionManager atom level. If this is about pricing, it should probabl=
y be a
> per-context property instead, both for CDMA and GSM.

There is a RoamingAllowed property in the connman atom, and this property i=
s used to set if the user want to do some data call while in roaming mode.

Some months ago has been introduced a cdma-connman atom, but currently, the=
re is no RoamingAllowed property in this version.

The goal of this patch is to add the same property, so when doing a CDMA da=
ta call, if we are in roaming, we can check if the user still want to do th=
e data call or not.

In CDMA, there is no context as in GSM.

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


--===============8174812285539643800==--

