Content-Type: multipart/mixed; boundary="===============8113238347155510818=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/4] Remove unused threading support
Date: Sun, 04 Feb 2018 23:55:49 +0100
Message-ID: <20180204225550.10977-3-jonas@southpole.se>
In-Reply-To: <20180204225550.10977-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8113238347155510818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Threads are not used anywhere within ofono so there's no point in having a
configure option to enable threading in GLib or DBus.  I think this is most=
ly
a leftover from when ofono underwent mitosis from Connman...? :)
---
 configure.ac         |  8 --------
 src/main.c           | 12 ------------
 tools/auto-enable.c  | 12 ------------
 tools/huawei-audio.c | 12 ------------
 4 files changed, 44 deletions(-)

diff --git a/configure.ac b/configure.ac
index 79436adc..a22b0b11 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,14 +68,6 @@ PKG_CHECK_MODULES(GLIB, glib-2.0 >=3D 2.32, dummy=3Dyes,
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 =

-if (test "${enable_threads}" =3D "yes"); then
-	AC_DEFINE(NEED_THREADS, 1, [Define if threading support is required])
-	PKG_CHECK_MODULES(GTHREAD, gthread-2.0 >=3D 2.16, dummy=3Dyes,
-				AC_MSG_ERROR(GThread >=3D 2.16 is required))
-	GLIB_CFLAGS=3D"$GLIB_CFLAGS $GTHREAD_CFLAGS"
-	GLIB_LIBS=3D"$GLIB_LIBS $GTHREAD_LIBS"
-fi
-
 PKG_CHECK_MODULES(DBUS, dbus-1 >=3D 1.4, dummy=3Dyes,
 				AC_MSG_ERROR(D-Bus >=3D 1.4 is required))
 AC_SUBST(DBUS_CFLAGS)
diff --git a/src/main.c b/src/main.c
index 2d359dde..2c1b23a0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -211,11 +211,6 @@ int main(int argc, char **argv)
 	struct ell_event_source *source;
 #endif
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

@@ -246,13 +241,6 @@ int main(int argc, char **argv)
 =

 	event_loop =3D g_main_loop_new(NULL, FALSE);
 =

-#ifdef NEED_THREADS
-	if (dbus_threads_init_default() =3D=3D FALSE) {
-		fprintf(stderr, "Can't init usage of threads\n");
-		exit(1);
-	}
-#endif
-
 #ifdef HAVE_ELL
 	l_log_set_stderr();
 	l_debug_enable("*");
diff --git a/tools/auto-enable.c b/tools/auto-enable.c
index 87fb0a8d..1fb23401 100644
--- a/tools/auto-enable.c
+++ b/tools/auto-enable.c
@@ -492,11 +492,6 @@ int main(int argc, char **argv)
 	guint watch;
 	struct sigaction sa;
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

@@ -518,13 +513,6 @@ int main(int argc, char **argv)
 =

 	main_loop =3D g_main_loop_new(NULL, FALSE);
 =

-#ifdef NEED_THREADS
-	if (dbus_threads_init_default() =3D=3D FALSE) {
-		fprintf(stderr, "Can't init usage of threads\n");
-		exit(1);
-	}
-#endif
-
 	dbus_error_init(&err);
 =

 	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
diff --git a/tools/huawei-audio.c b/tools/huawei-audio.c
index 9997a581..b22b50a3 100644
--- a/tools/huawei-audio.c
+++ b/tools/huawei-audio.c
@@ -775,11 +775,6 @@ int main(int argc, char **argv)
 	guint watch;
 	struct sigaction sa;
 =

-#ifdef NEED_THREADS
-	if (g_thread_supported() =3D=3D FALSE)
-		g_thread_init(NULL);
-#endif
-
 	context =3D g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 =

@@ -801,13 +796,6 @@ int main(int argc, char **argv)
 =

 	main_loop =3D g_main_loop_new(NULL, FALSE);
 =

-#ifdef NEED_THREADS
-	if (dbus_threads_init_default() =3D=3D FALSE) {
-		fprintf(stderr, "Can't init usage of threads\n");
-		exit(1);
-	}
-#endif
-
 	dbus_error_init(&err);
 =

 	conn =3D g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
-- =

2.14.1


--===============8113238347155510818==--

