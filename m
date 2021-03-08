Content-Type: multipart/mixed; boundary="===============7320809227114186215=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] build: require glib >= 2.60
Date: Mon, 08 Mar 2021 18:33:14 +0900
Message-ID: <20210308093314.30554-1-wjs890204@gmail.com>
In-Reply-To: <CAKnLNuTVeg5pN-6w9-GQV=NLYOSf9ajG0V7b8oBbmLogXNH9Hw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7320809227114186215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

g_utf8_validate_len() is support after glib 2.60
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index d4efc8a8..f195c862 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,8 +63,8 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 =

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
-				AC_MSG_ERROR(GLib >=3D 2.32 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.60, dummy=3Dyes,
+				AC_MSG_ERROR(GLib >=3D 2.60 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 =

-- =

2.17.1

--===============7320809227114186215==--

