Content-Type: multipart/mixed; boundary="===============0204143053011084463=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 11/14] bluetooth: Use generic function to parse dict
Date: Mon, 03 Dec 2012 10:11:52 -0300
Message-ID: <1354540315-27731-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0204143053011084463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the Device PropertiesChanged signal parser to use
the generic utility function to decode dictionary entries.
---
 plugins/bluetooth.c | 81 ++++++++++++++++++-------------------------------=
----
 1 file changed, 27 insertions(+), 54 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 37738e7..a3dccee 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -401,8 +401,9 @@ static void get_device_properties(const char *path)
 static gboolean properties_changed(DBusConnection *conn, DBusMessage *msg,
 				void *user_data)
 {
-	const char *property, *interface;
-	DBusMessageIter iter, dict, entry, variant;
+	const char *interface, *path, *alias =3D NULL;
+	DBusMessageIter iter;
+	GSList *uuids =3D NULL;
 =

 	DBG("");
 =

@@ -420,59 +421,31 @@ static gboolean properties_changed(DBusConnection *co=
nn, DBusMessage *msg,
 	if (!dbus_message_iter_next(&iter))
 		return FALSE;
 =

-	/* Reading Dict entries containing properties */
-	dbus_message_iter_recurse(&iter, &dict);
-
-	do {
-		if (dbus_message_iter_get_arg_type(&dict) !=3D
-						DBUS_TYPE_DICT_ENTRY)
-			return FALSE;
-
-		dbus_message_iter_recurse(&dict, &entry);
-
-		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_STRING)
-			return FALSE;
-
-		dbus_message_iter_get_basic(&entry, &property);
-
-		if (!dbus_message_iter_next(&entry))
-			return FALSE;
-
-		if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_VARIANT)
-			return FALSE;
-
-		dbus_message_iter_recurse(&entry, &variant);
-		if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
-			GSList *uuids =3D NULL;
-			const char *path =3D dbus_message_get_path(msg);
-
-			parse_uuids(&variant, &uuids);
-
-			/* We need the full set of properties to be able to
-			 * create the modem properly, including Adapter and
-			 * Alias, so refetch everything again
-			 */
-			if (uuids)
-				get_device_properties(path);
-		} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
-			const char *path =3D dbus_message_get_path(msg);
-			struct bluetooth_profile *profile;
-			const char *alias =3D NULL;
-			GHashTableIter hash_iter;
-			gpointer key, value;
-
-			parse_string(&variant, &alias);
-
-			g_hash_table_iter_init(&hash_iter, uuid_hash);
-			while (g_hash_table_iter_next(&hash_iter, &key,
-								&value)) {
-				profile =3D value;
-				if (profile->set_alias)
-					profile->set_alias(path, alias);
-			}
+	bluetooth_parse_properties(&iter,
+			"UUIDs", parse_uuids, &uuids,
+			"Alias", parse_string, &alias,
+			NULL);
+
+	path =3D dbus_message_get_path(msg);
+
+	/* We need the full set of properties to be able to
+	 * create the modem properly, including Adapter and
+	 * Alias, so refetch everything again
+	 */
+	if (uuids)
+		get_device_properties(path);
+
+	if (alias) {
+		GHashTableIter hash_iter;
+		gpointer key, value;
+
+		g_hash_table_iter_init(&hash_iter, uuid_hash);
+		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
+			struct bluetooth_profile *profile =3D value;
+			if (profile->set_alias)
+				profile->set_alias(path, alias);
 		}
-
-	} while (dbus_message_iter_next(&dict));
+	}
 =

 	return TRUE;
 }
-- =

1.7.11.7


--===============0204143053011084463==--

