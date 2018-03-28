Content-Type: multipart/mixed; boundary="===============1764566515290413405=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 23/30] qmi: use standard endian macros
Date: Wed, 28 Mar 2018 21:00:09 +0200
Message-ID: <20180328190016.28509-24-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1764566515290413405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 58 +++++++++++++++++++++++++---------------------=
----
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5178228b..b6280c05 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -192,15 +192,15 @@ static int __request_submit(struct qmi_device* device,
 	hdr =3D req->buf;
 =

 	hdr->frame =3D 0x01;
-	hdr->length =3D GUINT16_TO_LE(req->len - 1);
+	hdr->length =3D htole16(req->len - 1);
 	hdr->flags =3D 0x00;
 	hdr->service =3D service;
 	hdr->client =3D client;
 =

 	msg =3D req->buf + QMI_MUX_HDR_SIZE + headroom;
 =

-	msg->message =3D GUINT16_TO_LE(message);
-	msg->length =3D GUINT16_TO_LE(length);
+	msg->message =3D htole16(message);
+	msg->length =3D htole16(length);
 =

 	if (data && length > 0)
 		memcpy(req->buf + QMI_MUX_HDR_SIZE + headroom +
@@ -526,13 +526,13 @@ static void __debug_msg(const char dir, const void *b=
uf, size_t len,
 		}
 =

 		str +=3D sprintf(str, "%s msg=3D%d len=3D%d", type,
-					GUINT16_FROM_LE(msg->message),
-					GUINT16_FROM_LE(msg->length));
+					le16toh(msg->message),
+					le16toh(msg->length));
 =

 		str +=3D sprintf(str, " [client=3D%d,type=3D%d,tid=3D%d,len=3D%d]",
 					hdr->client, ctl->type,
 					ctl->transaction,
-					GUINT16_FROM_LE(hdr->length));
+					le16toh(hdr->length));
 	} else {
 		const struct qmi_service_hdr *srv;
 		const char *type;
@@ -558,13 +558,13 @@ static void __debug_msg(const char dir, const void *b=
uf, size_t len,
 		}
 =

 		str +=3D sprintf(str, "%s msg=3D%d len=3D%d", type,
-					GUINT16_FROM_LE(msg->message),
-					GUINT16_FROM_LE(msg->length));
+					le16toh(msg->message),
+					le16toh(msg->length));
 =

 		str +=3D sprintf(str, " [client=3D%d,type=3D%d,tid=3D%d,len=3D%d]",
 					hdr->client, srv->type,
-					GUINT16_FROM_LE(srv->transaction),
-					GUINT16_FROM_LE(hdr->length));
+					le16toh(srv->transaction),
+					le16toh(hdr->length));
 	}
 =

 	function(strbuf, user_data);
@@ -576,14 +576,14 @@ static void __debug_msg(const char dir, const void *b=
uf, size_t len,
 	str +=3D sprintf(str, "      ");
 	offset =3D 0;
 =

-	while (offset + QMI_TLV_HDR_SIZE < GUINT16_FROM_LE(msg->length)) {
+	while (offset + QMI_TLV_HDR_SIZE < le16toh(msg->length)) {
 		const struct qmi_tlv_hdr *tlv =3D ptr + offset;
-		uint16_t tlv_length =3D GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length =3D le16toh(tlv->length);
 =

 		if (tlv->type =3D=3D 0x02 && tlv_length =3D=3D QMI_RESULT_CODE_SIZE) {
 			const struct qmi_result_code *result =3D ptr + offset +
 							QMI_TLV_HDR_SIZE;
-			uint16_t error =3D GUINT16_FROM_LE(result->error);
+			uint16_t error =3D le16toh(result->error);
 			const char *error_str;
 =

 			error_str =3D __error_to_string(error);
@@ -738,8 +738,8 @@ static void handle_packet(struct qmi_device *device,
 =

 		msg =3D buf + QMI_CONTROL_HDR_SIZE;
 =

-		message =3D GUINT16_FROM_LE(msg->message);
-		length =3D GUINT16_FROM_LE(msg->length);
+		message =3D le16toh(msg->message);
+		length =3D le16toh(msg->length);
 =

 		data =3D buf + QMI_CONTROL_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
 =

@@ -763,12 +763,12 @@ static void handle_packet(struct qmi_device *device,
 =

 		msg =3D buf + QMI_SERVICE_HDR_SIZE;
 =

-		message =3D GUINT16_FROM_LE(msg->message);
-		length =3D GUINT16_FROM_LE(msg->length);
+		message =3D le16toh(msg->message);
+		length =3D le16toh(msg->length);
 =

 		data =3D buf + QMI_SERVICE_HDR_SIZE + QMI_MESSAGE_HDR_SIZE;
 =

-		tid =3D GUINT16_FROM_LE(service->transaction);
+		tid =3D le16toh(service->transaction);
 =

 		if (service->type =3D=3D 0x04) {
 			handle_indication(device, hdr->service, hdr->client,
@@ -823,7 +823,7 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 		if (hdr->frame !=3D 0x01 || hdr->flags !=3D 0x80)
 			break;
 =

-		len =3D GUINT16_FROM_LE(hdr->length) + 1;
+		len =3D le16toh(hdr->length) + 1;
 =

 		/* Check that packet size matches frame size */
 		if (bytes_read - offset < len)
@@ -1001,7 +1001,7 @@ void qmi_result_print_tlvs(struct qmi_result *result)
 =

 	while (len > QMI_TLV_HDR_SIZE) {
 		const struct qmi_tlv_hdr *tlv =3D ptr;
-		uint16_t tlv_length =3D GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length =3D le16toh(tlv->length);
 =

 		DBG("tlv: 0x%02x len 0x%04x", tlv->type, tlv->length);
 =

@@ -1019,7 +1019,7 @@ static const void *tlv_get(const void *data, uint16_t=
 size,
 =

 	while (len > QMI_TLV_HDR_SIZE) {
 		const struct qmi_tlv_hdr *tlv =3D ptr;
-		uint16_t tlv_length =3D GUINT16_FROM_LE(tlv->length);
+		uint16_t tlv_length =3D le16toh(tlv->length);
 =

 		if (tlv->type =3D=3D type) {
 			if (length)
@@ -1132,9 +1132,9 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 =

 	for (i =3D 0; i < service_list->count; i++) {
 		uint16_t major =3D
-			GUINT16_FROM_LE(service_list->services[i].major);
+			le16toh(service_list->services[i].major);
 		uint16_t minor =3D
-			GUINT16_FROM_LE(service_list->services[i].minor);
+			le16toh(service_list->services[i].minor);
 		uint8_t type =3D service_list->services[i].type;
 		const char *name =3D __service_type_to_string(type);
 =

@@ -1578,7 +1578,7 @@ bool qmi_param_append(struct qmi_param *param, uint8_=
t type,
 	tlv =3D ptr + param->length;
 =

 	tlv->type =3D type;
-	tlv->length =3D GUINT16_TO_LE(length);
+	tlv->length =3D htole16(length);
 	memcpy(tlv->value, data, length);
 =

 	param->data =3D ptr;
@@ -1769,7 +1769,7 @@ bool qmi_result_get_uint16(struct qmi_result *result,=
 uint8_t type,
 	memcpy(&tmp, ptr, 2);
 =

 	if (value)
-		*value =3D GUINT16_FROM_LE(tmp);
+		*value =3D le16toh(tmp);
 =

 	return true;
 }
@@ -1791,7 +1791,7 @@ bool qmi_result_get_uint32(struct qmi_result *result,=
 uint8_t type,
 	memcpy(&tmp, ptr, 4);
 =

 	if (value)
-		*value =3D GUINT32_FROM_LE(tmp);
+		*value =3D le32toh(tmp);
 =

 	return true;
 }
@@ -1813,7 +1813,7 @@ bool qmi_result_get_uint64(struct qmi_result *result,=
 uint8_t type,
 	memcpy(&tmp, ptr, 8);
 =

 	if (value)
-		*value =3D GUINT64_FROM_LE(tmp);
+		*value =3D le64toh(tmp);
 =

 	return true;
 }
@@ -2128,8 +2128,8 @@ static void service_send_callback(uint16_t message, u=
int16_t length,
 	if (len !=3D QMI_RESULT_CODE_SIZE)
 		goto done;
 =

-	result.result =3D GUINT16_FROM_LE(result_code->result);
-	result.error =3D GUINT16_FROM_LE(result_code->error);
+	result.result =3D le16toh(result_code->result);
+	result.error =3D le16toh(result_code->error);
 =

 done:
 	if (data->func)
-- =

2.15.1


--===============1764566515290413405==--

