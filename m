Content-Type: multipart/mixed; boundary="===============6143014726290204706=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 1/2] unit: CAIF test: remove character dev tests and add RTNL.
Date: Sun, 21 Nov 2010 23:03:00 +0100
Message-ID: <1290376981-4248-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1290376981-4248-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6143014726290204706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

- Remove tests for CAIF Character device. Character devices are depreceated
and replaced with Sockets.
- Add RTNL Tests for creating and removing CAIF GPRS Network Interface.
---
 Makefile.am      |    4 +-
 unit/test-caif.c |  108 +++++++++++++++++++++++++++++++++++++-------------=
----
 2 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f841b4c..e505a39 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -474,7 +474,9 @@ unit_objects +=3D $(unit_test_mux_OBJECTS)
 =

 unit_test_caif_SOURCES =3D unit/test-caif.c $(gatchat_sources) \
 					drivers/stemodem/caif_socket.h \
-					drivers/stemodem/if_caif.h =

+					drivers/stemodem/caif_rtnl.c \
+					drivers/stemodem/caif_rtnl.h \
+					drivers/stemodem/if_caif.h
 unit_test_caif_LDADD =3D @GLIB_LIBS@
 unit_objects +=3D $(unit_test_caif_OBJECTS)
 =

diff --git a/unit/test-caif.c b/unit/test-caif.c
index 51e29bc..fdcdc3e 100644
--- a/unit/test-caif.c
+++ b/unit/test-caif.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ST-Ericsson AB.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -28,28 +29,26 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <net/if.h>
 =

 #include <glib.h>
 #include <glib/gprintf.h>
 =

 #include <gatchat.h>
-
+#include <ofono/log.h>
 #include <drivers/stemodem/caif_socket.h>
 #include <drivers/stemodem/if_caif.h>
+#include <drivers/stemodem/caif_rtnl.h>
 =

 static GMainLoop *mainloop;
 =

-static int do_open(void)
+void ofono_debug(const char *format, ...)
 {
-	int fd;
-
-	fd =3D open("/dev/chnlat11", O_RDWR);
-	if (fd < 0) {
-		g_printerr("Open of chnlat11 failed (%d)\n", errno);
-		return -EIO;
-	}
-
-	return fd;
+	va_list ap;
+	va_start(ap, format);
+	if (g_test_verbose())
+		vprintf(format, ap);
+	va_end(ap);
 }
 =

 static int do_connect(void)
@@ -58,7 +57,7 @@ static int do_connect(void)
 	int sk, err;
 =

 	/* Create a CAIF socket for AT Service */
-	sk =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
+	sk =3D socket(AF_CAIF, SOCK_STREAM, CAIFPROTO_AT);
 	if (sk < 0) {
 		g_printerr("CAIF socket creation failed (%d)\n", errno);
 		return -EIO;
@@ -81,7 +80,8 @@ static int do_connect(void)
 =

 static void caif_debug(const char *str, void *data)
 {
-	g_print("%s\n", str);
+	if (g_test_verbose())
+		g_print("CAIF:%s\n", str);
 }
 =

 static void caif_init(gboolean ok, GAtResult *result, gpointer data)
@@ -100,18 +100,15 @@ static void caif_init(gboolean ok, GAtResult *result,=
 gpointer data)
 	g_main_loop_quit(mainloop);
 }
 =

-static void test_connect(gboolean use_socket)
+static void test_connect()
 {
 	GIOChannel *io;
 	GAtChat *chat;
 	GAtSyntax *syntax;
 	int fd;
 =

-	if (use_socket =3D=3D TRUE)
-		fd =3D do_connect();
-	else
-		fd =3D do_open();
 =

+	fd =3D do_connect();
 	if (fd < 0)
 		return;
 =

@@ -138,34 +135,77 @@ static void test_connect(gboolean use_socket)
 	g_main_loop_unref(mainloop);
 }
 =

-static void test_basic(void)
+/* Storage for rtnl_callback data */
+static int rtnl_result;
+static int rtnl_ifi;
+static char rtnl_ifname[16];
+static void *rtnl_user_data;
+
+static void rtnl_create_cb(int ifindex, const char *ifname, void *user_dat=
a)
 {
-	if (g_test_trap_fork(60 * 1000 * 1000, 0) =3D=3D TRUE) {
-		test_connect(TRUE);
-		exit(0);
-	}
+	strcpy(rtnl_ifname, ifname);
+	rtnl_ifi =3D ifindex;
+	rtnl_user_data =3D user_data;
+}
+
+static void test_rtnl_normal()
+{
+	int res;
+	int connid =3D 1;
+
+	res =3D caif_rtnl_init();
+	res =3D caif_rtnl_create_interface(IFLA_CAIF_IPV4_CONNID, connid, FALSE,
+						rtnl_create_cb,
+						(void *)0xbaadf00d);
+	g_assert_cmpint(0, =3D=3D, res);
+
+	g_main_iteration(TRUE);
 =

-	g_test_trap_assert_passed();
-	//g_test_trap_assert_stderr("failed");
+	g_assert_cmpint(0, =3D=3D, rtnl_result);
+	g_assert((void *)0xbaadf00d =3D=3D rtnl_user_data);
+
+	res =3D caif_rtnl_delete_interface(rtnl_ifi);
+
+	g_main_iteration(TRUE);
+	g_assert_cmpint(0, =3D=3D, res);
+
+	caif_rtnl_exit();
 }
 =

-static void test_chnlat(void)
+static void test_rtnl_bad_delete()
 {
-	if (g_test_trap_fork(60 * 1000 * 1000, 0) =3D=3D TRUE) {
-		test_connect(FALSE);
-		exit(0);
-	}
+	int res;
 =

-	g_test_trap_assert_passed();
-	//g_test_trap_assert_stderr("failed");
+	res =3D caif_rtnl_init();
+	res =3D caif_rtnl_delete_interface(1000);
+	g_assert_cmpint(0, =3D=3D, res);
+
+	caif_rtnl_exit();
+}
+
+static void test_rtnl_einval()
+{
+	int res =3D caif_rtnl_init();
+
+	res =3D caif_rtnl_create_interface(__IFLA_CAIF_MAX, 0, FALSE, NULL,
+						(void *)0xbaadf00d);
+
+	g_assert_cmpint(-EINVAL, =3D=3D, res);
+
+	caif_rtnl_exit();
 }
 =

 int main(int argc, char **argv)
 {
+
+	g_print("This test must run as root (netadm capability)\n");
+
 	g_test_init(&argc, &argv, NULL);
 =

-	g_test_add_func("/testcaif/basic", test_basic);
-	g_test_add_func("/testcaif/chnlat", test_chnlat);
+	g_test_add_func("/testcaif/basic", test_connect);
+	g_test_add_func("/testcaif/basic", test_rtnl_normal);
+	g_test_add_func("/testcaif/basic", test_rtnl_bad_delete);
+	g_test_add_func("/testcaif/basic", test_rtnl_einval);
 =

 	return g_test_run();
 }
-- =

1.7.0.4


--===============6143014726290204706==--

