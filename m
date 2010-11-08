Content-Type: multipart/mixed; boundary="===============1627253697291354035=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] Move DBUS_GSM_ERROR_INTERFACE to OFONO_ERROR_INTERFACE
Date: Mon, 08 Nov 2010 15:12:00 -0200
Message-ID: <1289236320-19087-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1627253697291354035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new name is more generic, which make more sense.
---
 src/dbus.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/src/dbus.c b/src/dbus.c
index c51f2a9..8a685aa 100644
--- a/src/dbus.c
+++ b/src/dbus.c
@@ -28,7 +28,7 @@
 =

 #include "ofono.h"
 =

-#define DBUS_GSM_ERROR_INTERFACE "org.ofono.Error"
+#define OFONO_ERROR_INTERFACE "org.ofono.Error"
 =

 static DBusConnection *g_connection;
 =

@@ -247,52 +247,52 @@ int ofono_dbus_signal_dict_property_changed(DBusConne=
ction *conn,
 =

 DBusMessage *__ofono_error_invalid_args(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
 					".InvalidArguments",
 					"Invalid arguments in method call");
 }
 =

 DBusMessage *__ofono_error_invalid_format(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
 					".InvalidFormat",
 					"Argument format is not recognized");
 }
 =

 DBusMessage *__ofono_error_not_implemented(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
 					".NotImplemented",
 					"Implementation not provided");
 }
 =

 DBusMessage *__ofono_error_failed(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".Failed",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Failed",
 					"Operation failed");
 }
 =

 DBusMessage *__ofono_error_busy(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".InProgress",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".InProgress",
 					"Operation already in progress");
 }
 =

 DBusMessage *__ofono_error_not_found(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".NotFound",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".NotFound",
 			"Object is not found or not valid for this operation");
 }
 =

 DBusMessage *__ofono_error_not_active(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".NotActive",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".NotActive",
 			"Operation is not active or in progress");
 }
 =

 DBusMessage *__ofono_error_not_supported(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
 					".NotSupported",
 					"Operation is not supported by the"
 					" network / modem");
@@ -300,45 +300,45 @@ DBusMessage *__ofono_error_not_supported(DBusMessage =
*msg)
 =

 DBusMessage *__ofono_error_not_available(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE
 					".NotAvailable",
 					"Operation currently not available");
 }
 =

 DBusMessage *__ofono_error_timed_out(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".Timedout",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Timedout",
 			"Operation failure due to timeout");
 }
 =

 DBusMessage *__ofono_error_sim_not_ready(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".SimNotReady",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".SimNotReady",
 			"SIM is not ready or not inserted");
 }
 =

 DBusMessage *__ofono_error_in_use(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".InUse",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".InUse",
 			"The resource is currently in use");
 }
 =

 DBusMessage *__ofono_error_not_attached(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".NotAttached",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".NotAttached",
 			"GPRS is not attached");
 }
 =

 DBusMessage *__ofono_error_attach_in_progress(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg,
-				DBUS_GSM_ERROR_INTERFACE ".AttachInProgress",
+				OFONO_ERROR_INTERFACE ".AttachInProgress",
 				"GPRS Attach is in progress");
 }
 =

 DBusMessage *__ofono_error_canceled(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, DBUS_GSM_ERROR_INTERFACE ".Canceled",
+	return g_dbus_create_error(msg, OFONO_ERROR_INTERFACE ".Canceled",
 					"Operation has been canceled");
 }
 =

-- =

1.7.3.1


--===============1627253697291354035==--

