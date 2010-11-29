Content-Type: multipart/mixed; boundary="===============6452170877631796004=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] configure: do not hard-code the C run-time library name
Date: Mon, 29 Nov 2010 10:29:02 +0200
Message-ID: <1291019342-20747-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6452170877631796004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since oFono does (obviously) not use -nostdlib, this only broke support
for alternative C run-times.
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7f7a935..0c1986a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -61,7 +61,7 @@ AC_ARG_ENABLE(pie, AC_HELP_STRING([--enable-pie],
 AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 		[enable threading support]), [enable_threads=3D${enableval}])
 =

-AC_CHECK_LIB(c, signalfd, dummy=3Dyes,
+AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 			AC_MSG_ERROR(signalfd support is required))
 =

 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
-- =

1.7.1


--===============6452170877631796004==--

