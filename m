Content-Type: multipart/mixed; boundary="===============1031640548226074072=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH mmsd 2/3] build: Use libgdbus-internal.la
Date: Fri, 19 Jul 2013 16:33:06 -0300
Message-ID: <1374262387-27803-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1374262387-27803-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1031640548226074072==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lucas De Marchi <lucas.demarchi@intel.com>

With the current approach if we have different CFLAGS for each binary we
wou build gdbus several times for no reason.

Instead of prepending $(gdbus_sources) to several _SOURCES variable, use
a convenience library thas is used internally only, thus with a
"-internal" suffix.
---
 Makefile.am | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index ee2c715..f553f5b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,7 +1,10 @@
 =

 AM_MAKEFLAGS =3D --no-print-directory
 =

-gdbus_sources =3D gdbus/gdbus.h gdbus/mainloop.c gdbus/watch.c \
+noinst_LTLIBRARIES =3D gdbus/libgdbus-internal.la
+
+gdbus_libgdbus_internal_la_SOURCES =3D gdbus/gdbus.h \
+				gdbus/mainloop.c gdbus/watch.c \
 				gdbus/object.c gdbus/client.c gdbus/polkit.c
 =

 gweb_sources =3D gweb/gweb.h gweb/gweb.c gweb/gresolv.h gweb/gresolv.c \
@@ -17,14 +20,15 @@ builtin_sources +=3D plugins/ofono.c
 =

 libexec_PROGRAMS =3D src/mmsd
 =

-src_mmsd_SOURCES =3D $(gdbus_sources) $(gweb_sources) $(builtin_sources) \
+src_mmsd_SOURCES =3D $(gweb_sources) $(builtin_sources) \
 			src/main.c src/mms.h src/types.h \
 			src/log.h src/log.c src/plugin.h src/plugin.c \
 			src/dbus.h src/dbus.c src/service.h src/service.c \
 			src/push.h src/push.c src/store.h src/store.c \
 			src/wsputil.h src/wsputil.c src/mmsutil.h src/mmsutil.c
 =

-src_mmsd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ -lresolv -ldl
+src_mmsd_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
+			@GLIB_LIBS@ @DBUS_LIBS@ -lresolv -ldl
 =

 src_mmsd_LDFLAGS =3D -Wl,--export-dynamic
 =

-- =

1.8.3.3


--===============1031640548226074072==--

