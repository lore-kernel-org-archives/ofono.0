Content-Type: multipart/mixed; boundary="===============2228609098332962024=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v3 06/16] elect: Add skeleton implementation for device
Date: Tue, 13 Dec 2011 16:00:00 +0100
Message-ID: <1323788410-9988-7-git-send-email-wagi@monom.org>
In-Reply-To: <1323788410-9988-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2228609098332962024==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am    |    2 +-
 elect/device.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 elect/elect.h  |   15 ++++++++
 elect/main.c   |    4 ++-
 4 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 elect/device.c

diff --git a/Makefile.am b/Makefile.am
index 628cd0b..cdeab8d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,7 +653,7 @@ sbin_PROGRAMS +=3D elect/electd
 =

 elect_electd_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
-			elect/main.c elect/dbus.c elect/manager.c
+			elect/main.c elect/dbus.c elect/manager.c elect/device.c
 =

 elect_electd_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LI=
BS@ -ldl
 =

diff --git a/elect/device.c b/elect/device.c
new file mode 100644
index 0000000..1198083
--- /dev/null
+++ b/elect/device.c
@@ -0,0 +1,100 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <netinet/ether.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "elect.h"
+
+static GHashTable *device_hash;
+
+struct elect_device {
+};
+
+const char *__elect_device_get_path(struct elect_device *device)
+{
+	return "/";
+}
+
+void __elect_device_append_properties(struct elect_device *device,
+					DBusMessageIter *dict)
+{
+}
+
+void __elect_device_foreach(elect_device_foreach_func func, void *userdata)
+{
+	GHashTableIter iter;
+	gpointer key, value;
+
+	DBG("");
+
+	g_hash_table_iter_init(&iter, device_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value) =3D=3D TRUE) {
+		struct elect_device *device =3D value;
+
+		func(device, userdata);
+	}
+}
+
+static void destroy_device(gpointer user)
+{
+	struct elect_device *device =3D user;
+
+	g_free(device);
+}
+
+static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
+{
+}
+
+void __elect_device_shutdown(void)
+{
+	g_hash_table_foreach(device_hash, device_shutdown, NULL);
+
+	__elect_exit();
+}
+
+int __elect_device_init(void)
+{
+	DBG("");
+
+	device_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, destroy_device);
+
+	return 0;
+}
+
+void __elect_device_cleanup(void)
+{
+	DBG("");
+
+	g_hash_table_destroy(device_hash);
+}
diff --git a/elect/elect.h b/elect/elect.h
index 8ecd694..3244a1e 100644
--- a/elect/elect.h
+++ b/elect/elect.h
@@ -54,3 +54,18 @@ DBusMessage *__elect_error_connection_refused(DBusMessag=
e *msg);
 =

 int __elect_manager_init(void);
 void __elect_manager_cleanup(void);
+
+
+struct elect_device;
+
+int __elect_device_init(void);
+void __elect_device_cleanup(void);
+void __elect_device_shutdown(void);
+
+typedef void (*elect_device_foreach_func)(struct elect_device *device,
+						void *data);
+void __elect_device_foreach(elect_device_foreach_func cb, void *userdata);
+
+const char *__elect_device_get_path(struct elect_device *device);
+void __elect_device_append_properties(struct elect_device *device,
+					DBusMessageIter *dict);
diff --git a/elect/main.c b/elect/main.c
index 66c3ea9..16303d5 100644
--- a/elect/main.c
+++ b/elect/main.c
@@ -80,7 +80,7 @@ static gboolean signal_handler(GIOChannel *channel, GIOCo=
ndition cond,
 			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
 						quit_eventloop, NULL);
 =

-			quit_eventloop(NULL);
+			__elect_device_shutdown();
 		}
 =

 		__terminated =3D 1;
@@ -233,9 +233,11 @@ int main(int argc, char **argv)
 	__ofono_dbus_init(conn);
 =

 	__elect_manager_init();
+	__elect_device_init();
 =

 	g_main_loop_run(event_loop);
 =

+	__elect_device_cleanup();
 	__elect_manager_cleanup();
 =

 	__ofono_dbus_cleanup();
-- =

1.7.8.110.g4cb5d1


--===============2228609098332962024==--

