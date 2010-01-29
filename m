Content-Type: multipart/mixed; boundary="===============3162664201628440279=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: API for Neighbouring Cell Info
Date: Fri, 29 Jan 2010 15:31:19 -0600
Message-ID: <201001291531.20020.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9BACB21D9@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3162664201628440279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > Hi Aki,
> >
> > > > Honestly I don't like either approach, the Agent pattern would be a
> > > > much better fit here.  This would allow us to specify
> > > > the polling/update interval and stop neighbor cell updates when no
> > > > one is interested in them.
> > >
> > > In my experience, the positioning guys don't need periodic updates at
> > > all. The data needs to be fetched on demand. Like whenever the user
> > > starts up a location-aware application.
> >
> > Fair enough, but we also have to consider the case of multiple
> > applications
> > being interested in this information.  We can't assume that it will be
> > polled on demand by just one...
> =

> Ny understanding is that typically there would be a location service that
>  queries this information from oFono and converts it into actual
>  coordinates through voodoo and black magic and that location-aware
>  applications will ask this location service for coordinates. E.g. you
>  would have something like GeoClue providing a single API for providing
>  coordinates to applications and under GeoClue there is the location
>  service, and the location service in turn talks to oFono.
> =


You're absolutely correct.  My point is that if only one entity is ever goi=
ng =

to be interested in this information (e.g. GeoClue) then a full blown atom =
/ =

DBus API is not even necessary.  We can do this similarly to the history at=
om =

and leave it up to the system integrator to decide how and what service to =

use.

DBus API implies that multiple user applications are interested in the =

information provided.  If this is the case, then in my view a procedural, =

application-driven polling API is not the best approach.

Regards,
-Denis

--===============3162664201628440279==--

