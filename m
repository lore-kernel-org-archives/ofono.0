Content-Type: multipart/mixed; boundary="===============2201436019253527241=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/8] Add reply / signal utilities to g_dbus_util
Date: Wed, 10 Feb 2010 13:16:31 -0600
Message-ID: <1265829391-13935-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2201436019253527241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Connman/BlueZ/oFono share the same API structure and thus share the same
basic code to build GetProperties() replies and PropertyChanged signal
emissions.  These utilities are duplicated across projects.

This patch adds the three most commonly used utilities for building the
GetProperties dictionaries and PropertyChanged signal emissions.
---
 Makefile.am   |    3 +-
 gdbus/gdbus.h |   31 ++++++++
 gdbus/util.c  |  226 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 259 insertions(+), 1 deletions(-)
 create mode 100644 gdbus/util.c

diff --git a/Makefile.am b/Makefile.am
index 7cd2194..13c7452 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,7 +39,8 @@ builtin_sources =3D
 builtin_libadd =3D
 builtin_cflags =3D
 =

-gdbus_sources =3D gdbus/gdbus.h gdbus/mainloop.c gdbus/object.c gdbus/watc=
h.c
+gdbus_sources =3D gdbus/gdbus.h gdbus/mainloop.c gdbus/object.c gdbus/watc=
h.c \
+		gdbus/util.c
 =

 gisi_sources =3D gisi/phonet.h gisi/modem.h gisi/netlink.h gisi/netlink.c \
 		gisi/socket.h gisi/socket.c gisi/client.h gisi/client.c \
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 77b8aee..941f924 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -135,6 +135,37 @@ guint g_dbus_add_signal_watch(DBusConnection *connecti=
on,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 =

+gboolean g_dbus_properties_dict_append(DBusMessageIter *dict,
+					const char *key,
+					int type, void *value);
+
+gboolean g_dbus_properties_dict_append_string_array(DBusMessageIter *dict,
+				const char *key, int type, char **val);
+
+gboolean g_dbus_properties_dict_append_fixed_array(DBusMessageIter *dict,
+							const char *key,
+							int type, void *val,
+							int len);
+
+gboolean g_dbus_emit_property_changed(DBusConnection *conn,
+					const char *path,
+					const char *interface,
+					const char *name,
+					int type, void *value);
+
+gboolean g_dbus_emit_string_array_property_changed(DBusConnection *conn,
+							const char *path,
+							const char *interface,
+							const char *name,
+							int type,
+							char **values);
+
+gboolean g_dbus_emit_fixed_array_property_changed(DBusConnection *conn,
+							const char *path,
+							const char *interface,
+							const char *name,
+							int type, void *value,
+							int len);
 #ifdef __cplusplus
 }
 #endif
diff --git a/gdbus/util.c b/gdbus/util.c
new file mode 100644
index 0000000..988af7b
--- /dev/null
+++ b/gdbus/util.c
@@ -0,0 +1,226 @@
+/*
+ *
+ *  D-Bus helper library
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
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
+#include <glib.h>
+#include <dbus/dbus.h>
+
+#include "gdbus.h"
+
+static void append_variant(DBusMessageIter *iter,
+				int type, void *value)
+{
+	char sig[2];
+	DBusMessageIter valueiter;
+
+	sig[0] =3D type;
+	sig[1] =3D 0;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						sig, &valueiter);
+
+	dbus_message_iter_append_basic(&valueiter, type, value);
+
+	dbus_message_iter_close_container(iter, &valueiter);
+}
+
+static void append_string_array_variant(DBusMessageIter *iter,
+					int type, char **val)
+{
+	DBusMessageIter variant, array;
+	char typesig[2];
+	char arraysig[3];
+	int i;
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D typesig[0] =3D type;
+	arraysig[2] =3D typesig[1] =3D '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	for (i =3D 0; val[i]; i++)
+		dbus_message_iter_append_basic(&array, type, &(val[i]));
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void append_fixed_array_variant(DBusMessageIter *iter,
+					int type, void *val, int len)
+{
+	DBusMessageIter variant, array;
+	char typesig[2];
+	char arraysig[3];
+
+	arraysig[0] =3D DBUS_TYPE_ARRAY;
+	arraysig[1] =3D typesig[0] =3D type;
+	arraysig[2] =3D typesig[1] =3D '\0';
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						arraysig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						typesig, &array);
+
+	dbus_message_iter_append_fixed_array(&array, type, val, len);
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+gboolean g_dbus_properties_dict_append(DBusMessageIter *dict,
+					const char *key,
+					int type, void *value)
+{
+	DBusMessageIter keyiter;
+
+	if (type =3D=3D DBUS_TYPE_STRING || type =3D=3D DBUS_TYPE_OBJECT_PATH) {
+		const char *str =3D *((const char **) value);
+		if (str =3D=3D NULL)
+			return FALSE;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &keyiter);
+
+	dbus_message_iter_append_basic(&keyiter, DBUS_TYPE_STRING, &key);
+
+	append_variant(&keyiter, type, value);
+
+	dbus_message_iter_close_container(dict, &keyiter);
+
+	return TRUE;
+}
+
+gboolean g_dbus_properties_dict_append_string_array(DBusMessageIter *dict,
+				const char *key, int type, char **val)
+{
+	DBusMessageIter entry;
+
+	if (type !=3D DBUS_TYPE_STRING && type !=3D DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_string_array_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+
+	return TRUE;
+}
+
+gboolean g_dbus_properties_dict_append_fixed_array(DBusMessageIter *dict,
+							const char *key,
+							int type, void *val,
+							int len)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_fixed_array_variant(&entry, type, val, len);
+
+	dbus_message_iter_close_container(dict, &entry);
+
+	return TRUE;
+}
+
+gboolean g_dbus_emit_property_changed(DBusConnection *conn,
+					const char *path,
+					const char *interface,
+					const char *name,
+					int type, void *value)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal =3D dbus_message_new_signal(path, interface, "PropertyChanged");
+
+	if (signal =3D=3D NULL)
+		return FALSE;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+	append_variant(&iter, type, value);
+
+	return g_dbus_send_message(conn, signal);
+}
+
+gboolean g_dbus_emit_string_array_property_changed(DBusConnection *conn,
+							const char *path,
+							const char *interface,
+							const char *name,
+							int type, char **values)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	if (type !=3D DBUS_TYPE_STRING && type !=3D DBUS_TYPE_OBJECT_PATH)
+		return FALSE;
+
+	signal =3D dbus_message_new_signal(path, interface, "PropertyChanged");
+	if (signal =3D=3D NULL)
+		return FALSE;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+	append_string_array_variant(&iter, type, values);
+
+	return g_dbus_send_message(conn, signal);
+}
+
+gboolean g_dbus_emit_fixed_array_property_changed(DBusConnection *conn,
+							const char *path,
+							const char *interface,
+							const char *name,
+							int type, void *value,
+							int len)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal =3D dbus_message_new_signal(path, interface, "PropertyChanged");
+	if (signal =3D=3D NULL)
+		return FALSE;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+	append_fixed_array_variant(&iter, type, value, len);
+
+	return g_dbus_send_message(conn, signal);
+}
-- =

1.6.4.4


--===============2201436019253527241==--

