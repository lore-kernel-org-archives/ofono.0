Content-Type: multipart/mixed; boundary="===============4140985611767188319=="
MIME-Version: 1.0
From: jr_extern@vfnet.de
Subject: [PATCH 3/3] let configure find required libs
Date: Tue, 28 Feb 2012 09:17:25 +0100
Message-ID: <1330417045-26518-3-git-send-email-jr_extern@vfnet.de>
In-Reply-To: <1330417045-26518-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4140985611767188319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <jr_extern@vfnet.de>

---
 Makefile.am  |    2 +-
 configure.ac |   24 +++++++++++++++++-------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index bebcb90..178def4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -28,7 +28,7 @@ src_mmsd_SOURCES =3D $(gdbus_sources) $(gweb_sources) $(b=
uiltin_sources) \
 			src/push.h src/push.c src/store.h src/store.c \
 			src/wsputil.h src/wsputil.c src/mmsutil.h src/mmsutil.c
 =

-src_mmsd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -lresolv -ldl
+src_mmsd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@
 =

 src_mmsd_LDFLAGS =3D -Wl,--export-dynamic
 =

diff --git a/configure.ac b/configure.ac
index d82569b..883b59c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -64,15 +64,25 @@ dnl be different for different compiler flags (known is=
sue on AIX)
 LT_INIT([dlopen,disable-static])
 AC_SUBST([LIBTOOL_DEPS])
 =

+dnl check how we can use the resolver. while resolv.h comes with bind,
+dnl it's probably reasonable to use a combined search macro like
+dnl smart-snmpd's ACX_CHECK_LIB_FLAGS
 AC_CHECK_HEADERS(resolv.h, dummy=3Dyes,
 			AC_MSG_ERROR(resolver header files are required))
-AC_CHECK_LIB(resolv, ns_initparse, dummy=3Dyes, [
-	AC_CHECK_LIB(resolv, __ns_initparse, dummy=3Dyes,
-			AC_MSG_ERROR(resolver library support is required))
-])
-
-AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
-			AC_MSG_ERROR(dynamic linking loader is required))
+dnl ns_initparse is libresolv internal use only - limited usage intended?
+AC_SEARCH_LIBS(ns_initparse, resolv, ,
+		AC_MSG_ERROR(resolver support is required))
+dnl AC_CHECK_LIB(resolv, ns_initparse, dummy=3Dyes, [
+dnl 	AC_CHECK_LIB(resolv, __ns_initparse, dummy=3Dyes,
+dnl 			AC_MSG_ERROR(resolver library support is required))
+dnl ])
+
+dnl search how we can load dynamic libraries
+dnl TODO use libltdl, which would work on BeOS (Haiku), Darwin (MacOS X) or
+dnl      for debugging purposes with libtool's dlpreopen
+AC_SEARCH_LIBS(dlopen, dl, , AC_MSG_ERROR(dynamic linking loader is requir=
ed))
+dnl AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
+dnl 			AC_MSG_ERROR(dynamic linking loader is required))
 =

 PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.16, dummy=3Dyes,
 				AC_MSG_ERROR(GLib >=3D 2.16 is required))
-- =

1.7.9.1


--===============4140985611767188319==--

