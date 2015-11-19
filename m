Content-Type: multipart/mixed; boundary="===============6871370967848393626=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: [PATCH 2/2] build: update for test-rilmodem-cs changes
Date: Wed, 18 Nov 2015 19:17:43 -0500
Message-ID: <1447892263-18947-3-git-send-email-espy@canonical.com>
In-Reply-To: <1447892263-18947-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6871370967848393626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 1cdfc1f..6c052bd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -797,6 +797,8 @@ unit_test_rilmodem_cs_SOURCES =3D unit/test-rilmodem-cs=
.c $(gril_sources) \
 			src/log.c src/common.c src/util.c \
 			gatchat/ringbuffer.h gatchat/ringbuffer.c \
 			drivers/rilmodem/call-settings.c \
+			unit/rilmodem-test-server.h \
+			unit/rilmodem-test-server.c \
 			src/simutil.c
 unit_test_rilmodem_cs_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libad=
d) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
-- =

2.1.4


--===============6871370967848393626==--

