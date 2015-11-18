Content-Type: multipart/mixed; boundary="===============3933773791809899588=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2] build: add support for test-rilmodem-sms
Date: Tue, 17 Nov 2015 20:45:16 -0500
Message-ID: <1447811116-11970-3-git-send-email-espy@canonical.com>
In-Reply-To: <1447811116-11970-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3933773791809899588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index fba25ba..1cdfc1f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -740,7 +740,8 @@ unit_objects =3D
 unit_tests =3D unit/test-common unit/test-util unit/test-idmap \
 				unit/test-simutil unit/test-stkutil \
 				unit/test-sms unit/test-cdmasms \
-				unit/test-rilmodem-cs
+				unit/test-rilmodem-cs \
+				unit/test-rilmodem-sms
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -801,6 +802,17 @@ unit_test_rilmodem_cs_LDADD =3D gdbus/libgdbus-interna=
l.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 unit_objects +=3D $(unit_test_rilmodem_cs_OBJECTS)
 =

+unit_test_rilmodem_sms_SOURCES =3D unit/test-rilmodem-sms.c $(gril_sources=
) \
+			src/log.c src/common.c src/util.c \
+			gatchat/ringbuffer.h gatchat/ringbuffer.c \
+			drivers/rilmodem/sms.c \
+			unit/rilmodem-test-server.h \
+			unit/rilmodem-test-server.c \
+			src/simutil.c
+unit_test_rilmodem_sms_LDADD =3D gdbus/libgdbus-internal.la $(builtin_liba=
dd) \
+			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilmodem_sms_OBJECTS)
+
 TESTS =3D $(unit_tests)
 =

 if TOOLS
-- =

2.1.4


--===============3933773791809899588==--

