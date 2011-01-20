Content-Type: multipart/mixed; boundary="===============7429940136054091341=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Allow distcheck to work without bluetooth
Date: Thu, 20 Jan 2011 10:31:32 +0100
Message-ID: <1295515892.3873.257.camel@aeonflux>
In-Reply-To: <201101201025.47411.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7429940136054091341==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > > > > diff --git a/Makefile.am b/Makefile.am
> > > > > index c1c34ca..e93076a 100644
> > > > > --- a/Makefile.am
> > > > > +++ b/Makefile.am
> > > > > @@ -550,6 +550,9 @@ gatchat_test_qcdm_LDADD =3D @GLIB_LIBS@
> > > > > =

> > > > >  DISTCHECK_CONFIGURE_FLAGS =3D --disable-datafiles
> > > > > =

> > > > > +if !BLUETOOTH
> > > > > +DISTCHECK_CONFIGURE_FLAGS +=3D --disable-bluetooth
> > > > > +endif
> > > > =

> > > > this patch makes no sense to me. I am not going to apply it. Using =
make
> > > > distcheck works nicely on my system where I build the releases.
> > > =

> > > I am not trying to steal your release privilege. I am trying to be ab=
le
> > > to test my changes to Makefiles or whatever.
> > =

> > you could just install libbluetooth and this would be fine. I like to
> > run make distcheck with everything enabled all the time. That is the
> > only way to ensure that it does build properly.
> =

> Fair enough, but does disabling data files not defeat the purpose?

these are just configuration files and not code.

Regards

Marcel



--===============7429940136054091341==--

