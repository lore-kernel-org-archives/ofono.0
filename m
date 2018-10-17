Content-Type: multipart/mixed; boundary="===============1534051738753828082=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 2/2] configure.ac: simplify usage of PKG_CHECK_MODULES
Date: Wed, 17 Oct 2018 15:52:25 +0200
Message-ID: <20181017135225.26573-3-jonas@norrbonn.se>
In-Reply-To: <20181017135225.26573-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1534051738753828082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These days pkg-config does the right thing pretty much automatically so
the usage of the autoconf macros can be simplified a bit.  This
functionality exists from pkg-config 0.24, which is already pretty old,
so we specify that as a minimum version for that utility.
---
 configure.ac | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5680d65b..044700b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -10,7 +10,7 @@ AM_MAINTAINER_MODE
 =

 AC_PREFIX_DEFAULT(/usr/local)
 =

-PKG_PROG_PKG_CONFIG
+PKG_PROG_PKG_CONFIG([0.24])
 =

 COMPILER_FLAGS
 =

@@ -60,15 +60,8 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 =

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
-				AC_MSG_ERROR(GLib >=3D 2.32 is required))
-AC_SUBST(GLIB_CFLAGS)
-AC_SUBST(GLIB_LIBS)
-
-PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.4, dummy=3Dyes,
-				AC_MSG_ERROR(D-Bus >=3D 1.4 is required))
-AC_SUBST(DBUS_CFLAGS)
-AC_SUBST(DBUS_LIBS)
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32)
+PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.4)
 =

 AC_ARG_WITH(dbusconfdir, AC_HELP_STRING([--with-dbusconfdir=3DPATH],
 	[path to D-Bus config directory]), [path_dbusconf=3D${withval}],
@@ -115,8 +108,7 @@ AC_ARG_ENABLE(udev, AC_HELP_STRING([--disable-udev],
 			[disable udev modem detection support]),
 						[enable_udev=3D${enableval}])
 if (test "${enable_udev}" !=3D "no"); then
-	PKG_CHECK_MODULES(UDEV, libudev >=3D 143, [enable_udev=3D"yes"],
-				AC_MSG_ERROR(libudev >=3D 143 is required))
+	PKG_CHECK_MODULES(UDEV, libudev >=3D 143, [enable_udev=3D"yes"])
 	UDEV_DATADIR=3D"`$PKG_CONFIG --variable=3Dudevdir udev`"
 	if (test -z "${UDEV_DATADIR}"); then
 		UDEV_DATADIR=3D"${sysconfdir}/udev/rules.d"
@@ -125,8 +117,6 @@ if (test "${enable_udev}" !=3D "no"); then
 	fi
 	AC_SUBST(UDEV_DATADIR)
 fi
-AC_SUBST(UDEV_CFLAGS)
-AC_SUBST(UDEV_LIBS)
 AM_CONDITIONAL(UDEV, test "${enable_udev}" =3D "yes")
 =

 AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmodem],
@@ -169,10 +159,7 @@ AC_ARG_ENABLE(bluez4, AC_HELP_STRING([--enable-bluez4],
 					[enable_bluez4=3D${enableval}])
 =

 if (test "${enable_bluez4}" =3D "yes"); then
-	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99 bluez < 5, dummy=3Dyes,
-			  AC_MSG_ERROR(Bluetooth library >=3D 4.99 and < 5 is required))
-	AC_SUBST(BLUEZ_CFLAGS)
-	AC_SUBST(BLUEZ_LIBS)
+	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99 bluez < 5)
 fi
 =

 AM_CONDITIONAL(BLUEZ4, test "${enable_bluetooth}" !=3D "no" && test "${ena=
ble_bluez4}" =3D "yes")
@@ -217,10 +204,7 @@ AC_ARG_ENABLE(ell, AC_HELP_STRING([--enable-ell],
 =

 if (test "${enable_ell}" =3D "yes"); then
 	AC_DEFINE(HAVE_ELL, 1, [Defined if Ell is enabled])
-	PKG_CHECK_MODULES(ELL, ell >=3D 0.2, dummy=3Dyes,
-			  AC_MSG_ERROR(ell library >=3D 0.2 is required))
-	AC_SUBST(ELL_CFLAGS)
-	AC_SUBST(ELL_LIBS)
+	PKG_CHECK_MODULES(ELL, ell >=3D 0.2)
 fi
 =

 AM_CONDITIONAL(MBIMMODEM, test "${enable_ell}" !=3D "no" && test "${enable=
_mbimmodem}" =3D "yes")
-- =

2.17.1


--===============1534051738753828082==--

