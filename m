Content-Type: multipart/mixed; boundary="===============8149173082062331969=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: [PATCH] Autotool improvements.
Date: Thu, 08 Oct 2009 19:51:31 +0300
Message-ID: <1255020691-30867-1-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8149173082062331969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Bootstrap script now tries to use explicitly versioned automake, which makes
life easier with scratchbox and friends. Bootstrap also uses autoreconf
instead of explictly running various autotools.
---
 Makefile.am  |    2 ++
 bootstrap    |   38 +++++++++++++++++++++++++++++++++-----
 configure.ac |    3 ++-
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cf84bf7..9ade516 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,8 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

+ACLOCAL_AMFLAGS =3D -I m4
+
 includedir =3D @includedir@/ofono
 =

 include_HEADERS =3D include/log.h include/plugin.h include/history.h \
diff --git a/bootstrap b/bootstrap
index 053f5c8..c751b3c 100755
--- a/bootstrap
+++ b/bootstrap
@@ -1,7 +1,35 @@
 #!/bin/sh
 =

-aclocal && \
-    autoheader && \
-        libtoolize --automake --copy --force &&
-	    automake --add-missing --copy && \
-		autoconf
+if test -z "$AUTOMAKE"
+then
+    for version in 1.10 1.11 1.12
+    do =

+	if which automake-$version > /dev/null
+	then
+	    AUTOMAKE=3Dautomake-$version ACLOCAL=3Daclocal-$version
+	    export AUTOMAKE ACLOCAL
+	    break
+	fi
+   done
+fi
+
+if test -z "$AUTOMAKE"
+then
+    for version in 1.10 1.11 1.12
+    do =

+	if automake --version | head -1 | fgrep -q $version
+	then
+	    AUTOMAKE=3Dautomake ACLOCAL=3Daclocal
+	    export AUTOMAKE ACLOCAL
+	fi
+    done
+fi
+
+# Remove libtool files (in case they conflict with older libtool)
+rm -f m4/libtool.m4 \
+      m4/lt~obsolete.m4 \
+      m4/ltoptions.m4 \
+      m4/ltsugar.m4 \
+      m4/ltversion.m4
+
+autoreconf --install --force "$@"
diff --git a/configure.ac b/configure.ac
index 4cc4449..55fd281 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,8 +1,9 @@
 AC_PREREQ(2.60)
 AC_INIT(ofono, 0.7)
 =

-AM_INIT_AUTOMAKE([foreign subdir-objects])
+AM_INIT_AUTOMAKE([foreign subdir-objects 1.10])
 AM_CONFIG_HEADER(config.h)
+AC_CONFIG_MACRO_DIR([m4])
 =

 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 =

-- =

1.6.0.4


--===============8149173082062331969==--

