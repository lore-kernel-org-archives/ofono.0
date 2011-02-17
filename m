Content-Type: multipart/mixed; boundary="===============1528562798172839916=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/5] bluetooth: move find_adapter_cb to better place.
Date: Thu, 17 Feb 2011 19:00:45 -0300
Message-ID: <1297980049-30760-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1528562798172839916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   52 +++++++++++++++++++++++++----------------------=
---
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 175ebaa..32be96e 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -633,6 +633,32 @@ static void add_record(gpointer data, gpointer user_da=
ta)
 					DBUS_TYPE_INVALID);
 }
 =

+static void find_adapter_cb(DBusPendingCall *call, gpointer user_data)
+{
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError derr;
+	const char *path;
+
+	dbus_error_init(&derr);
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		ofono_error("Replied with an error: %s, %s",
+					derr.name, derr.message);
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	adapter_any_path =3D g_strdup(path);
+
+	g_slist_foreach(server_list, (GFunc) add_record, NULL);
+
+done:
+	dbus_message_unref(reply);
+}
+
 static gboolean adapter_added(DBusConnection *connection, DBusMessage *mes=
sage,
 				void *user_data)
 {
@@ -724,32 +750,6 @@ static void bluetooth_disconnect(DBusConnection *conne=
ction, void *user_data)
 	g_hash_table_foreach(uuid_hash, bluetooth_remove_all_modem, NULL);
 }
 =

-static void find_adapter_cb(DBusPendingCall *call, gpointer user_data)
-{
-	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
-	DBusError derr;
-	const char *path;
-
-	dbus_error_init(&derr);
-
-	if (dbus_set_error_from_message(&derr, reply)) {
-		ofono_error("Replied with an error: %s, %s",
-					derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &path,
-					DBUS_TYPE_INVALID);
-
-	adapter_any_path =3D g_strdup(path);
-
-	g_slist_foreach(server_list, (GFunc) add_record, NULL);
-
-done:
-	dbus_message_unref(reply);
-}
-
 static guint bluetooth_watch;
 static guint adapter_added_watch;
 static guint adapter_removed_watch;
-- =

1.7.4


--===============1528562798172839916==--

