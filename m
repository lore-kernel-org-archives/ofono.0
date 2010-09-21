Content-Type: multipart/mixed; boundary="===============7489728029289681882=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Simplify linker script
Date: Tue, 21 Sep 2010 09:46:31 -0300
Message-ID: <1285073191-321-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7489728029289681882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Version linker scripts support function names and globs, so there's no
need to rely on nm tool to gather the exported symbols.
---
 .gitignore    |    2 --
 Makefile.am   |   12 +-----------
 configure.ac  |    3 ---
 src/ofono.ver |    7 +++++++
 4 files changed, 8 insertions(+), 16 deletions(-)
 create mode 100644 src/ofono.ver

diff --git a/.gitignore b/.gitignore
index 1ce7067..472522b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -27,8 +27,6 @@ include/ofono
 include/version.h
 src/builtin.h
 src/ofonod
-src/ofono.exp
-src/ofono.ver
 =

 unit/test-common
 unit/test-util
diff --git a/Makefile.am b/Makefile.am
index eda0250..702e308 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -300,8 +300,7 @@ src_ofonod_LDFLAGS =3D -Wl,--export-dynamic -Wl,--versi=
on-script=3Dsrc/ofono.ver
 =

 src_ofonod_DEPENDENCIES =3D src/ofono.ver
 =

-CLEANFILES =3D src/ofono.ver src/ofono.exp src/builtin.h \
-					$(local_headers) $(rules_DATA)
+CLEANFILES =3D src/builtin.h $(local_headers) $(rules_DATA)
 =

 plugindir =3D $(libdir)/ofono/plugins
 =

@@ -458,15 +457,6 @@ src/plugin.$(OBJEXT): src/builtin.h
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 =

-src/ofono.exp: $(src_ofonod_OBJECTS)
-	$(AM_V_GEN)$(NM) $^ | $(AWK) '{ print $$3 }' | sort -u | \
-				$(EGREP) -e '^ofono_' -e '^g_dbus_' > $@
-
-src/ofono.ver: src/ofono.exp
-	$(AM_V_at)echo "{ global:" > $@
-	$(AM_V_GEN)$(SED) -e "s/\(.*\)/\1;/" $< >> $@
-	$(AM_V_at)echo "local: *; };" >> $@
-
 plugins/%.rules:
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 =

diff --git a/configure.ac b/configure.ac
index 401a959..fb78a8e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -22,8 +22,6 @@ AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
 AC_PROG_INSTALL
-AC_PROG_SED
-AC_PROG_AWK
 AM_PROG_MKDIR_P
 =

 m4_define([_LT_AC_TAGCONFIG], [])
@@ -31,7 +29,6 @@ m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 =

 AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
-AC_PROG_NM
 =

 AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
diff --git a/src/ofono.ver b/src/ofono.ver
new file mode 100644
index 0000000..3dce6f3
--- /dev/null
+++ b/src/ofono.ver
@@ -0,0 +1,7 @@
+{
+	global:
+		ofono_*;
+		g_dbus_*;
+	local:
+		*;
+};
-- =

1.7.2.3


--===============7489728029289681882==--

