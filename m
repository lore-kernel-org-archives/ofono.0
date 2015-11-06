Content-Type: multipart/mixed; boundary="===============3121537531478888905=="
MIME-Version: 1.0
From: Petr Vorel <petr.vorel@gmail.com>
Subject: [PATCH 1/2] configure.ac: rewrite support for backtrace detection
Date: Fri, 06 Nov 2015 18:34:16 +0100
Message-ID: <1446831257-26136-1-git-send-email-petr.vorel@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3121537531478888905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac | 4 ++++
 src/log.c    | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index b8d42c8..b6183a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -245,3 +245,7 @@ AC_DEFINE_UNQUOTED(CONFIGDIR, "${configdir}",
 =

 AC_OUTPUT(Makefile include/version.h src/ofono.service ofono.pc \
 		dundee/dundee.service)
+
+dnl Check for backtrace() support
+AC_CHECK_HEADERS(execinfo.h)
+AC_CHECK_FUNCS(backtrace)
diff --git a/src/log.c b/src/log.c
index 6331b0d..0d55d6e 100644
--- a/src/log.c
+++ b/src/log.c
@@ -30,7 +30,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
-#ifdef __GLIBC__
+#ifdef HAVE_EXECINFO_H
 #include <execinfo.h>
 #endif
 #include <dlfcn.h>
@@ -115,7 +115,7 @@ void ofono_debug(const char *format, ...)
 	va_end(ap);
 }
 =

-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 static void print_backtrace(unsigned int offset)
 {
 	void *frames[99];
@@ -309,7 +309,7 @@ int __ofono_log_init(const char *program, const char *d=
ebug,
 	if (detach =3D=3D FALSE)
 		option |=3D LOG_PERROR;
 =

-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 	signal_setup(signal_handler);
 #endif
 =

@@ -326,7 +326,7 @@ void __ofono_log_cleanup(void)
 =

 	closelog();
 =

-#ifdef __GLIBC__
+#ifdef HAVE_BACKTRACE
 	signal_setup(SIG_DFL);
 #endif
 =

-- =

2.6.2


--===============3121537531478888905==--

