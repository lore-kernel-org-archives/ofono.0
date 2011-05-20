Content-Type: multipart/mixed; boundary="===============6741685235099154634=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 7/7] add -Wno-unused-but-set-variable to CFLAGS
Date: Fri, 20 May 2011 16:03:45 -0300
Message-ID: <1305918225-8438-7-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-6-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6741685235099154634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 acinclude.m4 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index ac29c2b..18c019d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -17,6 +17,7 @@ AC_DEFUN([COMPILER_FLAGS], [
 	if (test "$USE_MAINTAINER_MODE" =3D "yes"); then
 		CFLAGS=3D"$CFLAGS -Werror -Wextra"
 		CFLAGS=3D"$CFLAGS -Wno-unused-parameter"
+		CFLAGS=3D"$CFLAGS -Wno-unused-but-set-variable"
 		CFLAGS=3D"$CFLAGS -Wno-missing-field-initializers"
 		CFLAGS=3D"$CFLAGS -Wdeclaration-after-statement"
 		CFLAGS=3D"$CFLAGS -Wmissing-declarations"
-- =

1.7.5.1


--===============6741685235099154634==--

