Content-Type: multipart/mixed; boundary="===============7089354374848904619=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 4/4] bluetooth: Fix Device PropertyChanged
Date: Tue, 20 Nov 2012 09:12:19 -0300
Message-ID: <1353413539-19693-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1353413539-19693-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7089354374848904619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

BlueZ PropertyChanged signal for Device objects was replaced by
PropertiesChanged emitted on org.freedesktop.DBus.Properties interface.
---
 plugins/bluetooth.c | 105 ++++++++++++++++++++++++++++++------------------=
----
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 675e53d..09c9870 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -364,64 +364,81 @@ static void get_device_properties(const char *path)
 				DBUS_TYPE_INVALID);
 }
 =

-static gboolean property_changed(DBusConnection *conn, DBusMessage *msg,
+static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
 				void *user_data)
 {
-	const char *property;
-	DBusMessageIter iter;
+	const char *property, *interface;
+	DBusMessageIter iter, dict, entry, variant;
+
+	DBG("");
 =

-	dbus_message_iter_init(msg, &iter);
+	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
+		return FALSE;
 =

+	/* Reading the interface */
 	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return TRUE;
+
+	dbus_message_iter_get_basic(&iter, &interface);
+	if (g_strcmp0(BLUEZ_DEVICE_INTERFACE, interface) !=3D 0)
+		return TRUE;
+
+	if (!dbus_message_iter_next(&iter))
 		return FALSE;
 =

-	dbus_message_iter_get_basic(&iter, &property);
-	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
-		GSList *uuids =3D NULL;
-		const char *path =3D dbus_message_get_path(msg);
-		DBusMessageIter variant;
+	/* Reading Dict entries containing properties */
+	dbus_message_iter_recurse(&iter, &dict);
 =

-		if (!dbus_message_iter_next(&iter))
+	do {
+		if (dbus_message_iter_get_arg_type(&dict) !=3D
+						DBUS_TYPE_DICT_ENTRY)
 			return FALSE;
 =

-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
+		dbus_message_iter_recurse(&dict, &entry);
 =

-		dbus_message_iter_recurse(&iter, &variant);
-
-		parse_uuids(&variant, &uuids);
-
-		/* We need the full set of properties to be able to create
-		 * the modem properly, including Adapter and Alias, so
-		 * refetch everything again
-		 */
-		if (uuids)
-			get_device_properties(path);
-	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
-		const char *path =3D dbus_message_get_path(msg);
-		struct bluetooth_profile *profile;
-		const char *alias =3D NULL;
-		DBusMessageIter variant;
-		GHashTableIter hash_iter;
-		gpointer key, value;
-
-		if (!dbus_message_iter_next(&iter))
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
 			return FALSE;
 =

-		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
+		dbus_message_iter_get_basic(&entry, &property);
 =

-		dbus_message_iter_recurse(&iter, &variant);
+		if (!dbus_message_iter_next(&entry))
+			return FALSE;
 =

-		parse_string(&variant, &alias);
+		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
 =

-		g_hash_table_iter_init(&hash_iter, uuid_hash);
-		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
-			profile =3D value;
-			if (profile->set_alias)
-				profile->set_alias(path, alias);
+		dbus_message_iter_recurse(&entry, &variant);
+		if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
+			GSList *uuids =3D NULL;
+			const char *path =3D dbus_message_get_path(msg);
+
+			parse_uuids(&variant, &uuids);
+
+			/* We need the full set of properties to be able to
+			 * create the modem properly, including Adapter and
+			 * Alias, so refetch everything again
+			 */
+			if (uuids)
+				get_device_properties(path);
+		} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
+			const char *path =3D dbus_message_get_path(msg);
+			struct bluetooth_profile *profile;
+			const char *alias =3D NULL;
+			GHashTableIter hash_iter;
+			gpointer key, value;
+
+			parse_string(&variant, &alias);
+
+			g_hash_table_iter_init(&hash_iter, uuid_hash);
+			while (g_hash_table_iter_next(&hash_iter, &key,
+								&value)) {
+				profile =3D value;
+				if (profile->set_alias)
+					profile->set_alias(path, alias);
+			}
 		}
-	}
+
+	} while (dbus_message_iter_next(&dict));
 =

 	return TRUE;
 }
@@ -882,9 +899,9 @@ static void bluetooth_ref(void)
 =

 	property_watch =3D g_dbus_add_signal_watch(connection,
 						BLUEZ_SERVICE, NULL,
-						BLUEZ_DEVICE_INTERFACE,
-						"PropertyChanged",
-						property_changed, NULL, NULL);
+						FREEDESKTOP_PROPERTIES_INTERFACE,
+						"PropertiesChanged",
+						properties_changed, NULL, NULL);
 =

 	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
 			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
-- =

1.7.11.7


--===============7089354374848904619==--

