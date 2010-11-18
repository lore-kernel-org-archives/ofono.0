Content-Type: multipart/mixed; boundary="===============3559986318003810460=="
MIME-Version: 1.0
From: George Matveev <george@matveev.se>
Subject: [PATCH] build: Update glib version in configure.ac
Date: Thu, 18 Nov 2010 12:13:25 +0000
Message-ID: <1290082324-4816-1-git-send-email-george@matveev.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3559986318003810460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

function g_mkstemp_full in src/storage.c
requires glib version 2.22 or higher
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6aeab7c..c0f4217 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,8 +67,8 @@ AC_CHECK_LIB(c, signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 =

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.16, dummy=3Dyes,
-				AC_MSG_ERROR(GLib >=3D 2.16 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.22, dummy=3Dyes,
+				AC_MSG_ERROR(GLib >=3D 2.22 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 =

-- =

1.5.6.5


--===============3559986318003810460==--

