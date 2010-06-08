Content-Type: multipart/mixed; boundary="===============2254329277233274321=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: [RFC patches 10/13] doc: explain debugging options to -d,
 add a pointer in -h to manpage
Date: Tue, 08 Jun 2010 16:33:53 -0700
Message-ID: <1276040033.2478.69.camel@localhost.localdomain>
In-Reply-To: <1276038804.2182.55.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2254329277233274321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-06-08 at 16:13 -0700, Marcel Holtmann wrote: =

> Hi Inaky,
> =

> > > > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > > > =

> > > > Modified HACKING and man page to have more formation on what are the
> > > > debugging options and how to enable them.
> > > > ---
> > > >  HACKING      |   10 ++++++++++
> > > >  doc/ofonod.8 |    5 ++++-
> > > >  src/main.c   |    4 +++-
> > > >  3 files changed, 17 insertions(+), 2 deletions(-)
> > > > =

> > > > diff --git a/HACKING b/HACKING
> > > > index ae420aa..e825185 100644
> > > > --- a/HACKING
> > > > +++ b/HACKING
> > > > @@ -81,3 +81,13 @@ automatically includes this option.
> > > >  =

> > > >  For production installations or distribution packaging it is impor=
tant that
> > > >  the "--enable-maintainer-mode" option is NOT used.
> > > > +
> > > > +Note multiple arguments to -d can be specified, colon, comma or sp=
ace
> > > > +separated. The arguments are relative source code filenames for wh=
ich
> > > > +debugging output should be enabled; output shell-style globs are
> > > > +accepted (e.g.: 'plugins/*:src/main.c').
> > > > +
> > > > +Other debugging settings that can be toggled:
> > > > +
> > > > + - Environment variable OFONO_AT_DEBUG (set to 1): enable AT comma=
nds
> > > > +   debugging
> > > > diff --git a/doc/ofonod.8 b/doc/ofonod.8
> > > > index 474d7fb..7bb908c 100644
> > > > --- a/doc/ofonod.8
> > > > +++ b/doc/ofonod.8
> > > > @@ -18,7 +18,10 @@ is used to manage \fID-Bus\fP permissions for oF=
ono.
> > > >  .SH OPTIONS
> > > >  .TP
> > > >  .B --debug, -d
> > > > -Enable debug information output.
> > > > +Enable debug information output. Note multiple arguments to -d can=
 be
> > > > +specified, colon, comma or space separated. The arguments are rela=
tive
> > > > +source code filenames for which debugging output should be enabled;
> > > > +output shell-style globs are accepted (e.g.: "plugins/*:src/main.c=
").
> > > >  .TP
> > > >  .B --nodetach, -n
> > > >  Don't run as daemon in background.
> > > =

> > > you need to hook this up to automake :)
> > =

> > Can you clarify, please?
> =

> we do wanna install the man pages, right? Then this needs man_MANS and
> EXTRA_DIST magic to get included and installed.

Hmm, I didn't realize the makefile magic wasn't plugged in--I just
patched the man page.

Ack to that, will add that as soon as I have the tree rebased from the
modified commits.

> > > > diff --git a/src/main.c b/src/main.c
> > > > index 8e686ac..c5791be 100644
> > > > --- a/src/main.c
> > > > +++ b/src/main.c
> > > > @@ -98,7 +98,9 @@ static gboolean option_version =3D FALSE;
> > > >  =

> > > >  static GOptionEntry options[] =3D {
> > > >  	{ "debug", 'd', 0, G_OPTION_ARG_STRING, &option_debug,
> > > > -				"Specify debug options to enable", "DEBUG" },
> > > > +			   "Specify debug options to enable (see the "
> > > > +			   "man page for ofonod(8) for more information).",
> > > > +			   "DEBUG" },
> > > >  	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
> > > >  				G_OPTION_ARG_NONE, &option_detach,
> > > >  				"Don't run as daemon in background" },
> > > =

> > > Please leave this out. If we have a man page and man ofonod works, th=
en
> > > this is not needed.
> > =

> > Denis and me, AFAIR, agreed on this wording as it just gives the quick
> > pointer to where the extra information is found. Again, not critical,
> > but confusing feedback.
> =

> Maybe I am too old school Linux here ;)
> =

> If we have an installed man page and I don't understand the usage
> information, then it is clear to just do man ofonod. I don't need the
> usage tell me that.

heh -- yeah, I tend to do that too. Anyhow, let's leave it up to Denis.



--===============2254329277233274321==--

