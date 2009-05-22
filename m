Content-Type: multipart/mixed; boundary="===============8222462769443124057=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: [PATCH] Add dbus .service file to auto start ofonod
Date: Fri, 22 May 2009 16:03:00 -0700
Message-ID: <1243033380-2002-1-git-send-email-shane.bryan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8222462769443124057==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Shane Bryan <shane.bryan@linux.intel.com>
---
 configure.ac          |    4 ++++
 src/Makefile.am       |    4 +++-
 src/org.ofono.service |    4 ++++
 3 files changed, 11 insertions(+), 1 deletions(-)
 create mode 100644 src/org.ofono.service

diff --git a/configure.ac b/configure.ac
index 36fec5f..0b452dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -73,6 +73,10 @@ else
 fi
 AC_SUBST(DBUS_DATADIR)
 =

+DBUS_SYSTEM_SERVICEDIR=3D"${datadir}/dbus-1/system-services"
+AC_SUBST(DBUS_SYSTEM_SERVICEDIR)
+
+
 AC_SUBST([GDBUS_CFLAGS], ['$(DBUS_CFLAGS) -I$(top_srcdir)/gdbus'])
 AC_SUBST([GDBUS_LIBS], ['$(top_builddir)/gdbus/libgdbus.la $(DBUS_LIBS)'])
 =

diff --git a/src/Makefile.am b/src/Makefile.am
index 38c97bd..0c618b8 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,8 +1,10 @@
 =

 if DATAFILES
 dbusdir =3D @DBUS_DATADIR@
+servicedir =3D @DBUS_SYSTEM_SERVICEDIR@
 =

 dbus_DATA =3D ofono.conf
+service_DATA =3D org.ofono.service
 endif
 =

 sbin_PROGRAMS =3D ofonod
@@ -35,7 +37,7 @@ AM_CFLAGS =3D @GTHREAD_CFLAGS@ @GLIB_CFLAGS@ @GDBUS_CFLAG=
S@ @GATCHAT_CFLAGS@ \
 =

 INCLUDES =3D -I$(top_builddir)/include -I$(top_builddir)
 =

-EXTRA_DIST =3D ofono.conf
+EXTRA_DIST =3D ofono.conf org.ofono.service
 =

 MAINTAINERCLEANFILES =3D Makefile.in
 =

diff --git a/src/org.ofono.service b/src/org.ofono.service
new file mode 100644
index 0000000..b98b109
--- /dev/null
+++ b/src/org.ofono.service
@@ -0,0 +1,4 @@
+[D-BUS Service]
+Name=3Dorg.ofono
+Exec=3D/usr/sbin/ofonod
+User=3Droot
-- =

1.6.0.4


--===============8222462769443124057==--

