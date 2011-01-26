Content-Type: multipart/mixed; boundary="===============7429768159242586807=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH v3 2/7] gps: add gps atom and gpsagent implementations
Date: Wed, 26 Jan 2011 20:13:31 -0200
Message-ID: <20110126221331.GC2192@joana>
In-Reply-To: <20110126221146.GB18330@nodo3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7429768159242586807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Rafael Ignacio Zurita <rafael.zurita@profusion.mobi> [2011-01-26 19:11:=
46 -0300]:

> Hi Gustavo,
> =

> On Wed, Jan 26, 2011 at 07:51:57PM -0200, Gustavo F. Padovan wrote:
> > Hi Rafael,
> > =

> > * Rafael Ignacio Zurita <rafael.zurita@profusion.mobi> [2011-01-26 12=
:32:49 -0300]:
> > =

> > > ---
> > >  Makefile.am    |    3 +-
> > >  src/gps.c      |  326 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  src/gpsagent.c |  145 +++++++++++++++++++++++++
> > >  src/gpsagent.h |   37 +++++++
> > >  src/ofono.conf |    1 +
> > >  src/ofono.h    |    2 +
> > >  6 files changed, 513 insertions(+), 1 deletions(-)
> > >  create mode 100644 src/gps.c
> > >  create mode 100644 src/gpsagent.c
> > >  create mode 100644 src/gpsagent.h
> > > =

> > > diff --git a/Makefile.am b/Makefile.am
> > > index 7374f70..de70976 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -355,7 +355,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin=
_sources) src/ofono.ver \
> > >  			src/simfs.c src/simfs.h src/audio-settings.c \
> > >  			src/smsagent.c src/smsagent.h src/ctm.c \
> > >  			src/cdma-voicecall.c src/sim-auth.c \
> > > -			src/message.h src/message.c
> > > +			src/message.h src/message.c src/gps.c \
> > > +			src/gpsagent.c src/gpsagent.h
> > =

> > gpsagent.c should not be in src/, it should be in test/. But I saw you =
already
> > have python implementation for the Agent. So just discard the c one and=
 keep
> > only the python one. oFono does not really care about the Agent
> > implementation.
> =

> I am not understanding your comments. gpsagent.c here is not a test. =

> It is similar to stkagent or smsagent.

Yeah, because they are wrong. :(

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============7429768159242586807==--

