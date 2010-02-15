Content-Type: multipart/mixed; boundary="===============6444744308957993742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 2/2] Add a helper method for setting basic properties
Date: Mon, 15 Feb 2010 17:07:58 -0600
Message-ID: <1266275278-17362-2-git-send-email-denkenz@gmail.com>
In-Reply-To: <1266275278-17362-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6444744308957993742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Several plugins have code for setting properties using the
BlueZ/ConnMan/oFono style API.  The code for this is duplicated
unnecessarily.  The properties tend to be e.g. booleans for Powered or
simple String states.

Here we create a convenience function that will send the set property
request and call the user-provided callback function.
---
 gdbus/gdbus.h |    8 ++++++++
 gdbus/util.c  |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index fd35e65..dda49f3 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -166,6 +166,14 @@ gboolean g_dbus_emit_property_changed_fixed_array(DBus=
Connection *conn,
 							const char *name,
 							int type, void *value,
 							int len);
+
+gboolean g_dbus_set_property_basic(DBusConnection *conn, const char *servi=
ce,
+					const char *path, const char *interface,
+					const char *property,
+					int type, void *value,
+					DBusPendingCallNotifyFunction cb,
+					void *user_data,
+					DBusFreeFunction free_func);
 #ifdef __cplusplus
 }
 #endif
diff --git a/gdbus/util.c b/gdbus/util.c
index 1abffc9..70a4413 100644
--- a/gdbus/util.c
+++ b/gdbus/util.c
@@ -224,3 +224,48 @@ gboolean g_dbus_emit_property_changed_fixed_array(DBus=
Connection *conn,
 =

 	return g_dbus_send_message(conn, signal);
 }
+
+gboolean g_dbus_set_property_basic(DBusConnection *conn, const char *servi=
ce,
+					const char *path, const char *interface,
+					const char *property,
+					int type, void *value,
+					DBusPendingCallNotifyFunction cb,
+					void *user_data,
+					DBusFreeFunction free_func)
+{
+	DBusMessage *message;
+	DBusMessageIter iter;
+	DBusPendingCall *call;
+
+	message =3D dbus_message_new_method_call(service, path, interface,
+						"SetProperty");
+
+	if (message =3D=3D NULL)
+		goto fail;
+
+	dbus_message_set_auto_start(message, FALSE);
+
+	dbus_message_iter_init_append(message, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &property);
+	append_variant(&iter, type, value);
+
+	if (dbus_connection_send_with_reply(conn, message, &call, -1) =3D=3D FALS=
E)
+		goto fail;
+
+	if (call =3D=3D NULL)
+		goto fail;
+
+	dbus_pending_call_set_notify(call, cb, user_data, free_func);
+	dbus_message_unref(message);
+
+	return TRUE;
+
+fail:
+	if (message)
+		dbus_message_unref(message);
+
+	if (free_func && user_data)
+		free_func(user_data);
+
+	return FALSE;
+}
-- =

1.6.4.4


--===============6444744308957993742==--

