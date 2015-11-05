Content-Type: multipart/mixed; boundary="===============3388547344652370047=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2] build: add support for unit/rilmodem-cs
Date: Thu, 05 Nov 2015 13:10:18 -0500
Message-ID: <1446747018-5885-3-git-send-email-espy@canonical.com>
In-Reply-To: <1446747018-5885-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3388547344652370047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 71c136d..57f65bb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -807,7 +807,8 @@ unit_tests =3D unit/test-common unit/test-util unit/tes=
t-idmap \
 				unit/test-mnclength \
 				unit/test-mtkrequest \
 				unit/test-mtkreply \
-				unit/test-mtkunsol
+				unit/test-mtkunsol \
+				unit/test-rilmodem-cs
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -903,6 +904,14 @@ unit_test_mnclength_SOURCES =3D unit/test-mnclength.c =
plugins/mnclength.c \
 unit_test_mnclength_LDADD =3D @GLIB_LIBS@ -ldl
 unit_objects +=3D $(unit_test_mnclength_OBJECTS)
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


--===============3388547344652370047==--

