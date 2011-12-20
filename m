Content-Type: multipart/mixed; boundary="===============2144619892144431001=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 08/16] dundee: Add Manager interface
Date: Tue, 20 Dec 2011 15:47:11 +0100
Message-ID: <1324392439-26508-9-git-send-email-wagi@monom.org>
In-Reply-To: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2144619892144431001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am      |    2 +-
 dundee/dundee.h  |    6 +++
 dundee/main.c    |    9 ++---
 dundee/manager.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 107 insertions(+), 7 deletions(-)
 create mode 100644 dundee/manager.c

diff --git a/Makefile.am b/Makefile.am
index ea9733c..b65f283 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,7 +653,7 @@ sbin_PROGRAMS +=3D dundee/dundee
 =

 dundee_dundee_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
-			dundee/main.c dundee/dbus.c
+			dundee/main.c dundee/dbus.c dundee/manager.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

diff --git a/dundee/dundee.h b/dundee/dundee.h
index 20ae527..a4d42d7 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -39,6 +39,8 @@ void __ofono_log_enable(struct ofono_debug_desc *start,
 #include <ofono/dbus.h>
 =

 #define DUNDEE_SERVICE			"org.ofono.dundee"
+#define DUNDEE_MANAGER_INTERFACE	"org.ofono.dundee.Manager"
+#define DUNDEE_MANAGER_PATH		"/"
 =

 int __ofono_dbus_init(DBusConnection *conn);
 void __ofono_dbus_cleanup(void);
@@ -47,3 +49,7 @@ void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMe=
ssage *reply);
 =

 DBusMessage *__dundee_error_invalid_args(DBusMessage *msg);
 DBusMessage *__dundee_error_failed(DBusMessage *msg);
+
+
+int __dundee_manager_init(void);
+void __dundee_manager_cleanup(void);
diff --git a/dundee/main.c b/dundee/main.c
index dc5ed91..29991ff 100644
--- a/dundee/main.c
+++ b/dundee/main.c
@@ -232,15 +232,12 @@ int main(int argc, char **argv)
 =

 	__ofono_dbus_init(conn);
 =

-	/*
-	 * The reason why this DBG is here is that we have the __stop__debug,
-	 * __start__debug linking symbols in the object. As soon we
-	 * have real DBG we can remove this one again.
-	 */
-	DBG("");
+	__dundee_manager_init();
 =

 	g_main_loop_run(event_loop);
 =

+	__dundee_manager_cleanup();
+
 	__ofono_dbus_cleanup();
 	dbus_connection_unref(conn);
 =

diff --git a/dundee/manager.c b/dundee/manager.c
new file mode 100644
index 0000000..45f168e
--- /dev/null
+++ b/dundee/manager.c
@@ -0,0 +1,97 @@
+/*
+ *
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
+#include <string.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "dundee.h"
+
+static DBusMessage *manager_get_devices(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+
+	DBG("");
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static GDBusMethodTable manager_methods[] =3D {
+	{ "GetDevices",          "",    "a(oa{sv})",  manager_get_devices },
+	{ }
+};
+
+static GDBusSignalTable manager_signals[] =3D {
+	{ "DeviceAdded",        "oa{sv}" },
+	{ "DeviceRemoved",      "o" },
+	{ }
+};
+
+int __dundee_manager_init(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	gboolean ret;
+
+	ret =3D g_dbus_register_interface(conn, DUNDEE_MANAGER_PATH,
+					DUNDEE_MANAGER_INTERFACE,
+					manager_methods, manager_signals,
+					NULL, NULL, NULL);
+
+	if (ret =3D=3D FALSE)
+		return -1;
+
+	return 0;
+}
+
+void __dundee_manager_cleanup(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	g_dbus_unregister_interface(conn, DUNDEE_MANAGER_PATH,
+					DUNDEE_MANAGER_INTERFACE);
+}
-- =

1.7.8.110.g4cb5d1


--===============2144619892144431001==--

