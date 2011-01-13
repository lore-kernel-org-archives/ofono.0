Content-Type: multipart/mixed; boundary="===============6548817811515391073=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 05/10] Update documentation for GPRS technology
Date: Thu, 13 Jan 2011 10:24:50 +0200
Message-ID: <201101131024.50935.remi.denis-courmont@nokia.com>
In-Reply-To: <1294849942.3873.92.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6548817811515391073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 12 January 2011 18:32:22 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > > > +		string Technology [readonly, optional]
> > > > +
> > > > +			Contains the data technology as reported by the
> > > > +			GPRS service registration (if known).
> > > > +
> > > > +			Possible values are the same as for the Technology
> > > > +			property the NetworkRegistration object.
> > > > +
> > > =

> > > we used to have this value and then we removed it since it ended up
> > > being not useful. So why do you wanna bring it back?
> > =

> > The network registration only ever tells 2G/3G/4G. We need something to
> > tell about EDGE or HS*PA. We cannot rely (only) on the CPSB bearer as it
> > is only defined when there is an active context. Technology is set
> > whenever we are registered to the GPRS service.
> =

> as I said, we took the Technology field from the Connection Manager
> since it was just duplication.
> =

> So why are we not feeding the CPSB bearer information into the Network
> Registration and have it just update from GSM -> EDGE and UMTS -> HSPA
> accordingly.
> =

> I think that the UI should only require to monitor one location for this
> information to display them. And if it jumps from 3.5G to 3G and back
> depending if a GPRS context is active or not. That is fine with me.

Unfortunately, it is a bit more complicated. Different people have differen=
t =

understandings of what the UI should show... At the root of the issue, we h=
ave =

the fact that the network access technology (found in the network registrat=
ion =

atom at the moment) and the current bearer technology (not currently expose=
d =

by oFono) have no total order.

It is of course perfectly normal for the access technology to be "more =

powerful" than the current bearer - for instance if the device is not =

transmitting much if any data. But on some network, we can also have the =

opposite situation because some network cells do not expose their support o=
f =

HS*PA during registration, but only when data transfer occurs.

One view is that the UI should expose the "highest" of both values. Another =

view si that the UI should expose the current bearer if any, otherwise the =

network registration technology. And then I have seen some more "advanced" =
use =

cases where we need both infos separated.


So my take is that oFono should expose both values. If we want to make it =

"easy" for the user interface, then we should have a third pre-digested val=
ue, =

and even then we might need to make the "algorithm" configurable.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6548817811515391073==--

