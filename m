Content-Type: multipart/mixed; boundary="===============2959345486371499994=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Support for pkg-config
Date: Wed, 26 Jan 2011 14:03:40 +0100
Message-ID: <1296047020.1520.131.camel@aeonflux>
In-Reply-To: <201101261446.32293.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2959345486371499994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > prefix=3D@prefix@
> > exec_prefix=3D@exec_prefix@
> > libdir=3D@libdir@
> > includedir=3D@includedir@
> > =

> > plugindir=3D${libdir}/@PACKAGE@/plugins
> > =

> > Name: @PACKAGE@
> > Description: oFono - Open Source Telephony
> > Requires: glib-2.0 dbus-1
> > Version: @VERSION@
> > Libs: -module -avoid-version -export-symbols-regex @PACKAGE(a)_plugin_d=
esc
> =

> In my experience, automake does not fancy LDFLAGS in LIBADD/LDADD. Call t=
hat a =

> pkg-config limitation if you want.

so pkg-config --libs clearly is for "all linker flags". So that seems
pretty much fine. Alternatives are --libs-only-*.

Regards

Marcel



--===============2959345486371499994==--

