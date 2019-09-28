Content-Type: multipart/mixed; boundary="===============5950484910815800325=="
MIME-Version: 1.0
From: Tom Nguyen <tomirq@earthlink.net>
Subject: Re: [PATCH v4] qmimodem: change msg class none to store/notify
Date: Sat, 28 Sep 2019 01:48:39 +0000
Message-ID: <1530553207.4266.1559751983478@wamui-aurora.atl.sa.earthlink.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5950484910815800325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change message class none configuration from directly delivering a new
message in the event indication to storing it in the modem's NV then
sending an event indication identifying the new message. Also, add
checking for stored, unread messages at boot up.

This fixes a scenario where the modem powers on, automatically
connects to the network, receives a message, and sends an indication
before oFono has fully initialized. Now, the message is saved and
retrieved after initialization.

This also helps with suspend/resume on platforms where the modem,
supports waking the host CPU upon SMS reception. And, the platform
design limitation is that the modem's interfaces (eg, cdc-wdm, wwan,
etc) disconnect on suspend and reconnect on resume. This causes oFono
to re-initialize and miss the message indication because it was sent
before oFono is ready. Now, the wake up message is saved and retrieved
after initialization.
---
 drivers/qmimodem/sms.c | 367 ++++++++++++++++++++++++++++++++++++++++++---=
----
 drivers/qmimodem/wms.h |  77 ++++++++---
 2 files changed, 376 insertions(+), 68 deletions(-)

diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 1e93039..033e6cc 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -39,8 +39,17 @@ struct sms_data {
 	struct qmi_service *wms;
 	uint16_t major;
 	uint16_t minor;
+	struct qmi_wms_read_msg_id rd_msg_id;
+	struct qmi_wms_result_msg_list *msg_list;
+	uint32_t rd_msg_num;
+	uint8_t msg_mode;
+	bool msg_mode_all;
+	bool msg_list_chk;
 };
 =

+static void get_msg_list(struct ofono_sms *sms);
+static void raw_read(struct ofono_sms *sms, uint8_t type, uint32_t ndx);
+
 static void get_smsc_addr_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -334,21 +343,93 @@ error:
 	g_free(cbd);
 }
 =

+static void delete_msg_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	uint16_t err;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &err))
+		DBG("Err: delete %d - %s", err, qmi_result_get_error(result));
+
+	/* Continue processing msg list. If error occurred, something
+	 * serious happened, then don't bother. */
+	if (data->msg_list && data->msg_list_chk) {
+		uint32_t msg =3D ++data->rd_msg_num;
+
+		/*
+		 * Get another msg. If list is empty check for more. Once query
+		 * returns empty, rely on event indication to get new msgs.
+		 */
+		if (msg < data->msg_list->cnt)
+			raw_read(sms, data->msg_list->msg[msg].type,
+				GUINT32_FROM_LE(data->msg_list->msg[msg].ndx));
+		else
+			get_msg_list(sms);
+	}
+}
+
+static void delete_msg(struct ofono_sms *sms, uint8_t tag)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_param *param;
+	qmi_result_func_t func =3D NULL;
+
+	DBG("");
+
+	param =3D qmi_param_new();
+	if (param =3D=3D NULL)
+		goto done;
+
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_STORE,
+				QMI_WMS_STORAGE_TYPE_NV);
+
+	if (tag =3D=3D QMI_WMS_MT_UNDEFINE) {
+		DBG("delete read msg type %d ndx %d", data->rd_msg_id.type,
+			data->rd_msg_id.ndx);
+
+		/* delete 1 msg */
+		qmi_param_append_uint32(param, QMI_WMS_PARAM_DEL_NDX,
+					data->rd_msg_id.ndx);
+		func =3D delete_msg_cb;
+	} else {
+		DBG("delete msg tag %d mode %d", tag, data->msg_mode);
+
+		/* delete all msgs from 1 tag type */
+		qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_TYPE, tag);
+	}
+
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_DEL_MODE, data->msg_mode);
+
+	if (qmi_service_send(data->wms, QMI_WMS_DELETE, param,
+				func, sms, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+done:
+	data->msg_list_chk =3D false;
+}
+
 static void raw_read_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms =3D user_data;
-	const struct qmi_wms_raw_message* msg;
-	uint16_t len;
-	uint16_t error;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	const struct qmi_wms_raw_message *msg;
+	uint16_t err;
 =

-	if (qmi_result_set_error(result, &error)) {
-		DBG("Raw read error: %d (%s)", error,
-			qmi_result_get_error(result));
+	DBG("");
+
+	if (qmi_result_set_error(result, &err)) {
+		DBG("Err: read %d - %s", err, qmi_result_get_error(result));
+		data->msg_list_chk =3D false;
 		return;
 	}
 =

 	/* Raw message data */
-	msg =3D qmi_result_get(result, 0x01, &len);
+	msg =3D qmi_result_get(result, QMI_WMS_RESULT_READ_MSG, NULL);
 	if (msg) {
 		uint16_t plen;
 		uint16_t tpdu_len;
@@ -357,9 +438,175 @@ static void raw_read_cb(struct qmi_result *result, vo=
id *user_data)
 		tpdu_len =3D plen - msg->msg_data[0] - 1;
 =

 		ofono_sms_deliver_notify(sms, msg->msg_data, plen, tpdu_len);
+	} else
+		DBG("Err: no data in type %d ndx %d", data->rd_msg_id.type,
+			data->rd_msg_id.ndx);
+
+	/* delete read msg */
+	delete_msg(sms, QMI_WMS_MT_UNDEFINE);
+}
+
+static void raw_read(struct ofono_sms *sms, uint8_t type, uint32_t ndx)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_param *param;
+
+	DBG("");
+
+	param =3D qmi_param_new();
+	if (param =3D=3D NULL)
+		goto done;
+
+	data->rd_msg_id.type =3D type;
+	data->rd_msg_id.ndx =3D ndx;
+
+	DBG("read type %d ndx %d", data->rd_msg_id.type, data->rd_msg_id.ndx);
+
+	qmi_param_append(param, QMI_WMS_PARAM_READ_MSG,
+				sizeof(data->rd_msg_id), &data->rd_msg_id);
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_READ_MODE, data->msg_mode);
+
+	if (qmi_service_send(data->wms, QMI_WMS_RAW_READ, param,
+				raw_read_cb, sms, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+done:
+	data->msg_list_chk =3D false;
+}
+
+static void get_msg_list_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_param *param;
+	const struct qmi_wms_result_msg_list *list;
+	uint32_t cnt =3D 0;
+	uint16_t tmp;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &tmp)) {
+		DBG("Err: get msg list mode=3D%d %d=3D%s", data->msg_mode, tmp,
+			qmi_result_get_error(result));
+		goto done;
+	}
+
+	list =3D qmi_result_get(result, QMI_WMS_RESULT_MSG_LIST, NULL);
+	if (list =3D=3D NULL) {
+		DBG("Err: get msg list empty");
+		goto done;
+	}
+
+	cnt =3D GUINT32_FROM_LE(list->cnt);
+	DBG("msgs found %d", cnt);
+
+	for (tmp =3D 0; tmp < cnt; tmp++) {
+		DBG("unread type %d ndx %d", list->msg[tmp].type,
+			GUINT32_FROM_LE(list->msg[tmp].ndx));
+	}
+
+	/* free list from last time */
+	if (data->msg_list) {
+		g_free(data->msg_list);
+		data->msg_list =3D NULL;
+	}
+
+	/* save list and get 1st msg */
+	if (cnt) {
+		int msg_size =3D cnt * sizeof(list->msg[0]);
+
+		data->msg_list =3D g_try_malloc0(sizeof(list->cnt) + msg_size);
+		if (data->msg_list =3D=3D NULL)
+			goto done;
+
+		data->msg_list->cnt =3D cnt;
+		memcpy(data->msg_list->msg, list->msg, msg_size);
+
+		data->rd_msg_num =3D 0;
+		raw_read(sms, data->msg_list->msg[0].type,
+				GUINT32_FROM_LE(data->msg_list->msg[0].ndx));
+		return;
+	}
+
+done:
+	data->msg_list_chk =3D false;
+
+	/* if both protocols supported, check the other */
+	if (data->msg_mode_all) {
+		data->msg_mode_all =3D false;
+		data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
+		get_msg_list(sms);
+	}
+}
+
+static void get_msg_list(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	struct qmi_param *param;
+
+	DBG("");
+
+	param =3D qmi_param_new();
+	if (param =3D=3D NULL)
+		return;
+
+	data->msg_list_chk =3D true;
+
+	/* query NOT_READ msg list */
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_STORAGE_TYPE,
+				QMI_WMS_STORAGE_TYPE_NV);
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_TAG_TYPE,
+				QMI_WMS_MT_NOT_READ);
+	qmi_param_append_uint8(param, QMI_WMS_PARAM_MESSAGE_MODE,
+				data->msg_mode);
+
+	if (qmi_service_send(data->wms, QMI_WMS_GET_MSG_LIST, param,
+				get_msg_list_cb, sms, NULL) > 0)
+		return;
+
+	data->msg_list_chk =3D false;
+	qmi_param_free(param);
+}
+
+static void get_msg_protocol_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+	uint16_t err;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &err) &&
+			(err !=3D QMI_ERR_OP_DEVICE_UNSUPPORTED)) {
+		DBG("Err: protocol %d - %s", err, qmi_result_get_error(result));
+		return;
+	}
+
+	if (err !=3D QMI_ERR_OP_DEVICE_UNSUPPORTED) {
+		/* modem supports only 1 protocol */
+		qmi_result_get_uint8(result, QMI_WMS_PARAM_PROTOCOL,
+					&data->msg_mode);
 	} else {
-		DBG("No message data available at requested position");
+		/* check both, start with 1 then switch to other */
+		DBG("device supports CDMA and WCDMA msg protocol");
+		data->msg_mode_all =3D true;
+		data->msg_mode =3D QMI_WMS_MESSAGE_MODE_CDMA;
 	}
+
+	/* check for messages */
+	get_msg_list(sms);
+}
+
+static void get_msg_protocol(struct ofono_sms *sms)
+{
+	struct sms_data *data =3D ofono_sms_get_data(sms);
+
+	DBG("");
+
+	qmi_service_send(data->wms, QMI_WMS_GET_MSG_PROTOCOL, NULL,
+				get_msg_protocol_cb, sms, NULL);
 }
 =

 static void event_notify(struct qmi_result *result, void *user_data)
@@ -367,66 +614,78 @@ static void event_notify(struct qmi_result *result, v=
oid *user_data)
 	struct ofono_sms *sms =3D user_data;
 	struct sms_data *data =3D ofono_sms_get_data(sms);
 	const struct qmi_wms_result_new_msg_notify *notify;
-	const struct qmi_wms_result_message *message;
-	uint16_t len;
 =

 	DBG("");
 =

-	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, &len);
+	/*
+	 * The 2 types of MT message TLVs are mutually exclusive, depending on
+	 * how the route action is configured. If action is store and notify,
+	 * then the MT message TLV is sent. If action is transfer only or
+	 * transfer and ack, then the transfer route MT message TLV is sent.
+	 */
+	notify =3D qmi_result_get(result, QMI_WMS_RESULT_NEW_MSG_NOTIFY, NULL);
 	if (notify) {
-		DBG("storage type %d index %d", notify->storage_type,
-				GUINT32_FROM_LE(notify->storage_index));
-	}
+		/* route is store and notify */
+		if (!qmi_result_get_uint8(result, QMI_WMS_RESULT_MSG_MODE,
+						&data->msg_mode))
+			DBG("msg mode not found, use mode %d", data->msg_mode);
+
+		DBG("msg type %d ndx %d mode %d", notify->storage_type,
+			GUINT32_FROM_LE(notify->storage_index), data->msg_mode);
+
+		/* don't read if list is being processed, get this msg later */
+		if (!data->msg_list_chk)
+			raw_read(sms, notify->storage_type,
+					GUINT32_FROM_LE(notify->storage_index));
+	} else {
+		/* route is either transfer only or transfer and ACK */
+		const struct qmi_wms_result_message *message;
 =

-	message =3D qmi_result_get(result, QMI_WMS_RESULT_MESSAGE, &len);
-	if (message) {
-		uint16_t plen;
+		message =3D qmi_result_get(result, QMI_WMS_RESULT_MESSAGE, NULL);
+		if (message) {
+			uint16_t plen;
 =

-		plen =3D GUINT16_FROM_LE(message->msg_length);
+			plen =3D GUINT16_FROM_LE(message->msg_length);
 =

-		DBG("ack_required %d transaction id %u", message->ack_required,
+			DBG("ack_required %d transaction id %u",
+				message->ack_required,
 				GUINT32_FROM_LE(message->transaction_id));
-		DBG("msg format %d PDU length %d", message->msg_format, plen);
+			DBG("msg format %d PDU length %d",
+				message->msg_format, plen);
 =

-		ofono_sms_deliver_notify(sms, message->msg_data, plen, plen);
-	} else {
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
+			ofono_sms_deliver_notify(sms, message->msg_data,
+							plen, plen);
+		}
 	}
 }
 =

 static void set_routes_cb(struct qmi_result *result, void *user_data)
 {
 	struct ofono_sms *sms =3D user_data;
+	struct sms_data *data =3D ofono_sms_get_data(sms);
 =

 	DBG("");
 =

 	ofono_sms_register(sms);
+
+	/*
+	 * Modem storage is limited. As a fail safe, delete processed messages
+	 * to free device memory to prevent blockage of new messages.
+	 */
+	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_CDMA;
+	delete_msg(sms, QMI_WMS_MT_READ);
+	delete_msg(sms, QMI_WMS_MO_SENT);
+	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
+	delete_msg(sms, QMI_WMS_MT_READ);
+	delete_msg(sms, QMI_WMS_MO_SENT);
+
+	/*
+	 * Subsystem initialized, now start process to check for unread
+	 * messages. First, query msg protocol/mode. If modem supports both
+	 * modes, then check messages for both modes since there's no way to
+	 * query which mode is active.
+	 */
+	get_msg_protocol(sms);
 }
 =

 static void get_routes_cb(struct qmi_result *result, void *user_data)
@@ -468,8 +727,8 @@ static void get_routes_cb(struct qmi_result *result, vo=
id *user_data)
 	new_list->count =3D GUINT16_TO_LE(1);
 	new_list->route[0].msg_type =3D QMI_WMS_MSG_TYPE_P2P;
 	new_list->route[0].msg_class =3D QMI_WMS_MSG_CLASS_NONE;
-	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NONE;
-	new_list->route[0].action =3D QMI_WMS_ACTION_TRANSFER_AND_ACK;
+	new_list->route[0].storage_type =3D QMI_WMS_STORAGE_TYPE_NV;
+	new_list->route[0].action =3D QMI_WMS_ACTION_STORE_AND_NOTIFY;
 =

 	param =3D qmi_param_new();
 	if (!param)
@@ -524,6 +783,9 @@ static void create_wms_cb(struct qmi_service *service, =
void *user_data)
 =

 	data->wms =3D qmi_service_ref(service);
 =

+	memset(&data->rd_msg_id, 0, sizeof(data->rd_msg_id));
+	data->msg_mode =3D QMI_WMS_MESSAGE_MODE_GSMWCDMA;
+
 	qmi_service_register(data->wms, QMI_WMS_EVENT,
 					event_notify, sms, NULL);
 =

@@ -568,6 +830,9 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 =

 	qmi_service_unref(data->wms);
 =

+	if (data->msg_list)
+		g_free(data->msg_list);
+
 	g_free(data);
 }
 =

diff --git a/drivers/qmimodem/wms.h b/drivers/qmimodem/wms.h
index 7e18ec9..f53fc1b 100644
--- a/drivers/qmimodem/wms.h
+++ b/drivers/qmimodem/wms.h
@@ -25,8 +25,9 @@
 =

 #define QMI_WMS_RAW_SEND		32	/* Send a raw message */
 =

-#define QMI_WMS_RAW_READ		34	/* Read raw message from storage*/
-
+#define QMI_WMS_RAW_READ		34	/* Read raw message from storage */
+#define QMI_WMS_DELETE			36	/* Delete message */
+#define QMI_WMS_GET_MSG_PROTOCOL	48	/* Get message protocol */
 #define QMI_WMS_GET_MSG_LIST		49	/* Get list of messages from the device */
 #define QMI_WMS_SET_ROUTES		50	/* Set routes for message memory storage */
 #define QMI_WMS_GET_ROUTES		51	/* Get routes for message memory storage */
@@ -45,6 +46,17 @@ struct qmi_wms_result_new_msg_notify {
 	uint32_t storage_index;
 } __attribute__((__packed__));
 =

+#define QMI_WMS_RESULT_MESSAGE			0x11
+struct qmi_wms_result_message {
+	uint8_t ack_required;				/* bool */
+	uint32_t transaction_id;
+	uint8_t msg_format;
+	uint16_t msg_length;
+	uint8_t msg_data[0];
+} __attribute__((__packed__));
+
+#define QMI_WMS_RESULT_MSG_MODE			0x12
+
 /* Set new message conditions */
 #define QMI_WMS_PARAM_NEW_MSG_REPORT		0x10	/* bool */
 =

@@ -57,23 +69,59 @@ struct qmi_wms_param_message {
 } __attribute__((__packed__));
 #define QMI_WMS_RESULT_MESSAGE_ID		0x01	/* uint16 */
 =

+/* Read a raw message */
+#define QMI_WMS_PARAM_READ_MSG			0x01
+struct qmi_wms_read_msg_id {
+	uint8_t  type;
+	uint32_t ndx;
+} __attribute__((__packed__));
+
+#define QMI_WMS_PARAM_READ_MODE			0x10
+
+#define QMI_WMS_RESULT_READ_MSG			0x01
+struct qmi_wms_raw_message {
+	uint8_t msg_tag;
+	uint8_t msg_format;
+	uint16_t msg_length;
+	uint8_t msg_data[0];
+} __attribute__((__packed__));
+
+/* Delete messages */
+#define QMI_WMS_PARAM_DEL_STORE			0x01
+#define QMI_WMS_PARAM_DEL_NDX			0x10
+#define QMI_WMS_PARAM_DEL_TYPE			0x11
+#define QMI_WMS_PARAM_DEL_MODE			0x12
+
+/* Get message protocol */
+#define QMI_WMS_PARAM_PROTOCOL			0x01
+
 /* Get list of messages from the device */
 #define QMI_WMS_PARAM_STORAGE_TYPE		0x01	/* uint8 */
+#define QMI_WMS_PARAM_TAG_TYPE			0x10
 #define QMI_WMS_PARAM_MESSAGE_MODE		0x11	/* uint8 */
 =

+#define QMI_WMS_RESULT_MSG_LIST			0x01
+struct qmi_wms_result_msg_list {
+	uint32_t cnt;
+	struct {
+		uint32_t ndx;
+		uint8_t  type;
+	} __attribute__((__packed__)) msg[0];
+} __attribute__((__packed__));
+
 #define QMI_WMS_STORAGE_TYPE_UIM		0
 #define QMI_WMS_STORAGE_TYPE_NV			1
 #define QMI_WMS_STORAGE_TYPE_UNKNOWN		2
 #define QMI_WMS_STORAGE_TYPE_NONE		255
 =

-#define QMI_WMS_MESSAGE_MODE_GSMWCDMA		1
+#define QMI_WMS_MT_READ				0x00
+#define QMI_WMS_MT_NOT_READ			0x01
+#define QMI_WMS_MO_SENT				0x02
+#define QMI_WMS_MO_NOT_SENT			0x03
+#define QMI_WMS_MT_UNDEFINE			0xff
 =

-struct qmi_wms_raw_message {
-	uint8_t msg_tag;
-	uint8_t msg_format;
-	uint16_t msg_length;
-	uint8_t msg_data[0];
-} __attribute__((__packed__));
+#define QMI_WMS_MESSAGE_MODE_CDMA		0x00
+#define QMI_WMS_MESSAGE_MODE_GSMWCDMA		0x01
 =

 /* Get routes for message memory storage */
 #define QMI_WMS_RESULT_ROUTE_LIST		0x01
@@ -89,14 +137,6 @@ struct qmi_wms_route_list {
 } __attribute__((__packed__));
 #define QMI_WMS_RESULT_STATUS_REPORT		0x10	/* bool */
 #define QMI_WMS_PARAM_STATUS_REPORT		0x10	/* bool */
-#define QMI_WMS_RESULT_MESSAGE			0x11
-struct qmi_wms_result_message {
-	uint8_t ack_required;				/* bool */
-	uint32_t transaction_id;
-	uint8_t msg_format;
-	uint16_t msg_length;
-	uint8_t msg_data[0];
-} __attribute__((__packed__));
 =

 #define QMI_WMS_MSG_TYPE_P2P			0x00
 #define QMI_WMS_MSG_TYPE_BROADCAST		0x01
@@ -134,3 +174,6 @@ struct qmi_wms_result_smsc_addr {
 #define QMI_WMS_DOMAIN_PS_PREFERRED		0x01
 #define QMI_WMS_DOMAIN_CS_ONLY			0x02
 #define QMI_WMS_DOMAIN_PS_ONLY			0x03
+
+/* Error code */
+#define QMI_ERR_OP_DEVICE_UNSUPPORTED		0x19
-- =

1.9.1


--===============5950484910815800325==--

