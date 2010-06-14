Content-Type: multipart/mixed; boundary="===============2809809468446222761=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/7] Add parse properties stuff to bluetooth.c
Date: Mon, 14 Jun 2010 15:04:24 -0300
Message-ID: <1276538668-12755-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1276538668-12755-2-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2809809468446222761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 46eb304..254fe5b 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -93,6 +93,90 @@ fail:
 	return err;
 }
 =

+typedef void (*PropertyHandler)(DBusMessageIter *iter, gpointer user_data);
+
+struct property_handler {
+	const char *property;
+	PropertyHandler callback;
+	gpointer user_data;
+};
+
+static gint property_handler_compare(gconstpointer a, gconstpointer b)
+{
+	const struct property_handler *handler =3D a;
+	const char *property =3D b;
+
+	return strcmp(handler->property, property);
+}
+
+static void parse_properties_reply(DBusMessage *reply,
+					const char *property, ...)
+{
+	va_list args;
+	GSList *prop_handlers =3D NULL;
+	DBusMessageIter array, dict;
+
+	va_start(args, property);
+
+	while (property !=3D NULL) {
+		struct property_handler *handler =3D
+					g_new0(struct property_handler, 1);
+
+		handler->property =3D property;
+		handler->callback =3D va_arg(args, PropertyHandler);
+		handler->user_data =3D va_arg(args, gpointer);
+
+		property =3D va_arg(args, const char *);
+
+		prop_handlers =3D g_slist_prepend(prop_handlers, handler);
+	}
+
+	va_end(args);
+
+	if (dbus_message_iter_init(reply, &array) =3D=3D FALSE)
+		goto done;
+
+	if (dbus_message_iter_get_arg_type(&array) !=3D DBUS_TYPE_ARRAY)
+		goto done;
+
+	dbus_message_iter_recurse(&array, &dict);
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
+	g_slist_foreach(prop_handlers, (GFunc)g_free, NULL);
+	g_slist_free(prop_handlers);
+}
+
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
 	if (uuid_hash)
-- =

1.7.1


--===============2809809468446222761==--

