Content-Type: multipart/mixed; boundary="===============8150399144114350491=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Thu, 20 Jan 2011 11:52:27 +0200
Message-ID: <201101201152.27117.remi.denis-courmont@nokia.com>
In-Reply-To: <1295515892.3873.257.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8150399144114350491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thursday 20 January 2011 11:31:32 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > > > > > diff --git a/Makefile.am b/Makefile.am
> > > > > > index c1c34ca..e93076a 100644
> > > > > > --- a/Makefile.am
> > > > > > +++ b/Makefile.am
> > > > > > @@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
> > > > > > =

> > > > > >  DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
> > > > > > =

> > > > > > +if !BLUETOOTH
> > > > > > +DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
> > > > > > +endif
> > > > > =

> > > > > this patch makes no sense to me. I am not going to apply it. Using
> > > > > make distcheck works nicely on my system where I build the
> > > > > releases.
> > > > =

> > > > I am not trying to steal your release privilege. I am trying to be
> > > > able to test my changes to Makefiles or whatever.
> > > =

> > > you could just install libbluetooth and this would be fine. I like to
> > > run make distcheck with everything enabled all the time. That is the
> > > only way to ensure that it does build properly.
> > =

> > Fair enough, but does disabling data files not defeat the purpose?
> =

> these are just configuration files and not code.

Yeah? distcheck is about checking that all *files* are declared properly in=
 the =

Makefiles, and installation/uninstallation is clean.

If you merely want to check compilation, check is more than enough.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============8150399144114350491==--

