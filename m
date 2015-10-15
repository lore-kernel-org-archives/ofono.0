Content-Type: multipart/mixed; boundary="===============3807158695522685149=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 09/10] build: Add rilmodem unit tests
Date: Thu, 15 Oct 2015 18:47:02 +0200
Message-ID: <1444927623-31141-10-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444927623-31141-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3807158695522685149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 35ec7ce..4f895f1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -739,7 +739,10 @@ unit_objects =3D
 =

 unit_tests =3D unit/test-common unit/test-util unit/test-idmap \
 				unit/test-simutil unit/test-stkutil \
-				unit/test-sms unit/test-cdmasms
+				unit/test-sms unit/test-cdmasms \
+				unit/test-rilreply \
+				unit/test-rilrequest \
+				unit/test-rilunsol
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -791,6 +794,30 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_=
sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_rilrequest_SOURCES =3D unit/test-rilrequest.c $(gril_sources) \
+				drivers/rilmodem/rilrequest.c \
+				drivers/rilmodem/rilutil.c \
+                                src/log.c src/util.c src/simutil.c \
+                                src/common.c gatchat/ringbuffer.c
+unit_test_rilrequest_LDADD =3D @GLIB_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilrequest_OBJECTS)
+
+unit_test_rilreply_SOURCES =3D unit/test-rilreply.c $(gril_sources) \
+				drivers/rilmodem/rilreply.c \
+				drivers/rilmodem/rilutil.c \
+                                src/log.c src/util.c src/simutil.c \
+                                src/common.c gatchat/ringbuffer.c
+unit_test_rilreply_LDADD =3D @GLIB_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilreply_OBJECTS)
+
+unit_test_rilunsol_SOURCES =3D unit/test-rilunsol.c $(gril_sources) \
+				drivers/rilmodem/rilunsol.c \
+				drivers/rilmodem/rilutil.c \
+                                src/log.c src/util.c src/simutil.c \
+                                src/common.c gatchat/ringbuffer.c
+unit_test_rilunsol_LDADD =3D @GLIB_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilunsol_OBJECTS)
+
 TESTS =3D $(unit_tests)
 =

 if TOOLS
-- =

2.1.4


--===============3807158695522685149==--

