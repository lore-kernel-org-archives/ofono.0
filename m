Content-Type: multipart/mixed; boundary="===============4997658892944643898=="
MIME-Version: 1.0
From: Marko Sulejic <marko.sulejic@hale.at>
Subject: [PATCH] configure.ac: Little typo.
Date: Fri, 03 Jul 2015 11:51:50 +0200
Message-ID: <1435917110-3213-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4997658892944643898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 8cfaf4e..450cac1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -188,7 +188,7 @@ AC_ARG_WITH([provisiondb], AC_HELP_STRING([--with-provi=
siondb=3DFILE],
 	[location of provision database]), [path_provisiondb=3D${withval}])
 =

 AC_ARG_ENABLE(provision, AC_HELP_STRING([--disable-provision],
-				[disable provisioning suport]),
+				[disable provisioning support]),
 					[enable_provision=3D${enableval}])
 if (test "${enable_provision}" !=3D "no"); then
 	if (test -n "${path_provisiondb}"); then
-- =

2.1.0


--===============4997658892944643898==--

