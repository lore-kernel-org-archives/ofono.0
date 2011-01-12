Content-Type: multipart/mixed; boundary="===============8743115758451966001=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 05/10] Update documentation for GPRS technology
Date: Wed, 12 Jan 2011 08:32:22 -0800
Message-ID: <1294849942.3873.92.camel@aeonflux>
In-Reply-To: <201101111057.47545.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8743115758451966001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > +		string Technology [readonly, optional]
> > > +
> > > +			Contains the data technology as reported by the
> > > +			GPRS service registration (if known).
> > > +
> > > +			Possible values are the same as for the Technology
> > > +			property the NetworkRegistration object.
> > > +
> > =

> > we used to have this value and then we removed it since it ended up
> > being not useful. So why do you wanna bring it back?
> =

> The network registration only ever tells 2G/3G/4G. We need something to t=
ell =

> about EDGE or HS*PA. We cannot rely (only) on the CPSB bearer as it is on=
ly =

> defined when there is an active context. Technology is set whenever we ar=
e =

> registered to the GPRS service.

as I said, we took the Technology field from the Connection Manager
since it was just duplication.

So why are we not feeding the CPSB bearer information into the Network
Registration and have it just update from GSM -> EDGE and UMTS -> HSPA
accordingly.

I think that the UI should only require to monitor one location for this
information to display them. And if it jumps from 3.5G to 3G and back
depending if a GPRS context is active or not. That is fine with me.

Regards

Marcel



--===============8743115758451966001==--

