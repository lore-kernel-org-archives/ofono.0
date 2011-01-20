Content-Type: multipart/mixed; boundary="===============1859938780423325427=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Thu, 20 Jan 2011 10:25:47 +0200
Message-ID: <201101201025.47411.remi.denis-courmont@nokia.com>
In-Reply-To: <1295447768.3873.246.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1859938780423325427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 19 January 2011 16:36:08 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> > > > diff --git a/Makefile.am b/Makefile.am
> > > > index c1c34ca..e93076a 100644
> > > > --- a/Makefile.am
> > > > +++ b/Makefile.am
> > > > @@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
> > > > =

> > > >  DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
> > > > =

> > > > +if !BLUETOOTH
> > > > +DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
> > > > +endif
> > > =

> > > this patch makes no sense to me. I am not going to apply it. Using ma=
ke
> > > distcheck works nicely on my system where I build the releases.
> > =

> > I am not trying to steal your release privilege. I am trying to be able
> > to test my changes to Makefiles or whatever.
> =

> you could just install libbluetooth and this would be fine. I like to
> run make distcheck with everything enabled all the time. That is the
> only way to ensure that it does build properly.

Fair enough, but does disabling data files not defeat the purpose?


-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============1859938780423325427==--

