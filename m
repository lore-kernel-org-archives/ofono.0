Content-Type: multipart/mixed; boundary="===============6022102502607957967=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 08/09] MMSD Allow Maintainer mode to compile without -WError
Date: Fri, 19 Feb 2021 01:06:45 +0000
Message-ID: <20210219010645.2937.3346@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6022102502607957967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Right now, MMSD will fail to compile in maintainer mode. I removed -WError =
to =

fix that.
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

2.30.0
--===============6022102502607957967==--

