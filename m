Content-Type: multipart/mixed; boundary="===============3606984369316502294=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/6] Makefile: Add configure option for BlueZ 4 and 5
Date: Wed, 16 Jan 2013 10:31:26 -0300
Message-ID: <1358343091-23350-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358343091-23350-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3606984369316502294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BlueZ 5 is the default option. If --enable-bluez4 is provided, oFono
plugins based on BlueZ 4 are enabled prior to BlueZ 5.
--disable-bluetooth configure option disables BlueZ 5 and BlueZ 4
plugins.
---
 Makefile.am  |  7 ++++++-
 configure.ac | 20 ++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 0d2ba9f..c2bd4a4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -408,6 +408,7 @@ builtin_modules +=3D sim900
 builtin_sources +=3D plugins/sim900.c
 =

 if BLUETOOTH
+if BLUEZ4
 builtin_modules +=3D bluetooth
 builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
 =

@@ -434,6 +435,7 @@ builtin_cflags +=3D @BLUEZ_CFLAGS@
 builtin_libadd +=3D @BLUEZ_LIBS@
 endif
 endif
+endif
 =

 if PROVISION
 builtin_sources +=3D plugins/mbpi.h plugins/mbpi.c
@@ -742,6 +744,8 @@ tools_stktest_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
 endif
 endif
 =

+if BLUETOOTH
+if BLUEZ4
 if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

@@ -759,7 +763,8 @@ if SYSTEMD
 systemdunit_DATA +=3D dundee/dundee.service
 endif
 endif
-
+endif
+endif
 endif
 =

 noinst_PROGRAMS +=3D gatchat/gsmdial gatchat/test-server gatchat/test-qcdm
diff --git a/configure.ac b/configure.ac
index 450352b..7db4198 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,14 +173,22 @@ AC_ARG_ENABLE(qmimodem, AC_HELP_STRING([--disable-qmi=
modem],
 AM_CONDITIONAL(QMIMODEM, test "${enable_qmimodem}" !=3D "no")
 =

 AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bluetooth],
-				[disable Bluetooth modem support]),
+				[disable BlueZ 4 and BlueZ 5 plugins support]),
 					[enable_bluetooth=3D${enableval}])
-if (test "${enable_bluetooth}" !=3D "no"); then
-	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99, dummy=3Dyes,
-			AC_MSG_ERROR(Bluetooth library >=3D 4.99 is required))
+
+AC_ARG_ENABLE(bluez4, AC_HELP_STRING([--enable-bluez4],
+				[enable BlueZ 4 plugins support prior to BlueZ 5]),
+					[enable_bluez4=3D${enableval}])
+
+if (test "${enable_bluez4}" =3D "yes"); then
+	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.99 bluez < 5,
+			  enable_bluez4=3Dyes,
+			  AC_MSG_ERROR(Bluetooth library >=3D 4.99 and < 5 is required))
+	AC_SUBST(BLUEZ_CFLAGS)
+	AC_SUBST(BLUEZ_LIBS)
 fi
-AC_SUBST(BLUEZ_CFLAGS)
-AC_SUBST(BLUEZ_LIBS)
+
+AM_CONDITIONAL(BLUEZ4, test "${enable_bluetooth}" !=3D "no" && test "${ena=
ble_bluez4}" =3D "yes")
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" !=3D "no")
 =

 AC_ARG_WITH([provisiondb], AC_HELP_STRING([--with-provisiondb=3DFILE],
-- =

1.7.11.7


--===============3606984369316502294==--

