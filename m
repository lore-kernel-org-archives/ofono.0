Content-Type: multipart/mixed; boundary="===============8759690933787416107=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 3/3] Support for pkg-config
Date: Mon, 24 Jan 2011 14:50:50 +0200
Message-ID: <1295873450-5891-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1295873450-5891-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8759690933787416107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 .gitignore  |    1 +
 Makefile.am |   10 ++++++++--
 ofono.pc.in |   10 ++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)
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
index 1f09c11..e8570f8 100644
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
@@ -364,7 +367,7 @@ src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
 =

 BUILT_SOURCES =3D $(local_headers)
 =

-CLEANFILES =3D src/builtin.h $(BUILT_SOURCES) $(rules_DATA)
+CLEANFILES =3D src/builtin.h ofono.pc $(BUILT_SOURCES) $(rules_DATA)
 =

 plugindir =3D $(pkglibdir)/plugins
 =

@@ -477,7 +480,7 @@ testdir =3D $(pkglibdir)/test
 test_SCRIPTS =3D $(test_scripts)
 endif
 =

-EXTRA_DIST =3D src/genbuiltin $(udev_files) \
+EXTRA_DIST =3D src/genbuiltin ofono.pc.in $(udev_files) \
 					$(doc_files) $(test_scripts)
 =

 dist_man_MANS =3D doc/ofonod.8
@@ -572,5 +575,8 @@ include/ofono/%.h: include/%.h
 	$(AM_V_at)$(MKDIR_P) include/ofono
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 =

+%.pc: %.pc.in $(builddir)/config.status
+	$(AM_V_GEN)$(SHELL) ./config.status --file=3D$@ >/dev/null
+
 clean-local:
 	@$(RM) -rf include/ofono
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


--===============8759690933787416107==--

