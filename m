Content-Type: multipart/mixed; boundary="===============4568859822915514647=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/2] Support for pkg-config
Date: Wed, 26 Jan 2011 13:09:32 +0200
Message-ID: <1296040172-19180-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1296040172-19180-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4568859822915514647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .gitignore   |    1 +
 Makefile.am  |    3 +++
 configure.ac |    2 +-
 ofono.pc.in  |   10 ++++++++++
 4 files changed, 15 insertions(+), 1 deletions(-)
 create mode 100644 ofono.pc.in

diff --git a/.gitignore b/.gitignore
index 7cfb1d9..59308be 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,6 +20,7 @@ install-sh
 libtool
 ltmain.sh
 missing
+ofono.pc
 stamp-h1
 autom4te.cache
 =

diff --git a/Makefile.am b/Makefile.am
index 71365d7..3b29d19 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,6 +21,9 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
 				$(nodist_pkginclude_HEADERS), \
 					include/ofono/$(notdir $(file)))
 =

+pkgconfigdir =3D $(libdir)/pkgconfig
+pkgconfig_DATA =3D ofono.pc
+
 =

 if DATAFILES
 dbusconfdir =3D @DBUS_CONFDIR@
diff --git a/configure.ac b/configure.ac
index b034ff0..d26b64f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -226,4 +226,4 @@ fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 =

-AC_OUTPUT(Makefile include/version.h src/ofono.service)
+AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc)
diff --git a/ofono.pc.in b/ofono.pc.in
new file mode 100644
index 0000000..19f12e6
--- /dev/null
+++ b/ofono.pc.in
@@ -0,0 +1,10 @@
+prefix=3D@prefix@
+exec_prefix=3D@exec_prefix@
+libdir=3D@libdir@
+plugindir=3D${libdir}/@PACKAGE@/plugins
+includedir=3D@includedir@
+
+Name: oFono
+Description: oFono - Open Source Telephony
+Version: @VERSION@
+Cflags: -I${includedir}
-- =

1.7.1


--===============4568859822915514647==--

