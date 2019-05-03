Content-Type: multipart/mixed; boundary="===============4597641270541752052=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH] Makefile.am : Fix compilation with ell
Date: Fri, 03 May 2019 12:59:53 +0300
Message-ID: <20190503095953.26994-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4597641270541752052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix compilation issue with newer ell, which seems to have some
extra timeout handling.

  CC       ell/main.lo
ell/main.c:44:21: fatal error: timeout.h: No such file or directory
 #include "timeout.h"
                     ^
compilation terminated.
make[1]: *** [Makefile:4068: ell/main.lo] Error 1
make: *** [Makefile:2357: all] Error 2
---
 Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 21f776b6..f5453bed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -21,6 +21,7 @@ ell_headers =3D ell/util.h \
 			ell/strv.h \
 			ell/utf8.h \
 			ell/queue.h \
+			ell/timeout.h \
 			ell/main.h \
 			ell/idle.h \
 			ell/signal.h \
@@ -38,6 +39,7 @@ ell_sources =3D ell/private.h \
 			ell/strv.c \
 			ell/utf8.c \
 			ell/queue.c \
+			ell/timeout.c \
 			ell/main.c \
 			ell/idle.c \
 			ell/signal.c \
-- =

2.20.1


--===============4597641270541752052==--

