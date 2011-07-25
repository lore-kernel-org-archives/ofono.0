Content-Type: multipart/mixed; boundary="===============0655778744280086618=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] add CDMA SMS decoding/encoding support
Date: Mon, 25 Jul 2011 17:33:44 +0800
Message-ID: <1311586424-20541-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0655778744280086618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

diff --git a/src/cdma-sms.c b/src/cdma-sms.c
index ea88028..49a349f 100644
--- a/src/cdma-sms.c
+++ b/src/cdma-sms.c
@@ -100,7 +100,7 @@ static void ofono_cdma_sms_process_wmt_deliver(struct o=
fono_cdma_sms *cdma_sms,
 	const char *oaddr;
 	const struct cdma_sms_ud *ud;
 =

-	ud =3D &incoming->p2p_msg.bd.wmt_deliver.ud;
+	ud =3D &incoming->p2p_msg.bd.deliver.ud;
 =

 	/*
 	 * If incoming message does not contain USER DATA, still
@@ -115,7 +115,7 @@ static void ofono_cdma_sms_process_wmt_deliver(struct o=
fono_cdma_sms *cdma_sms,
 	if (message =3D=3D NULL)
 		return;
 =

-	oaddr =3D cdma_sms_address_to_string(&incoming->p2p_msg.oaddr);
+	oaddr =3D cdma_sms_address_to_string(&incoming->p2p_msg.addr);
 	if (oaddr =3D=3D NULL) {
 		g_free(message);
 		return;
diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
index dfa3403..3fac323 100644
--- a/src/cdma-smsutil.c
+++ b/src/cdma-smsutil.c
@@ -31,8 +31,9 @@
 #include <unistd.h>
 =

 #include <glib.h>
-
+#include "stdio.h"
 #include "cdma-smsutil.h"
+#include "smsutil.h"
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -40,7 +41,7 @@ enum cdma_sms_rec_flag {
 	CDMA_SMS_REC_FLAG_MANDATORY =3D	1,
 };
 =

-typedef gboolean (*rec_handler)(const guint8 *, guint8, void *);
+typedef gboolean (*dec_handler)(const guint8 *, guint8, void **);
 =

 struct simple_iter {
 	guint8 max;
@@ -51,6 +52,16 @@ struct simple_iter {
 	const guint8 *data;
 };
 =

+struct param_item {
+	guint8 id;
+	guint8 len;
+	void *data;
+};
+
+static gboolean decode_bearer_data(const guint8 *data, guint8 len,
+			struct cdma_sms_bearer_data *bd);
+static guint8 bit_field_unpack(const guint8 *buf, guint16 offset, guint8 n=
bit);
+
 static void simple_iter_init(struct simple_iter *iter,
 				const guint8 *pdu, guint8 len)
 {
@@ -112,6 +123,48 @@ static inline void set_bitmap(guint32 *bitmap, guint8 =
pos)
 	*bitmap =3D *bitmap | (1 << pos);
 }
 =

+
+static void free_param_item(struct param_item *item, void *user_data)
+{
+	if (item !=3D NULL)
+		g_free(item->data);
+
+	g_free(item);
+}
+
+static void *get_param(GSList *params, guint id)
+{
+	GSList *l =3D params;
+
+	for (; l; l =3D l->next) {
+		struct param_item *item =3D l->data;
+
+		if (item->id =3D=3D id)
+			return item->data;
+	}
+
+	return NULL;
+}
+
+static gboolean set_parameter(GSList *params, void *param, guint8 id,
+				guint32 size, guint32 *bitmap)
+{
+	void *value;
+
+	value =3D get_param(params,  id);
+
+	if (value !=3D NULL) {
+		memcpy(param, value, size);
+
+		if (bitmap !=3D NULL)
+			set_bitmap(bitmap, id);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 /* Unpacks the byte stream. The field has to be <=3D 8 bits. */
 static guint8 bit_field_unpack(const guint8 *buf, guint16 offset, guint8 n=
bit)
 {
@@ -144,76 +197,125 @@ static gboolean dtmf_to_ascii(char *buf, const guint=
8 *addr,
 	 * Note, 0 is NOT a valid value and not mapped to
 	 * any valid DTMF digit.
 	 */
-	static const char dtmf_digits[13] =3D {0, '1', '2', '3', '4', '5', '6',
+	const char dtmf_digits[13] =3D {0, '1', '2', '3', '4', '5', '6',
 						'7', '8', '9', '0', '*', '#'};
-	guint8 index;
+	guint8 i;
 	guint8 value;
+	guint16 bit_offset =3D 0;
+
+	for (i =3D 0; i < num_fields; i++) {
+		value =3D bit_field_unpack(addr, bit_offset, 4);
+		bit_offset +=3D 4;
 =

-	for (index =3D 0; index < num_fields; index++) {
-		if (addr[index] =3D=3D 0 || addr[index] > 12)
+		if (value =3D=3D 0 || value > 12)
 			return FALSE;  /* Invalid digit in address field */
 =

-		value =3D addr[index];
-		buf[index] =3D dtmf_digits[value];
+		buf[i] =3D dtmf_digits[value];
 	}
 =

-	buf[index] =3D 0; /* Make it NULL terminated string */
+	buf[i] =3D 0; /* Make it NULL terminated string */
 =

 	return TRUE;
 }
 =

-const char *cdma_sms_address_to_string(const struct cdma_sms_address *addr)
+static guint8 get_character_length(enum cdma_sms_msg_encoding encoding)
 {
-	static char buf[CDMA_SMS_MAX_ADDR_FIELDS + 1];
+	guint8 chari_len =3D 8;
 =

-	/* TODO: Only support CDMA_SMS_DIGIT_MODE_4BIT_DTMF currently */
-	switch (addr->digit_mode) {
-	case CDMA_SMS_DIGIT_MODE_4BIT_DTMF:
-		if (dtmf_to_ascii(buf, addr->address,
-					addr->num_fields) =3D=3D TRUE)
-			return buf;
-		else
-			return NULL;
-	case CDMA_SMS_DIGIT_MODE_8BIT_ASCII:
-		return NULL;
+	switch (encoding) {
+	case CDMA_SMS_MSG_ENCODING_OCTET:
+	case CDMA_SMS_MSG_ENCODING_SHIFT_JIS:
+	case CDMA_SMS_MSG_ENCODING_KOREAN:
+	case CDMA_SMS_MSG_ENCODING_LATIN_HEBREW:
+	case CDMA_SMS_MSG_ENCODING_LATIN:
+		chari_len =3D 8;
+		break;
+
+	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
+	case CDMA_SMS_MSG_ENCODING_IA5:
+	case CDMA_SMS_MSG_ENCODING_GSM_7BIT:
+		chari_len =3D 7;
+		break;
+
+	case CDMA_SMS_MSG_ENCODING_UNICODE:
+		chari_len =3D 16;
+		break;
+
+	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
+	case CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING:
+		break;
 	}
 =

-	return NULL;
+	return chari_len;
 }
 =

-/* Decode Teleservice ID */
-static gboolean cdma_sms_decode_teleservice(const guint8 *buf, guint8 len,
-								void *data)
-{
-	enum cdma_sms_teleservice_id *id =3D data;
-
-	*id =3D bit_field_unpack(buf, 0, 8) << 8 |
-				bit_field_unpack(buf, 8, 8);
-
-	switch (*id) {
-	case CDMA_SMS_TELESERVICE_ID_CMT91:
-	case CDMA_SMS_TELESERVICE_ID_WPT:
-	case CDMA_SMS_TELESERVICE_ID_WMT:
-	case CDMA_SMS_TELESERVICE_ID_VMN:
-	case CDMA_SMS_TELESERVICE_ID_WAP:
-	case CDMA_SMS_TELESERVICE_ID_WEMT:
-	case CDMA_SMS_TELESERVICE_ID_SCPT:
-	case CDMA_SMS_TELESERVICE_ID_CATPT:
-		return TRUE;
+/* extract raw data from pdu
+  *
+  * total_bits: total bits to extract
+  * bit_offset: the start bit pos
+*/
+static void extract_raw_data(guint8 *to, const guint8 *from, guint16 total=
_bits,
+				guint16 bit_offset)
+{
+	guint8  i;
+	int count =3D total_bits / 8;
+	guint8 remain_bits =3D  total_bits % 8;
+
+	for (i =3D 0; i < count; i++) {
+		to[i] =3D bit_field_unpack(from, bit_offset, 8);
+		bit_offset +=3D 8;
 	}
 =

-	return FALSE; /* Invalid teleservice type */
+	if (remain_bits !=3D 0)
+		to[i] =3D bit_field_unpack(from, bit_offset, remain_bits)
+					<< (8 - remain_bits);
+}
+
+/* Decode Teleservice ID */
+static gboolean decode_param_teleservice(const guint8 *buf,
+			guint8 len, void **data)
+{
+	enum cdma_sms_teleservice_id *id;
+
+	if (len !=3D 2)
+		return FALSE;
+
+	id =3D g_new0(enum cdma_sms_teleservice_id, 1);
+
+	*id =3D *buf << 8 | *(buf + 1);
+
+	*data =3D id;
+
+	return TRUE;
+}
+
+/* Decode Service category */
+static gboolean decode_param_service_category(const guint8 *buf,
+			guint8 len, void **data)
+{
+	enum cdma_sms_service_cat *cat;
+
+	if (len !=3D 2)
+		return FALSE;
+
+	cat =3D g_new0(enum cdma_sms_service_cat, 1);
+
+	*cat =3D *buf << 8 | *(buf + 1);
+
+	*data =3D cat;
+
+	return TRUE;
 }
 =

-/* Decode Address parameter record */
-static gboolean cdma_sms_decode_addr(const guint8 *buf, guint8 len,
-							void *data)
+/* Decode Address parameter */
+static gboolean decode_param_addr(const guint8 *buf, guint8 len, void **da=
ta)
 {
-	struct cdma_sms_address *addr =3D data;
+	struct cdma_sms_address *addr;
 	guint16 bit_offset =3D 0;
 	guint8  chari_len;
 	guint16 total_num_bits =3D len * 8;
-	guint8  index;
+
+	addr =3D g_new0(struct cdma_sms_address, 1);
 =

 	addr->digit_mode =3D bit_field_unpack(buf, bit_offset, 1);
 	bit_offset +=3D 1;
@@ -232,8 +334,10 @@ static gboolean cdma_sms_decode_addr(const guint8 *buf=
, guint8 len,
 		bit_offset +=3D 3;
 =

 		if (addr->number_mode =3D=3D CDMA_SMS_NUM_MODE_DIGIT) {
-			if (bit_offset + 4 > total_num_bits)
+			if (bit_offset + 4 > total_num_bits) {
+				g_free(addr);
 				return FALSE;
+			}
 =

 			addr->number_plan =3D
 				bit_field_unpack(buf, bit_offset, 4);
@@ -241,8 +345,10 @@ static gboolean cdma_sms_decode_addr(const guint8 *buf=
, guint8 len,
 		}
 	}
 =

-	if (bit_offset + 8 > total_num_bits)
+	if (bit_offset + 8 > total_num_bits) {
+		g_free(addr);
 		return FALSE;
+	}
 =

 	addr->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
 	bit_offset +=3D 8;
@@ -252,484 +358,1279 @@ static gboolean cdma_sms_decode_addr(const guint8 =
*buf, guint8 len,
 	else
 		chari_len =3D 8;
 =

-	if ((bit_offset + chari_len * addr->num_fields) > total_num_bits)
+	if ((bit_offset + chari_len * addr->num_fields) > total_num_bits) {
+		g_free(addr);
 		return FALSE;
-
-	for (index =3D 0; index < addr->num_fields; index++) {
-		addr->address[index] =3D bit_field_unpack(buf,
-							bit_offset,
-							chari_len);
-		bit_offset +=3D chari_len;
 	}
 =

+	extract_raw_data(addr->address, buf, addr->num_fields * chari_len,
+						bit_offset);
+
+	*data =3D addr;
+
 	return TRUE;
 }
 =

-static char *decode_text_7bit_ascii(const struct cdma_sms_ud *ud)
+static gboolean decode_param_subaddr(const guint8 *buf, guint8 len,
+				void **data)
+{
+	/* TODO */
+	return FALSE;
+}
+
+static gboolean decode_param_bearer_reply_option(const guint8 *buf,
+			guint8 len, void **data)
 {
-	char *buf;
+	struct cdma_sms_bearer_reply_option *option;
 =

-	buf =3D g_new(char, ud->num_fields + 1);
-	if (buf =3D=3D NULL)
-		return NULL;
+	if (len !=3D 1)
+		return FALSE;
 =

-	memcpy(buf, ud->chari, ud->num_fields);
-	buf[ud->num_fields] =3D 0; /* Make it NULL terminated string */
+	option =3D g_new0(struct cdma_sms_bearer_reply_option, 1);
+	*data =3D option;
 =

-	return buf;
+	option->reply_seq =3D bit_field_unpack(buf, 0, 6);
+
+	return TRUE;
 }
 =

-char *cdma_sms_decode_text(const struct cdma_sms_ud *ud)
+static gboolean decode_param_cause_codes(const guint8 *buf,
+			guint8 len, void **data)
 {
-	switch (ud->msg_encoding) {
-	case CDMA_SMS_MSG_ENCODING_OCTET:
-	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
-		return NULL; /* TODO */
-	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
-		return decode_text_7bit_ascii(ud);
-	case CDMA_SMS_MSG_ENCODING_IA5:
-	case CDMA_SMS_MSG_ENCODING_UNICODE:
-	case CDMA_SMS_MSG_ENCODING_SHIFT_JIS:
-	case CDMA_SMS_MSG_ENCODING_KOREAN:
-	case CDMA_SMS_MSG_ENCODING_LATIN_HEBREW:
-	case CDMA_SMS_MSG_ENCODING_LATIN:
-	case CDMA_SMS_MSG_ENCODING_GSM_7BIT:
-	case CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING:
-		return NULL; /* TODO */
-	}
+	struct cdma_sms_cause_code *cause;
 =

-	return NULL;
+	if (len > 2 || len =3D=3D 0)
+		return FALSE;
+
+	cause =3D g_new0(struct cdma_sms_cause_code, 1);
+	*data =3D cause;
+
+	cause->reply_seq =3D bit_field_unpack(buf, 0, 6);
+	cause->error_class =3D bit_field_unpack(buf, 6, 2);
+
+	if (len > 1)
+		cause->cause_code =3D *(buf + 1);
+
+	return TRUE;
 }
 =

-/* Decode User Data */
-static gboolean cdma_sms_decode_ud(const guint8 *buf, guint8 len, void *da=
ta)
+static gboolean decode_param_bearer_data(const guint8 *buf,
+			guint8 len, void **data)
 {
-	guint16 bit_offset =3D 0;
-	guint8  chari_len =3D 0;
-	guint16 total_num_bits =3D len * 8;
-	guint8  index;
-	enum cdma_sms_msg_encoding  msg_encoding;
-	struct cdma_sms_ud *ud =3D data;
+	struct cdma_sms_bearer_data *bd;
+	gboolean ret;
 =

-	if (total_num_bits < 13)
-		return FALSE;
+	bd =3D g_new0(struct cdma_sms_bearer_data, 1);
 =

-	msg_encoding =3D bit_field_unpack(buf, bit_offset, 5);
-	ud->msg_encoding =3D  msg_encoding;
-	bit_offset +=3D 5;
+	ret =3D decode_bearer_data(buf, len, bd);
 =

-	if (msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG ||
-		msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING) {
-		/*
-		 * Skip message type field for now.
-		 * TODO: Add support for message type field.
-		 */
-		bit_offset +=3D 8;
-	}
+	if (ret =3D=3D FALSE)
+		g_free(bd);
 =

-	if (bit_offset + 8 > total_num_bits)
-		return FALSE;
+	*data =3D bd;
 =

-	ud->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
-	bit_offset +=3D 8;
+	return ret;
+}
 =

-	switch (msg_encoding) {
-	case CDMA_SMS_MSG_ENCODING_OCTET:
-		chari_len =3D 8;
-		break;
-	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
-		return FALSE; /* TODO */
-	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
-	case CDMA_SMS_MSG_ENCODING_IA5:
-		chari_len =3D 7;
-		break;
-	case CDMA_SMS_MSG_ENCODING_UNICODE:
-	case CDMA_SMS_MSG_ENCODING_SHIFT_JIS:
-	case CDMA_SMS_MSG_ENCODING_KOREAN:
-		return FALSE; /* TODO */
-	case CDMA_SMS_MSG_ENCODING_LATIN_HEBREW:
-	case CDMA_SMS_MSG_ENCODING_LATIN:
-		chari_len =3D 8;
-		break;
-	case CDMA_SMS_MSG_ENCODING_GSM_7BIT:
-		chari_len =3D 7;
-		break;
-	case CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING:
-		return FALSE; /* TODO */
-	}
+static dec_handler get_param_dec_handler_by_id(enum cdma_sms_param_id id)
+{
+	switch (id) {
+	case CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER:
+		return decode_param_teleservice;
 =

-	/* TODO: Add support for all other encoding types */
-	if (chari_len =3D=3D 0)
-		return FALSE;
+	case CDMA_SMS_PARAM_ID_SERVICE_CATEGORY:
+		return decode_param_service_category;
 =

-	if (bit_offset + chari_len * ud->num_fields > total_num_bits)
-		return FALSE;
+	case CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS:
+	case CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS:
+		return decode_param_addr;
+
+	case CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS:
+	case CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS:
+		return decode_param_subaddr;
+
+	case CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION:
+		return decode_param_bearer_reply_option;
+
+	case CDMA_SMS_PARAM_ID_CAUSE_CODE:
+		return decode_param_cause_codes;
 =

-	for (index =3D 0; index < ud->num_fields; index++) {
-		ud->chari[index] =3D bit_field_unpack(buf,
-						bit_offset,
-						chari_len);
-		bit_offset +=3D chari_len;
+	case CDMA_SMS_PARAM_ID_BEARER_DATA:
+		return decode_param_bearer_data;
 	}
 =

-	return TRUE;
+	return NULL;
 }
 =

 /* Decode Message Identifier */
-static gboolean cdma_sms_decode_message_id(const guint8 *buf, guint8 len,
-						void *data)
+static gboolean decode_subparam_message_id(const guint8 *buf,
+			guint8 len, void **data)
 {
-	struct cdma_sms_identifier *id =3D data;
+	struct cdma_sms_msg_id *id;
 =

 	if (len !=3D 3)
 		return FALSE;
 =

+	id =3D g_new0(struct cdma_sms_msg_id, 1);
+
 	id->msg_type =3D bit_field_unpack(buf, 0, 4);
 =

 	if (id->msg_type <=3D 0 ||
-			id->msg_type > CDMA_SMS_MSG_TYPE_SUBMIT_REPORT)
+			id->msg_type > CDMA_SMS_MSG_TYPE_SUBMIT_REPORT) {
+		g_free(id);
 		return FALSE; /* Invalid message type */
+	}
 =

 	id->msg_id =3D (bit_field_unpack(buf, 4, 8) << 8) |
 			bit_field_unpack(buf, 12, 8);
 =

 	id->header_ind =3D bit_field_unpack(buf, 20, 1);
 =

+	*data =3D id;
+
 	return TRUE;
 }
 =

-static gboolean find_and_decode(struct simple_iter *iter, guint8 rec_id,
-					rec_handler handler, void *data)
-{
-	guint8 id;
-	guint8 len;
-	const guint8 *buf;
 =

-	while (simple_iter_next(iter) =3D=3D TRUE) {
-		id =3D simple_iter_get_id(iter);
-		if (id !=3D rec_id)
-			continue;
+/* Decode User Data */
+static gboolean decode_subparam_ud(const guint8 *buf, guint8 len, void **d=
ata)
+{
+	enum cdma_sms_msg_encoding  msg_encoding;
+	struct cdma_sms_ud *ud;
+	guint16 bit_offset =3D 0;
+	guint16 total_num_bits =3D len * 8;
+	guint8 chari_len;
 =

-		len =3D simple_iter_get_length(iter);
-		buf =3D simple_iter_get_data(iter);
+	if (total_num_bits < 13)
+		return FALSE;
 =

-		return handler(buf, len, data);
-	}
+	ud =3D g_new0(struct cdma_sms_ud, 1);
 =

-	return FALSE;
-}
+	msg_encoding =3D bit_field_unpack(buf, bit_offset, 5);
+	ud->msg_encoding =3D  msg_encoding;
+	bit_offset +=3D 5;
 =

-static rec_handler subparam_handler_for_id(enum cdma_sms_subparam_id id)
-{
-	switch (id) {
-	case CDMA_SMS_SUBPARAM_ID_MESSAGE_ID:
-		return cdma_sms_decode_message_id;
-	case CDMA_SMS_SUBPARAM_ID_USER_DATA:
-		return cdma_sms_decode_ud;
-	case CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE:
-	case CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP:
-	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE:
-	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE:
-	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE:
-	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE:
-	case CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR:
-	case CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR:
-	case CDMA_SMS_SUBPARAM_ID_REPLY_OPTION:
-	case CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES:
-	case CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY:
-	case CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR:
-	case CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER:
-	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE:
-	case CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA:
-	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX:
-	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA:
-	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT:
-	case CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS:
-	case CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE:
-	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN:
-	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK:
-		return NULL; /* TODO */
+	if (msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG ||
+		msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING) {
+		ud->type =3D bit_field_unpack(buf, bit_offset, 8);
+		bit_offset +=3D 8;
 	}
 =

-	return NULL;
-}
+	if (bit_offset + 8 > total_num_bits) {
+		g_free(ud);
+		return FALSE;
+	}
 =

-struct subparam_handler_entry {
-	enum cdma_sms_subparam_id id;
-	int flags;
-	gboolean found;
-	void *data;
-};
+	ud->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
 =

-static gboolean decode_subparams(struct simple_iter *iter, guint32 *bitmap,
-					void *data, ...)
-{
-	GSList *entries =3D NULL;
-	GSList *l;
-	va_list args;
-	gboolean decode_result =3D TRUE;
+	chari_len =3D get_character_length(msg_encoding);
 =

-	va_start(args, data);
+	if (bit_offset + ud->num_fields * chari_len > total_num_bits) {
+		g_free(ud);
+		return FALSE;
+	}
 =

-	while (data !=3D NULL) {
-		struct subparam_handler_entry *entry;
+	/* just copy orginal data */
+	extract_raw_data(ud->data, buf, ud->num_fields * chari_len,
+					bit_offset);
 =

-		entry =3D g_new0(struct subparam_handler_entry, 1);
+	*data =3D ud;
 =

-		entry->data =3D data;
-		entry->id =3D va_arg(args, enum cdma_sms_subparam_id);
-		entry->flags =3D va_arg(args, int);
+	return TRUE;
+}
 =

-		data =3D va_arg(args, void *);
-		entries =3D g_slist_prepend(entries, entry);
-	}
+static gboolean decode_subparam_time(const guint8 *buf,
+			guint8 len, void **data)
+{
+	struct cdma_sms_time *time;
 =

-	va_end(args);
+	if (len !=3D 6)
+		return FALSE;
 =

-	entries =3D g_slist_reverse(entries);
+	time =3D g_new0(struct cdma_sms_time, 1);
 =

-	l =3D entries;
-	while (simple_iter_next(iter) =3D=3D TRUE) {
-		rec_handler handler;
-		struct subparam_handler_entry *entry;
-		guint8 subparam_len;
-		const guint8 *subparam_buf;
-		GSList *l2;
+	time->year =3D  ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+	if (time->year >=3D 96)
+		time->year +=3D 1900;
+	else
+		time->year +=3D 2000;
+	buf++;
 =

-		for (l2 =3D l; l2; l2 =3D l2->next) {
-			entry =3D l2->data;
+	time->month =3D  ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+	buf++;
 =

-			if (simple_iter_get_id(iter) =3D=3D entry->id)
-				break;
-		}
+	time->day =3D ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+	buf++;
 =

-		/* Ignore unexpected subparameter record */
-		if (l2 =3D=3D NULL)
-			continue;
+	time->hour =3D ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+	buf++;
 =

-		entry->found =3D TRUE;
+	time->min =3D  ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+	buf++;
 =

-		subparam_len =3D simple_iter_get_length(iter);
-		subparam_buf =3D simple_iter_get_data(iter);
+	time->sec =3D  ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
 =

-		handler =3D subparam_handler_for_id(entry->id);
+	*data =3D time;
 =

-		decode_result =3D handler(subparam_buf,
-					subparam_len,
-					entry->data);
-		if (decode_result =3D=3D FALSE)
-			break; /* Stop if decoding failed */
+	return TRUE;
+}
 =

-		set_bitmap(bitmap, entry->id);
-	}
+static gboolean decode_subparam_byte(const guint8 *buf, guint8 len,
+			void **data)
+{
+	guint8 *byte;
 =

-	for (; l; l =3D l->next) {
-		struct subparam_handler_entry *entry =3D l->data;
+	if (len !=3D 1)
+		return FALSE;
 =

-		if ((entry->flags & CDMA_SMS_REC_FLAG_MANDATORY) &&
-			(entry->found =3D=3D FALSE)) {
-			decode_result =3D FALSE;
-			break;
-		}
-	}
+	byte =3D g_new0(guint8, 1);
+	*data =3D byte;
 =

-	g_slist_foreach(entries, (GFunc) g_free, NULL);
-	g_slist_free(entries);
+	*byte =3D *buf;
 =

-	return decode_result;
+	return TRUE;
 }
 =

-/* Decode WMT */
-static gboolean cdma_sms_decode_wmt(struct simple_iter *iter,
-					struct cdma_sms_bearer_data *bd)
+static gboolean decode_subparam_priority_indicator(const guint8 *buf,
+			guint8 len, void **data)
 {
-	switch (bd->id.msg_type) {
-	case CDMA_SMS_MSG_TYPE_RESERVED:
-		return FALSE; /* Invalid */
-	case CDMA_SMS_MSG_TYPE_DELIVER:
-		/*
-		 * WMT DELIVER, table 4.3.4-1 of C.S0015-B v2.0
-		 * TODO: Not all optional subparameters supported.
-		 */
-		return decode_subparams(iter,
-					&bd->subparam_bitmap,
-					&bd->wmt_deliver.ud,
-					CDMA_SMS_SUBPARAM_ID_USER_DATA,
-					0,
-					NULL);
-		break;
-	case CDMA_SMS_MSG_TYPE_SUBMIT:
-	case CDMA_SMS_MSG_TYPE_CANCEL:
-		return FALSE; /* Invalid for MT WMT */
-	case CDMA_SMS_MSG_TYPE_DELIVER_ACK:
-	case CDMA_SMS_MSG_TYPE_USER_ACK:
-	case CDMA_SMS_MSG_TYPE_READ_ACK:
-		return FALSE; /* TODO: Not supported yet */
-	case CDMA_SMS_MSG_TYPE_DELIVER_REPORT:
-	case CDMA_SMS_MSG_TYPE_SUBMIT_REPORT:
-		return FALSE; /* Invalid for MT WMT */
+	enum cdma_sms_priority *pri;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	pri =3D g_new0(enum cdma_sms_priority, 1);
+	*data =3D pri;
+
+	*pri =3D bit_field_unpack(buf, 0, 2);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_privacy_indicator(const guint8 *buf,
+			guint8 len, void **data)
+{
+	enum cdma_sms_privacy *pri;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	pri =3D g_new0(enum cdma_sms_privacy, 1);
+	*data =3D pri;
+
+	*pri =3D bit_field_unpack(buf, 0, 2);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_reply_option(const guint8 *buf,
+			guint8 len, void **data)
+{
+	struct cdma_sms_reply_option *option;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	option =3D g_new0(struct cdma_sms_reply_option, 1);
+	*data =3D option;
+
+	option->user_ack_req =3D bit_field_unpack(buf, 0, 1);
+	option->dak_req =3D bit_field_unpack(buf, 1, 1);
+	option->read_ack_req =3D bit_field_unpack(buf, 2, 1);
+	option->report_ack =3D bit_field_unpack(buf, 3, 1);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_num_of_msgs(const guint8 *buf,
+			guint8 len, void **data)
+{
+	guint8 *num;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	num =3D g_new0(guint8, 1);
+	*data =3D num;
+
+	*num =3D ((*buf & 0xF0) >> 4) * 10 + (*buf & 0x0F);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_alert_on_delivery(const guint8 *buf,
+			guint8 len, void **data)
+{
+	enum cdma_sms_alert *alert;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	alert =3D g_new0(enum cdma_sms_alert, 1);
+	*data =3D alert;
+
+	*alert =3D bit_field_unpack(buf, 0, 2);
+	return TRUE;
+}
+
+static gboolean decode_subparam_callback_number(const guint8 *buf,
+			guint8 len, void **data)
+{
+	struct cdma_sms_address *addr;
+	guint16 bit_offset =3D 0;
+	guint8  chari_len;
+	guint16 total_num_bits =3D len * 8;
+
+	addr =3D g_new0(struct cdma_sms_address, 1);
+
+	addr->digit_mode =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	if (addr->digit_mode =3D=3D CDMA_SMS_DIGIT_MODE_8BIT_ASCII) {
+		addr->digi_num_type =3D bit_field_unpack(buf, bit_offset, 3);
+		bit_offset +=3D 3;
+
+		addr->number_plan =3D bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
 	}
 =

-	return FALSE;
+	if (bit_offset + 8 > total_num_bits) {
+		g_free(addr);
+		return FALSE;
+	}
+
+	addr->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	if (addr->digit_mode =3D=3D CDMA_SMS_DIGIT_MODE_4BIT_DTMF)
+		chari_len =3D 4;
+	else
+		chari_len =3D 8;
+
+	if ((bit_offset + chari_len * addr->num_fields) > total_num_bits) {
+		g_free(addr);
+		return FALSE;
+	}
+
+	extract_raw_data(addr->address, buf, addr->num_fields * chari_len,
+						bit_offset);
+
+	*data =3D addr;
+
+	return TRUE;
 }
 =

-static gboolean p2p_decode_bearer_data(const guint8 *buf, guint8 len,
-					enum cdma_sms_teleservice_id tele_id,
-					struct cdma_sms_bearer_data *bd)
+static gboolean decode_subparam_display_mode(const guint8 *buf,
+			guint8 len, void **data)
 {
-	struct simple_iter iter;
+	enum cdma_sms_display_mode *mode;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	mode =3D g_new0(enum cdma_sms_display_mode, 1);
+	*data =3D mode;
+
+	*mode =3D bit_field_unpack(buf, 0, 2);
+
+	return TRUE;
+}
 =

-	simple_iter_init(&iter, buf, len);
+static gboolean decode_subparam_deposit_idx(const guint8 *buf,
+			guint8 len, void **data)
+{
+	guint16 *idx;
 =

-	/* Message Identifier is mandatory, * Section 4 of C.S0015-B v2.0 */
-	if (find_and_decode(&iter,
-				CDMA_SMS_SUBPARAM_ID_MESSAGE_ID,
-				cdma_sms_decode_message_id,
-				&bd->id) !=3D TRUE)
+	if (len !=3D 2)
 		return FALSE;
 =

-	set_bitmap(&bd->subparam_bitmap, CDMA_SMS_SUBPARAM_ID_MESSAGE_ID);
+	idx =3D g_new0(guint16, 1);
+	*data =3D idx;
+
+	*idx =3D *buf << 8 | *(buf + 1);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_service_category_program_data(
+			const guint8 *buf, guint8 len, void **data)
+{
+	struct cdma_sms_serive_category_program_data *scpd;
+	guint16 bit_offset =3D 0;
+	guint8 chari_len;
+	int i;
+
+	scpd =3D g_new0(struct cdma_sms_serive_category_program_data, 1);
+	scpd->encoding =3D bit_field_unpack(buf, bit_offset, 5);
+	bit_offset +=3D 5;
+
+	scpd->fields_count =3D len / 6;
+
+	chari_len =3D get_character_length(scpd->encoding);
 =

-	simple_iter_init(&iter, buf, len);
+	for (i =3D 0; i < scpd->fields_count; i++) {
+		scpd->fields[i].op_code =3D bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
 =

-	switch (tele_id) {
-	case CDMA_SMS_TELESERVICE_ID_CMT91:
-	case CDMA_SMS_TELESERVICE_ID_WPT:
-		return FALSE; /* TODO */
-	case CDMA_SMS_TELESERVICE_ID_WMT:
-		return cdma_sms_decode_wmt(&iter, bd);
-	case CDMA_SMS_TELESERVICE_ID_VMN:
-	case CDMA_SMS_TELESERVICE_ID_WAP:
-	case CDMA_SMS_TELESERVICE_ID_WEMT:
-	case CDMA_SMS_TELESERVICE_ID_SCPT:
-	case CDMA_SMS_TELESERVICE_ID_CATPT:
-		return FALSE; /* TODO */
+		scpd->fields[i].category =3D
+			(bit_field_unpack(buf, bit_offset, 8) << 8) +
+			bit_field_unpack(buf, bit_offset + 8, 8);
+		bit_offset +=3D 16;
+
+		scpd->fields[i].language =3D
+				bit_field_unpack(buf, bit_offset, 8);
+		bit_offset +=3D 8;
+
+		scpd->fields[i].max_msg =3D
+				bit_field_unpack(buf, bit_offset, 8);
+		bit_offset +=3D 8;
+
+		scpd->fields[i].alart_option =3D
+				bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
+
+		scpd->fields[i].num_fields =3D
+				bit_field_unpack(buf, bit_offset, 8);
+		bit_offset +=3D 8;
+
+		extract_raw_data(scpd->fields[i].data,
+				buf,
+				scpd->fields[i].num_fields * chari_len,
+				bit_offset);
+
+		bit_offset +=3D scpd->fields[i].num_fields * chari_len	;
 	}
 =

-	return FALSE;
+	*data =3D scpd;
+
+	return TRUE;
 }
 =

-/* Decode Bearer Data */
-static gboolean cdma_sms_decode_bearer_data(const guint8 *buf, guint8 len,
-								void *data)
+static gboolean decode_subparam_service_category_program_results(
+			const guint8 *buf, guint8 len, void **data)
 {
-	struct cdma_sms *msg =3D data;
+	struct cdma_sms_serive_category_program_results *results;
+	int i;
 =

-	switch (msg->type) {
-	case CDMA_SMS_TP_MSG_TYPE_P2P:
-		return p2p_decode_bearer_data(buf, len,
-						msg->p2p_msg.teleservice_id,
-						&msg->p2p_msg.bd);
-	case CDMA_SMS_TP_MSG_TYPE_BCAST:
-		return FALSE; /* TODO */
-	case CDMA_SMS_TP_MSG_TYPE_ACK:
-		return FALSE; /* Invalid */
+	if (len < 3 || len % 3 !=3D 0)
+		return FALSE;
+
+	results =3D g_new0(struct cdma_sms_serive_category_program_results,
+				len / 3);
+
+	for (i =3D 0; i < len / 3; i++) {
+		results[i].category =3D *buf << 8 | *(buf + 1);
+		results[i].result =3D (*(buf + 2) & 0xF0) >> 4;
+		buf +=3D 3;
 	}
 =

-	return FALSE;
+	*data =3D results;
+
+	return TRUE;
 }
 =

-static rec_handler param_handler_for_id(enum cdma_sms_param_id id,
-						struct cdma_sms *incoming,
-						void **data)
+static gboolean decode_subparam_message_status(const guint8 *buf,
+			guint8 len, void **data)
 {
-	if (incoming->type !=3D CDMA_SMS_TP_MSG_TYPE_P2P)
-		return NULL; /* TODO: Other types not supported yet */
+	struct cdma_sms_msg_status *status;
+
+	if (len !=3D 1)
+		return FALSE;
+
+	status =3D g_new0(struct cdma_sms_msg_status, 1);
+	*data =3D status;
+
+	status->error =3D bit_field_unpack(buf, 0, 2);
+	status->status =3D bit_field_unpack(buf, 2, 6);
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_enhanced_vmn(const guint8 *buf,
+			guint8 len, void **data)
+{
+	struct cdma_sms_enhanced_vmn *vmn;
+	guint16 bit_offset =3D 0;
+	guint8 chari_len;
+
+	vmn =3D g_new0(struct cdma_sms_enhanced_vmn, 1);
+
+	vmn->priority =3D bit_field_unpack(buf, bit_offset, 2);
+	bit_offset +=3D 2;
+
+	vmn->pwd_required =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->setup_required =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->pwd_chg_required =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	if (vmn->setup_required =3D=3D TRUE && vmn->pwd_chg_required =3D=3D TRUE)=
 {
+		vmn->min_pwd_len =3D bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
+
+		vmn->max_pwd_len =3D bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
+	}
+
+	vmn->unheard_msgs =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	vmn->almost_full =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->full =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->reply_allow =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->fax_include =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
 =

+	vmn->vm_length =3D (bit_field_unpack(buf, bit_offset, 8) << 8) |
+				bit_field_unpack(buf, bit_offset + 8, 4);
+	bit_offset +=3D 12;
+
+	vmn->retention_days =3D bit_field_unpack(buf, bit_offset, 7);
+	bit_offset +=3D 7;
+
+	vmn->msg_id =3D (bit_field_unpack(buf, bit_offset, 8) << 8) |
+				bit_field_unpack(buf, bit_offset + 8, 8);
+	bit_offset +=3D 16;
+
+	vmn->mailbox_id =3D (bit_field_unpack(buf, bit_offset, 8) << 8) |
+				bit_field_unpack(buf, bit_offset + 8, 8);
+	bit_offset +=3D 16;
+
+	vmn->access_number.digit_mode =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->access_number.digi_num_type =3D
+				bit_field_unpack(buf, bit_offset, 3);
+	bit_offset +=3D 3;
+
+	if (vmn->access_number.digit_mode =3D=3D
+				CDMA_SMS_DIGIT_MODE_8BIT_ASCII) {
+		vmn->access_number.number_plan =3D
+				bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
+
+		chari_len =3D 8;
+	} else {
+		chari_len =3D 4;
+	}
+
+	vmn->access_number.num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	extract_raw_data(vmn->access_number.address, buf,
+			vmn->access_number.num_fields * chari_len, bit_offset);
+
+	bit_offset +=3D vmn->access_number.num_fields * chari_len;
+
+	vmn->cli.digit_mode =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	vmn->cli.digi_num_type =3D
+				bit_field_unpack(buf, bit_offset, 3);
+	bit_offset +=3D 3;
+
+	if (vmn->cli.digit_mode =3D=3D
+				CDMA_SMS_DIGIT_MODE_8BIT_ASCII) {
+		vmn->cli.number_plan =3D
+				bit_field_unpack(buf, bit_offset, 4);
+		bit_offset +=3D 4;
+
+		chari_len =3D 8;
+	} else {
+		chari_len =3D 4;
+	}
+
+	vmn->cli.num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	extract_raw_data(vmn->cli.address, buf,
+			vmn->cli.num_fields * chari_len, bit_offset);
+
+	*data =3D vmn;
+
+	return TRUE;
+}
+
+static gboolean decode_subparam_enhanced_vmn_ack(const guint8 *buf,
+			guint8 len, void **data)
+{
+	struct cdma_sms_enhanced_vmn_ack *ack;
+	guint16 bit_offset =3D 0;
+	int i;
+
+	ack =3D g_new0(struct cdma_sms_enhanced_vmn_ack, 1);
+
+	ack->mailbox_id =3D *buf << 8 | *(buf + 1);
+	buf +=3D 2;
+	ack->unheard_msgs =3D *buf++;
+
+	ack->del_acks_num =3D bit_field_unpack(buf, bit_offset, 3);
+	bit_offset +=3D 3;
+
+	ack->play_acks_num =3D bit_field_unpack(buf, bit_offset, 3);
+	bit_offset +=3D 3;
+
+	for (i =3D 0; i < ack->del_acks_num; i++) {
+		ack->da_id[i] =3D (bit_field_unpack(buf, bit_offset, 8) << 8) |
+				bit_field_unpack(buf, bit_offset + 8, 8);
+		bit_offset +=3D 16;
+	}
+
+	for (i =3D 0; i < ack->play_acks_num; i++) {
+		ack->pa_id[i] =3D (bit_field_unpack(buf, bit_offset, 8) << 8) |
+				bit_field_unpack(buf, bit_offset + 8, 8);
+		bit_offset +=3D 16;
+	}
+
+	*data =3D ack;
+
+	return TRUE;
+}
+
+static dec_handler get_subparam_dec_handler_by_id(enum cdma_sms_subparam_i=
d id)
+{
 	switch (id) {
-	case CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER:
-		*data =3D &incoming->p2p_msg.teleservice_id;
-		return cdma_sms_decode_teleservice;
-	case CDMA_SMS_PARAM_ID_SERVICE_CATEGORY:
-		return NULL; /* TODO */
-	case CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS:
-		*data =3D &incoming->p2p_msg.oaddr;
-		return cdma_sms_decode_addr;
-	case CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS:
-	case CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS:
-	case CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS:
-	case CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION:
-	case CDMA_SMS_PARAM_ID_CAUSE_CODE:
-		return NULL; /* TODO */
-	case CDMA_SMS_PARAM_ID_BEARER_DATA:
-		*data =3D incoming;
-		return cdma_sms_decode_bearer_data;
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_ID:
+		return decode_subparam_message_id;
+
+	case CDMA_SMS_SUBPARAM_ID_USER_DATA:
+		return decode_subparam_ud;
+
+	case CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE:
+	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE:
+	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE:
+	case CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR:
+	case CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE:
+		return decode_subparam_byte;
+
+	case CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP:
+	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE:
+	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE:
+		return decode_subparam_time;
+
+	case CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR:
+		return decode_subparam_priority_indicator;
+
+	case CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR:
+		return decode_subparam_privacy_indicator;
+
+	case CDMA_SMS_SUBPARAM_ID_REPLY_OPTION:
+		return decode_subparam_reply_option;
+
+	case CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES:
+		return decode_subparam_num_of_msgs;
+
+	case CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY:
+		return decode_subparam_alert_on_delivery;
+
+	case CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER:
+		return decode_subparam_callback_number;
+
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE:
+		return decode_subparam_display_mode;
+
+	case CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA:
+		/* TODO */
+		return NULL;
+
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX:
+		return decode_subparam_deposit_idx;
+
+	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA:
+		return decode_subparam_service_category_program_data;
+
+	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT:
+		return decode_subparam_service_category_program_results;
+
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS:
+		return decode_subparam_message_status;
+
+	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN:
+		return decode_subparam_enhanced_vmn;
+
+	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK:
+		return decode_subparam_enhanced_vmn_ack;
 	}
 =

 	return NULL;
 }
 =

-static gboolean cdma_sms_p2p_decode(const guint8 *pdu, guint8 len,
-					struct cdma_sms *incoming)
+static gboolean decode_params(const guint8 *data, guint len, GSList **para=
ms,
+			gboolean sub)
 {
 	struct simple_iter iter;
 =

-	simple_iter_init(&iter, pdu, len);
+	simple_iter_init(&iter, data, len);
 =

-	/*
-	 * Teleservice Identifier is mandatory,
-	 * Table 3.4.2.1-1 of C.S0015-B v2.0
-	 */
-	if (find_and_decode(&iter,
-				CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER,
-				cdma_sms_decode_teleservice,
-				&incoming->p2p_msg.teleservice_id) !=3D TRUE)
+	while (simple_iter_next(&iter) =3D=3D TRUE) {
+		dec_handler handler;
+		guint8 id;
+		guint8 len;
+		const guint8 *buf;
+		void *uninitialized_var(dataobj);
+		struct param_item *item;
+
+		id =3D simple_iter_get_id(&iter);
+		len =3D simple_iter_get_length(&iter);
+		buf =3D simple_iter_get_data(&iter);
+
+		if (!sub)
+			handler =3D get_param_dec_handler_by_id(id);
+		else
+			handler =3D get_subparam_dec_handler_by_id(id);
+
+		if (handler !=3D NULL) {
+			if (handler(buf, len, &dataobj) =3D=3D FALSE)
+				continue;
+		}
+
+		item =3D g_new0(struct param_item, 1);
+		item->id =3D id;
+		item->len =3D len;
+		item->data =3D dataobj;
+
+		*params =3D g_slist_append(*params, item);
+	}
+
+	return TRUE;
+}
+
+static void decode_bearer_data_delivery(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_deliver *deliver =3D &bd->deliver;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &deliver->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(deliver->ud),
+			bitmap);
+
+	set_parameter(params, &deliver->time_stamp,
+			CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP,
+			sizeof(deliver->time_stamp),
+			bitmap);
+
+	set_parameter(params, &deliver->vp_absolute,
+			CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE,
+			sizeof(deliver->vp_absolute),
+			bitmap);
+
+	set_parameter(params, &deliver->vp,
+			CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE,
+			sizeof(deliver->vp),
+			bitmap);
+
+	set_parameter(params, &deliver->ddt_absolute,
+			CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE,
+			sizeof(deliver->ddt_absolute),
+			bitmap);
+
+	set_parameter(params, &deliver->ddt,
+			CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE,
+			sizeof(deliver->ddt),
+			bitmap);
+
+	set_parameter(params, &deliver->priority,
+			CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR,
+			sizeof(deliver->priority),
+			bitmap);
+
+	set_parameter(params, &deliver->privacy,
+			CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR,
+			sizeof(deliver->privacy),
+			bitmap);
+
+	set_parameter(params, &deliver->reply_option,
+			CDMA_SMS_SUBPARAM_ID_REPLY_OPTION,
+			sizeof(deliver->reply_option),
+			bitmap);
+
+	set_parameter(params, &deliver->msg_num,
+			CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES,
+			sizeof(deliver->msg_num),
+			bitmap);
+
+	set_parameter(params, &deliver->alert,
+			CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY,
+			sizeof(deliver->alert),
+			bitmap);
+
+	set_parameter(params, &deliver->language,
+			CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR,
+			sizeof(deliver->language),
+			bitmap);
+
+	set_parameter(params, &deliver->cb_number,
+			CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER,
+			sizeof(deliver->cb_number),
+			bitmap);
+
+	set_parameter(params, &deliver->display_mode,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE,
+			sizeof(deliver->display_mode),
+			bitmap);
+
+	set_parameter(params, &deliver->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(deliver->me_ud),
+			bitmap);
+
+	set_parameter(params, &deliver->deposit_idx,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX,
+			sizeof(deliver->deposit_idx),
+			bitmap);
+
+	set_parameter(params, &deliver->scpd,
+			CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA,
+			sizeof(deliver->scpd),
+			bitmap);
+}
+
+static void decode_bearer_data_submit(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_submit *submit =3D &bd->submit;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &submit->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(submit->ud),
+			bitmap);
+
+	set_parameter(params, &submit->vp_absolute,
+			CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE,
+			sizeof(submit->vp_absolute),
+			bitmap);
+
+	set_parameter(params, &submit->vp,
+			CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE,
+			sizeof(submit->vp),
+			bitmap);
+
+	set_parameter(params, &submit->ddt_absolute,
+			CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE,
+			sizeof(submit->ddt_absolute),
+			bitmap);
+
+	set_parameter(params, &submit->ddt,
+			CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE,
+			sizeof(submit->ddt),
+			bitmap);
+
+	set_parameter(params, &submit->priority,
+			CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR,
+			sizeof(submit->priority),
+			bitmap);
+
+	set_parameter(params, &submit->privacy,
+			CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR,
+			sizeof(submit->privacy),
+			bitmap);
+
+	set_parameter(params, &submit->reply_option,
+			CDMA_SMS_SUBPARAM_ID_REPLY_OPTION,
+			sizeof(submit->reply_option),
+			bitmap);
+
+	set_parameter(params, &submit->alert,
+			CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY,
+			sizeof(submit->alert),
+			bitmap);
+
+	set_parameter(params, &submit->language,
+			CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR,
+			sizeof(submit->language),
+			bitmap);
+
+	set_parameter(params, &submit->cb_number,
+			CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER,
+			sizeof(submit->cb_number),
+			bitmap);
+
+	set_parameter(params, &submit->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(submit->me_ud),
+			bitmap);
+
+	set_parameter(params, &submit->deposit_idx,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX,
+			sizeof(submit->deposit_idx),
+			bitmap);
+
+	set_parameter(params, &submit->scpr,
+			CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT,
+			sizeof(submit->scpr),
+			bitmap);
+}
+
+static void decode_bearer_data_deliver_ack(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_deliver_ack *ack =3D &bd->deliver_ack;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &ack->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(ack->ud),
+			bitmap);
+
+	set_parameter(params, &ack->time_stamp,
+			CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP,
+			sizeof(ack->time_stamp),
+			bitmap);
+
+	set_parameter(params, &ack->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(ack->me_ud),
+			bitmap);
+
+	set_parameter(params, &ack->status,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS,
+			sizeof(ack->status),
+			bitmap);
+}
+
+static void decode_bearer_data_user_ack(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_user_ack *ack =3D &bd->user_ack;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &ack->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(ack->ud),
+			bitmap);
+
+	set_parameter(params, &ack->response,
+			CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE,
+			sizeof(ack->response),
+			bitmap);
+
+	set_parameter(params, &ack->time_stamp,
+			CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP,
+			sizeof(ack->time_stamp),
+			bitmap);
+
+	set_parameter(params, &ack->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(ack->me_ud),
+			bitmap);
+
+	set_parameter(params, &ack->deposit_idx,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX,
+			sizeof(ack->deposit_idx),
+			bitmap);
+}
+
+static void decode_bearer_data_read_ack(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_read_ack *ack =3D &bd->read_ack;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &ack->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(ack->ud),
+			bitmap);
+
+	set_parameter(params, &ack->time_stamp,
+			CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP,
+			sizeof(ack->time_stamp),
+			bitmap);
+
+	set_parameter(params, &ack->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(ack->me_ud),
+			bitmap);
+
+	set_parameter(params, &ack->deposit_idx,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX,
+			sizeof(ack->deposit_idx),
+			bitmap);
+}
+
+static void decode_bearer_data_report(GSList *params,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct cdma_sms_report *report =3D &bd->report;
+	guint32 *bitmap =3D &bd->subparam_bitmap;
+
+	set_parameter(params, &report->cause,
+			CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE,
+			sizeof(report->cause),
+			bitmap);
+
+	set_parameter(params, &report->ud,
+			CDMA_SMS_SUBPARAM_ID_USER_DATA,
+			sizeof(report->ud),
+			bitmap);
+
+	set_parameter(params, &report->language,
+			CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR,
+			sizeof(report->language),
+			bitmap);
+
+	set_parameter(params, &report->me_ud,
+			CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA,
+			sizeof(report->me_ud),
+			bitmap);
+}
+
+static gboolean decode_bearer_data(const guint8 *data, guint8 len,
+			struct cdma_sms_bearer_data *bd)
+{
+	GSList *subparams;
+	gboolean ret;
+
+	subparams =3D NULL;
+
+	ret =3D decode_params(data, len, &subparams, TRUE);
+
+	if (ret =3D=3D FALSE) {
+		g_slist_foreach(subparams, (GFunc) free_param_item, NULL);
+		g_slist_free(subparams);
 		return FALSE;
+	}
 =

-	set_bitmap(&incoming->p2p_msg.param_bitmap,
-			CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER);
+	ret =3D set_parameter(subparams, &bd->id,
+			CDMA_SMS_SUBPARAM_ID_MESSAGE_ID,
+			sizeof(bd->id),
+			&bd->subparam_bitmap);
 =

-	simple_iter_init(&iter, pdu, len);
+	if (ret =3D=3D FALSE) {
+		g_slist_foreach(subparams, (GFunc) free_param_item, NULL);
+		g_slist_free(subparams);
+		return FALSE;
+	}
 =

-	while (simple_iter_next(&iter) =3D=3D TRUE) {
-		rec_handler handler;
-		enum cdma_sms_param_id rec_id;
-		guint8 rec_len;
-		const guint8 *rec_buf;
-		void *uninitialized_var(dataobj);
+	switch (bd->id.msg_type) {
+	case CDMA_SMS_MSG_TYPE_RESERVED:
+		ret =3D FALSE;
+		break;
 =

-		rec_id =3D simple_iter_get_id(&iter);
-		if (rec_id =3D=3D CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER)
-			continue;
+	case CDMA_SMS_MSG_TYPE_DELIVER:
+		decode_bearer_data_delivery(subparams, bd);
+		break;
 =

-		rec_len =3D simple_iter_get_length(&iter);
-		rec_buf =3D simple_iter_get_data(&iter);
+	case CDMA_SMS_MSG_TYPE_SUBMIT:
+	case CDMA_SMS_MSG_TYPE_CANCEL:
+		decode_bearer_data_submit(subparams, bd);
+		break;
 =

-		handler =3D param_handler_for_id(rec_id, incoming, &dataobj);
-		if (handler !=3D NULL) {
-			if (handler(rec_buf, rec_len, dataobj) =3D=3D FALSE)
-				return FALSE;
+	case CDMA_SMS_MSG_TYPE_DELIVER_ACK:
+		decode_bearer_data_deliver_ack(subparams, bd);
+		break;
 =

-			set_bitmap(&incoming->p2p_msg.param_bitmap, rec_id);
-		}
+	case CDMA_SMS_MSG_TYPE_USER_ACK:
+		decode_bearer_data_user_ack(subparams, bd);
+		break;
+
+	case CDMA_SMS_MSG_TYPE_READ_ACK:
+		decode_bearer_data_read_ack(subparams, bd);
+		break;
+
+	case CDMA_SMS_MSG_TYPE_DELIVER_REPORT:
+	case CDMA_SMS_MSG_TYPE_SUBMIT_REPORT:
+		decode_bearer_data_report(subparams, bd);
+		break;
 	}
 =

-	/*
-	 * Originating Address is mandatory field,
-	 * Table 3.4.2.1-1 of C.S0015-B v2.0
-	 */
-	if ((incoming->p2p_msg.param_bitmap &
-			(1 << CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS)) =3D=3D 0)
+	g_slist_foreach(subparams, (GFunc) free_param_item, NULL);
+	g_slist_free(subparams);
+	return ret;
+}
+
+static gboolean decode_p2p_sms(GSList *params, struct cdma_sms *sms)
+{
+	guint32 *bitmap;
+
+	if (params =3D=3D NULL || sms =3D=3D NULL)
+		return FALSE;
+
+	bitmap =3D &sms->p2p_msg.param_bitmap;
+
+	set_parameter(params, &sms->p2p_msg.teleservice_id,
+			CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER,
+			sizeof(sms->p2p_msg.teleservice_id),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.service_category,
+			CDMA_SMS_PARAM_ID_SERVICE_CATEGORY,
+			sizeof(sms->p2p_msg.service_category),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.addr,
+			CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS,
+			sizeof(sms->p2p_msg.addr),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.subaddr,
+			CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS,
+			sizeof(sms->p2p_msg.subaddr),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.addr,
+			CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS,
+			sizeof(sms->p2p_msg.addr),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.subaddr,
+			CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS,
+			sizeof(sms->p2p_msg.subaddr),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.reply_option,
+			CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION,
+			sizeof(sms->p2p_msg.reply_option),
+			bitmap);
+
+	set_parameter(params, &sms->p2p_msg.bd,
+			CDMA_SMS_PARAM_ID_BEARER_DATA,
+			sizeof(sms->p2p_msg.bd),
+			bitmap);
+
+	return TRUE;
+}
+
+static gboolean decode_broadcast_sms(GSList *params, struct cdma_sms *sms)
+{
+	if (params =3D=3D NULL || sms =3D=3D NULL)
+		return FALSE;
+
+	set_parameter(params, &sms->broadcast_msg.service_category,
+			CDMA_SMS_PARAM_ID_SERVICE_CATEGORY,
+			sizeof(sms->broadcast_msg.service_category),
+			NULL);
+
+	set_parameter(params, &sms->broadcast_msg.bd,
+			CDMA_SMS_PARAM_ID_BEARER_DATA,
+			sizeof(sms->broadcast_msg.bd),
+			NULL);
+
+	return TRUE;
+}
+
+static gboolean decode_ack_sms(GSList *params, struct cdma_sms *sms)
+{
+	void *value;
+
+	if (params =3D=3D NULL || sms =3D=3D NULL)
+		return FALSE;
+
+	value =3D get_param(params,  CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS);
+	if (value !=3D NULL)
+		memcpy(&sms->ack_msg.daddr, value, sizeof(sms->ack_msg.daddr));
+
+	value =3D get_param(params,  CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS);
+	if (value !=3D NULL)
+		memcpy(&sms->ack_msg.subaddr, value,
+				sizeof(sms->ack_msg.subaddr));
+
+	value =3D get_param(params,  CDMA_SMS_PARAM_ID_CAUSE_CODE);
+	if (value !=3D NULL)
+		memcpy(&sms->ack_msg.cause_code, value,
+				sizeof(sms->ack_msg.cause_code));
+	else
 		return FALSE;
 =

 	return TRUE;
 }
 =

 gboolean cdma_sms_decode(const guint8 *pdu, guint8 len,
-				struct cdma_sms *incoming)
+				struct cdma_sms *sms)
 {
-	incoming->type =3D bit_field_unpack(pdu, 0, 8);
-	pdu +=3D 1;
-	len -=3D 1;
+	GSList *params =3D NULL;
 =

-	switch (incoming->type) {
+	gboolean ret;
+
+	if (pdu =3D=3D NULL || len =3D=3D 0 || sms =3D=3D NULL)
+		return FALSE;
+
+	memset(sms, 0, sizeof(struct cdma_sms));
+
+	sms->type =3D *pdu++;
+	len--;
+
+	ret =3D decode_params(pdu, len, &params, FALSE);
+
+	if (ret =3D=3D FALSE) {
+		g_slist_foreach(params, (GFunc) free_param_item, NULL);
+		g_slist_free(params);
+		return FALSE;
+	}
+
+	switch (sms->type) {
 	case CDMA_SMS_TP_MSG_TYPE_P2P:
-		return cdma_sms_p2p_decode(pdu, len, incoming);
+		ret =3D decode_p2p_sms(params, sms);
+		break;
+
 	case CDMA_SMS_TP_MSG_TYPE_BCAST:
+		ret =3D decode_broadcast_sms(params, sms);
+		break;
+
 	case CDMA_SMS_TP_MSG_TYPE_ACK:
-		/* TODO: Not supported yet */
-		return FALSE;
+		ret =3D decode_ack_sms(params, sms);
+		break;
 	}
 =

-	return FALSE;
+	g_slist_foreach(params, (GFunc) free_param_item, NULL);
+	g_slist_free(params);
+	return ret;
+}
+
+const char *cdma_sms_address_to_string(const struct cdma_sms_address *addr)
+{
+	static char buf[CDMA_SMS_MAX_ADDR_FIELDS + 1];
+
+	if (addr->digit_mode =3D=3D CDMA_SMS_DIGIT_MODE_4BIT_DTMF) {
+		if (dtmf_to_ascii(buf, addr->address,
+					addr->num_fields) =3D=3D TRUE)
+			return buf;
+		else
+			return NULL;
+	} else {
+		if (addr->number_mode =3D=3D CDMA_SMS_NUM_MODE_DIGIT) {
+			if (addr->digi_num_type =3D=3D
+					CDMA_SMS_DIGI_NUM_TYPE_INTERNATIONAL) {
+				sprintf(buf, "+%s", addr->address);
+				return buf;
+			}
+
+			return (char *)addr->address;
+		}
+
+		/* TODO: convert data network address */
+		return (char *)addr->address;
+	}
+}
+
+char *cdma_sms_decode_text(const struct cdma_sms_ud *ud)
+{
+	switch (ud->msg_encoding) {
+	case CDMA_SMS_MSG_ENCODING_OCTET:
+	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
+	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
+	case CDMA_SMS_MSG_ENCODING_IA5:
+	case CDMA_SMS_MSG_ENCODING_UNICODE:
+	case CDMA_SMS_MSG_ENCODING_SHIFT_JIS:
+	case CDMA_SMS_MSG_ENCODING_KOREAN:
+	case CDMA_SMS_MSG_ENCODING_LATIN_HEBREW:
+	case CDMA_SMS_MSG_ENCODING_LATIN:
+	case CDMA_SMS_MSG_ENCODING_GSM_7BIT:
+	case CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING:
+		return NULL; /* TODO */
+	}
+
+	return NULL;
 }
diff --git a/src/cdma-smsutil.h b/src/cdma-smsutil.h
index d8c22c3..bdd8b3a 100644
--- a/src/cdma-smsutil.h
+++ b/src/cdma-smsutil.h
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2010-2011  Nokia Corporation. All rights reserved.
+ *   Copyright (C) 2011  Wind river systems. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -20,6 +21,7 @@
  */
 =

 #define CDMA_SMS_MAX_ADDR_FIELDS 256
+#define CDMA_SMS_MAX_FIELDS 256
 #define CDMA_SMS_UD_LEN 512
 =

 /* 3GPP2 C.S0015-B v2.0, Table 3.4-1 */
@@ -80,6 +82,11 @@ enum cdma_sms_numbering_plan {
 	CDMA_SMS_NUMBERING_PLAN_RESERVED =3D	15
 };
 =

+enum cdma_sms_subaddr_type {
+	CDMA_SMS_SUBADDR_TYPE_NASP =3D 0,
+	CDMA_SMS_SUBADDR_TYPE_USER_SPEC =3D 1,
+};
+
 /* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */
 enum cdma_sms_msg_type {
 	CDMA_SMS_MSG_TYPE_RESERVED =3D		0,
@@ -196,6 +203,86 @@ enum cdma_sms_digit_mode {
 	CDMA_SMS_DIGIT_MODE_8BIT_ASCII =3D	1
 };
 =

+/* 3GPP2 C.S0015-B v2.0 Section 4.5.9 */
+enum cdma_sms_priority {
+	CDMA_SMS_PRIORITY_NORMAL =3D 0,
+	CDMA_SMS_PRIORITY_INTERACTIVE =3D 1,
+	CDMA_SMS_PRIORITY_URGENT =3D 2,
+	CDMA_SMS_PRIORITY_EMERGENCY =3D 3,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.10 */
+enum cdma_sms_privacy {
+	CDMA_SMS_PRIVACY_NOT_RESTRICTED =3D 0,
+	CDMA_SMS_PRIVACY_RESTRICTED =3D 1,
+	CDMA_SMS_PRIVACY_CONFIDENTIAL =3D 2,
+	CDMA_SMS_PRIVACY_SECRET =3D 3,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.13 */
+enum cdma_sms_alert {
+	CDMA_SMS_ALERT_DEFAULT =3D 0,
+	CDMA_SMS_ALERT_LOW =3D 1,
+	CDMA_SMS_ALERT_MEDIUM =3D 2,
+	CDMA_SMS_ALERT_HIGH =3D 3,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.14 */
+enum cdma_sms_language_indicator {
+	CDMA_SMS_LANGUAGE_UNSPECIFIED =3D 0,
+	CDMA_SMS_LANGUAGE_ENGLISH =3D 1,
+	CDMA_SMS_LANGUAGE_FRENCH =3D 2,
+	CDMA_SMS_LANGUAGE_SPANISH =3D 3,
+	CDMA_SMS_LANGUAGE_JAPANESE =3D 4,
+	CDMA_SMS_LANGUAGE_KOREAN =3D 5,
+	CDMA_SMS_LANGUAGE_CHINESE =3D 6,
+	CDMA_SMS_LANGUAGE_HEBREW =3D 7,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.16 */
+enum cdma_sms_display_mode {
+	CDMA_SMS_DISPLAY_MODE_IMMEDIATE =3D 0,
+	CDMA_SMS_DISPLAY_MODE_DEFAULT =3D 1,
+	CDMA_SMS_DISPLAY_MODE_USER_INVOKE =3D 2,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.20 */
+enum cdma_sms_service_category_program_result {
+	CDMA_SMS_SCP_RESULT_SUCCESS =3D 0,
+	CDMA_SMS_SCP_RESULT_MEMORY_EXCEEDED =3D 1,
+	CDMA_SMS_SCP_RESULT_CATEGORY_EXCEEDED =3D 2,
+	CDMA_SMS_SCP_RESULT_ALREAY_PROGRAMMED =3D 3,
+	CDMA_SMS_SCP_RESULT_NOT_PREPROGRAMMED =3D 4,
+	CDMA_SMS_SCP_RESULT_INVALID_MAX_MESSAGES =3D 5,
+	CDMA_SMS_SCP_RESULT_INVALID_ALERT_OPTION =3D 6,
+	CDMA_SMS_SCP_RESULT_INVALID_SERVICE_CATEGORY_NAME =3D 7,
+	CDMA_SMS_SCP_RESULT_UNSPECIFIED_FAILURE =3D 8,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.21 */
+enum cdma_sms_error_report_class {
+	CDMA_SMS_ERROR_REPORT_NO_ERROR =3D 0,
+	CDMA_SMS_ERROR_REPORT_TEMPORARY =3D 2,
+	CDMA_SMS_ERROR_REPORT_PERMANENT =3D 3,
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.22 */
+enum cdma_sms_msg_status_code {
+	CDMA_SMS_MSG_STATUS_ACCEPTED =3D 0,
+	CDMA_SMS_MSG_STATUS_DEPOSITED =3D 1,
+	CDMA_SMS_MSG_STATUS_DELIVERED =3D 2,
+	CDMA_SMS_MSG_STATUS_CANCELLED =3D 3,
+	CDMA_SMS_MSG_STATUS_NW_CONGRESTION =3D 4,
+	CDMA_SMS_MSG_STATUS_NW_ERROR =3D 5,
+	CDMA_SMS_MSG_STATUS_CANCEL_FAILED =3D 6,
+	CDMA_SMS_MSG_STATUS_BLOCKED =3D 7,
+	CDMA_SMS_MSG_STATUS_TXT_TOO_LONG =3D 8,
+	CDMA_SMS_MSG_STATUS_DUPLICATED =3D 9,
+	CDMA_SMS_MSG_STATUS_INVALID_DEST =3D 10,
+	CDMA_SMS_MSG_STATUS_EXPIRED =3D 13,
+	CDMA_SMS_MSG_STATUS_UNKNOWN_ERROR =3D 63,
+};
+
 /* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
 struct cdma_sms_address {
 	enum cdma_sms_digit_mode digit_mode;
@@ -209,6 +296,19 @@ struct cdma_sms_address {
 	guint8 address[CDMA_SMS_MAX_ADDR_FIELDS];
 };
 =

+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.4 */
+struct cdma_sms_subaddress {
+	enum cdma_sms_subaddr_type type;
+	gboolean odd;
+	guint8 num_fields;
+	guint8 address[CDMA_SMS_MAX_ADDR_FIELDS];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.5 */
+struct cdma_sms_bearer_reply_option {
+	guint8 reply_seq;
+};
+
 /* 3GPP2 C.S0015-B v2.0 Section 3.4.3.6 */
 struct cdma_sms_cause_code {
 	guint8 reply_seq;
@@ -217,7 +317,7 @@ struct cdma_sms_cause_code {
 };
 =

 /* 3GPP2 C.S0015-B v2.0 Section 4.5.1 */
-struct cdma_sms_identifier {
+struct cdma_sms_msg_id {
 	enum cdma_sms_msg_type msg_type;
 	guint16 msg_id;
 	gboolean header_ind;
@@ -226,25 +326,178 @@ struct cdma_sms_identifier {
 /* 3GPP2 C.S0015-B v2.0 Section 4.5.2 */
 struct cdma_sms_ud {
 	enum cdma_sms_msg_encoding msg_encoding;
+	enum cdma_sms_msg_type type;
 	guint8 num_fields;
-	guint8 chari[CDMA_SMS_UD_LEN];
+	guint8 data[CDMA_SMS_UD_LEN];
 };
 =

-/*
- * 3GPP2 C.S0015-B v2.0 Table 4.3.4-1.
- * TODO: Not all subparameter records defined
- *       and supported yet.
- */
-struct cdma_sms_wmt_deliver {
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.4 */
+struct cdma_sms_time {
+	guint16 year;
+	guint8 month;
+	guint8 day;
+	guint8 hour;
+	guint8 min;
+	guint8 sec;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.11 */
+struct cdma_sms_reply_option {
+	guint8 user_ack_req:1;
+	guint8 dak_req:1;
+	guint8 read_ack_req:1;
+	guint8 report_ack:1;
+	guint8 padding:4;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.19 */
+struct cdma_sms_category_specific_fields {
+	guint8 op_code;
+	guint16 category;
+	guint8 language;
+	guint8 max_msg;
+	enum cdma_sms_alert alart_option;
+	guint8 num_fields;
+	guint8 data[CDMA_SMS_MAX_FIELDS];
+};
+
+struct cdma_sms_serive_category_program_data {
+	enum cdma_sms_msg_encoding encoding;
+	guint8 fields_count;
+	struct cdma_sms_category_specific_fields fields[64];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.20 */
+struct cdma_sms_serive_category_program_results {
+	guint16 category;
+	enum cdma_sms_service_category_program_result result;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.21 */
+struct cdma_sms_msg_status {
+	enum cdma_sms_error_report_class error;
+	enum cdma_sms_msg_status_code status;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.23 */
+struct cdma_sms_enhanced_vmn {
+	enum cdma_sms_priority priority;
+	gboolean pwd_required;
+	gboolean setup_required;
+	gboolean pwd_chg_required;
+	guint8 min_pwd_len;
+	guint8 max_pwd_len;
+	guint8 unheard_msgs;
+	gboolean almost_full;
+	gboolean full;
+	gboolean reply_allow;
+	gboolean fax_include;
+	guint16 vm_length;
+	guint8 retention_days;
+	guint16 msg_id;
+	guint16 mailbox_id;
+	struct cdma_sms_address access_number;
+	struct cdma_sms_address cli;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.24 */
+struct cdma_sms_enhanced_vmn_ack {
+	guint16 mailbox_id;
+	guint8 unheard_msgs;
+	guint8 del_acks_num;
+	guint8 play_acks_num;
+	guint16 da_id[8];
+	guint16 pa_id[8];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.4.1-1. */
+struct cdma_sms_deliver {
 	struct cdma_sms_ud ud;
+	struct cdma_sms_time time_stamp;
+	union {
+		struct cdma_sms_time vp_absolute;
+		guint8 vp;
+	};
+	union {
+		struct cdma_sms_time ddt_absolute;
+		guint8 ddt;
+	};
+	enum cdma_sms_priority priority;
+	enum cdma_sms_privacy privacy;
+	struct cdma_sms_reply_option reply_option;
+	guint8 msg_num;
+	enum cdma_sms_alert alert;
+	enum cdma_sms_language_indicator language;
+	struct cdma_sms_address cb_number;
+	enum cdma_sms_display_mode display_mode;
+	struct cdma_sms_ud me_ud;
+	guint16 deposit_idx;
+	struct cdma_sms_serive_category_program_data scpd;
 };
 =

-/* 3GPP2 C.S0015-B v2.0 Section 4.5 */
+/* 3GPP2 C.S0015-B v2.0 Table 4.4.2-1. */
+struct cdma_sms_submit {
+	struct cdma_sms_ud ud;
+	union {
+		struct cdma_sms_time vp_absolute;
+		guint8 vp;
+	};
+	union {
+		struct cdma_sms_time ddt_absolute;
+		guint8 ddt;
+	};
+	enum cdma_sms_priority priority;
+	enum cdma_sms_privacy privacy;
+	struct cdma_sms_reply_option reply_option;
+	enum cdma_sms_alert alert;
+	enum cdma_sms_language_indicator language;
+	struct cdma_sms_address cb_number;
+	struct cdma_sms_ud me_ud;
+	guint16 deposit_idx;
+	struct cdma_sms_serive_category_program_results scpr[128];
+};
+
+struct cdma_sms_user_ack {
+	struct cdma_sms_ud ud;
+	guint8 response;
+	struct cdma_sms_time time_stamp;
+	struct cdma_sms_ud me_ud;
+	guint16 deposit_idx;
+};
+
+struct cdma_sms_deliver_ack {
+	struct cdma_sms_ud ud;
+	struct cdma_sms_time time_stamp;
+	struct cdma_sms_ud me_ud;
+	struct cdma_sms_msg_status status;
+};
+
+struct cdma_sms_read_ack {
+	struct cdma_sms_ud ud;
+	struct cdma_sms_time time_stamp;
+	struct cdma_sms_ud me_ud;
+	guint16 deposit_idx;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.4.7-1 &  Table 4.4.8-1*/
+struct cdma_sms_report {
+	guint8 cause;
+	struct cdma_sms_ud ud;
+	enum cdma_sms_language_indicator language;
+	struct cdma_sms_ud me_ud;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.4 */
 struct cdma_sms_bearer_data {
 	guint32 subparam_bitmap;
-	struct cdma_sms_identifier id;
+	struct cdma_sms_msg_id id;
 	union {
-		struct cdma_sms_wmt_deliver wmt_deliver;
+		struct cdma_sms_deliver deliver;
+		struct cdma_sms_submit submit;
+		struct cdma_sms_user_ack user_ack;
+		struct cdma_sms_deliver_ack deliver_ack;
+		struct cdma_sms_read_ack	read_ack;
+		struct cdma_sms_report report;
 	};
 };
 =

@@ -256,7 +509,10 @@ struct cdma_sms_bearer_data {
 struct cdma_sms_p2p_msg {
 	guint32 param_bitmap;
 	enum cdma_sms_teleservice_id teleservice_id;
-	struct cdma_sms_address oaddr;
+	enum cdma_sms_service_cat service_category;
+	struct cdma_sms_address addr;
+	struct cdma_sms_subaddress subaddr;
+	struct cdma_sms_bearer_reply_option reply_option;
 	struct cdma_sms_bearer_data bd;
 };
 =

@@ -273,6 +529,7 @@ struct cdma_sms_broadcast_msg {
  */
 struct cdma_sms_ack_msg {
 	struct cdma_sms_address daddr;
+	struct cdma_sms_subaddress subaddr;
 	struct cdma_sms_cause_code cause_code;
 };
 =

diff --git a/unit/test-cdmasms.c b/unit/test-cdmasms.c
index 1d27cbb..e968d0b 100644
--- a/unit/test-cdmasms.c
+++ b/unit/test-cdmasms.c
@@ -91,10 +91,10 @@ static void test_wmt_deliver(gconstpointer data)
 =

 	g_assert(s.p2p_msg.teleservice_id =3D=3D CDMA_SMS_TELESERVICE_ID_WMT);
 =

-	addr =3D cdma_sms_address_to_string(&s.p2p_msg.oaddr);
+	addr =3D cdma_sms_address_to_string(&s.p2p_msg.addr);
 	check_text(addr, test->oaddr);
 =

-	message =3D cdma_sms_decode_text(&s.p2p_msg.bd.wmt_deliver.ud);
+	message =3D (char *)cdma_sms_decode_text(&s.p2p_msg.bd.deliver.ud);
 	check_text(message, test->text);
 =

 	g_free(message);
-- =

1.7.5


--===============0655778744280086618==--

