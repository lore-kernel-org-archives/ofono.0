Content-Type: multipart/mixed; boundary="===============0316000491828067127=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] build: Fix build when optimization is disabled
Date: Wed, 28 Nov 2012 19:44:11 -0300
Message-ID: <1354142651-9023-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0316000491828067127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FORTIFY_SOURCE requires that optimization is enabled, and causes build
to fail when it isn't. For example, from config.log:

configure:12459: checking for signalfd
configure:12459: gcc -o conftest -Wall -O2 -D_FORTIFY_SOURCE=3D2 -Werror -W=
extra -Wno-unused-parameter -Wno-missing-field-initializers -Wdeclaration-a=
fter-statement -Wmissing-declarations -Wredundant-decls -Wcast-align -DG_DI=
SABLE_DEPRECATED -O0 -g   conftest.c  >&5
In file included from /usr/include/limits.h:26:0,
                 from /usr/lib64/gcc/x86_64-pc-linux-gnu/4.7.2/include-fixe=
d/limits.h:169,
                 from /usr/lib64/gcc/x86_64-pc-linux-gnu/4.7.2/include-fixe=
d/syslimits.h:7,
                 from /usr/lib64/gcc/x86_64-pc-linux-gnu/4.7.2/include-fixe=
d/limits.h:34,
                 from conftest.c:34:
/usr/include/features.h:330:4: error: #warning _FORTIFY_SOURCE requires com=
piling with optimization (-O) [-Werror=3Dcpp]
cc1: all warnings being treated as errors
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2d6247d..e284215 100644
--- a/configure.ac
+++ b/configure.ac
@@ -33,7 +33,7 @@ AC_PROG_LIBTOOL
 AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
 	if (test "${enableval}" =3D "no"); then
-		CFLAGS=3D"$CFLAGS -O0"
+		CFLAGS=3D"$CFLAGS -O0 -U_FORTIFY_SOURCE"
 	fi
 ])
 =

-- =

1.8.0


--===============0316000491828067127==--

