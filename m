Content-Type: multipart/mixed; boundary="===============2380614987310127814=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Wed, 19 Jan 2011 15:29:34 +0200
Message-ID: <201101191529.34193.remi.denis-courmont@nokia.com>
In-Reply-To: <1295443258.3873.243.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2380614987310127814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 19 January 2011 15:20:58 ext Marcel Holtmann, you wrote:
> > diff --git a/Makefile.am b/Makefile.am
> > index c1c34ca..e93076a 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
> > =

> >  DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
> > =

> > +if !BLUETOOTH
> > +DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
> > +endif
> =

> this patch makes no sense to me. I am not going to apply it. Using make
> distcheck works nicely on my system where I build the releases.

I am not trying to steal your release privilege. I am trying to be able to =

test my changes to Makefiles or whatever.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============2380614987310127814==--

