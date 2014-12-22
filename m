Content-Type: multipart/mixed; boundary="===============5503404653137732853=="
MIME-Version: 1.0
From: You-Sheng Yang <vicamo@gmail.com>
Subject: [PATCH 3/3] build: accommodate to headers move
Date: Tue, 23 Dec 2014 00:07:48 +0800
Message-ID: <1419264468-22351-3-git-send-email-vicamo@gmail.com>
In-Reply-To: <1419264468-22351-1-git-send-email-vicamo@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5503404653137732853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: You-Sheng Yang <vicamo@gmail.com>

diff --git a/.gitignore b/.gitignore
index b9c23a0..401a0f3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -21,18 +21,17 @@ libtool
 ltmain.sh
 missing
 stamp-h1
 autom4te.cache
 test-driver
 test-suite.log
 =

 ofono.pc
-include/ofono
-include/version.h
+include/ofono/version.h
 src/builtin.h
 src/ofonod
 src/ofono.service
 dundee/dundee
 dundee/dundee.service
 =

 unit/test-common
 unit/test-util
diff --git a/Makefile.am b/Makefile.am
index 6729e9b..c6966de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,62 +1,58 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

 noinst_LTLIBRARIES =3D
 =

 pkginclude_HEADERS =3D \
-	include/audio-settings.h \
-	include/call-barring.h \
-	include/call-forwarding.h \
-	include/call-meter.h \
-	include/call-settings.h \
-	include/call-volume.h \
-	include/cbs.h \
-	include/cdma-connman.h \
-	include/cdma-netreg.h \
-	include/cdma-provision.h \
-	include/cdma-sms.h \
-	include/cdma-voicecall.h \
-	include/ctm.h \
-	include/dbus.h \
-	include/devinfo.h \
-	include/emulator.h \
-	include/gnss.h \
-	include/gprs-context.h \
-	include/gprs-provision.h \
-	include/gprs.h \
-	include/handsfree-audio.h \
-	include/handsfree.h \
-	include/history.h \
-	include/location-reporting.h \
-	include/log.h \
-	include/message-waiting.h \
-	include/modem.h \
-	include/netreg.h \
-	include/nettime.h \
-	include/phonebook.h \
-	include/plugin.h \
-	include/private-network.h \
-	include/radio-settings.h \
-	include/sim-auth.h \
-	include/sim.h \
-	include/siri.h \
-	include/sms.h \
-	include/stk.h \
-	include/types.h \
-	include/ussd.h \
-	include/voicecall.h
+	include/ofono/audio-settings.h \
+	include/ofono/call-barring.h \
+	include/ofono/call-forwarding.h \
+	include/ofono/call-meter.h \
+	include/ofono/call-settings.h \
+	include/ofono/call-volume.h \
+	include/ofono/cbs.h \
+	include/ofono/cdma-connman.h \
+	include/ofono/cdma-netreg.h \
+	include/ofono/cdma-provision.h \
+	include/ofono/cdma-sms.h \
+	include/ofono/cdma-voicecall.h \
+	include/ofono/ctm.h \
+	include/ofono/dbus.h \
+	include/ofono/devinfo.h \
+	include/ofono/emulator.h \
+	include/ofono/gnss.h \
+	include/ofono/gprs-context.h \
+	include/ofono/gprs-provision.h \
+	include/ofono/gprs.h \
+	include/ofono/handsfree-audio.h \
+	include/ofono/handsfree.h \
+	include/ofono/history.h \
+	include/ofono/location-reporting.h \
+	include/ofono/log.h \
+	include/ofono/message-waiting.h \
+	include/ofono/modem.h \
+	include/ofono/netreg.h \
+	include/ofono/nettime.h \
+	include/ofono/phonebook.h \
+	include/ofono/plugin.h \
+	include/ofono/private-network.h \
+	include/ofono/radio-settings.h \
+	include/ofono/sim-auth.h \
+	include/ofono/sim.h \
+	include/ofono/siri.h \
+	include/ofono/sms.h \
+	include/ofono/stk.h \
+	include/ofono/types.h \
+	include/ofono/ussd.h \
+	include/ofono/voicecall.h
 =

 nodist_pkginclude_HEADERS =3D \
-	include/version.h
-
-local_headers =3D $(foreach file,$(pkginclude_HEADERS) \
-				$(nodist_pkginclude_HEADERS), \
-					include/ofono/$(notdir $(file)))
+	include/ofono/version.h
 =

 pkgconfigdir =3D $(libdir)/pkgconfig
 pkgconfig_DATA =3D ofono.pc
 =

 =

 if DATAFILES
 dbusconfdir =3D @DBUS_CONFDIR@
 =

@@ -698,17 +694,16 @@ src_ofonod_LDADD =3D \
 	@DBUS_LIBS@ \
 	-ldl
 =

 src_ofonod_LDFLAGS =3D \
 	-Wl,--export-dynamic \
 	-Wl,--version-script=3D$(srcdir)/src/ofono.ver
 =

 BUILT_SOURCES =3D \
-	$(local_headers) \
 	src/builtin.h
 =

 CLEANFILES =3D \
 	$(BUILT_SOURCES) \
 	$(rules_DATA)
 =

 plugindir =3D $(pkglibdir)/plugins
 =

@@ -1124,19 +1119,8 @@ MAINTAINERCLEANFILES =3D \
 	mkinstalldirs
 =

 =

 src/builtin.h: src/genbuiltin config.status
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 =

 plugins/%.rules:
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
-
-include/ofono/version.h: include/version.h
-	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
-
-include/ofono/%.h: $(abs_top_srcdir)/include/%.h
-	$(AM_V_at)$(MKDIR_P) include/ofono
-	$(AM_V_GEN)$(LN_S) $< $@
-
-clean-local:
-	@$(RM) -rf include/ofono
diff --git a/configure.ac b/configure.ac
index 8cfaf4e..4483c4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -233,10 +233,10 @@ AC_DEFINE_UNQUOTED(STORAGEDIR, "${storagedir}",
 if (test "$sysconfdir" =3D '${prefix}/etc'); then
 	configdir=3D"${prefix}/etc/ofono"
 else
 	configdir=3D"${sysconfdir}/ofono"
 fi
 AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 			[Directory for the configuration files])
 =

-AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc \
+AC_OUTPUT(Makefile include/ofono/version.h src/ofono.service ofono.pc \
 		dundee/dundee.service)
-- =

2.1.4


--===============5503404653137732853==--

