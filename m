Content-Type: multipart/mixed; boundary="===============8155587559138214219=="
MIME-Version: 1.0
From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 2/2] dundee: return error if there is a connection procedure
 ongoing
Date: Mon, 24 Jun 2013 17:14:02 +0100
Message-ID: <1372090442-15152-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1372090442-15152-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8155587559138214219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 dundee/dbus.c   | 7 +++++++
 dundee/device.c | 3 +++
 dundee/dundee.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/dundee/dbus.c b/dundee/dbus.c
index 90bd76b..a1fd2f9 100644
--- a/dundee/dbus.c
+++ b/dundee/dbus.c
@@ -44,6 +44,13 @@ DBusMessage *__dundee_error_failed(DBusMessage *msg)
 					"Operation failed");
 }
 =

+DBusMessage *__dundee_error_in_progress(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, DUNDEE_ERROR_INTERFACE
+					".InProgress",
+					"Operation already in progress");
+}
+
 DBusMessage *__dundee_error_timed_out(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, DUNDEE_ERROR_INTERFACE ".Timedout",
diff --git a/dundee/device.c b/dundee/device.c
index 76fb692..2f4ed56 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -460,6 +460,9 @@ static DBusMessage *set_property_active(struct dundee_d=
evice *device,
 	if (dbus_message_iter_get_arg_type(var) !=3D DBUS_TYPE_BOOLEAN)
 		return __dundee_error_invalid_args(msg);
 =

+	if (device->pending)
+		return __dundee_error_in_progress(msg);
+
 	dbus_message_iter_get_basic(var, &active);
 =

 	device->pending =3D dbus_message_ref(msg);
diff --git a/dundee/dundee.h b/dundee/dundee.h
index 56c6913..4f4fa76 100644
--- a/dundee/dundee.h
+++ b/dundee/dundee.h
@@ -96,6 +96,7 @@ void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMe=
ssage *reply);
 =

 DBusMessage *__dundee_error_invalid_args(DBusMessage *msg);
 DBusMessage *__dundee_error_failed(DBusMessage *msg);
+DBusMessage *__dundee_error_in_progress(DBusMessage *msg);
 DBusMessage *__dundee_error_timed_out(DBusMessage *msg);
 =

 =

-- =

1.8.1.4


--===============8155587559138214219==--

