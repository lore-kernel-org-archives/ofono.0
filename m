Content-Type: multipart/mixed; boundary="===============7352338889133741321=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Tue, 07 Dec 2010 00:29:34 +0100
Message-ID: <1291678174.4795.124.camel@aeonflux>
In-Reply-To: <201012061833.45629.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7352338889133741321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > The only thing I would change here are the names. It's customary to
> > > avoid repeating the interface name in the signal or method, but of
> > > course the problem here is then what to call these. Maybe just Get()
> > > and Changed()? ;-)
> > > =

> > > Oh, and you probably should have included a short description of what
> > > this plugin is for (I forgot to mention this before).
> > > =

> > > The thinking behind this plugin is that timed in MeeGo wants to get
> > > the information, and a D-Bus API is a fine way to accomplish this.
> > =

> > where is this timed running? I prefer the plugin just send a D-Bus
> > message to the timed directly instead of a Get/Changed API kind of
> > thing.
> =

> AFAIK, Get/Changed is the simplest functional way to avoid races, where s=
ay =

> oFono would receive the time before timed can process it. The getter also =

> enables implementing trivial a tool =C3=A0 la ntpdate.

then please answer my questions from my other email. If we receive the
time before timed (or any other time daemon) is running, who does ensure
the current timestamp of this received time and what it correlates to.

If no time daemon is running it is safer to just set this time as system
time right away and then let the time daemon adjust it later. But just
handing out a random time from a random time before is not helping. And
oFono is not suppose to track time and it corelation to it.

Regards

Marcel



--===============7352338889133741321==--

