Content-Type: multipart/mixed; boundary="===============1530073011047248160=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/6] dbus: Add new error types
Date: Tue, 29 May 2012 18:38:33 +0200
Message-ID: <1338309517-14808-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1530073011047248160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |   13 +++++++++++++
 src/ofono.h |    2 ++
 2 files changed, 15 insertions(+)

diff --git a/src/dbus.c b/src/dbus.c
index 52e3a68..5cccc32 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -375,6 +375,19 @@ DBusMessage *__ofono_error_emergency_active(DBusMessag=
e *msg)
 				"Emergency mode active");
 }
 =

+DBusMessage *__ofono_error_incorrect_password(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg,
+				OFONO_ERROR_INTERFACE ".IncorrectPassword",
+				"Password is incorrect");
+}
+
+DBusMessage *__ofono_error_not_allowed(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".NotAllowed",
+					"Operation is not allowed");
+}
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
diff --git a/src/ofono.h b/src/ofono.h
index a6f1af1..81d5f71 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -63,6 +63,8 @@ DBusMessage *__ofono_error_not_registered(DBusMessage *ms=
g);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
 DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
 DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);
+DBusMessage *__ofono_error_incorrect_password(DBusMessage *msg);
+DBusMessage *__ofono_error_not_allowed(DBusMessage *msg);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

-- =

1.7.9.5


--===============1530073011047248160==--

