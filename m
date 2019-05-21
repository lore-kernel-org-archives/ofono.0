Content-Type: multipart/mixed; boundary="===============8746548629911173728=="
MIME-Version: 1.0
From: Adrian Bunk <bunk@kernel.org>
Subject: [PATCH] Makefile.am: Don't overwrite src_ofonod_DEPENDENCIES
Date: Tue, 21 May 2019 14:35:40 +0300
Message-ID: <20190521113540.24373-1-bunk@kernel.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8746548629911173728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

src_ofonod_DEPENDENCIES did overwrite the dependencies
automatically generated from src_ofonod_LDADD with
incomplete dependencies.

This fixes the following build error:
...
  CCLD     src/ofonod
libtool:   error: cannot find the library 'gdbus/libgdbus-internal.la' or u=
nhandled argument 'gdbus/libgdbus-internal.la'
make: *** [Makefile:3448: src/ofonod] Error 1
---
 Makefile.am | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d2e310d5..5edc4488 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -6,12 +6,10 @@ noinst_LTLIBRARIES =3D
 if EXTERNAL_ELL
 ell_cflags =3D @ELL_CFLAGS@
 ell_ldadd =3D @ELL_LIBS@
-ell_dependencies =3D
 ell_built_sources =3D
 else
 ell_cflags =3D
 ell_ldadd =3D ell/libell-internal.la
-ell_dependencies =3D $(ell_ldadd)
 ell_built_sources =3D ell/internal ell/ell.h
 =

 noinst_LTLIBRARIES +=3D ell/libell-internal.la
@@ -729,8 +727,6 @@ src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(built=
in_libadd) $(ell_ldadd) \
 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
 =

-src_ofonod_DEPENDENCIES =3D $(ell_dependencies)
-
 BUILT_SOURCES =3D $(local_headers) $(ell_built_sources) src/builtin.h
 =

 CLEANFILES =3D $(BUILT_SOURCES) $(rules_DATA)
-- =

2.20.1


--===============8746548629911173728==--

