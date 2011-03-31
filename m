Content-Type: multipart/mixed; boundary="===============8659068592581498147=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 1/9] dbus: Add __ofono_error_emergency_active
Date: Thu, 31 Mar 2011 09:18:24 -0700
Message-ID: <1301588312-6932-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8659068592581498147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/dbus.c  |    7 +++++++
 src/ofono.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index 01d43cf..73b3294 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -361,6 +361,13 @@ DBusMessage *__ofono_error_access_denied(DBusMessage *=
msg)
 					"Operation not permitted");
 }
 =

+DBusMessage *__ofono_error_emergency_active(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg,
+				OFONO_ERROR_INTERFACE ".EmergencyActive",
+				"Emergency active");
+}
+
 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
diff --git a/src/ofono.h b/src/ofono.h
index b9ca314..511be8a 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -58,6 +58,7 @@ DBusMessage *__ofono_error_not_attached(DBusMessage *msg);
 DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg);
 DBusMessage *__ofono_error_canceled(DBusMessage *msg);
 DBusMessage *__ofono_error_access_denied(DBusMessage *msg);
+DBusMessage *__ofono_error_emergency_active(DBusMessage *msg);
 =

 void __ofono_dbus_pending_reply(DBusMessage **msg, DBusMessage *reply);
 =

-- =

1.7.0.4


--===============8659068592581498147==--

