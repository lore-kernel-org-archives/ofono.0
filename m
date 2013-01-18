Content-Type: multipart/mixed; boundary="===============6655124504836396038=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 01/10] dbus: Add ofono_dbus_iter_parse_properties()
Date: Fri, 18 Jan 2013 20:21:47 -0300
Message-ID: <1358551316-27305-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6655124504836396038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

With the move of BlueZ to DBus ObjectManager and the ProfileManager1
interface, the case that ofono receives a message with a properties
dictionary should be more common, so we add a function to help deal
with it.
---
 include/dbus.h |  6 ++++
 src/dbus.c     | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 96 insertions(+)

diff --git a/include/dbus.h b/include/dbus.h
index 44faa7f..3901a96 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -100,6 +100,12 @@ int ofono_dbus_signal_dict_property_changed(DBusConnec=
tion *conn,
 						const char *name, int type,
 						void *value);
 =

+typedef void (*property_handler_cb)(DBusMessageIter *iter, void *user_data=
);
+
+void ofono_dbus_iter_parse_properties(DBusMessageIter *array,
+				const char *property, property_handler_cb cb,
+				void *user_data, ...);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/dbus.c b/src/dbus.c
index 1558a51..1afbb44 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -30,6 +30,14 @@
 =

 #define OFONO_ERROR_INTERFACE "org.ofono.Error"
 =

+typedef void (*property_handler_cb)(DBusMessageIter *iter, void *user_data=
);
+
+struct property_handler {
+	const char *property;
+	property_handler_cb callback;
+	void *user_data;
+};
+
 static DBusConnection *g_connection;
 =

 struct error_mapping_entry {
@@ -273,6 +281,88 @@ int ofono_dbus_signal_dict_property_changed(DBusConnec=
tion *conn,
 	return g_dbus_send_message(conn, signal);
 }
 =

+static gint property_handler_compare(gconstpointer a, gconstpointer b)
+{
+	const struct property_handler *handler =3D a;
+	const char *property =3D b;
+
+	return g_strcmp0(handler->property, property);
+}
+
+void ofono_dbus_iter_parse_properties(DBusMessageIter *array,
+				const char *property, property_handler_cb cb,
+				void *user_data, ...)
+{
+	va_list args;
+	GSList *prop_handlers =3D NULL;
+	DBusMessageIter dict;
+
+	if (dbus_message_iter_get_arg_type(array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
+
+	va_start(args, user_data);
+
+	if (property =3D=3D NULL)
+		return;
+
+	while (1) {
+		struct property_handler *handler =3D
+					g_new0(struct property_handler, 1);
+
+		handler->property =3D property;
+		handler->callback =3D cb;
+		handler->user_data =3D user_data;
+
+		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
+
+		property =3D va_arg(args, const char *);
+		if (property =3D=3D NULL)
+			break;
+
+		cb =3D va_arg(args, property_handler_cb);
+		user_data =3D va_arg(args, void *);
+	}
+
+	va_end(args);
+
+	dbus_message_iter_recurse(array, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) =3D=3D DBUS_TYPE_DICT_ENTRY)=
 {
+		DBusMessageIter entry, value;
+		const char *key;
+		GSList *l;
+
+		dbus_message_iter_recurse(&dict, &entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
+			goto done;
+
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			goto done;
+
+		dbus_message_iter_recurse(&entry, &value);
+
+		l =3D g_slist_find_custom(prop_handlers, key,
+					property_handler_compare);
+
+		if (l) {
+			struct property_handler *handler =3D l->data;
+
+			handler->callback(&value, handler->user_data);
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+done:
+	g_slist_foreach(prop_handlers, (GFunc) g_free, NULL);
+	g_slist_free(prop_handlers);
+}
+
 DBusMessage *__ofono_error_invalid_args(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
-- =

1.7.11.7


--===============6655124504836396038==--

