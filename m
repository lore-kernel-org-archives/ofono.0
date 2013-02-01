Content-Type: multipart/mixed; boundary="===============5431995922701319166=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/4] bluez5: Add support for Connecting/Disconnecting per UUID
Date: Fri, 01 Feb 2013 20:33:07 -0300
Message-ID: <1359761589-18561-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359761589-18561-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5431995922701319166==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds supports for sending the ConnectProfile() and
DisconnectProfile() messages for the org.bluez.Device1 interface.
---
 plugins/bluez5.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluez5.h | 10 ++++++
 2 files changed, 102 insertions(+)

diff --git a/plugins/bluez5.c b/plugins/bluez5.c
index c505e71..f2cd4bb 100644
--- a/plugins/bluez5.c
+++ b/plugins/bluez5.c
@@ -41,6 +41,12 @@
 =

 #define BLUEZ_PROFILE_MGMT_INTERFACE   BLUEZ_SERVICE ".ProfileManager1"
 =

+struct finish_callback {
+	bt_finish_cb cb;
+	gpointer user_data;
+	char *member;
+};
+
 void bt_bacpy(bdaddr_t *dst, const bdaddr_t *src)
 {
 	memcpy(dst, src, sizeof(bdaddr_t));
@@ -162,5 +168,91 @@ void bt_unregister_profile(DBusConnection *conn, const=
 char *object)
 	dbus_message_unref(msg);
 }
 =

+static void finish_profile_cb(DBusPendingCall *call, gpointer user_data)
+{
+	struct finish_callback *callback =3D user_data;
+	DBusMessage *reply;
+	DBusError derr;
+	gboolean success;
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&derr);
+
+	success =3D TRUE;
+
+	if (dbus_set_error_from_message(&derr, reply)) {
+		success =3D FALSE;
+
+		ofono_error("%s() replied an error: %s, %s", callback->member,
+						derr.name, derr.message);
+		dbus_error_free(&derr);
+	}
+
+	if (callback->cb)
+		callback->cb(success, callback->user_data);
+
+	dbus_message_unref(reply);
+}
+
+static void finish_callback_free(void *data)
+{
+	struct finish_callback *callback =3D data;
+
+	g_free(callback->member);
+	g_free(callback);
+}
+
+static void device_send_message(DBusConnection *conn, const char *device,
+				const char *member, const char *uuid,
+				bt_finish_cb cb, gpointer user_data)
+{
+	struct finish_callback *callback;
+	DBusMessageIter iter;
+	DBusPendingCall *c;
+	DBusMessage *msg;
+
+	DBG("Bluetooth: sending %s for %s on %s", member, uuid, device);
+
+	msg =3D dbus_message_new_method_call(BLUEZ_SERVICE, device,
+				BLUEZ_DEVICE_INTERFACE, member);
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &uuid);
+
+	if (!dbus_connection_send_with_reply(conn, msg, &c, -1)) {
+		ofono_error("Sending %s failed", member);
+		dbus_message_unref(msg);
+		return;
+	}
+
+	callback =3D g_new0(struct finish_callback, 1);
+	callback->cb =3D cb;
+	callback->user_data =3D user_data;
+	callback->member =3D g_strdup(dbus_message_get_member(msg));
+
+	dbus_pending_call_set_notify(c, finish_profile_cb, callback,
+							finish_callback_free);
+	dbus_pending_call_unref(c);
+
+	dbus_message_unref(msg);
+}
+
+void bt_connect_profile(DBusConnection *conn,
+				const char *device, const char *uuid,
+				bt_finish_cb cb, gpointer user_data)
+{
+	device_send_message(conn, device, "ConnectProfile", uuid,
+							cb, user_data);
+}
+
+void bt_disconnect_profile(DBusConnection *conn,
+				const char *device, const char *uuid,
+				bt_finish_cb cb, gpointer user_data)
+{
+	device_send_message(conn, device, "DisconnectProfile", uuid,
+							cb, user_data);
+}
+
 OFONO_PLUGIN_DEFINE(bluez5, "BlueZ 5 Utils Plugin", VERSION,
 			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
diff --git a/plugins/bluez5.h b/plugins/bluez5.h
index 16245eb..3155901 100644
--- a/plugins/bluez5.h
+++ b/plugins/bluez5.h
@@ -73,3 +73,13 @@ int bt_register_profile(DBusConnection *conn, const char=
 *uuid,
 					const char *name, const char *object);
 =

 void bt_unregister_profile(DBusConnection *conn, const char *object);
+
+typedef void (*bt_finish_cb)(gboolean success, gpointer user_data);
+
+void bt_connect_profile(DBusConnection *conn,
+				const char *device, const char *uuid,
+				bt_finish_cb cb, gpointer user_data);
+
+void bt_disconnect_profile(DBusConnection *conn,
+				const char *device, const char *uuid,
+				bt_finish_cb cb, gpointer user_data);
-- =

1.8.1.1


--===============5431995922701319166==--

