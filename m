Content-Type: multipart/mixed; boundary="===============4928294523938120483=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] hfp: create modem for new devices paired on runtime
Date: Mon, 01 Feb 2010 15:30:27 -0200
Message-ID: <1265045427-14794-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4928294523938120483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It listens the Paired property to create a modem to the recently paired
devices.
---
 plugins/hfp.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp.c b/plugins/hfp.c
index 0e2e359..2141078 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -594,6 +594,55 @@ static gboolean adapter_added(DBusConnection *connecti=
on, DBusMessage *message,
 	return TRUE;
 }
 =

+static gboolean paired_added(DBusConnection *connection, DBusMessage *mess=
age,
+				void *user_data)
+{
+	DBusError err;
+	const char *device, *paired;
+	DBusMessageIter iter, variant;
+	int ret, value;
+
+	dbus_error_init(&err);
+
+	if (dbus_message_get_args(message, &err, DBUS_TYPE_STRING,
+				 &paired, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		if (dbus_error_is_set(&err) =3D=3D TRUE) {
+			ofono_error("%s", err.message);
+			dbus_error_free(&err);
+		}
+
+		return FALSE;
+	}
+
+	if (strcmp(paired, "Paired"))
+		return TRUE;
+
+	dbus_message_iter_init(message, &iter);
+	if (dbus_message_iter_get_arg_type(&iter) =3D=3D DBUS_TYPE_STRING) {
+
+		if (!dbus_message_iter_next(&iter))
+			return FALSE;
+
+		dbus_message_iter_recurse(&iter, &variant);
+		dbus_message_iter_get_basic(&variant, &value);
+
+		if (!value)
+			return TRUE;
+	}
+
+	device =3D dbus_message_get_path(message);
+	ret =3D send_method_call(BLUEZ_SERVICE, device,
+			BLUEZ_DEVICE_INTERFACE, "GetProperties",
+			get_properties_cb, (void *)device,
+			DBUS_TYPE_INVALID);
+	if (ret < 0) {
+		ofono_error("GetProperties failed(%d)", ret);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 static void list_adapters_cb(DBusPendingCall *call, gpointer user_data)
 {
 	DBusError err;
@@ -802,6 +851,7 @@ static struct ofono_modem_driver hfp_driver =3D {
 };
 =

 static guint added_watch;
+static guint paired_watch;
 =

 static int hfp_init(void)
 {
@@ -817,7 +867,13 @@ static int hfp_init(void)
 						"AdapterAdded",
 						adapter_added, NULL, NULL);
 =

-	if (added_watch =3D=3D 0) {
+	paired_watch =3D g_dbus_add_signal_watch(connection, NULL, NULL,
+						BLUEZ_DEVICE_INTERFACE,
+						"PropertyChanged",
+						paired_added, NULL, NULL);
+
+
+	if (added_watch =3D=3D 0 || paired_watch =3D=3D 0) {
 		err =3D -EIO;
 		goto remove;
 	}
@@ -832,6 +888,7 @@ static int hfp_init(void)
 =

 remove:
 	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, paired_watch);
 =

 	dbus_connection_unref(connection);
 =

@@ -841,6 +898,7 @@ remove:
 static void hfp_exit(void)
 {
 	g_dbus_remove_watch(connection, added_watch);
+	g_dbus_remove_watch(connection, paired_watch);
 =

 	ofono_modem_driver_unregister(&hfp_driver);
 }
-- =

1.6.4.4


--===============4928294523938120483==--

