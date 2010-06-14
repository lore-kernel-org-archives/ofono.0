Content-Type: multipart/mixed; boundary="===============7102768071408097193=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 2/7] Add send_method_call_with_reply to bluetooth.c
Date: Mon, 14 Jun 2010 15:04:23 -0300
Message-ID: <1276538668-12755-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1276538668-12755-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7102768071408097193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index b4fe676..46eb304 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -40,6 +40,59 @@ static DBusConnection *connection;
 static GHashTable *uuid_hash =3D NULL;
 static GHashTable *adapter_address_hash =3D NULL;
 =

+static int send_method_call_with_reply(const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, DBusFreeFunction free_func,
+				int timeout, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+	int err;
+
+	msg =3D dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		ofono_error("Unable to allocate new D-Bus %s message", method);
+		err =3D -ENOMEM;
+		goto fail;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		va_end(args);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	va_end(args);
+
+	if (timeout > 0)
+		timeout *=3D 1000;
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, timeout)) {
+		ofono_error("Sending %s failed", method);
+		err =3D -EIO;
+		goto fail;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, free_func);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return 0;
+
+fail:
+	if (free_func && user_data)
+		free_func(user_data);
+
+	if (msg)
+		dbus_message_unref(msg);
+
+	return err;
+}
+
 int bluetooth_register_uuid(const char *uuid, struct bluetooth_profile *pr=
ofile)
 {
 	if (uuid_hash)
-- =

1.7.1


--===============7102768071408097193==--

