Content-Type: multipart/mixed; boundary="===============2388164383944216661=="
MIME-Version: 1.0
From: Alfonso =?unknown-8bit?q?S=C3=A1nchez-Beato?= <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 3/4] build: add rilmodem gprs unit tests
Date: Mon, 24 Oct 2016 12:57:06 +0200
Message-ID: <20161024105707.7731-3-alfonsosanchezbeato@yahoo.es>
In-Reply-To: <20161024105707.7731-1-alfonsosanchezbeato@yahoo.es>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2388164383944216661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 16865ee..acd5083 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -775,7 +775,8 @@ unit_tests =3D unit/test-common unit/test-util unit/tes=
t-idmap \
 				unit/test-sms unit/test-cdmasms \
 				unit/test-rilmodem-cs \
 				unit/test-rilmodem-sms \
-				unit/test-rilmodem-cb
+				unit/test-rilmodem-cb \
+				unit/test-rilmodem-gprs
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -831,7 +832,10 @@ test_rilmodem_sources =3D $(gril_sources) src/log.c sr=
c/common.c src/util.c \
 				gatchat/ringbuffer.h gatchat/ringbuffer.c \
 				unit/rilmodem-test-server.h \
 				unit/rilmodem-test-server.c \
-				src/simutil.c
+				unit/rilmodem-test-engine.h \
+				unit/rilmodem-test-engine.c \
+				src/simutil.c \
+				drivers/rilmodem/rilutil.c
 =

 unit_test_rilmodem_cs_SOURCES =3D $(test_rilmodem_sources) \
 					unit/test-rilmodem-cs.c \
@@ -854,6 +858,13 @@ unit_test_rilmodem_cb_LDADD =3D gdbus/libgdbus-interna=
l.la $(builtin_libadd) \
 					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 unit_objects +=3D $(unit_test_rilmodem_cb_OBJECTS)
 =

+unit_test_rilmodem_gprs_SOURCES =3D $(test_rilmodem_sources) \
+					unit/test-rilmodem-gprs.c \
+					drivers/rilmodem/gprs.c
+unit_test_rilmodem_gprs_LDADD =3D gdbus/libgdbus-internal.la $(builtin_lib=
add) \
+					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilmodem_gprs_OBJECTS)
+
 TESTS =3D $(unit_tests)
 =

 if TOOLS
-- =

2.9.3


--===============2388164383944216661==--

