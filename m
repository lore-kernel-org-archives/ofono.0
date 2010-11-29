Content-Type: multipart/mixed; boundary="===============7403643241955754418=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/3] Use %m instead of strerror() in syslog messages
Date: Mon, 29 Nov 2010 10:28:15 +0100
Message-ID: <1291022895.4795.17.camel@aeonflux>
In-Reply-To: <201011291011.10503.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7403643241955754418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > strerror() is not thread-safe, nor in the glibc implementation,
> > > nor in the POSIX specification. In my experience, it will infrequently
> > > crash when another thread uses locale data in any way, including
> > > string formatting and such...
> > > =

> > > Since the Huawei driver uses thread, we might as well avoid strerror(=
).
> > > ---
> > > =

> > >  drivers/isimodem/sim.c |    3 ++-
> > >  plugins/hfp.c          |    4 ++--
> > >  plugins/isigen.c       |   13 ++++++++-----
> > >  plugins/n900.c         |   14 +++++++-------
> > >  plugins/nokia-gpio.c   |   29 +++++++++++++++++------------
> > >  5 files changed, 36 insertions(+), 27 deletions(-)
> > =

> > Since we do not use threads, do you still want this patch?  If you do,
> > can you please break this up into two patches, one for drivers/isimodem
> > and one for plugins?  We prefer patches to be split by directory.
> =

> Why do we initialize glib and dbus with thread support? If the plan is to =

> smoothen the hypothetical use of threads in the future, then this patch s=
hould =

> probably go in as well?

we do not initialize it with thread support, but in case a plugin
actually uses threads it could force it. This is common across BlueZ,
ConnMan and oFono and really just in case thing. In ConnMan we have this
case with the WiMAX plugin. For oFono we should hopefully never require
threading support.

Regards

Marcel



--===============7403643241955754418==--

