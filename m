Content-Type: multipart/mixed; boundary="===============0820979743533925016=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 11/11] __ofono_ussd_initiate internal api for STK-Send USSD
Date: Wed, 01 Sep 2010 04:00:36 -0700
Message-ID: <1283338836-13572-11-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0820979743533925016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ussd.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 109 insertions(+), 16 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index 825d560..1441044 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -34,6 +34,7 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "smsutil.h"
 =

 #define SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementaryServices"
 =

@@ -46,6 +47,15 @@ enum ussd_state {
 	USSD_STATE_RESPONSE_SENT,
 };
 =

+struct ussd_request {
+	struct ofono_ussd *ussd;
+	int dcs;
+	unsigned char *str;
+	int str_len;
+	ofono_ussd_request_cb_t cb;
+	void *user_data;
+};
+
 struct ofono_ussd {
 	int state;
 	DBusMessage *pending;
@@ -56,6 +66,7 @@ struct ofono_ussd {
 	const struct ofono_ussd_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ussd_request *req;
 };
 =

 struct ssc_entry {
@@ -306,15 +317,55 @@ static void ussd_change_state(struct ofono_ussd *ussd=
, int state)
 			"State", DBUS_TYPE_STRING, &value);
 }
 =

-void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *st=
r)
+static void ussd_request_finish(struct ofono_ussd *ussd, int error, int dc=
s,
+                                const unsigned char *str, int str_len)
+{
+	struct ussd_request *req =3D ussd->req;
+
+	if (req && req->cb){
+		req->cb(error, dcs, str, str_len, req->user_data);
+		g_free(req->str);
+		g_free(req);
+		ussd->req =3D NULL;
+	}
+}
+
+static int ussd_status_to_failure_code(int status)
+{
+	switch (status) {
+	case OFONO_USSD_STATUS_TIMED_OUT:
+		return OFONO_USSD_FAILURE_TIMED_OUT;
+	case OFONO_USSD_STATUS_NOT_SUPPORTED:
+		return OFONO_USSD_FAILURE_RETURN_ERROR;
+	}
+
+	return OFONO_USSD_FAILURE_NONE;
+}
+
+void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
+                       const unsigned char *str, int str_len)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *ussdstr =3D "USSD";
+	const char *utf8_str =3D NULL;
 	const char sig[] =3D { DBUS_TYPE_STRING, 0 };
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter variant;
 =

+	if (ussd->req &&
+		(status =3D=3D OFONO_USSD_STATUS_NOTIFY ||
+		status =3D=3D OFONO_USSD_STATUS_TERMINATED ||
+		status =3D=3D OFONO_USSD_STATUS_TIMED_OUT ||
+		status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED)){
+
+		ussd_request_finish(ussd, ussd_status_to_failure_code(status),
+                		    dcs, str, str_len);
+
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+		return;
+	}
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

@@ -335,14 +386,13 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
 		goto out;
 	}
 =

+	utf8_str =3D str ? ussd_decode(dcs, str_len, str) : "";
+
 	/* TODO: Rework this in the Agent framework */
 	if (ussd->state =3D=3D USSD_STATE_ACTIVE) {
 =

 		reply =3D dbus_message_new_method_return(ussd->pending);
 =

-		if (!str)
-			str =3D "";
-
 		dbus_message_iter_init_append(reply, &iter);
 =

 		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
@@ -352,7 +402,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int sta=
tus, const char *str)
 							&variant);
 =

 		dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING,
-						&str);
+                                       &utf8_str);
 =

 		dbus_message_iter_close_container(&iter, &variant);
 =

@@ -364,11 +414,8 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, const char *str)
 	} else if (ussd->state =3D=3D USSD_STATE_RESPONSE_SENT) {
 		reply =3D dbus_message_new_method_return(ussd->pending);
 =

-		if (!str)
-			str =3D "";
-
-		dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
-						DBUS_TYPE_INVALID);
+		dbus_message_append_args(reply, DBUS_TYPE_STRING, &utf8_str,
+				DBUS_TYPE_INVALID);
 =

 		if (status =3D=3D OFONO_USSD_STATUS_ACTION_REQUIRED)
 			ussd_change_state(ussd, USSD_STATE_USER_ACTION);
@@ -387,9 +434,6 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int sta=
tus, const char *str)
 			signal_name =3D "NotificationReceived";
 		}
 =

-		if (!str)
-			str =3D "";
-
 		g_dbus_emit_signal(conn, path,
 				SUPPLEMENTARY_SERVICES_INTERFACE, signal_name,
 				DBUS_TYPE_STRING, &str, DBUS_TYPE_INVALID);
@@ -436,6 +480,8 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D -1;
+
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -465,7 +511,8 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 =

 	ussd->pending =3D dbus_message_ref(msg);
 =

-	ussd->driver->request(ussd, str, ussd_callback, ussd);
+	ussd->driver->request(ussd, dcs, (const guint8*) str, strlen(str), =

+                          ussd_callback, ussd);
 =

 	return NULL;
 }
@@ -496,6 +543,7 @@ static DBusMessage *ussd_respond(DBusConnection *conn, =
DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D -1;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -515,7 +563,8 @@ static DBusMessage *ussd_respond(DBusConnection *conn, =
DBusMessage *msg,
 =

 	ussd->pending =3D dbus_message_ref(msg);
 =

-	ussd->driver->request(ussd, str, ussd_response_callback, ussd);
+	ussd->driver->request(ussd, dcs, (const guint8*) str, strlen(str),
+                          ussd_response_callback, ussd);
 =

 	return NULL;
 }
@@ -543,7 +592,10 @@ static void ussd_cancel_callback(const struct ofono_er=
ror *error, void *data)
 	reply =3D dbus_message_new_method_return(ussd->cancel);
 	__ofono_dbus_pending_reply(&ussd->cancel, reply);
 =

-	ussd_change_state(ussd, USSD_STATE_IDLE);
+    if (ussd->req)
+        ussd_request_finish(ussd, -1, USSD_STATE_USER_ACTION, NULL, -1);
+
+    ussd_change_state(ussd, USSD_STATE_IDLE);
 }
 =

 static DBusMessage *ussd_cancel(DBusConnection *conn, DBusMessage *msg,
@@ -741,3 +793,44 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
 {
 	return ussd->driver_data;
 }
+
+static void ussd_request_callback(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_ussd *ussd =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ussd_request_finish(ussd, OFONO_USSD_FAILURE_RETURN_ERROR, -1, NULL, -1);
+	else
+		ussd_change_state(ussd,USSD_STATE_ACTIVE);
+}
+
+gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd)
+{
+	if (ussd->pending || ussd->state !=3D USSD_STATE_IDLE || ussd->req)
+		return TRUE;
+	return FALSE;
+}
+
+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+                          const unsigned char *str, int str_len,
+                          ofono_ussd_request_cb_t cb, void *user_data)
+{
+	struct ussd_request *req;
+
+	if (!ussd->driver->request)
+		return -ENOSYS;
+
+	req =3D g_try_new0(struct ussd_request, 1);
+	req->dcs =3D dcs;
+	req->str =3D g_memdup(str, str_len);
+	req->str_len =3D str_len;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	ussd->req =3D req;
+
+	ussd->driver->request(ussd, dcs, str, str_len, ussd_request_callback,
+        	          ussd);
+
+	return 0;
+}
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============0820979743533925016==--

