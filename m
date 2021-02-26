Content-Type: multipart/mixed; boundary="===============5592919087619849466=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCH] build: require glib >= 2.60
Date: Fri, 26 Feb 2021 05:41:17 +0000
Message-ID: <20210226054117.2871.32381@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5592919087619849466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Build failure in the latest version has occurred with glib 2.56.4.

src/simutil.c: In function =E2=80=98validate_utf8_tlv=E2=80=99:
src/simutil.c:779:9: error: implicit declaration of function
=E2=80=98g_utf8_validate_len=E2=80=99; did you mean =E2=80=98g_utf8_validat=
e=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  return g_utf8_validate_len((const char *)tlv + 2, len, NULL);
         ^~~~~~~~~~~~~~~~~~~
         g_utf8_validate


According to glib documentation, "g_utf8_validate_len" is supported since
2.60
So, I sent this patch.

Regards,
JongSeok Won

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

-PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
- AC_MSG_ERROR(GLib >=3D 2.32 is required))
+PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.60, dummy=3Dyes,
+ AC_MSG_ERROR(GLib >=3D 2.60 is required))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 --
--===============5592919087619849466==--

