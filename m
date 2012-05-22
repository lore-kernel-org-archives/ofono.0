Content-Type: multipart/mixed; boundary="===============4896461653513195623=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH v7 08/16] dundee: Add Manager interface
Date: Tue, 22 May 2012 18:33:16 +0200
Message-ID: <1337704404-5260-9-git-send-email-wagi@monom.org>
In-Reply-To: <1337704404-5260-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4896461653513195623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am      |    3 +-
 dundee/dundee.h  |    6 ++++
 dundee/main.c    |    9 ++---
 dundee/manager.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 111 insertions(+), 7 deletions(-)
 create mode 100644 dundee/manager.c

diff --git a/Makefile.am b/Makefile.am
index 31e0110..00e1118 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -689,7 +689,8 @@ sbin_PROGRAMS +=3D dundee/dundee
 =

 dundee_dundee_SOURCES =3D $(gdbus_sources) \
 			src/log.c src/dbus.c \
-			dundee/dundee.h dundee/main.c dundee/dbus.c
+			dundee/dundee.h dundee/main.c dundee/dbus.c \
+			dundee/manager.c
 =

 dundee_dundee_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_L=
IBS@ -ldl
 =

diff --git a/dundee/dundee.h b/dundee/dundee.h
index c972af0..3050baf 100644
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
index 95ee795..07b8501 100644
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
index 0000000..61fa25e
--- /dev/null
+++ b/dundee/manager.c
@@ -0,0 +1,100 @@
+/*
+ *
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
+static const GDBusMethodTable manager_methods[] =3D {
+	{ GDBUS_METHOD("GetDevices", NULL,
+		GDBUS_ARGS({ "devices", "a(oa{sv})" }), manager_get_devices) },
+	{ }
+};
+
+static const GDBusSignalTable manager_signals[] =3D {
+	{ GDBUS_SIGNAL("DevicesAdded",
+		GDBUS_ARGS({ "path", "o"},{ "properties", "a{sv}" })) },
+	{ GDBUS_SIGNAL("DeviceRemoved",
+		GDBUS_ARGS({ "path", "o"})) },
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

1.7.10.130.g36e6c


--===============4896461653513195623==--

