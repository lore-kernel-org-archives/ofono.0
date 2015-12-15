Content-Type: multipart/mixed; boundary="===============8257173034412968935=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 3/3] build: add support for new test-rilmodem-cb
Date: Tue, 15 Dec 2015 11:34:35 -0500
Message-ID: <1450197275-5463-3-git-send-email-espy@canonical.com>
In-Reply-To: <1450197275-5463-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8257173034412968935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b2904ba..5f5b64a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -737,7 +737,8 @@ unit_tests =3D unit/test-common unit/test-util unit/tes=
t-idmap \
 				unit/test-simutil unit/test-stkutil \
 				unit/test-sms unit/test-cdmasms \
 				unit/test-rilmodem-cs \
-				unit/test-rilmodem-sms
+				unit/test-rilmodem-sms \
+				unit/test-rilmodem-cb
 =

 noinst_PROGRAMS =3D $(unit_tests) \
 			unit/test-sms-root unit/test-mux unit/test-caif
@@ -809,6 +810,13 @@ unit_test_rilmodem_sms_LDADD =3D gdbus/libgdbus-intern=
al.la $(builtin_libadd) \
 					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
 unit_objects +=3D $(unit_test_rilmodem_sms_OBJECTS)
 =

+unit_test_rilmodem_cb_SOURCES =3D $(test_rilmodem_sources) \
+					unit/test-rilmodem-cb.c \
+					drivers/rilmodem/call-barring.c
+unit_test_rilmodem_cb_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libad=
d) \
+					@GLIB_LIBS@ @DBUS_LIBS@ -ldl
+unit_objects +=3D $(unit_test_rilmodem_cb_OBJECTS)
+
 TESTS =3D $(unit_tests)
 =

 if TOOLS
-- =

2.1.4


--===============8257173034412968935==--

