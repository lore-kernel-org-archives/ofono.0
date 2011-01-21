Content-Type: multipart/mixed; boundary="===============8163104621878113240=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Fri, 21 Jan 2011 15:28:49 +0200
Message-ID: <1295616529.10774.11.camel@apaila-ThinkPad-T410>
In-Reply-To: <1295522391.3873.285.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8163104621878113240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2011-01-20 at 12:19 +0100, ext Marcel Holtmann wrote:
> Hi Aki,
> =

> > > please don't implement org.ofono interface in timed. Just implement a
> > > timed specific (com.nokia.time) interface and punch the whole for that
> > > in the timed D-Bus policy.
> > =

> > I think there is some disconnect here. The intention is to implement a
> > similar agent interface as PushNotification and SmartMessaging already
> > do, with the exception that the one and only agent is known beforehand
> > and "hard-coded" to the plugin.
> =

> that is not what I said and that is clearly not the intent here.
> =

> > This is a generic interface that some other time information sink
> > could also implement, so it makes sense to have it in the org.ofono
> > namespace. Regardless of which namespace we use, though, it is oFono
> > that will be calling methods on this interface, and thus it needs to
> > have this interface opened in its D-Bus config.
> =

> They will be always specific to the target daemon and that is fine. This
> is not up to oFono to define and that is point here.
> =

> > > The plugin is timed specific since it monitors com.nokia.time and thus
> > > should also target a timed specific API. Not a generic oFono API
> > > description.
> > =

> > This is really just another agent API in oFono, just one with a
> > build-time registration mechanism for agents.
> =

> It is not. This is timed exposing an API to get notifications from a
> cellular stack and then a timed specific plugin inside oFono. It has
> nothing to do with an oFono defined D-Bus API.

As I see, the question at the moment is where to punch the hole in D-Bus
configuration; alternatives being either in ofono or in timed side. I
can see the rationale and reasoning behind both approaches, but in order
to make some progress with this matter we need a decision. So, should we
take a vote or what? After all isn't this a non-functional,
matter-of-taste type of question?

Best Regards,
  Antti


--===============8163104621878113240==--

