Content-Type: multipart/mixed; boundary="===============7766640608844105141=="
MIME-Version: 1.0
From: Christopher Talbot <chris@talbothome.com>
Subject: [PATCH 8/9] Allow Maintainer mode to compile without -WError
Date: Wed, 24 Feb 2021 19:48:53 -0500
Message-ID: <4c2893b067fba752d66d62778cd188579d77fe4a.camel@talbothome.com>
In-Reply-To: <20210225003933.2871.63570@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7766640608844105141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without this, compiling in maintainer mode errors out.

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

--===============7766640608844105141==--

