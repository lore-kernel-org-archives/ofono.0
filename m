Content-Type: multipart/mixed; boundary="===============8795605712022641396=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 4/6] bluetooth: add PropertyChanged watch
Date: Sun, 20 Jun 2010 05:51:22 -0300
Message-ID: <1277023884-27143-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1277023884-27143-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8795605712022641396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This one is a bit diferent from the hfp.c one, so a separated patch for
it.
---
 plugins/bluetooth.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 75 insertions(+), 1 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index a398312..cb45b3f 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -303,6 +303,72 @@ static void parse_devices(DBusMessageIter *array, gpoi=
nter user_data)
 	}
 }
 =

+static gboolean property_changed(DBusConnection *connection, DBusMessage *=
msg,
+				void *user_data)
+{
+	const char *property;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (g_str_equal(property, "UUIDs") =3D=3D TRUE) {
+		int profiles =3D 0;
+		const char *path =3D dbus_message_get_path(msg);
+		DBusMessageIter variant;
+
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		has_uuid(&variant, &profiles);
+
+		/* We need the full set of properties to be able to create
+		 * the modem properly, including Adapter and Alias, so
+		 * refetch everything again
+		 */
+		if (profiles)
+			bluetooth_send_with_reply(path, BLUEZ_DEVICE_INTERFACE,
+					"GetProperties", device_properties_cb,
+					g_strdup(path), g_free, -1,
+					DBUS_TYPE_INVALID);
+	} else if (g_str_equal(property, "Alias") =3D=3D TRUE) {
+		const char *path =3D dbus_message_get_path(msg);
+		struct bluetooth_profile *profile;
+		const char *alias =3D NULL;
+		DBusMessageIter variant;
+		GHashTableIter hash_iter;
+		gpointer key, value;
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+
+		parse_string(&variant, &alias);
+
+		g_hash_table_iter_init(&hash_iter, uuid_hash);
+		while (g_hash_table_iter_next(&hash_iter, &key, &value)) {
+			profile =3D value;
+			if (profile->set_alias)
+				profile->set_alias(path, alias);
+		}
+	}
+
+	return TRUE;
+}
+
 static void adapter_properties_cb(DBusPendingCall *call, gpointer user_dat=
a)
 {
 	const char *path =3D user_data;
@@ -430,6 +496,7 @@ static void bluetooth_disconnect(DBusConnection *connec=
tion, void *user_data)
 static guint bluetooth_watch;
 static guint adapter_added_watch;
 static guint adapter_removed_watch;
+static guint property_watch;
 =

 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
@@ -453,8 +520,13 @@ int bluetooth_register_uuid(const char *uuid, struct b=
luetooth_profile *profile)
 						"AdapterRemoved",
 						adapter_removed, NULL, NULL);
 =

+	property_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						property_changed, NULL, NULL);
+
 	if (bluetooth_watch =3D=3D 0 || adapter_added_watch =3D=3D 0 ||
-			adapter_removed_watch =3D=3D 0) {
+			adapter_removed_watch =3D=3D 0 || property_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -478,6 +550,7 @@ remove:
 	g_dbus_remove_watch(connection, bluetooth_watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
 	return err;
 }
 =

@@ -491,6 +564,7 @@ void bluetooth_unregister_uuid(const char *uuid)
 	g_dbus_remove_watch(connection, bluetooth_watch);
 	g_dbus_remove_watch(connection, adapter_added_watch);
 	g_dbus_remove_watch(connection, adapter_removed_watch);
+	g_dbus_remove_watch(connection, property_watch);
 =

 	g_hash_table_destroy(uuid_hash);
 	g_hash_table_destroy(adapter_address_hash);
-- =

1.7.1


--===============8795605712022641396==--

