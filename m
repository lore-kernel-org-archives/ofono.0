Content-Type: multipart/mixed; boundary="===============6544985081609263220=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 13:14:11 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BACB21D9@orsmsx508.amr.corp.intel.com>
In-Reply-To: <201001291051.52879.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6544985081609263220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Aki,
> =

> > > Honestly I don't like either approach, the Agent pattern would be a
> > > much better fit here.  This would allow us to specify
> > > the polling/update interval and stop neighbor cell updates when no one
> > > is interested in them.
> >
> > In my experience, the positioning guys don't need periodic updates at
> > all. The data needs to be fetched on demand. Like whenever the user
> > starts up a location-aware application.
> =

> Fair enough, but we also have to consider the case of multiple
> applications
> being interested in this information.  We can't assume that it will be
> polled on demand by just one...

Ny understanding is that typically there would be a location service that q=
ueries this information from oFono and converts it into actual coordinates =
through voodoo and black magic and that location-aware applications will as=
k this location service for coordinates. E.g. you would have something like=
 GeoClue providing a single API for providing coordinates to applications a=
nd under GeoClue there is the location service, and the location service in=
 turn talks to oFono.

Cheers,
Waldo

--===============6544985081609263220==--

