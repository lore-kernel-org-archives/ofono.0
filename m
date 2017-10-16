Content-Type: multipart/mixed; boundary="===============1847215165458375996=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Mon, 16 Oct 2017 14:20:48 +0200
Message-ID: <20171016122048.2405-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1847215165458375996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The Quectel EC21 does not provide the SMS PDU on the message event
notification.

This patch adds a call to 'raw read' on the message ID from the event
notification if the event notification does not already contain the
message data.

The message data begins with the SMSC length, type, and address so
the TPDU length is adjusted accordingly in the raw_read callback.  This
differs from the way the raw message data is handled in the case
that it is included in the event notification itself.  As I don't have
access to any other QMI modem at this time, I'm can not confirm that
this difference is reasonable.
---
 drivers/qmimodem/sms.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/wms.h |  9 ++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 3f4bdeb..7e6baec 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -334,9 +334,38 @@ error:
 	g_free(cbd);
 }
 =

+static void raw_read_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	const struct qmi_wms_raw_message* msg;
+	uint16_t len;
+	uint16_t error;
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("Raw read error: %d (%s)", error,
+			qmi_result_get_error(result));
+		return;
+	}
+
+	/* Raw message data */
+	msg =3D qmi_result_get(result, 0x01, &len);
+	if (msg) {
+		uint16_t plen;
+		uint16_t tpdu_len;
+
+		plen =3D GUINT16_FROM_LE(msg->msg_length);
+		tpdu_len =3D plen - msg->msg_data[0] - 1;
+
+		ofono_sms_deliver_notify(sms, msg->msg_data, plen, tpdu_len);
+	} else {
+		DBG("No message data available at requested position");
+	}
+}
+
 static void event_notify(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
 	const struct qmi_wms_result_new_msg_notify *notify;
 	const struct qmi_wms_result_message *message;
 	uint16_t len;
@@ -360,6 +389,34 @@ static void event_notify(struct qmi_result *result, vo=
id *user_data)
 		DBG("msg format %d PDU length %d", message->msg_format, plen);
 =

 		ofono_sms_deliver_notify(sms, message->msg_data, plen, plen);
+	} else {
+		/* The Quectel EC21, at least, does not provide the
+		 * message data in the event notification, so a 'raw read'
+		 * needs to be issued in order to query the message itself
+		 */
+		struct qmi_param *param;
+
+		param =3D qmi_param_new();
+		if (!param)
+			return;
+
+		/* Message memory storage ID */
+		qmi_param_append(param, 0x01, sizeof(*notify), notify);
+		/* The 'message mode' parameter is documented as optional,
+		 * but the Quectel EC21 errors out with error 17 (missing
+		 * argument) if it is not provided... we default to 3GPP
+		 * here because that's what works for me and it's not clear
+		 * how to actually query what this should be otherwise...
+		 */
+		/* Message mode */
+		qmi_param_append_uint8(param, 0x10,
+				QMI_WMS_MESSAGE_MODE_GSMWCDMA);
+
+		if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
+					raw_read_cb, sms, NULL) > 0)
+			return;
+
+		qmi_param_free(param);
 	}
 }
 =

diff --git a/drivers/qmimodem/wms.h b/drivers/qmimodem/wms.h
index 21fe4d9..7e18ec9 100644
--- a/drivers/qmimodem/wms.h
+++ b/drivers/qmimodem/wms.h
@@ -25,6 +25,8 @@
 =

 #define QMI_WMS_RAW_SEND		32	/* Send a raw message */
 =

+#define QMI_WMS_RAW_READ		34	/* Read raw message from storage*/
+
 #define QMI_WMS_GET_MSG_LIST		49	/* Get list of messages from the device */
 #define QMI_WMS_SET_ROUTES		50	/* Set routes for message memory storage */
 #define QMI_WMS_GET_ROUTES		51	/* Get routes for message memory storage */
@@ -66,6 +68,13 @@ struct qmi_wms_param_message {
 =

 #define QMI_WMS_MESSAGE_MODE_GSMWCDMA		1
 =

+struct qmi_wms_raw_message {
+	uint8_t msg_tag;
+	uint8_t msg_format;
+	uint16_t msg_length;
+	uint8_t msg_data[0];
+} __attribute__((__packed__));
+
 /* Get routes for message memory storage */
 #define QMI_WMS_RESULT_ROUTE_LIST		0x01
 #define QMI_WMS_PARAM_ROUTE_LIST		0x01
-- =

2.9.3


--===============1847215165458375996==--

