Content-Type: multipart/mixed; boundary="===============7066767666442645730=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH 2/2] Support for pkg-config
Date: Wed, 26 Jan 2011 14:46:32 +0200
Message-ID: <201101261446.32293.remi.denis-courmont@nokia.com>
In-Reply-To: <1296041243.1520.128.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7066767666442645730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 January 2011 13:27:23 ext Marcel Holtmann, you wrote:
> prefix=3D@prefix@
> exec_prefix=3D@exec_prefix@
> libdir=3D@libdir@
> includedir=3D@includedir@
> =

> plugindir=3D${libdir}/@PACKAGE@/plugins
> =

> Name: @PACKAGE@
> Description: oFono - Open Source Telephony
> Requires: glib-2.0 dbus-1
> Version: @VERSION@
> Libs: -module -avoid-version -export-symbols-regex @PACKAGE(a)_plugin_desc

In my experience, automake does not fancy LDFLAGS in LIBADD/LDADD. Call tha=
t a =

pkg-config limitation if you want.

> Cflags: -I${includedir}


-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============7066767666442645730==--

