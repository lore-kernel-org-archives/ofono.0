Content-Type: multipart/mixed; boundary="===============5330340567976460738=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/1] Add option to support version
Date: Wed, 03 Nov 2010 14:57:46 +0800
Message-ID: <1288767466-12837-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1288767466-12837-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5330340567976460738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am  |    2 +-
 bootstrap    |    2 +-
 configure.ac |    1 +
 src/main.cpp |   11 +++++++++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f124b08..dd54c42 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -50,7 +50,7 @@ dist_pkgdata_DATA =3D src/default.xml
 EXTRA_DIST =3D src/controlbase.ui src/GSMSpecification.xml
 =

 MAINTAINERCLEANFILES =3D Makefile.in \
-	aclocal.m4 configure depcomp missing install-sh
+	aclocal.m4 configure config.h.in depcomp missing install-sh
 =

 =

 $(src_phonesim_OBJECTS): src/ui_controlbase.h
diff --git a/bootstrap b/bootstrap
index 562c115..05eee20 100755
--- a/bootstrap
+++ b/bootstrap
@@ -1,3 +1,3 @@
 #!/bin/sh
 =

-aclocal && automake --add-missing --copy && autoconf
+aclocal && autoheader && automake --add-missing --copy && autoconf
diff --git a/configure.ac b/configure.ac
index 725ae7e..445a11c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,6 +2,7 @@ AC_PREREQ(2.60)
 AC_INIT(phonesim, 1.8)
 =

 AM_INIT_AUTOMAKE([foreign subdir-objects])
+AM_CONFIG_HEADER(config.h)
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

diff --git a/src/main.cpp b/src/main.cpp
index d7de416..6a00cb5 100644
--- a/src/main.cpp
+++ b/src/main.cpp
@@ -17,6 +17,10 @@
 **
 **************************************************************************=
**/
 =

+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <server.h>
 #include "control.h"
 #include <qapplication.h>
@@ -28,7 +32,7 @@ static void usage()
 {
     qWarning() << "Usage:"
                << QFileInfo(QCoreApplication::instance()->applicationFileP=
ath()).fileName().toLocal8Bit().constData()
-               << "[-p port] [-gui] filename";
+               << "[-v] [-p port] [-gui] filename";
     exit(-1);
 }
 =

@@ -43,7 +47,10 @@ int main(int argc, char **argv)
     // Parse the command-line.
     index =3D 1;
     for (index =3D 1; index < argc; index++) {
-        if (strcmp(argv[index],"-p") =3D=3D 0) {
+        if (strcmp(argv[index],"-v") =3D=3D 0) {
+            qWarning() << VERSION;
+            exit(0);
+        } else if (strcmp(argv[index],"-p") =3D=3D 0) {
             index++;
             if (index >=3D argc) {
                 qWarning() << "ERROR: Got -p but missing port number";
-- =

1.7.2.3


--===============5330340567976460738==--

