Content-Type: multipart/mixed; boundary="===============2867836625984550150=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/4] Internal and Driver API changes for Send USSD
Date: Tue, 14 Sep 2010 14:23:14 -0700
Message-ID: <1284499394-19842-1-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <4C8FAFBF.1030008@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2867836625984550150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/ussd.c  |  115 ++++++++++++++++++++++++++++---------------=
----
 drivers/isimodem/ussd.c |   42 +++--------------
 include/ussd.h          |    8 ++-
 src/ussd.c              |   39 +++++++++++++---
 4 files changed, 115 insertions(+), 89 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 30145ad..685bc9b 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -65,15 +65,17 @@ static void read_charset_cb(gboolean ok, GAtResult *res=
ult,
 =

 static void cusd_parse(GAtResult *result, struct ofono_ussd *ussd)
 {
+	struct ussd_data *data =3D ofono_ussd_get_data(ussd);
 	GAtResultIter iter;
 	int status;
 	int dcs;
-	const char *content;
-	char *converted =3D NULL;
-	gboolean udhi;
+	const char *content =3D NULL;
 	enum sms_charset charset;
-	gboolean compressed;
-	gboolean iso639;
+	unsigned char msg[160];
+	const unsigned char *msg_ptr =3D NULL;
+	unsigned char *converted =3D NULL;
+	long written;
+	long msg_len =3D 0;
 =

 	g_at_result_iter_init(&iter, result);
 =

@@ -86,34 +88,50 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	if (!g_at_result_iter_next_string(&iter, &content))
 		goto out;
 =

-	if (g_at_result_iter_next_number(&iter, &dcs)) {
-		if (!cbs_dcs_decode(dcs, &udhi, NULL, &charset,
-					&compressed, NULL, &iso639))
-			goto out;
+	if (!g_at_result_iter_next_number(&iter, &dcs))
+		dcs =3D 0;
 =

-		if (udhi || compressed || iso639)
-			goto out;
-	} else
-		charset =3D SMS_CHARSET_7BIT;
-
-	if (charset =3D=3D SMS_CHARSET_7BIT)
-		converted =3D convert_gsm_to_utf8((const guint8 *) content,
-						strlen(content), NULL, NULL, 0);
-
-	else if (charset =3D=3D SMS_CHARSET_8BIT) {
-		/* TODO: Figure out what to do with 8 bit data */
-		ofono_error("8-bit coded USSD response received");
-		status =3D 4; /* Not supported */
-	} else {
-		/* No other encoding is mentioned in TS27007 7.15 */
+	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset, NULL, NULL, NULL)) {
 		ofono_error("Unsupported USSD data coding scheme (%02x)", dcs);
 		status =3D 4; /* Not supported */
+		goto out;
 	}
 =

-out:
-	ofono_ussd_notify(ussd, status, converted);
+	switch (charset) {
+	case SMS_CHARSET_7BIT:
+		if (data->charset =3D=3D AT_UTIL_CHARSET_GSM)
+			msg_ptr =3D pack_7bit_own_buf((const guint8 *) content,
+					strlen(content), 0, TRUE, &msg_len, 0, msg);
+		else if (data->charset =3D=3D AT_UTIL_CHARSET_UTF8)
+			ussd_encode(content, &msg_len, msg);
+		else if (data->charset =3D=3D AT_UTIL_CHARSET_UCS2) {
+			msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+
+			converted =3D convert_ucs2_to_gsm(msg_ptr, msg_len, NULL,
+							&written, 0);
+			if (!converted) {
+				msg_ptr =3D NULL;
+				msg_len =3D 0;
+				goto out;
+			}
+
+			msg_ptr =3D pack_7bit_own_buf(converted,
+						written, 0, TRUE,
+						&msg_len, 0, msg);
+
+			g_free(converted);
+		}
+		break;
+	case SMS_CHARSET_8BIT:
+		msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+		break;
+	case SMS_CHARSET_UCS2:
+		msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+		break;
+	}
 =

-	g_free(converted);
+out:
+	ofono_ussd_notify(ussd, status, dcs, msg_ptr, msg_len);
 }
 =

 static void cusd_request_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
@@ -130,39 +148,45 @@ static void cusd_request_cb(gboolean ok, GAtResult *r=
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
+	unsigned char unpacked_buf[182];
+	char coded_buf[160];
+	char *converted;
+	long written;
+	enum sms_charset charset;
 =

 	if (!cbd)
 		goto error;
 =

 	cbd->user =3D ussd;
 =

-	converted =3D convert_utf8_to_gsm(str, strlen(str), NULL, &written, 0);
-
-	if (!converted)
+	if (!cbs_dcs_decode(dcs, NULL, NULL, &charset,
+					NULL, NULL, NULL))
 		goto error;
-	else {
-		dcs =3D 15;
-		max_len =3D 182;
-	}
 =

-	if (written > max_len)
-		goto error;
+	if (charset =3D=3D SMS_CHARSET_7BIT) {
+		unpack_7bit_own_buf(pdu, len, 0, TRUE, sizeof(unpacked_buf),
+					&written, 0, unpacked_buf);
 =

-	snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
-			(int) written, converted, dcs);
+		if (written < 1)
+			goto error;
 =

-	g_free(converted);
-	converted =3D NULL;
+		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
+				(int) written, unpacked_buf, dcs);
+	} else {
+		converted =3D encode_hex_own_buf(pdu, len, 0, coded_buf);
+		if (!converted)
+			goto error;
+
+		snprintf(buf, sizeof(buf), "AT+CUSD=3D1,\"%.*s\",%d",
+				strlen(converted), converted, dcs);
+	}
 =

 	if (data->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM) {
 		/* Ensure that the modem is using GSM character set. It
@@ -179,7 +203,6 @@ static void at_ussd_request(struct ofono_ussd *ussd, co=
nst char *str,
 =

 error:
 	g_free(cbd);
-	g_free(converted);
 =

 	CALLBACK_WITH_FAILURE(cb, user_data);
 }
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index 330a141..19ba30e 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -74,24 +74,14 @@ static void ussd_parse(struct ofono_ussd *ussd, const v=
oid *restrict data,
 {
 	const unsigned char *msg =3D data;
 	int status =3D OFONO_USSD_STATUS_NOT_SUPPORTED;
-	char *converted =3D NULL;
 =

 	if (!msg || len < 4)
-		goto out;
+		ofono_ussd_notify(ussd, status, 0, NULL, 0);
 =

 	status =3D isi_type_to_status(msg[2]);
 =

 	if (msg[3] =3D=3D 0 || (size_t)(msg[3] + 4) > len)
-		goto out;
-
-	converted =3D ussd_decode(msg[1], msg[3], msg + 4);
-
-	if (converted)
-		status =3D OFONO_USSD_STATUS_NOTIFY;
-
-out:
-	ofono_ussd_notify(ussd, status, converted);
-	g_free(converted);
+		ofono_ussd_notify(ussd, status, msg[1], msg + 4, msg[3]);
 }
 =

 =

@@ -129,7 +119,7 @@ error:
 }
 =

 static GIsiRequest *ussd_send(GIsiClient *client,
-				uint8_t *str, size_t len,
+				int dcs, uint8_t *str, size_t len,
 				void *data, GDestroyNotify notify)
 {
 	const uint8_t msg[] =3D {
@@ -138,7 +128,7 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 		0x01,		/* subblock count */
 		SS_GSM_USSD_STRING,
 		4 + len + 3,	/* subblock length */
-		0x0f,		/* DCS */
+		dcs,		/* DCS */
 		len,		/* string length */
 		/* USSD string goes here */
 	};
@@ -152,33 +142,17 @@ static GIsiRequest *ussd_send(GIsiClient *client,
 				ussd_send_resp_cb, data, notify);
 }
 =

-static void isi_request(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t cb, void *data)
+static void isi_request(struct ofono_ussd *ussd, int dcs,
+			const unsigned char *pdu, int len,
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
+	if (ussd_send(ud->client, dcs, (guint8 *) pdu, len, cbd, g_free))
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
index fbb07d2..f89345a 100644
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
+	const char *str;
 	const char sig[] =3D { DBUS_TYPE_STRING, 0 };
 	DBusMessage *reply;
 	DBusMessageIter iter;
@@ -346,6 +352,11 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int st=
atus, const char *str)
 		goto out;
 	}
 =

+	if (data && data_len > 0)
+		utf8_str =3D ussd_decode(dcs, data_len, data);
+
+	str =3D utf8_str;
+
 	/* TODO: Rework this in the Agent framework */
 	if (ussd->state =3D=3D USSD_STATE_ACTIVE) {
 =

@@ -406,12 +417,12 @@ void ofono_ussd_notify(struct ofono_ussd *ussd, int s=
tatus, const char *str)
 				DBUS_TYPE_STRING, &str, DBUS_TYPE_INVALID);
 =

 		ussd_change_state(ussd, new_state);
-		return;
+		goto free;
 	} else {
 		ofono_error("Received an unsolicited USSD but can't handle.");
 		DBG("USSD is: status: %d, %s", status, str);
 =

-		return;
+		goto free;
 	}
 =

 out:
@@ -419,6 +430,9 @@ out:
 =

 	dbus_message_unref(ussd->pending);
 	ussd->pending =3D NULL;
+
+free:
+	g_free(utf8_str);
 }
 =

 static void ussd_callback(const struct ofono_error *error, void *data)
@@ -447,6 +461,9 @@ static DBusMessage *ussd_initiate(DBusConnection *conn,=
 DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D 0x0f;
+	unsigned char buf[160];
+	long num_packed;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -469,14 +486,17 @@ static DBusMessage *ussd_initiate(DBusConnection *con=
n, DBusMessage *msg,
 	if (!valid_ussd_string(str))
 		return __ofono_error_invalid_format(msg);
 =

-	DBG("OK, running USSD request");
+	if (!ussd_encode(str, &num_packed, buf))
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
+	ussd->driver->request(ussd, dcs, buf, num_packed, ussd_callback, ussd);
 =

 	return NULL;
 }
@@ -507,6 +527,9 @@ static DBusMessage *ussd_respond(DBusConnection *conn, =
DBusMessage *msg,
 {
 	struct ofono_ussd *ussd =3D data;
 	const char *str;
+	int dcs =3D 0x0f;
+	unsigned char buf[160];
+	long num_packed;
 =

 	if (ussd->pending)
 		return __ofono_error_busy(msg);
@@ -521,12 +544,16 @@ static DBusMessage *ussd_respond(DBusConnection *conn=
, DBusMessage *msg,
 	if (strlen(str) =3D=3D 0)
 		return __ofono_error_invalid_format(msg);
 =

+	if (!ussd_encode(str, &num_packed, buf))
+		return __ofono_error_invalid_format(msg);
+
 	if (!ussd->driver->request)
 		return __ofono_error_not_implemented(msg);
 =

 	ussd->pending =3D dbus_message_ref(msg);
 =

-	ussd->driver->request(ussd, str, ussd_response_callback, ussd);
+	ussd->driver->request(ussd, dcs, buf, num_packed, ussd_response_callback,
+				ussd);
 =

 	return NULL;
 }
-- =

1.7.0.4


--===============2867836625984550150==--

