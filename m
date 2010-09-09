Content-Type: multipart/mixed; boundary="===============3718577573961851272=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 6/8] Internal and Driver api changes for Send USSD proactive
 command
Date: Thu, 09 Sep 2010 13:25:14 -0700
Message-ID: <1284063915-24808-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C89046C.5040106@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3718577573961851272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ussd.c  |   86 +++++++++++++++++++++++++------------------=
---
 drivers/isimodem/ussd.c |   44 +++++++----------------
 include/ussd.h          |    8 +++--
 src/ussd.c              |   87 ++++++++++++++++++++++++++++++++++++-------=
---
 4 files changed, 133 insertions(+), 92 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 30145ad..ac99f0e 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -65,15 +65,15 @@ static void read_charset_cb(gboolean ok, GAtResult *res=
ult,
 =

 static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 {
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 	GAtResultIter iter;
 	int status;
 	int dcs;
 	const char *content;
-	char *converted =3D NULL;
-	gboolean udhi;
 	enum sms_charset charset;
-	gboolean compressed;
-	gboolean iso639;
+	unsigned char msg[160];
+	long msg_len =3D 0;
+	unsigned char *msg_ptr =3D NULL;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -87,33 +87,27 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 		goto out;
 =

 	if (g_at_result_iter_next_number(&iter, &dcs)) {
-		if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
-					&compressed, NULL, &iso639))
-			goto out;
-
-		if (udhi || compressed || iso639)
+		if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
+					NULL, NULL, NULL))
 			goto out;
 	} else
 		charset =3D SMS_CHARSET_7BIT;
 =

-	if (charset =3D=3D SMS_CHARSET_7BIT)
-		converted =3D convert_gsm_to_utf8((const guint8 *) content,
-						strlen(content), NULL, NULL, 0);
-
-	else if (charset =3D=3D SMS_CHARSET_8BIT) {
-		/* TODO: Figure out what to do with 8 bit data */
-		ofono_error("8-bit coded USSD response received");
-		status =3D 4; /* Not supported */
-	} else {
+	if (charset =3D=3D SMS_CHARSET_7BIT) {
+		if (data->charset =3D=3D AT_UTIL_CHARSET_GSM)
+			msg_ptr =3D pack_7bit_own_buf((const guint8 *) content,
+					strlen(content), 0, TRUE,
+					&msg_len, 0, msg);
+	} else if (charset =3D=3D SMS_CHARSET_8BIT)
+		msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+	else {
 		/* No other encoding is mentioned in TS27007 7.15 */
 		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
 		status =3D 4; /* Not supported */
 	}
 =

 out:
-	ofono_ussd_notify(ussd, status, converted);
-
-	g_free(converted);
+	ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_len);
 }
 =

 static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -130,39 +124,52 @@ static void cusd_request_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	cusd_parse(result, ussd);
 }
 =

-static void at_ussd_request(struct ofono_ussd *ussd, const char *str,
+static void at_ussd_request(struct ofono_ussd *ussd, int dcs,
+				const unsigned char *pdu, int len,
 				ofono_ussd_cb_t cb, void *user_data)
 {
 	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	unsigned char *converted =3D NULL;
-	int dcs;
-	int max_len;
-	long written;
 	char buf[256];
+	long max_chars =3D 182;
+	unsigned char *unpacked_buf =3D NULL;
+	char *converted =3D NULL;
+	long written;
+	enum sms_charset charset;
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D ussd;
+        =

+	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
+					NULL, NULL, NULL))
+		goto error;
 =

-	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
+	if (charset =3D=3D SMS_CHARSET_7BIT) {
+		unpacked_buf =3D unpack_7bit(pdu, len, 0, TRUE, max_chars,
+						&written, 0);
 =

-	if (!converted)
-		goto error;
-	else {
-		dcs =3D 15;
-		max_len =3D 182;
-	}
+		if ( !unpacked_buf || written <=3D 0)
+			goto error;
 =

-	if (written > max_len)
-		goto error;
+		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
+				(int) written, unpacked_buf, dcs);
+
+		g_free(unpacked_buf);
+		unpacked_buf =3D NULL;
+	} else {
+		converted =3D encode_hex(pdu, len, 0);
 =

-	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
-			(int) written, converted, dcs);
+		if (!converted)
+			goto error;
 =

-	g_free(converted);
-	converted =3D NULL;
+		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
+				strlen(converted), converted, dcs);
+
+		g_free(converted);
+		converted =3D NULL;
+	}
 =

 	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
 		/* Ensure that the modem is using GSM character set. It
@@ -179,7 +186,6 @@ static void at_ussd_request(struct ofono_ussd *ussd, co=
nst char *str,
 =

 error:
 	g_free(cbd);
-	g_free(converted);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
 }
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 330a141..6ac945b 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -74,7 +74,9 @@ static void ussd_parse(struct ofono_ussd *ussd, const voi=
d *restrict data,
 {
 	const unsigned char *msg =3D data;
 	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
-	char *converted =3D NULL;
+	int msg_len =3D 0;
+	int dcs =3D -1;
+	unsigned char *coded_msg =3D NULL;
 =

 	if (!msg || len < 4)
 		goto out;
@@ -84,14 +86,11 @@ static void ussd_parse(struct ofono_ussd *ussd, const v=
oid *restrict data,
 	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
 		goto out;
 =

-	converted =3D ussd_decode(msg[1], msg[3], msg + 4);
-
-	if (converted)
-		status =3D OFONO_USSD_STATUS_NOTIFY;
-
+	dcs =3D msg[1];
+	msg_len =3D msg[3];
+	coded_msg =3D (guint8 *) msg+4;
 out:
-	ofono_ussd_notify(ussd, status, converted);
-	g_free(converted);
+	ofono_ussd_notify(ussd, status, dcs, coded_msg, msg_len);
 }
 =

 =

@@ -129,7 +128,7 @@ error:
 }
 =

 static GIsiRequest *ussd_send(GIsiClient *client,
-				uint8_t *str, size_t len,
+				int dcs, uint8_t *str, size_t len,
 				void *data, GDestroyNotify notify)
 {
 	const uint8_t msg[] =3D {
@@ -138,7 +137,7 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 		0x01,		/* subblock count */
 		SS_GSM_USSD_STRING,
 		4 + len + 3,	/* subblock length */
-		0x0f,		/* DCS */
+		dcs,		/* DCS */
 		len,		/* string length */
 		/* USSD string goes here */
 	};
@@ -152,33 +151,18 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 				ussd_send_resp_cb, data, notify);
 }
 =

-static void isi_request(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t cb, void *data)
+static void isi_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *binary_data, int binary_data_len,
+			ofono_ussd_cb_t cb, void *data)
 {
 	struct ussd_data *ud =3D ofono_ussd_get_data(ussd);
 	struct isi_cb_data *cbd =3D isi_cb_data_new(ussd, cb, data);
-	unsigned char buf[256];
-	unsigned char *packed =3D NULL;
-	unsigned char *converted =3D NULL;
-	long num_packed;
-	long written;
 =

 	if (!cbd)
 		goto error;
 =

-	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
-	if (!converted)
-		goto error;
-
-	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
-					&num_packed, 0, buf);
-
-	g_free(converted);
-
-	if (written > SS_MAX_USSD_LENGTH)
-		goto error;
-
-	if (ussd_send(ud->client, packed, num_packed, cbd, g_free))
+	if (ussd_send(ud->client, dcs, (guint8 *) binary_data,
+			binary_data_len, cbd, g_free))
 		return;
 =

 error:
diff --git a/include/ussd.h b/include/ussd.h
index 96e04cb..360ef00 100644
--- a/include/ussd.h
+++ b/include/ussd.h
@@ -45,13 +45,15 @@ struct ofono_ussd_driver {
 	const char *name;
 	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
 	void (*remove)(struct ofono_ussd *ussd);
-	void (*request)(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t, void *data);
+	void (*request)(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
+			ofono_ussd_cb_t, void *data);
 	void (*cancel)(struct ofono_ussd *ussd,
 				ofono_ussd_cb_t cb, void *data);
 };
 =

-void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *st=
r);
+void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
+			const unsigned char *data, int data_len);
 =

 int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
 void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
diff --git a/src/ussd.c b/src/ussd.c
index fbb07d2..a2e9e72 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -34,8 +34,11 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "smsutil.h"
+#include "util.h"
 =

 #define SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementaryServices"
+#define MAX_USSD_LENGTH 160
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -317,10 +320,13 @@ static void ussd_change_state(struct ofono_ussd *ussd=
, int state)
 			"State", DBUS_TYPE_STRING, &value);
 }
 =

-void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *st=
r)
+void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
+			const unsigned char *data, int data_len)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *ussdstr =3D "USSD";
+	char *utf8_str =3D NULL;
+	gboolean utf8_str_valid =3D FALSE;
 	const char sig[] =3D { DBUS_TYPE_STRING, 0 };
 	DBusMessage *reply;
 	DBusMessageIter iter;
@@ -345,15 +351,21 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
 		reply =3D __ofono_error_timed_out(ussd->pending);
 		goto out;
 	}
+	=

+	if (data && data_len > 0)
+		utf8_str =3D ussd_decode(dcs, data_len, data);
+
+	if (!utf8_str) {
+		utf8_str =3D "";
+		status =3D OFONO_USSD_STATUS_NOTIFY;
+	} else
+		utf8_str_valid =3D TRUE;
 =

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
@@ -363,7 +375,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int sta=
tus, const char *str)
 							&variant);
 =

 		dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING,
-						&str);
+						&utf8_str);
 =

 		dbus_message_iter_close_container(&iter, &variant);
 =

@@ -375,10 +387,7 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, const char *str)
 	} else if (ussd->state =3D=3D USSD_STATE_RESPONSE_SENT) {
 		reply =3D dbus_message_new_method_return(ussd->pending);
 =

-		if (!str)
-			str =3D "";
-
-		dbus_message_append_args(reply, DBUS_TYPE_STRING, &str,
+		dbus_message_append_args(reply, DBUS_TYPE_STRING, &utf8_str,
 						DBUS_TYPE_INVALID);
 =

 		if (status =3D=3D OFONO_USSD_STATUS_ACTION_REQUIRED)
@@ -398,20 +407,17 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
 			signal_name =3D "NotificationReceived";
 		}
 =

-		if (!str)
-			str =3D "";
-
 		g_dbus_emit_signal(conn, path,
 				SUPPLEMENTARY_SERVICES_INTERFACE, signal_name,
-				DBUS_TYPE_STRING, &str, DBUS_TYPE_INVALID);
+				DBUS_TYPE_STRING, &utf8_str, DBUS_TYPE_INVALID);
 =

 		ussd_change_state(ussd, new_state);
-		return;
+		goto free;
 	} else {
 		ofono_error("Received an unsolicited USSD but can't handle.");
-		DBG("USSD is: status: %d, %s", status, str);
+		DBG("USSD is: status: %d, %s", status, utf8_str);
 =

-		return;
+		goto free;
 	}
 =

 out:
@@ -419,6 +425,10 @@ out:
 =

 	dbus_message_unref(ussd->pending);
 	ussd->pending =3D NULL;
+
+free:
+	if (utf8_str_valid)
+		g_free(utf8_str);
 }
 =

 static void ussd_callback(const struct ofono_error *error, void *data)
@@ -447,6 +457,12 @@ static DBusMessage *ussd_initiate(DBusConnection *conn=
, DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D 0x0f;
+	unsigned char buf[256];
+	unsigned char *converted;
+	unsigned char *packed =3D NULL;
+	long num_packed;
+	long written;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -469,14 +485,27 @@ static DBusMessage *ussd_initiate(DBusConnection *con=
n, DBusMessage *msg,
 	if (!valid_ussd_string(str))
 		return __ofono_error_invalid_format(msg);
 =

-	DBG("OK, running USSD request");
+	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
+	if (!converted)
+		return __ofono_error_invalid_format(msg);
+
+	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
+					&num_packed, 0, buf);
+
+	g_free(converted);
+
+	if (num_packed > MAX_USSD_LENGTH)
+		return __ofono_error_invalid_format(msg);
 =

 	if (!ussd->driver->request)
 		return __ofono_error_not_implemented(msg);
 =

+	DBG("OK, running USSD request");
+
 	ussd->pending =3D dbus_message_ref(msg);
 =

-	ussd->driver->request(ussd, str, ussd_callback, ussd);
+	ussd->driver->request(ussd, dcs, packed, (int) num_packed,
+				ussd_callback, ussd);
 =

 	return NULL;
 }
@@ -507,6 +536,12 @@ static DBusMessage *ussd_respond(DBusConnection *conn,=
 DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D 0x0f;
+	unsigned char buf[256];
+	unsigned char *converted;
+	unsigned char *packed =3D NULL;
+	long num_packed;
+	long written;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -521,12 +556,25 @@ static DBusMessage *ussd_respond(DBusConnection *conn=
, DBusMessage *msg,
 	if (strlen(str) =3D=3D 0)
 		return __ofono_error_invalid_format(msg);
 =

+	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
+	if (!converted)
+		return __ofono_error_invalid_format(msg);
+
+	packed =3D pack_7bit_own_buf(converted, written, 0, TRUE,
+					&num_packed, 0, buf);
+
+	g_free(converted);
+
+	if (num_packed > MAX_USSD_LENGTH)
+		return __ofono_error_invalid_args(msg);
+
 	if (!ussd->driver->request)
 		return __ofono_error_not_implemented(msg);
 =

 	ussd->pending =3D dbus_message_ref(msg);
 =

-	ussd->driver->request(ussd, str, ussd_response_callback, ussd);
+	ussd->driver->request(ussd, dcs, packed, (int) num_packed,
+				ussd_response_callback, ussd);
 =

 	return NULL;
 }
@@ -752,3 +800,4 @@ void *ofono_ussd_get_data(struct ofono_ussd *ussd)
 {
 	return ussd->driver_data;
 }
+
-- =

1.7.0.4


--===============3718577573961851272==--

