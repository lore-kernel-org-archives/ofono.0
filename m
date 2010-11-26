Content-Type: multipart/mixed; boundary="===============6665191632171138168=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-volume: Fix dbus error message type
Date: Fri, 26 Nov 2010 06:59:32 -0800
Message-ID: <1290783572-5623-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6665191632171138168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index dd1be92..3c172ce 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -238,7 +238,7 @@ static DBusMessage *cv_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		unsigned char percent;
 =

 		if (!cv->driver->speaker_volume)
-			return __ofono_error_not_supported(msg);
+			return __ofono_error_not_implemented(msg);
 =

 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BYTE)
 			return __ofono_error_invalid_args(msg);
@@ -260,7 +260,7 @@ static DBusMessage *cv_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		unsigned char percent;
 =

 		if (!cv->driver->microphone_volume)
-			return __ofono_error_not_supported(msg);
+			return __ofono_error_not_implemented(msg);
 =

 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BYTE)
 			return __ofono_error_invalid_args(msg);
@@ -282,7 +282,7 @@ static DBusMessage *cv_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		dbus_bool_t muted;
 =

 		if (!cv->driver->mute)
-			return __ofono_error_not_supported(msg);
+			return __ofono_error_not_implemented(msg);
 =

 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
 			return __ofono_error_invalid_args(msg);
-- =

1.7.0.4


--===============6665191632171138168==--

