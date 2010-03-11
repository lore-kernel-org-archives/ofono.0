Content-Type: multipart/mixed; boundary="===============8929004325592218912=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/1] install data file
Date: Thu, 11 Mar 2010 09:20:58 -0800
Message-ID: <1268328058.3712.92.camel@localhost.localdomain>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD1DB5D8E2@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8929004325592218912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> > >  Makefile.am |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/Makefile.am b/Makefile.am
> > > index fcee5e6..007d5b9 100644
> > > --- a/Makefile.am
> > > +++ b/Makefile.am
> > > @@ -45,7 +45,7 @@ INCLUDES =3D -I$(top_srcdir)/src -I$(top_builddir)/=
src
> > >
> > >  CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
> > >
> > > -EXTRA_DIST =3D src/controlbase.ui src/default.xml src/GSMSpecificati=
on.xml
> > > +dist_pkgdata_DATA =3D src/controlbase.ui src/moblin.xml
> > src/GSMSpecification.xml
> > >
> > =

> > this looks wrong. You should not be installing src/controlbase.ui and
> > don't bother installing GSMSpecification.xml. I just put that into the
> > source code for reference.
> > =

> > Also if you wanna install default.xml, then it needs to be installed
> > in /etc/phonesim/ and not just somewhere.
> I am afraid that I am not be persuaded. ;-)
> =

> I think *.xml is the data file containing the AT commands simulation data=
, and not the config file. So I think it is not suitable to put it at /etc.
> And the proper place is data directory, /usr/share/phonesim. And install =
GSMSpecification.xml there is convenient for user to reference, they need n=
ot find the source package. =

> Think of wpa_s package, they will put all the types of conf example at ex=
ample directory

I have no strong preference one way or the other. I would be fully okay
with having this installed in /usr/share/phonesim and have phonesim use
the default.xml by default.

So please send a patch that just installs the default.xml and verify
that it is installed properly. Check as I explained in my previous
email.

Regards

Marcel



--===============8929004325592218912==--

