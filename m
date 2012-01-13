Content-Type: multipart/mixed; boundary="===============5360469841054132551=="
MIME-Version: 1.0
From: jc@eclis.ch
Subject: [PATCH] Add autoconfigure rule to search for backtrace().
Date: Fri, 13 Jan 2012 01:34:16 +0100
Message-ID: <1326414856-13932-1-git-send-email-jc@eclis.ch>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5360469841054132551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On system with the uClibc, it can be into the libubacktrace.
---
 configure.ac |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3bffbb9..98d9e67 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,10 @@ AC_CHECK_FUNC(signalfd, dummy=3Dyes,
 AC_CHECK_LIB(dl, dlopen, dummy=3Dyes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 =

+AC_SEARCH_LIBS([backtrace], [execinfo ubacktrace], [], [
+			AC_MSG_ERROR(backtrace support is required)
+])
+
 PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.22, dummy=3Dyes,
 				AC_MSG_ERROR(GLib >=3D 2.22 is required))
 AC_SUBST(GLIB_CFLAGS)
-- =

1.7.2.5


--===============5360469841054132551==--

