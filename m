Content-Type: multipart/mixed; boundary="===============5307352574545437456=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Tue, 18 Jan 2011 15:59:18 +0100
Message-ID: <1295362758.3873.200.camel@aeonflux>
In-Reply-To: <AANLkTin-1_VfU2MRTbfb7JDDRByWQVwxOn+X9Uuu69su@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5307352574545437456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> So these are redundant, unless the whole thing is rewritten as:
> >>
> >>       <allow send_destination=3D"org.ofono" send_interface=3D"org.ofon=
o.SimToolkitAgent"/>
> >>       <allow send_destination=3D"org.ofono" send_interface=3D"org.ofon=
o.PushNotificationAgent"/>
> >>       <allow send_destination=3D"org.ofono" send_interface=3D"org.ofon=
o.SmartMessagingAgent"/>
> >>
> >
> > The agents are registered by the application, not ofono.  So the
> > destination is in fact not org.ofono but a system bus connection owned
> > by the application.  Hence the need to punch holes here.
> =

> This means we also need punch a hole for org.ofono.NetworkTime. The
> only difference there to the above agent interfaces is that it's a
> singleton and comes with no registration API on oFono side. Instead,
> there is a custom plugin per agent implementation, like the one for
> timed.

please don't implement org.ofono interface in timed. Just implement a
timed specific (com.nokia.time) interface and punch the whole for that
in the timed D-Bus policy.

The plugin is timed specific since it monitors com.nokia.time and thus
should also target a timed specific API. Not a generic oFono API
description.

Regards

Marcel



--===============5307352574545437456==--

