Content-Type: multipart/mixed; boundary="===============7966368841022189360=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Mon, 17 Jan 2011 10:17:35 +0200
Message-ID: <1295252255.3202.15.camel@apaila-ThinkPad-T410>
In-Reply-To: <1294964579.3873.113.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7966368841022189360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Fri, 2011-01-14 at 01:22 +0100, ext Marcel Holtmann wrote:
> Hi Antti,
> =

> >  Makefile.am    |    9 +++++++--
> >  src/ofono.conf |    2 ++
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> =

> <snip>
>  =

> >    <policy user=3D"root">
> >      <allow own=3D"org.ofono"/>
> > +    <allow own=3D"com.meego"/>
> >      <allow send_destination=3D"org.ofono"/>
> >      <allow send_interface=3D"org.ofono.SimToolkitAgent"/>
> >      <allow send_interface=3D"org.ofono.PushNotificationAgent"/>
> >      <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
> > +    <allow send_interface=3D"org.ofono.NetworkTime"/>
> >    </policy>
> >  =

> >    <policy at_console=3D"true">
> =

> I am now lost in what you are trying to achieve here. I thought we
> agreed that we send a D-Bus method to timed. For that you neither have
> to have a well known name nor have a D-Bus interface present.

Are you referring to line
'<allow send_interface=3D"org.ofono.NetworkTime"/>'?
This is the interface timed is supposed to implement in order for oFono
to call its Notify method. How else would you do it? =



> And surely ofonod will not claim com.meego as service name.

Yes, sure. That was just left behind from testing, since the mock timed
script needed this for D-Bus access. I'll remove it.

Best Regards,
  Antti


--===============7966368841022189360==--

