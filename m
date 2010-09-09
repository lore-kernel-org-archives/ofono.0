Content-Type: multipart/mixed; boundary="===============5778467042841060209=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 7/8] Add __ofono_ussd_initiate internal api for Sending USSD
Date: Thu, 09 Sep 2010 13:25:15 -0700
Message-ID: <1284063915-24808-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284063915-24808-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5778467042841060209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |   14 +++++++++
 src/ussd.c  |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 7e814c9..9786829 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -244,6 +244,13 @@ gboolean __ofono_ssn_mt_watch_remove(struct ofono_ssn =
*ssn, int id);
 =

 #include <ofono/ussd.h>
 =

+enum ofono_ussd_failure {
+	OFONO_USSD_FAILURE_NONE,
+	OFONO_USSD_FAILURE_USER_TERMINATED,
+	OFONO_USSD_FAILURE_RETURN_ERROR,
+	OFONO_USSD_FAILURE_TIMED_OUT,
+};
+
 typedef gboolean (*ofono_ussd_ssc_cb_t)(int type,
 					const char *sc,
 					const char *sia, const char *sib,
@@ -254,6 +261,9 @@ typedef gboolean (*ofono_ussd_passwd_cb_t)(const char *=
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
@@ -265,6 +275,10 @@ gboolean __ofono_ussd_passwd_register(struct ofono_uss=
d *ussd, const char *sc,
 void __ofono_ussd_passwd_unregister(struct ofono_ussd *ussd, const char *s=
c);
 gboolean __ofono_ussd_is_busy(struct ofono_ussd *ussd);
 =

+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_request_cb_t cb, void *user_data);
+
 #include <ofono/netreg.h>
 =

 typedef void (*ofono_netreg_status_notify_cb_t)(int status, int lac, int c=
i,
diff --git a/src/ussd.c b/src/ussd.c
index a2e9e72..4db3bce 100644
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
+	if (req && req->cb) {
+		req->cb(error, dcs, pdu, len, req->user_data);
+		g_free(req->pdu);
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
 void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
 			const unsigned char *data, int data_len)
 {
@@ -332,6 +367,19 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, int dcs,
 	DBusMessageIter iter;
 	DBusMessageIter variant;
 =

+	if (ussd->req &&
+		(status =3D=3D OFONO_USSD_STATUS_NOTIFY ||
+		status =3D=3D OFONO_USSD_STATUS_TERMINATED ||
+		status =3D=3D OFONO_USSD_STATUS_TIMED_OUT ||
+		status =3D=3D OFONO_USSD_STATUS_NOT_SUPPORTED)) {
+
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

@@ -602,6 +650,9 @@ static void ussd_cancel_callback(const struct ofono_err=
or *error, void *data)
 	reply =3D dbus_message_new_method_return(ussd->cancel);
 	__ofono_dbus_pending_reply(&ussd->cancel, reply);
 =

+	if (ussd->req)
+		ussd_request_finish(ussd, -1, USSD_STATE_USER_ACTION, NULL, -1);
+
 	ussd_change_state(ussd, USSD_STATE_IDLE);
 }
 =

@@ -801,3 +852,35 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
 	return ussd->driver_data;
 }
 =

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
+int __ofono_ussd_initiate(struct ofono_ussd *ussd, int dcs,
+				const unsigned char *pdu, int len,
+				ofono_ussd_request_cb_t cb, void *user_data)
+{
+	struct ussd_request *req;
+
+	if (!ussd->driver->request)
+		return -ENOSYS;
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
-- =

1.7.0.4


--===============5778467042841060209==--

