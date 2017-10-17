Content-Type: multipart/mixed; boundary="===============6304432497119083140=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] qmi: query SMS storage at startup
Date: Tue, 17 Oct 2017 11:05:16 +0200
Message-ID: <20171017090516.14504-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6304432497119083140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With this patch, the QMI modem will query the SMS messages in non-volatile
storage at startup.  For each message, it will get the PDU, and pass it
up the ofono stack via ofono_sms_deliver_notify.
---

Hi Alexander,

Here's a patch that queries the SMS storage at modem initialization.  This
seems to be what the atmodem driver does:  it queries the storage and passes
the messages up via ofono_sms_deliver_notify.  This works for my Quectel EC=
21,
but it's not obvious to me that this is actually the right thing to do.

GetMessages() returns nothing even after doing this.  The documentation
says that it returns 'pending' messages, so I assume this means it returns
just messages that are pending being sent...???

/Jonas

 drivers/qmimodem/sms.c | 133 ++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 105 insertions(+), 28 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 7e6baec..cc9a0b3 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -341,6 +341,8 @@ static void raw_read_cb(struct qmi_result *result, void=
 *user_data)
 	uint16_t len;
 	uint16_t error;
 =

+	DBG("");
+
 	if (qmi_result_set_error(result, &error)) {
 		DBG("Raw read error: %d (%s)", error,
 			qmi_result_get_error(result));
@@ -362,10 +364,45 @@ static void raw_read_cb(struct qmi_result *result, vo=
id *user_data)
 	}
 }
 =

+static void get_message_pdu(struct ofono_sms* sms,
+				uint8_t storage_type,
+				uint32_t storage_index)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_wms_result_new_msg_notify storage;
+	struct qmi_param *param;
+
+	DBG("");
+
+	param =3D qmi_param_new();
+	if (!param)
+		return;
+
+	storage.storage_type =3D storage_type;
+	storage.storage_index =3D GUINT32_TO_LE(storage_index);
+
+	/* Message memory storage ID */
+	qmi_param_append(param, 0x01, sizeof(storage), &storage);
+	/* The 'message mode' parameter is documented as optional,
+	 * but the Quectel EC21 errors out with error 17 (missing
+	 * argument) if it is not provided... we default to 3GPP
+	 * here because that's what works for me and it's not clear
+	 * how to actually query what this should be otherwise...
+	 */
+	/* Message mode */
+	qmi_param_append_uint8(param, 0x10,
+			QMI_WMS_MESSAGE_MODE_GSMWCDMA);
+
+	if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
+				raw_read_cb, sms, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+}
+
 static void event_notify(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms =3D user_data;
-	struct sms_data *data =3D ofono_sms_get_data(sms);
 	const struct qmi_wms_result_new_msg_notify *notify;
 	const struct qmi_wms_result_message *message;
 	uint16_t len;
@@ -390,43 +427,83 @@ static void event_notify(struct qmi_result *result, v=
oid *user_data)
 =

 		ofono_sms_deliver_notify(sms, message->msg_data, plen, plen);
 	} else {
-		/* The Quectel EC21, at least, does not provide the
-		 * message data in the event notification, so a 'raw read'
-		 * needs to be issued in order to query the message itself
-		 */
-		struct qmi_param *param;
-
-		param =3D qmi_param_new();
-		if (!param)
-			return;
-
-		/* Message memory storage ID */
-		qmi_param_append(param, 0x01, sizeof(*notify), notify);
-		/* The 'message mode' parameter is documented as optional,
-		 * but the Quectel EC21 errors out with error 17 (missing
-		 * argument) if it is not provided... we default to 3GPP
-		 * here because that's what works for me and it's not clear
-		 * how to actually query what this should be otherwise...
-		 */
-		/* Message mode */
-		qmi_param_append_uint8(param, 0x10,
-				QMI_WMS_MESSAGE_MODE_GSMWCDMA);
-
-		if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
-					raw_read_cb, sms, NULL) > 0)
-			return;
-
-		qmi_param_free(param);
+		get_message_pdu(sms, notify->storage_type,
+						notify->storage_index);
+	}
+}
+
+static void get_messages_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	uint16_t len;
+	uint16_t error;
+	const struct {
+		uint32_t msg_count;
+		struct {
+			uint32_t index;
+			uint8_t tag;
+		} __attribute__((__packed__)) msg[0];
+	} __attribute__((__packed__)) *msglist;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("Get messages error: %d (%s)", error,
+			qmi_result_get_error(result));
+		return;
+	}
+
+	msglist =3D qmi_result_get(result, 0x01, &len);
+	if (msglist) {
+		int n;
+		int i;
+		uint32_t index;
+		n =3D GUINT16_FROM_LE(msglist->msg_count);
+		DBG("%d SMS in NV storage", n);
+		for (i =3D 0; i < n; i++) {
+			index =3D GUINT32_FROM_LE(msglist->msg[i].index);
+			DBG("Found message at index: %d (tag %hhd)", index,
+				msglist->msg[i].tag);
+			get_message_pdu(sms, QMI_WMS_STORAGE_TYPE_NV, index);
+		}
 	}
 }
 =

 static void set_routes_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_param *param;
 =

 	DBG("");
 =

 	ofono_sms_register(sms);
+
+	param =3D qmi_param_new();
+	if (!param)
+		return;
+
+	/* Storage type */
+	qmi_param_append_uint8(param, 0x01, QMI_WMS_STORAGE_TYPE_NV);
+	/* The 'message mode' parameter is documented as optional,
+	 * but the Quectel EC21 errors out with error 17 (missing
+	 * argument) if it is not provided... we default to 3GPP
+	 * here because that's what works for me and it's not clear
+	 * how to actually query what this should be otherwise...
+	 */
+	/* Message tag */
+	/* This parameter is documented as 'optional' but the Quectel EC21
+	 * returns error 17 (MISSING ARG) without it...
+	 */
+	qmi_param_append_uint8(param, 0x11, 1);
+
+	if (qmi_service_send(data->wms, QMI_WMS_GET_MSG_LIST, param,
+					get_messages_cb, sms, NULL) > 0)
+		return;
+
+	DBG("Failed to query SMS message list");
+
+	qmi_param_free(param);
 }
 =

 static void get_routes_cb(struct qmi_result *result, void *user_data)
-- =

2.9.3


--===============6304432497119083140==--

