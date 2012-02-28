Content-Type: multipart/mixed; boundary="===============3869881673054410340=="
MIME-Version: 1.0
From: jr_extern@vfnet.de
Subject: [PATCH 2/3] changing depreciated libtool initialization to modern one
Date: Tue, 28 Feb 2012 09:17:24 +0100
Message-ID: <1330417045-26518-2-git-send-email-jr_extern@vfnet.de>
In-Reply-To: <1330417045-26518-1-git-send-email-jr_extern@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3869881673054410340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jens Rehsack <jr_extern@vfnet.de>

---
 Makefile.am  |    4 ++++
 configure.ac |   10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c3a4486..bebcb90 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,10 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

+LIBTOOL_DEPS =3D @LIBTOOL_DEPS@
+libtool: $(LIBTOOL_DEPS)
+	$(SHELL) ./config.status libtool
+
 gdbus_sources =3D gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
 					gdbus/object.c gdbus/polkit.c
 =

diff --git a/configure.ac b/configure.ac
index 34cc526..d82569b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,8 +31,8 @@ AC_PROG_INSTALL
 m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 =

-AC_DISABLE_STATIC
-AC_PROG_LIBTOOL
+dnl AC_DISABLE_STATIC
+dnl AC_PROG_LIBTOOL
 =

 AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
@@ -58,6 +58,12 @@ AC_ARG_ENABLE(pie, AC_HELP_STRING([--enable-pie],
 	fi
 ])
 =

+dnl LT_INIT should be invoked after all compiler flags checks, because
+dnl of LT_INIT remembers the RPATH stored in test targets which might
+dnl be different for different compiler flags (known issue on AIX)
+LT_INIT([dlopen,disable-static])
+AC_SUBST([LIBTOOL_DEPS])
+
 AC_CHECK_HEADERS(resolv.h, dummy=3Dyes,
 			AC_MSG_ERROR(resolver header files are required))
 AC_CHECK_LIB(resolv, ns_initparse, dummy=3Dyes, [
-- =

1.7.9.1


--===============3869881673054410340==--

