Content-Type: multipart/mixed; boundary="===============2058544372551542119=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Mon, 17 Jan 2011 17:09:01 +0100
Message-ID: <1295280541.3873.161.camel@aeonflux>
In-Reply-To: <1295252255.3202.15.camel@apaila-ThinkPad-T410>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2058544372551542119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> > >  Makefile.am    |    9 +++++++--
> > >  src/ofono.conf |    2 ++
> > >  2 files changed, 9 insertions(+), 2 deletions(-)
> > =

> > <snip>
> >  =

> > >    <policy user=3D"root">
> > >      <allow own=3D"org.ofono"/>
> > > +    <allow own=3D"com.meego"/>
> > >      <allow send_destination=3D"org.ofono"/>
> > >      <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
> > >      <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
> > >      <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
> > > +    <allow send_interface=3D"org.ofono.NetworkTime"/>
> > >    </policy>
> > >  =

> > >    <policy at_console=3D"true">
> > =

> > I am now lost in what you are trying to achieve here. I thought we
> > agreed that we send a D-Bus method to timed. For that you neither have
> > to have a well known name nor have a D-Bus interface present.
> =

> Are you referring to line
> '<allow send_interface=3D"org.ofono.NetworkTime"/>'?
> This is the interface timed is supposed to implement in order for oFono
> to call its Notify method. How else would you do it? =


actually timed has to expose a proper interface for this. Don't intermix
this with org.ofono. This is a timed details.

And the D-Bus rules to be part of timed and not oFono.

Regards

Marcel



--===============2058544372551542119==--

