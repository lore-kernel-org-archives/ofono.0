Content-Type: multipart/mixed; boundary="===============8692679151828690713=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] build-sys: Use libgdbus-internal.la
Date: Wed, 03 Jul 2013 09:49:36 -0300
Message-ID: <1372855776-24235-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8692679151828690713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.demarchi@intel.com>

With the current approach if we have different CFLAGS for each binary we wo=
uld
build gdbus several times for no reason.

Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
a convenience library thas is used internally only, thus with a "-internal"
suffix.
---
 Makefile.am | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index cc763b8..d0823b0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,6 +1,8 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

+noinst_LTLIBRARIES =3D
+
 pkginclude_HEADERS =3D include/log.h include/plugin.h include/history.h \
 			include/dbus.h include/modem.h include/types.h \
 			include/call-barring.h include/call-forwarding.h \
@@ -486,9 +488,14 @@ builtin_sources +=3D plugins/smart-messaging.c
 builtin_modules +=3D push_notification
 builtin_sources +=3D plugins/push-notification.c
 =

+noinst_LTLIBRARIES +=3D gdbus/libgdbus-internal.la
+gdbus_libgdbus_internal_la_SOURCES =3D $(gdbus_sources)
+gdbus_libgdbus_internal_la_LDFLAGS =3D $(AM_LDFLAGS) @DBUS_LIBS@ @GLIB_LIB=
S@
+gdbus_libgdbus_internal_la_CFLAGS =3D $(AM_CFLAGS) @DBUS_CFLAGS@ @GLIB_CFL=
AGS@
+
 sbin_PROGRAMS =3D src/ofonod
 =

-src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sources) src/ofono.ver \
+src_ofonod_SOURCES =3D $(builtin_sources) src/ofono.ver \
 			src/main.c src/ofono.h src/log.c src/plugin.c \
 			src/modem.c src/common.h src/common.c \
 			src/manager.c src/dbus.c src/util.h src/util.c \
@@ -515,7 +522,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h
 =

-src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
+src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
+			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

 src_ofonod_LDFLAGS =3D -Wl,--export-dynamic \
 				-Wl,--version-script=3D$(srcdir)/src/ofono.ver
@@ -724,11 +732,11 @@ noinst_PROGRAMS +=3D tools/huawei-audio tools/auto-en=
able \
 			tools/get-location tools/lookup-apn \
 			tools/lookup-provider-name tools/tty-redirector
 =

-tools_huawei_audio_SOURCES =3D $(gdbus_sources) tools/huawei-audio.c
-tools_huawei_audio_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+tools_huawei_audio_SOURCES =3D tools/huawei-audio.c
+tools_huawei_audio_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_=
LIBS@
 =

-tools_auto_enable_SOURCES =3D $(gdbus_sources) tools/auto-enable.c
-tools_auto_enable_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+tools_auto_enable_SOURCES =3D tools/auto-enable.c
+tools_auto_enable_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_L=
IBS@
 =

 tools_get_location_SOURCES =3D tools/get-location.c
 tools_get_location_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
@@ -753,9 +761,9 @@ endif
 if MAINTAINER_MODE
 noinst_PROGRAMS +=3D tools/stktest
 =

-tools_stktest_SOURCES =3D $(gatchat_sources) $(gdbus_sources) tools/stktes=
t.c \
+tools_stktest_SOURCES =3D $(gatchat_sources) tools/stktest.c \
 				unit/stk-test-data.h
-tools_stktest_LDADD =3D @GLIB_LIBS@ @DBUS_LIBS@
+tools_stktest_LDADD =3D gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 endif
 endif
 =

@@ -763,11 +771,12 @@ if BLUETOOTH
 if DUNDEE
 sbin_PROGRAMS +=3D dundee/dundee
 =

-dundee_common_sources =3D $(gdbus_sources) $(gatchat_sources) \
+dundee_common_sources =3D $(gatchat_sources) \
 			src/log.c src/dbus.c dundee/dundee.h dundee/main.c \
 			dundee/dbus.c dundee/manager.c dundee/device.c
 =

-dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -ldl
+dundee_dundee_LDADD =3D $(builtin_libadd) gdbus/libgdbus-internal.la \
+			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 =

 if DATAFILES
 dist_dbusconf_DATA +=3D dundee/dundee.conf
-- =

1.8.3.2


--===============8692679151828690713==--

