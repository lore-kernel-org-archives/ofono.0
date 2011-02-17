Content-Type: multipart/mixed; boundary="===============1014378782072616797=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/5] bluetooth: add a bluetoothd connect watch
Date: Thu, 17 Feb 2011 19:00:46 -0300
Message-ID: <1297980049-30760-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297980049-30760-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1014378782072616797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fix a issue with sending DBus messages when bluetoothd is not up yet.
---
 plugins/bluetooth.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 32be96e..8ca9f5f 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -742,6 +742,18 @@ static void bluetooth_remove_all_modem(gpointer key, g=
pointer value,
 	profile->remove_all();
 }
 =

+static void bluetooth_connect(DBusConnection *connection, void *user_data)
+{
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
+				manager_properties_cb, NULL, NULL, -1,
+				DBUS_TYPE_INVALID);
+
+	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
+				find_adapter_cb, NULL, NULL, -1,
+				DBUS_TYPE_STRING, &adapter_any_name,
+				DBUS_TYPE_INVALID);
+}
+
 static void bluetooth_disconnect(DBusConnection *connection, void *user_da=
ta)
 {
 	if (uuid_hash =3D=3D NULL)
@@ -763,7 +775,8 @@ static void bluetooth_ref(void)
 	connection =3D ofono_dbus_get_connection();
 =

 	bluetooth_watch =3D g_dbus_add_service_watch(connection, BLUEZ_SERVICE,
-					NULL, bluetooth_disconnect, NULL, NULL);
+					bluetooth_connect,
+					bluetooth_disconnect, NULL, NULL);
 =

 	adapter_added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
 						BLUEZ_MANAGER_INTERFACE,
@@ -791,15 +804,6 @@ static void bluetooth_ref(void)
 	adapter_address_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 						g_free, g_free);
 =

-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "GetProperties",
-				manager_properties_cb, NULL, NULL, -1,
-				DBUS_TYPE_INVALID);
-
-	bluetooth_send_with_reply("/", BLUEZ_MANAGER_INTERFACE, "FindAdapter",
-				find_adapter_cb, NULL, NULL, -1,
-				DBUS_TYPE_STRING, &adapter_any_name,
-				DBUS_TYPE_INVALID);
-
 increment:
 	g_atomic_int_inc(&bluetooth_refcount);
 =

-- =

1.7.4


--===============1014378782072616797==--

