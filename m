Content-Type: multipart/mixed; boundary="===============7800278943557530090=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Mon, 06 Dec 2010 18:33:45 +0200
Message-ID: <201012061833.45629.remi.denis-courmont@nokia.com>
In-Reply-To: <1291420976.4795.113.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7800278943557530090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday 04 December 2010 02:02:56 ext Marcel Holtmann, you wrote:
> Hi Aki,
> =

> > The only thing I would change here are the names. It's customary to
> > avoid repeating the interface name in the signal or method, but of
> > course the problem here is then what to call these. Maybe just Get()
> > and Changed()? ;-)
> > =

> > Oh, and you probably should have included a short description of what
> > this plugin is for (I forgot to mention this before).
> > =

> > The thinking behind this plugin is that timed in MeeGo wants to get
> > the information, and a D-Bus API is a fine way to accomplish this.
> =

> where is this timed running? I prefer the plugin just send a D-Bus
> message to the timed directly instead of a Get/Changed API kind of
> thing.

AFAIK, Get/Changed is the simplest functional way to avoid races, where say =

oFono would receive the time before timed can process it. The getter also =

enables implementing trivial a tool =C3=A0 la ntpdate.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7800278943557530090==--

