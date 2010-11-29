Content-Type: multipart/mixed; boundary="===============6141626904259292985=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/3] Use %m instead of strerror() in syslog messages
Date: Mon, 29 Nov 2010 10:11:10 +0200
Message-ID: <201011291011.10503.remi.denis-courmont@nokia.com>
In-Reply-To: <4CF022A9.2070104@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6141626904259292985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Friday 26 November 2010 23:12:09 ext Denis Kenzior, you wrote:
> On 11/25/2010 04:51 AM, R=C3=A9mi Denis-Courmont wrote:
> > strerror() is not thread-safe, nor in the glibc implementation,
> > nor in the POSIX specification. In my experience, it will infrequently
> > crash when another thread uses locale data in any way, including
> > string formatting and such...
> > =

> > Since the Huawei driver uses thread, we might as well avoid strerror().
> > ---
> > =

> >  drivers/isimodem/sim.c |    3 ++-
> >  plugins/hfp.c          |    4 ++--
> >  plugins/isigen.c       |   13 ++++++++-----
> >  plugins/n900.c         |   14 +++++++-------
> >  plugins/nokia-gpio.c   |   29 +++++++++++++++++------------
> >  5 files changed, 36 insertions(+), 27 deletions(-)
> =

> Since we do not use threads, do you still want this patch?  If you do,
> can you please break this up into two patches, one for drivers/isimodem
> and one for plugins?  We prefer patches to be split by directory.

Why do we initialize glib and dbus with thread support? If the plan is to =

smoothen the hypothetical use of threads in the future, then this patch sho=
uld =

probably go in as well?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============6141626904259292985==--

