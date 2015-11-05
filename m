Content-Type: multipart/mixed; boundary="===============0342183135715198955=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2 v3] build: add support for rilmodem-cs test
Date: Thu, 05 Nov 2015 15:38:12 -0500
Message-ID: <1446755892-3370-2-git-send-email-espy@canonical.com>
In-Reply-To: <1446755892-3370-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0342183135715198955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 3ad1302..c4eda2a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -735,7 +735,8 @@ unit_objects =3D
 =

 unit_tests =3D unit/test-common unit/test-util unit/test-idmap \
 				unit/test-simutil unit/test-stkutil \
-				unit/test-sms unit/test-cdmasms
+				unit/test-sms unit/test-cdmasms \
+				unit/test-rilmodem-cs
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -787,6 +788,14 @@ unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_=
sources) \
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

+unit_test_rilmodem_cs_SOURCES =3D unit/test-rilmodem-cs.c $(gril_sources) \
+			src/log.c src/common.c src/util.c \
+			drivers/rilmodem/call-settings.c \
+			src/simutil.c gatchat/ringbuffer.c
+unit_test_rilmodem_cs_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libad=
d) \
+			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilmodem_cs_OBJECTS)
+
 TESTS =3D $(unit_tests)
 =

 if TOOLS
-- =

2.1.4


--===============0342183135715198955==--

