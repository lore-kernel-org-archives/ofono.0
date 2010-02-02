Content-Type: multipart/mixed; boundary="===============5399076662838346766=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: create modem for new devices paired on runtime
Date: Tue, 02 Feb 2010 19:42:17 -0200
Message-ID: <1265146937-22088-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5399076662838346766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It listens the Paired property to create a modem to the recently paired
devices. It also renames added_watch to adapter_watch, a more proper
name.
---
 plugins/hfp.c |   47 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 0e2e359..6f2000a 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -594,6 +594,34 @@ static gboolean adapter_added(DBusConnection *connecti=
on, DBusMessage *message,
 	return TRUE;
 }
 =

+static gboolean new_device_added(DBusConnection *connection, DBusMessage *=
message,
+				void *user_data)
+{
+	const char *device, *property;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(message, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (g_str_equal(property, "UUIDs") =3D=3D FALSE)
+		return TRUE;
+
+	if (!dbus_message_iter_next(&iter))
+		return FALSE;
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return FALSE;
+
+	device =3D dbus_message_get_path(message);
+
+	parse_uuids(&iter, device);
+
+	return TRUE;
+}
+
 static void list_adapters_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusError err;
@@ -801,7 +829,8 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

-static guint added_watch;
+static guint adapter_watch;
+static guint device_watch;
 =

 static int hfp_init(void)
 {
@@ -812,12 +841,18 @@ static int hfp_init(void)
 =

 	connection =3D ofono_dbus_get_connection();
 =

-	added_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+	adapter_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
 						BLUEZ_MANAGER_INTERFACE,
 						"AdapterAdded",
 						adapter_added, NULL, NULL);
 =

-	if (added_watch =3D=3D 0) {
+	device_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						new_device_added, NULL, NULL);
+
+
+	if (adapter_watch =3D=3D 0 || device_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -831,7 +866,8 @@ static int hfp_init(void)
 	return 0;
 =

 remove:
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, device_watch);
 =

 	dbus_connection_unref(connection);
 =

@@ -840,7 +876,8 @@ remove:
 =

 static void hfp_exit(void)
 {
-	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, adapter_watch);
+	g_dbus_remove_watch(connection, device_watch);
 =

 	ofono_modem_driver_unregister(&hfp_driver);
 }
-- =

1.6.4.4


--===============5399076662838346766==--

