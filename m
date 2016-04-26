Content-Type: multipart/mixed; boundary="===============8352493217648812961=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2 1/2] configure: Bump glib dependecy to 2.32
Date: Tue, 26 Apr 2016 06:19:38 +0000
Message-ID: <1461651574-31530-2-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461651574-31530-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8352493217648812961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

Needed to support g_queue_free_full
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f6253e5..88ac6db 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,8 +63,8 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 =

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.28, dummy=3Dyes,
-				AC_MSG_ERROR(GLib >=3D 2.28 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
+				AC_MSG_ERROR(GLib >=3D 2.32 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 =

-- =

1.9.1

--===============8352493217648812961==--

