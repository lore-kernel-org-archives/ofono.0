Content-Type: multipart/mixed; boundary="===============6814566565470710498=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/5 v3] nettime: DBUS and compilation configuration
Date: Wed, 19 Jan 2011 10:10:24 +0200
Message-ID: <AANLkTikP7ksrzzUWs6pFuXVW_1X1q32zBaW8Q91-LQi4@mail.gmail.com>
In-Reply-To: <1295362758.3873.200.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6814566565470710498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/18 Marcel Holtmann <marcel@holtmann.org>:
> please don't implement org.ofono interface in timed. Just implement a
> timed specific (com.nokia.time) interface and punch the whole for that
> in the timed D-Bus policy.

I think there is some disconnect here. The intention is to implement a
similar agent interface as PushNotification and SmartMessaging already
do, with the exception that the one and only agent is known beforehand
and "hard-coded" to the plugin.

This is a generic interface that some other time information sink
could also implement, so it makes sense to have it in the org.ofono
namespace. Regardless of which namespace we use, though, it is oFono
that will be calling methods on this interface, and thus it needs to
have this interface opened in its D-Bus config.

> The plugin is timed specific since it monitors com.nokia.time and thus
> should also target a timed specific API. Not a generic oFono API
> description.

This is really just another agent API in oFono, just one with a
build-time registration mechanism for agents.

Cheers,
Aki

--===============6814566565470710498==--

