Content-Type: multipart/mixed; boundary="===============2784937937268947315=="
MIME-Version: 1.0
From: Mika.Liljeberg@nokia.com
Subject: RE: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Mon, 17 Jan 2011 17:02:22 +0000
Message-ID: <CB0EE8641411214CBAFF8AEBB26ABCEC18BCEA@008-AM1MPN1-006.mgdnok.nokia.com>
In-Reply-To: <1295280541.3873.161.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2784937937268947315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On a side topic, the policy seems a bit broken to begin with.

> > > <snip>
> > >  =

> > > >    <policy user=3D"root">
> > > >      <allow own=3D"org.ofono"/>
> > > >      <allow send_destination=3D"org.ofono"/>

This alone already allows root access to all interfaces behind a connection=
 named org.ofono.

> > > >      <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
> > > >      <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
> > > >      <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>

So these are redundant, unless the whole thing is rewritten as:

	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.SimToolk=
itAgent"/>
	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.PushNoti=
ficationAgent"/>
	<allow send_destination=3D"org.ofono" send_interface=3D"org.ofono.SmartMes=
sagingAgent"/>

> > > >    </policy>

Br,

	MikaL

--===============2784937937268947315==--

