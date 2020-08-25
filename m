Content-Type: multipart/mixed; boundary="===============2138160339593382248=="
MIME-Version: 1.0
From: Nikhil Jha <hi@nikhiljha.com>
Subject: [PATCH 1/1] remove obsolete m4 macro
Date: Tue, 25 Aug 2020 13:12:39 -0700
Message-ID: <20200825201239.4254-1-hi@nikhiljha.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2138160339593382248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per https://www.gnu.org/software/libtool/manual/html_node/LT_005fINIT.ht=
ml
LT_INIT should be used instead.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3655a112..06ba5290 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,7 +28,7 @@ m4_define([_LT_AC_TAGCONFIG], [])
 m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 =

 AC_DISABLE_STATIC
-AC_PROG_LIBTOOL
+LT_INIT
 =

 AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
-- =

2.26.2

--===============2138160339593382248==--

