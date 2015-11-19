Content-Type: multipart/mixed; boundary="===============8780695444494780363=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 4/4 v2] build: update for test-rilmodem-cs changes
Date: Thu, 19 Nov 2015 17:21:31 -0500
Message-ID: <1447971691-22662-5-git-send-email-espy@canonical.com>
In-Reply-To: <1447971691-22662-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8780695444494780363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 1cdfc1f..a519fbb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -793,24 +793,24 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat=
_sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

-unit_test_rilmodem_cs_SOURCES =3D unit/test-rilmodem-cs.c $(gril_sources) \
-			src/log.c src/common.c src/util.c \
-			gatchat/ringbuffer.h gatchat/ringbuffer.c \
-			drivers/rilmodem/call-settings.c \
-			src/simutil.c
+test_rilmodem_sources =3D $(gril_sources) src/log.c src/common.c src/util.=
c \
+				gatchat/ringbuffer.h gatchat/ringbuffer.c \
+				unit/rilmodem-test-server.h \
+				unit/rilmodem-test-server.c \
+				src/simutil.c
+
+unit_test_rilmodem_cs_SOURCES =3D $(test_rilmodem_sources) \
+					unit/test-rilmodem-cs.c \
+					drivers/rilmodem/call-settings.c \
 unit_test_rilmodem_cs_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libad=
d) \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 unit_objects +=3D $(unit_test_rilmodem_cs_OBJECTS)
 =

-unit_test_rilmodem_sms_SOURCES =3D unit/test-rilmodem-sms.c $(gril_sources=
) \
-			src/log.c src/common.c src/util.c \
-			gatchat/ringbuffer.h gatchat/ringbuffer.c \
-			drivers/rilmodem/sms.c \
-			unit/rilmodem-test-server.h \
-			unit/rilmodem-test-server.c \
-			src/simutil.c
+unit_test_rilmodem_sms_SOURCES =3D $(test_rilmodem_sources) \
+					unit/test-rilmodem-sms.c
+					drivers/rilmodem/sms.c \
 unit_test_rilmodem_sms_LDADD =3D gdbus/libgdbus-internal.la $(builtin_liba=
dd) \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 unit_objects +=3D $(unit_test_rilmodem_sms_OBJECTS)
 =

 TESTS =3D $(unit_tests)
-- =

2.1.4


--===============8780695444494780363==--

