Content-Type: multipart/mixed; boundary="===============5955932308791837298=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] Support for pkg-config
Date: Mon, 31 Jan 2011 10:37:22 +0200
Message-ID: <1296463042-7321-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5955932308791837298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .gitignore   |    1 +
 Makefile.am  |    3 +++
 configure.ac |    2 +-
 ofono.pc.in  |   13 +++++++++++++
 4 files changed, 18 insertions(+), 1 deletions(-)
 create mode 100644 ofono.pc.in

diff --git a/.gitignore b/.gitignore
index 7cfb1d9..ec26af3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -23,6 +23,7 @@ missing
 stamp-h1
 autom4te.cache
 =

+ofono.pc
 include/ofono
 include/version.h
 src/builtin.h
diff --git a/Makefile.am b/Makefile.am
index e6b308b..a38fcb9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,6 +22,9 @@ local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
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
index 6e0d9d3..1b9867c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -222,4 +222,4 @@ fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 =

-AC_OUTPUT(Makefile include/version.h src/ofono.service)
+AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc)
diff --git a/ofono.pc.in b/ofono.pc.in
new file mode 100644
index 0000000..b4d0a77
--- /dev/null
+++ b/ofono.pc.in
@@ -0,0 +1,13 @@
+prefix=3D@prefix@
+exec_prefix=3D@exec_prefix@
+libdir=3D@libdir@
+includedir=3D@includedir@
+
+plugindir=3D${libdir}/@PACKAGE@/plugins
+
+Name: @PACKAGE@
+Description: oFono - Open Source Telephony
+Version: @VERSION@
+Requires: glib-2.0 dbus-1
+Cflags: -I${includedir}
+Libs: -module -avoid-version -export-symbols-regex '@PACKAGE(a)_plugin_des=
c'
-- =

1.7.1


--===============5955932308791837298==--

