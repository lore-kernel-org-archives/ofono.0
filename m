Content-Type: multipart/mixed; boundary="===============6539749070898547219=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/6] Makefile: Enable BlueZ 4 and BlueZ 5
Date: Thu, 10 Jan 2013 11:44:44 -0300
Message-ID: <1357829089-16029-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1357829089-16029-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539749070898547219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch enables BlueZ 4 and BlueZ 5 plugins if --enable-bluetooth is
informed. BlueZ 5 will be the default Bluetooth plugin. For BlueZ 4,
there is an additional BlueZ Library package version verification.
---
 Makefile.am  |  4 +++-
 configure.ac | 10 +++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0d2ba9f..811a3f5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -407,7 +407,7 @@ builtin_sources +=3D plugins/samsung.c
 builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

-if BLUETOOTH
+if BLUEZ4
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
 =

@@ -742,6 +742,7 @@ tools_stktest_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 endif
 endif
 =

+if BLUEZ4
 if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

@@ -759,6 +760,7 @@ if SYSTEMD
 systemdunit_DATA +=3D dundee/dundee.service
 endif
 endif
+endif
 =

 endif
 =

diff --git a/configure.ac b/configure.ac
index 450352b..e55d11d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -176,12 +176,16 @@ AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bl=
uetooth],
 				[disable Bluetooth modem support]),
 					[enable_bluetooth=3D${enableval}])
 if (test "${enable_bluetooth}" !=3D "no"); then
-	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99, dummy=3Dyes,
-			AC_MSG_ERROR(Bluetooth library >=3D 4.99 is required))
+	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99 bluez < 5,
+			  enable_bluez4=3Dyes enable_bluez5=3Dyes
+			  AC_MSG_NOTICE(Enabling BLUEZ 4 and BlueZ 5),
+			  enable_bluez4=3Dno enable_bluez5=3Dyes
+			  AC_MSG_NOTICE(Enabling BLUEZ 5))
 fi
 AC_SUBST(BLUEZ_CFLAGS)
 AC_SUBST(BLUEZ_LIBS)
-AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
+AM_CONDITIONAL(BLUEZ4, test "${enable_bluez4}" !=3D "no")
+AM_CONDITIONAL(BLUEZ5, test "${enable_bluez5}" !=3D "no")
 =

 AC_ARG_WITH([provisiondb], AC_HELP_STRING([--with-provisiondb=3DFILE],
 	[location of provision database]), [path_provisiondb=3D${withval}])
-- =

1.7.11.7


--===============6539749070898547219==--

