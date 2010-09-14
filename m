Content-Type: multipart/mixed; boundary="===============2375898060155287417=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 2/4] Add __ofono_ussd_initiate internal api for Sending USSD
Date: Tue, 14 Sep 2010 14:31:52 -0700
Message-ID: <1284499912-19979-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C8FB4A8.9050303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2375898060155287417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    8 +++++
 src/ussd.c  |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index f1c0973..f64f149 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -258,6 +258,9 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const char *=
sc,
 					const char *old, const char *new,
 					DBusMessage *msg, void *data);
 =

+typedef void (*ofono_ussd_request_cb_t)(int error, int dcs,
+					const unsigned char *pdu, int len, void *data);
+
 gboolean __ofono_ussd_ssc_register(struct ofono_ussd *ussd, const char *sc,
 					ofono_ussd_ssc_cb_t cb, void *data,
 					ofono_destroy_func destroy);
@@ -269,6 +272,11 @@ gboolean __ofono_ussd_passwd_register(struct ofono_uss=
d *ussd, const char *sc,
 void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char *s=
c);
 gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
 =

+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_request_cb_t cb, void *user_data);
+void __ofono_ussd_initiate_cancel(struct ofono_ussd *ussd);
+
 #include <ofono/netreg.h>
 =

 typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int c=
i,
diff --git a/src/ussd.c b/src/ussd.c
index f89345a..cb1d2e1 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -49,6 +49,15 @@ enum ussd_state {
 	USSD_STATE_RESPONSE_SENT,
 };
 =

+struct ussd_request {
+	struct ofono_ussd *ussd;
+	int dcs;
+	unsigned char *pdu;
+	int len;
+	ofono_ussd_request_cb_t cb;
+	void *user_data;
+};
+
 struct ofono_ussd {
 	int state;
 	DBusMessage *pending;
@@ -59,6 +68,7 @@ struct ofono_ussd {
 	const struct ofono_ussd_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct ussd_request *req;
 };
 =

 struct ssc_entry {
@@ -73,7 +83,7 @@ gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd)
 	if (!ussd)
 		return FALSE;
 =

-	if (ussd->pending || ussd->state !=3D USSD_STATE_IDLE)
+	if (ussd->pending || ussd->state !=3D USSD_STATE_IDLE || ussd->req)
 		return TRUE;
 =

 	return FALSE;
@@ -320,6 +330,31 @@ static void ussd_change_state(struct ofono_ussd *ussd,=
 int state)
 			"State", DBUS_TYPE_STRING, &value);
 }
 =

+static void ussd_request_finish(struct ofono_ussd *ussd, int error, int dc=
s,
+				const unsigned char *pdu, int len)
+{
+	struct ussd_request *req =3D ussd->req;
+
+	if (req && req->cb)
+		req->cb(error, dcs, pdu, len, req->user_data);
+
+	g_free(req->pdu);
+	g_free(req);
+	ussd->req =3D NULL;
+}
+
+static int ussd_status_to_failure_code(int status)
+{
+	switch (status) {
+	case OFONO_USSD_STATUS_TIMED_OUT:
+		return -ETIMEDOUT;
+	case OFONO_USSD_STATUS_NOT_SUPPORTED:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
 void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
 			const unsigned char *data, int data_len)
 {
@@ -332,6 +367,18 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 	DBusMessageIter iter;
 	DBusMessageIter variant;
 =

+	if (ussd->req &&
+			(status =3D=3D OFONO_USSD_STATUS_NOTIFY ||
+			status =3D=3D OFONO_USSD_STATUS_TERMINATED ||
+			status =3D=3D OFONO_USSD_STATUS_TIMED_OUT ||
+			status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED)) {
+		ussd_request_finish(ussd, ussd_status_to_failure_code(status),
+					dcs, data, data_len);
+
+		ussd_change_state(ussd, USSD_STATE_IDLE);
+		return;
+	}
+
 	if (status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED) {
 		ussd_change_state(ussd, USSD_STATE_IDLE);
 =

@@ -465,10 +512,7 @@ static DBusMessage *ussd_initiate(DBusConnection *conn=
, DBusMessage *msg,
 	unsigned char buf[160];
 	long num_packed;
 =

-	if (ussd->pending)
-		return __ofono_error_busy(msg);
-
-	if (ussd->state !=3D USSD_STATE_IDLE)
+	if (__ofono_ussd_is_busy(ussd))
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &str,
@@ -581,6 +625,9 @@ static void ussd_cancel_callback(const struct ofono_err=
or *error, void *data)
 	reply =3D dbus_message_new_method_return(ussd->cancel);
 	__ofono_dbus_pending_reply(&ussd->cancel, reply);
 =

+	if (ussd->req)
+		ussd_request_finish(ussd, -1, -ECANCELED, NULL, -1);
+
 	ussd_change_state(ussd, USSD_STATE_IDLE);
 }
 =

@@ -779,3 +826,47 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
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
+		ussd_request_finish(ussd, error->error, -1, NULL, -1);
+	else
+		ussd_change_state(ussd, USSD_STATE_ACTIVE);
+}
+
+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+				const unsigned char *pdu, int len,
+				ofono_ussd_request_cb_t cb, void *user_data)
+{
+	struct ussd_request *req;
+
+	if (!ussd->driver->request)
+		return -ENOSYS;
+
+	if (__ofono_ussd_is_busy(ussd))
+		return -EBUSY;
+
+	req =3D g_try_new0(struct ussd_request, 1);
+	req->dcs =3D dcs;
+	req->pdu =3D g_memdup(pdu, len);
+	req->len =3D len;
+	req->cb =3D cb;
+	req->user_data =3D user_data;
+
+	ussd->req =3D req;
+
+	ussd->driver->request(ussd, dcs, pdu, len, ussd_request_callback, ussd);
+
+	return 0;
+}
+
+void __ofono_ussd_initiate_cancel(struct ofono_ussd *ussd)
+{
+	if (!ussd->req || !ussd->req->cb)
+		return;
+
+	ussd->req->cb =3D NULL;
+}
-- =

1.7.0.4


--===============2375898060155287417==--

