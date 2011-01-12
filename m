Content-Type: multipart/mixed; boundary="===============0154764013309665916=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 02/16] core: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:04 +0200
Message-ID: <1294829538-3893-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0154764013309665916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c    |    2 +-
 src/main.c    |    2 +-
 src/manager.c |    4 ++--
 src/modem.c   |    6 +++---
 src/ofono.h   |   12 ++++++------
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index b719217..01d43cf 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -415,7 +415,7 @@ gboolean __ofono_dbus_valid_object_path(const char *pat=
h)
 	return TRUE;
 }
 =

-DBusConnection *ofono_dbus_get_connection()
+DBusConnection *ofono_dbus_get_connection(void)
 {
 	return g_connection;
 }
diff --git a/src/main.c b/src/main.c
index 87fb0ab..3db8819 100644
--- a/src/main.c
+++ b/src/main.c
@@ -42,7 +42,7 @@
 =

 static GMainLoop *event_loop;
 =

-void __ofono_exit()
+void __ofono_exit(void)
 {
 	g_main_loop_quit(event_loop);
 }
diff --git a/src/manager.c b/src/manager.c
index 0649bcc..7075909 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -91,7 +91,7 @@ static GDBusSignalTable manager_signals[] =3D {
 	{ }
 };
 =

-int __ofono_manager_init()
+int __ofono_manager_init(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	gboolean ret;
@@ -107,7 +107,7 @@ int __ofono_manager_init()
 	return 0;
 }
 =

-void __ofono_manager_cleanup()
+void __ofono_manager_cleanup(void)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

diff --git a/src/modem.c b/src/modem.c
index 953d6c3..981aabc 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1560,12 +1560,12 @@ static void sim_watch(struct ofono_atom *atom,
 							modem, NULL);
 }
 =

-void __ofono_modemwatch_init()
+void __ofono_modemwatch_init(void)
 {
 	g_modemwatches =3D __ofono_watchlist_new(g_free);
 }
 =

-void __ofono_modemwatch_cleanup()
+void __ofono_modemwatch_cleanup(void)
 {
 	__ofono_watchlist_free(g_modemwatches);
 }
@@ -1850,7 +1850,7 @@ void ofono_modem_driver_unregister(const struct ofono=
_modem_driver *d)
 	}
 }
 =

-void __ofono_modem_shutdown()
+void __ofono_modem_shutdown(void)
 {
 	struct ofono_modem *modem;
 	GSList *l;
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..77567c2 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -25,12 +25,12 @@
 =

 #include <ofono/types.h>
 =

-void __ofono_exit();
+void __ofono_exit(void);
 =

-int __ofono_manager_init();
-void __ofono_manager_cleanup();
+int __ofono_manager_init(void);
+void __ofono_manager_cleanup(void);
 =

-void __ofono_modem_shutdown();
+void __ofono_modem_shutdown(void);
 =

 #include <ofono/log.h>
 =

@@ -174,8 +174,8 @@ void __ofono_atom_free(struct ofono_atom *atom);
 =

 typedef void (*ofono_modemwatch_cb_t)(struct ofono_modem *modem,
 					gboolean added, void *data);
-void __ofono_modemwatch_init();
-void __ofono_modemwatch_cleanup();
+void __ofono_modemwatch_init(void);
+void __ofono_modemwatch_cleanup(void);
 unsigned int __ofono_modemwatch_add(ofono_modemwatch_cb_t cb, void *user,
 					ofono_destroy_func destroy);
 gboolean __ofono_modemwatch_remove(unsigned int id);
-- =

1.7.0.4


--===============0154764013309665916==--

