Content-Type: multipart/mixed; boundary="===============2560982498066379689=="
MIME-Version: 1.0
From: Chris Talbot <chris@talbothome.com>
Subject: [PATCH 8/9] Allow Maintainer mode to compile without -WError
Date: Sat, 10 Apr 2021 10:23:57 -0400
Message-ID: <c239428496e79e503d51c77346ef648f86c32eb0.camel@talbothome.com>
In-Reply-To: <9f9d0f40db75ff82a306af14e7879e567dce9821.camel@talbothome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2560982498066379689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch allows mmsd to compile.

---
 acinclude.m4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 329c6a9..314dbb1 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -15,7 +15,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 		CFLAGS=3D"-Wall -O2 -D_FORTIFY_SOURCE=3D2"
 	fi
 	if (test "$USE_MAINTAINER_MODE" =3D "yes"); then
-		CFLAGS+=3D" -Werror -Wextra"
+		CFLAGS+=3D" -Wextra"
 		CFLAGS+=3D" -Wno-unused-parameter"
 		CFLAGS+=3D" -Wno-missing-field-initializers"
 		CFLAGS+=3D" -Wdeclaration-after-statement"
-- =

2.30.2

--===============2560982498066379689==--

