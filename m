Content-Type: multipart/mixed; boundary="===============3234322772226537406=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 09/16] dundee: Add skeleton implementation for device
Date: Tue, 22 May 2012 18:33:17 +0200
Message-ID: <1337704404-5260-10-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3234322772226537406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am     |    2 +-
 dundee/device.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 dundee/dundee.h |   15 +++++++++
 dundee/main.c   |    4 ++-
 4 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 dundee/device.c

diff --git a/Makefile.am b/Makefile.am
index 00e1118..1e0934d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -690,7 +690,7 @@ sbin_PROGRAMS +=3D dundee/dundee
 dundee_dundee_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
 			dundee/dundee.h dundee/main.c dundee/dbus.c \
-			dundee/manager.c
+			dundee/manager.c dundee/device.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

diff --git a/dundee/device.c b/dundee/device.c
new file mode 100644
index 0000000..d9fc928
--- /dev/null
+++ b/dundee/device.c
@@ -0,0 +1,100 @@
+/*
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2012  BMW Car IT GmbH. All rights reserved.
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
+#include "dundee.h"
+
+static GHashTable *device_hash;
+
+struct dundee_device {
+};
+
+const char *__dundee_device_get_path(struct dundee_device *device)
+{
+	return "/";
+}
+
+void __dundee_device_append_properties(struct dundee_device *device,
+					DBusMessageIter *dict)
+{
+}
+
+void __dundee_device_foreach(dundee_device_foreach_func func, void *userda=
ta)
+{
+	GHashTableIter iter;
+	gpointer key, value;
+
+	DBG("");
+
+	g_hash_table_iter_init(&iter, device_hash);
+
+	while (g_hash_table_iter_next(&iter, &key, &value) =3D=3D TRUE) {
+		struct dundee_device *device =3D value;
+
+		func(device, userdata);
+	}
+}
+
+static void destroy_device(gpointer user)
+{
+	struct dundee_device *device =3D user;
+
+	g_free(device);
+}
+
+static void device_shutdown(gpointer key, gpointer value, gpointer user_da=
ta)
+{
+}
+
+void __dundee_device_shutdown(void)
+{
+	g_hash_table_foreach(device_hash, device_shutdown, NULL);
+
+	__dundee_exit();
+}
+
+int __dundee_device_init(void)
+{
+	DBG("");
+
+	device_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, destroy_device);
+
+	return 0;
+}
+
+void __dundee_device_cleanup(void)
+{
+	DBG("");
+
+	g_hash_table_destroy(device_hash);
+}
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 3050baf..4f8aa10 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -53,3 +53,18 @@ DBusMessage *__dundee_error_failed(DBusMessage *msg);
 =

 int __dundee_manager_init(void);
 void __dundee_manager_cleanup(void);
+
+
+struct dundee_device;
+
+int __dundee_device_init(void);
+void __dundee_device_cleanup(void);
+void __dundee_device_shutdown(void);
+
+typedef void (*dundee_device_foreach_func)(struct dundee_device *device,
+						void *data);
+void __dundee_device_foreach(dundee_device_foreach_func cb, void *userdata=
);
+
+const char *__dundee_device_get_path(struct dundee_device *device);
+void __dundee_device_append_properties(struct dundee_device *device,
+					DBusMessageIter *dict);
diff --git a/dundee/main.c b/dundee/main.c
index 07b8501..2d3d75e 100644
--- a/dundee/main.c
+++ b/dundee/main.c
@@ -80,7 +80,7 @@ static gboolean signal_handler(GIOChannel *channel, GIOCo=
ndition cond,
 			g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS,
 						quit_eventloop, NULL);
 =

-			quit_eventloop(NULL);
+			__dundee_device_shutdown();
 		}
 =

 		__terminated =3D 1;
@@ -233,9 +233,11 @@ int main(int argc, char **argv)
 	__ofono_dbus_init(conn);
 =

 	__dundee_manager_init();
+	__dundee_device_init();
 =

 	g_main_loop_run(event_loop);
 =

+	__dundee_device_cleanup();
 	__dundee_manager_cleanup();
 =

 	__ofono_dbus_cleanup();
-- =

1.7.10.130.g36e6c


--===============3234322772226537406==--

