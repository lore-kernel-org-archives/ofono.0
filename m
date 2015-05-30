Content-Type: multipart/mixed; boundary="===============5102487635072732840=="
MIME-Version: 1.0
From: Sergey Alirzaev <zl29ah@gmail.com>
Subject: [PATCH] make it build against musl
Date: Sat, 30 May 2015 12:13:56 +0300
Message-ID: <1432977236-31669-1-git-send-email-zl29ah@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5102487635072732840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ifdef away GNU libc extensions and use a POSIXly correct pointer type
---
 gatchat/ppp_net.c | 2 +-
 src/log.c         | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
index 813ed9b..914ca53 100644
--- a/gatchat/ppp_net.c
+++ b/gatchat/ppp_net.c
@@ -67,7 +67,7 @@ gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu)
 	strncpy(ifr.ifr_name, net->if_name, sizeof(ifr.ifr_name));
 	ifr.ifr_mtu =3D mtu;
 =

-	err =3D ioctl(sk, SIOCSIFMTU, (caddr_t) &ifr);
+	err =3D ioctl(sk, SIOCSIFMTU, (void *) &ifr);
 =

 	close(sk);
 =

diff --git a/src/log.c b/src/log.c
index febc874..6331b0d 100644
--- a/src/log.c
+++ b/src/log.c
@@ -30,7 +30,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
+#ifdef __GLIBC__
 #include <execinfo.h>
+#endif
 #include <dlfcn.h>
 =

 #include "ofono.h"
@@ -113,6 +115,7 @@ void ofono_debug(const char *format, ...)
 	va_end(ap);
 }
 =

+#ifdef __GLIBC__
 static void print_backtrace(unsigned int offset)
 {
 	void *frames[99];
@@ -240,6 +243,7 @@ static void signal_setup(sighandler_t handler)
 	sigaction(SIGABRT, &sa, NULL);
 	sigaction(SIGPIPE, &sa, NULL);
 }
+#endif
 =

 extern struct ofono_debug_desc __start___debug[];
 extern struct ofono_debug_desc __stop___debug[];
@@ -305,7 +309,9 @@ int __ofono_log_init(const char *program, const char *d=
ebug,
 	if (detach =3D=3D FALSE)
 		option |=3D LOG_PERROR;
 =

+#ifdef __GLIBC__
 	signal_setup(signal_handler);
+#endif
 =

 	openlog(basename(program), option, LOG_DAEMON);
 =

@@ -320,7 +326,9 @@ void __ofono_log_cleanup(void)
 =

 	closelog();
 =

+#ifdef __GLIBC__
 	signal_setup(SIG_DFL);
+#endif
 =

 	g_strfreev(enabled);
 }
-- =

2.4.1


--===============5102487635072732840==--

