Content-Type: multipart/mixed; boundary="===============3248623216698683588=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: [PATCH v4, 3/7] cdma-sms: Add CDMA SMS Support
Date: Tue, 18 Jan 2011 14:54:19 -0800
Message-ID: <1295391263-31592-1-git-send-email-lei.2.yu@nokia.com>
In-Reply-To: <Y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3248623216698683588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am        |    3 +-
 src/cdma-smsutil.c |  735 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/cdma-smsutil.h |  299 +++++++++++++++++++++
 3 files changed, 1036 insertions(+), 1 deletions(-)
 create mode 100644 src/cdma-smsutil.c
 create mode 100644 src/cdma-smsutil.h

diff --git a/Makefile.am b/Makefile.am
index da59be7..bd8c058 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -354,7 +354,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/cdma-smsutil.h \
+			src/cdma-smsutil.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-smsutil.c b/src/cdma-smsutil.c
new file mode 100644
index 0000000..283e1ed
--- /dev/null
+++ b/src/cdma-smsutil.c
@@ -0,0 +1,735 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 U=
SA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <string.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#include "cdma-smsutil.h"
+
+#define uninitialized_var(x) x =3D x
+
+enum cdma_sms_rec_flag {
+	CDMA_SMS_REC_FLAG_MANDATORY =3D	1,
+};
+
+typedef gboolean (*rec_handler)(const guint8 *, guint8, void *);
+
+struct simple_iter {
+	guint8 max;
+	const guint8 *pdu;
+	guint8 pos;
+	guint8 id;
+	guint8 len;
+	const guint8 *data;
+};
+
+static void simple_iter_init(struct simple_iter *iter,
+				const guint8 *pdu, guint8 len)
+{
+	iter->pdu =3D pdu;
+	iter->max =3D len;
+	iter->pos =3D 0;
+	iter->id =3D 0;
+	iter->len =3D 0;
+	iter->data =3D NULL;
+}
+
+static gboolean simple_iter_next(struct simple_iter *iter)
+{
+	const guint8 *pdu =3D iter->pdu + iter->pos;
+	const guint8 *end =3D iter->pdu + iter->max;
+	guint8 id;
+	guint8 len;
+
+	if (pdu =3D=3D end)
+		return FALSE;
+
+	id =3D *pdu;
+	pdu++;
+
+	if (pdu =3D=3D end)
+		return FALSE;
+
+	len =3D *pdu++;
+
+	if (pdu + len > end)
+		return FALSE;
+
+	iter->id =3D id;
+	iter->len =3D len;
+	iter->data =3D pdu;
+
+	iter->pos =3D pdu + len - iter->pdu;
+
+	return TRUE;
+}
+
+static guint8 simple_iter_get_id(struct simple_iter *iter)
+{
+	return iter->id;
+}
+
+static guint8 simple_iter_get_length(struct simple_iter *iter)
+{
+	return iter->len;
+}
+
+static const guint8 *simple_iter_get_data(struct simple_iter *iter)
+{
+	return iter->data;
+}
+
+static inline void set_bitmap(guint32 *bitmap, guint8 pos)
+{
+	*bitmap =3D *bitmap | (1 << pos);
+}
+
+/* Unpacks the byte stream. The field has to be <=3D 8 bits. */
+static guint8 bit_field_unpack(const guint8 *buf, guint16 offset, guint8 n=
bit)
+{
+	guint8 bit_pos;
+	guint8 val =3D 0;
+	const guint8 *pdu;
+
+	pdu =3D buf + (offset >> 3);
+	bit_pos =3D 8 - (offset & 0x7);
+
+	/* Field to be extracted is within current byte */
+	if (nbit <=3D bit_pos)
+		return (*pdu >> (bit_pos - nbit)) & ((1 << nbit) - 1);
+
+	/* Field to be extracted crossing two bytes */
+	val =3D *pdu & ((1 << bit_pos) - 1);
+	nbit -=3D bit_pos;
+	pdu++;
+
+	return (val << nbit) | (*pdu >> (8 - nbit));
+}
+
+/* Convert CDMA DTMF digits into a string */
+static gboolean dtmf_to_ascii(char *buf, const guint8 *addr,
+					guint8 num_fields)
+{
+	/*
+	 * Mapping from binary DTMF code to the digit it represents.
+	 * As defined in Table 2.7.1.3.2.4-4 of 3GPP2 C.S0005-E v2.0.
+	 * Note, 0 is NOT a valid value and not mapped to
+	 * any valid DTMF digit.
+	 */
+	static const char dtmf_digits[13] =3D {0, '1', '2', '3', '4', '5', '6',
+						'7', '8', '9', '0', '*', '#'};
+	guint8 index;
+	guint8 value;
+
+	for (index =3D 0; index < num_fields; index++) {
+		if (addr[index] =3D=3D 0 || addr[index] > 12)
+			return FALSE;  /* Invalid digit in address field */
+
+		value =3D addr[index];
+		buf[index] =3D dtmf_digits[value];
+	}
+
+	buf[index] =3D 0; /* Make it NULL terminated string */
+
+	return TRUE;
+}
+
+const char *cdma_sms_address_to_string(const struct cdma_sms_address *addr)
+{
+	static char buf[CDMA_SMS_MAX_ADDR_FIELDS + 1];
+
+	/* TODO: Only support CDMA_SMS_DIGIT_MODE_4BIT_DTMF currently */
+	switch (addr->digit_mode) {
+	case CDMA_SMS_DIGIT_MODE_4BIT_DTMF:
+		if (dtmf_to_ascii(buf, addr->address,
+					addr->num_fields) =3D=3D TRUE)
+			return buf;
+		else
+			return NULL;
+	case CDMA_SMS_DIGIT_MODE_8BIT_ASCII:
+		return NULL;
+	}
+
+	return NULL;
+}
+
+/* Decode Teleservice ID */
+static gboolean cdma_sms_decode_teleservice(const guint8 *buf, guint8 len,
+								void *data)
+{
+	enum cdma_sms_teleservice_id *id =3D data;
+
+	*id =3D bit_field_unpack(buf, 0, 8) << 8 |
+				bit_field_unpack(buf, 8, 8);
+
+	switch (*id) {
+	case CDMA_SMS_TELESERVICE_ID_CMT91:
+	case CDMA_SMS_TELESERVICE_ID_WPT:
+	case CDMA_SMS_TELESERVICE_ID_WMT:
+	case CDMA_SMS_TELESERVICE_ID_VMN:
+	case CDMA_SMS_TELESERVICE_ID_WAP:
+	case CDMA_SMS_TELESERVICE_ID_WEMT:
+	case CDMA_SMS_TELESERVICE_ID_SCPT:
+	case CDMA_SMS_TELESERVICE_ID_CATPT:
+		return TRUE;
+	}
+
+	return FALSE; /* Invalid teleservice type */
+}
+
+/* Decode Address parameter record */
+static gboolean cdma_sms_decode_addr(const guint8 *buf, guint8 len,
+							void *data)
+{
+	struct cdma_sms_address *addr =3D data;
+	guint16 bit_offset =3D 0;
+	guint8  chari_len;
+	guint16 total_num_bits =3D len * 8;
+	guint8  index;
+
+	addr->digit_mode =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	addr->number_mode =3D bit_field_unpack(buf, bit_offset, 1);
+	bit_offset +=3D 1;
+
+	if (addr->digit_mode =3D=3D CDMA_SMS_DIGIT_MODE_8BIT_ASCII) {
+		if (addr->number_mode =3D=3D CDMA_SMS_NUM_MODE_DIGIT)
+			addr->digi_num_type =3D
+				bit_field_unpack(buf, bit_offset, 3);
+		else
+			addr->data_nw_num_type =3D
+				bit_field_unpack(buf, bit_offset, 3);
+
+		bit_offset +=3D 3;
+
+		if (addr->number_mode =3D=3D CDMA_SMS_NUM_MODE_DIGIT) {
+			if (bit_offset + 4 > total_num_bits)
+				return FALSE;
+
+			addr->number_plan =3D
+				bit_field_unpack(buf, bit_offset, 4);
+			bit_offset +=3D 4;
+		}
+	}
+
+	if (bit_offset + 8 > total_num_bits)
+		return FALSE;
+
+	addr->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	if (addr->digit_mode =3D=3D CDMA_SMS_DIGIT_MODE_4BIT_DTMF)
+		chari_len =3D 4;
+	else
+		chari_len =3D 8;
+
+	if ((bit_offset + chari_len * addr->num_fields) > total_num_bits)
+		return FALSE;
+
+	for (index =3D 0; index < addr->num_fields; index++) {
+		addr->address[index] =3D bit_field_unpack(buf,
+							bit_offset,
+							chari_len);
+		bit_offset +=3D chari_len;
+	}
+
+	return TRUE;
+}
+
+static char *decode_text_7bit_ascii(const struct cdma_sms_ud *ud)
+{
+	char *buf;
+
+	buf =3D g_new(char, ud->num_fields + 1);
+	if (buf =3D=3D NULL)
+		return NULL;
+
+	memcpy(buf, ud->chari, ud->num_fields);
+	buf[ud->num_fields] =3D 0; /* Make it NULL terminated string */
+
+	return buf;
+}
+
+char *cdma_sms_decode_text(const struct cdma_sms_ud *ud)
+{
+	switch (ud->msg_encoding) {
+	case CDMA_SMS_MSG_ENCODING_OCTET:
+	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
+		return NULL; /* TODO */
+	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
+		return decode_text_7bit_ascii(ud);
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
+}
+
+/* Decode User Data */
+static gboolean cdma_sms_decode_ud(const guint8 *buf, guint8 len, void *da=
ta)
+{
+	guint16 bit_offset =3D 0;
+	guint8  chari_len =3D 0;
+	guint16 total_num_bits =3D len * 8;
+	guint8  index;
+	enum cdma_sms_msg_encoding  msg_encoding;
+	struct cdma_sms_ud *ud =3D data;
+
+	if (total_num_bits < 13)
+		return FALSE;
+
+	msg_encoding =3D bit_field_unpack(buf, bit_offset, 5);
+	ud->msg_encoding =3D  msg_encoding;
+	bit_offset +=3D 5;
+
+	if (msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG ||
+		msg_encoding =3D=3D CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING) {
+		/*
+		 * Skip message type field for now.
+		 * TODO: Add support for message type field.
+		 */
+		bit_offset +=3D 8;
+	}
+
+	if (bit_offset + 8 > total_num_bits)
+		return FALSE;
+
+	ud->num_fields =3D bit_field_unpack(buf, bit_offset, 8);
+	bit_offset +=3D 8;
+
+	switch (msg_encoding) {
+	case CDMA_SMS_MSG_ENCODING_OCTET:
+		chari_len =3D 8;
+		break;
+	case CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG:
+		return FALSE; /* TODO */
+	case CDMA_SMS_MSG_ENCODING_7BIT_ASCII:
+	case CDMA_SMS_MSG_ENCODING_IA5:
+		chari_len =3D 7;
+		break;
+	case CDMA_SMS_MSG_ENCODING_UNICODE:
+	case CDMA_SMS_MSG_ENCODING_SHIFT_JIS:
+	case CDMA_SMS_MSG_ENCODING_KOREAN:
+		return FALSE; /* TODO */
+	case CDMA_SMS_MSG_ENCODING_LATIN_HEBREW:
+	case CDMA_SMS_MSG_ENCODING_LATIN:
+		chari_len =3D 8;
+		break;
+	case CDMA_SMS_MSG_ENCODING_GSM_7BIT:
+		chari_len =3D 7;
+		break;
+	case CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING:
+		return FALSE; /* TODO */
+	}
+
+	/* TODO: Add support for all other encoding types */
+	if (chari_len =3D=3D 0)
+		return FALSE;
+
+	if (bit_offset + chari_len * ud->num_fields > total_num_bits)
+		return FALSE;
+
+	for (index =3D 0; index < ud->num_fields; index++) {
+		ud->chari[index] =3D bit_field_unpack(buf,
+						bit_offset,
+						chari_len);
+		bit_offset +=3D chari_len;
+	}
+
+	return TRUE;
+}
+
+/* Decode Message Identifier */
+static gboolean cdma_sms_decode_message_id(const guint8 *buf, guint8 len,
+						void *data)
+{
+	struct cdma_sms_identifier *id =3D data;
+
+	if (len !=3D 3)
+		return FALSE;
+
+	id->msg_type =3D bit_field_unpack(buf, 0, 4);
+
+	if (id->msg_type <=3D 0 ||
+			id->msg_type > CDMA_SMS_MSG_TYPE_SUBMIT_REPORT)
+		return FALSE; /* Invalid message type */
+
+	id->msg_id =3D (bit_field_unpack(buf, 4, 8) << 8) |
+			bit_field_unpack(buf, 12, 8);
+
+	id->header_ind =3D bit_field_unpack(buf, 20, 1);
+
+	return TRUE;
+}
+
+static gboolean find_and_decode(struct simple_iter *iter, guint8 rec_id,
+					rec_handler handler, void *data)
+{
+	guint8 id;
+	guint8 len;
+	const guint8 *buf;
+
+	while (simple_iter_next(iter) =3D=3D TRUE) {
+		id =3D simple_iter_get_id(iter);
+		if (id !=3D rec_id)
+			continue;
+
+		len =3D simple_iter_get_length(iter);
+		buf =3D simple_iter_get_data(iter);
+
+		return handler(buf, len, data);
+	}
+
+	return FALSE;
+}
+
+static rec_handler subparam_handler_for_id(enum cdma_sms_subparam_id id)
+{
+	switch (id) {
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_ID:
+		return cdma_sms_decode_message_id;
+	case CDMA_SMS_SUBPARAM_ID_USER_DATA:
+		return cdma_sms_decode_ud;
+	case CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE:
+	case CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP:
+	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE:
+	case CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE:
+	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE:
+	case CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE:
+	case CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR:
+	case CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR:
+	case CDMA_SMS_SUBPARAM_ID_REPLY_OPTION:
+	case CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES:
+	case CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY:
+	case CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR:
+	case CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER:
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE:
+	case CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA:
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX:
+	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA:
+	case CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT:
+	case CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS:
+	case CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE:
+	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN:
+	case CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK:
+		return NULL; /* TODO */
+	}
+
+	return NULL;
+}
+
+struct subparam_handler_entry {
+	enum cdma_sms_subparam_id id;
+	int flags;
+	gboolean found;
+	void *data;
+};
+
+static gboolean decode_subparams(struct simple_iter *iter, guint32 *bitmap,
+					void *data, ...)
+{
+	GSList *entries =3D NULL;
+	GSList *l;
+	va_list args;
+	gboolean decode_result =3D TRUE;
+
+	va_start(args, data);
+
+	while (data !=3D NULL) {
+		struct subparam_handler_entry *entry;
+
+		entry =3D g_new0(struct subparam_handler_entry, 1);
+
+		entry->data =3D data;
+		entry->id =3D va_arg(args, enum cdma_sms_subparam_id);
+		entry->flags =3D va_arg(args, int);
+
+		data =3D va_arg(args, void *);
+		entries =3D g_slist_prepend(entries, entry);
+	}
+
+	va_end(args);
+
+	entries =3D g_slist_reverse(entries);
+
+	l =3D entries;
+	while (simple_iter_next(iter) =3D=3D TRUE) {
+		rec_handler handler;
+		struct subparam_handler_entry *entry;
+		guint8 subparam_len;
+		const guint8 *subparam_buf;
+		GSList *l2;
+
+		for (l2 =3D l; l2; l2 =3D l2->next) {
+			entry =3D l2->data;
+
+			if (simple_iter_get_id(iter) =3D=3D entry->id)
+				break;
+		}
+
+		/* Ignore unexpected subparameter record */
+		if (l2 =3D=3D NULL)
+			continue;
+
+		entry->found =3D TRUE;
+
+		subparam_len =3D simple_iter_get_length(iter);
+		subparam_buf =3D simple_iter_get_data(iter);
+
+		handler =3D subparam_handler_for_id(entry->id);
+
+		decode_result =3D handler(subparam_buf,
+					subparam_len,
+					entry->data);
+		if (decode_result =3D=3D FALSE)
+			break; /* Stop if decoding failed */
+
+		set_bitmap(bitmap, entry->id);
+	}
+
+	for (; l; l =3D l->next) {
+		struct subparam_handler_entry *entry =3D l->data;
+
+		if ((entry->flags & CDMA_SMS_REC_FLAG_MANDATORY) &&
+			(entry->found =3D=3D FALSE)) {
+			decode_result =3D FALSE;
+			break;
+		}
+	}
+
+	g_slist_foreach(entries, (GFunc) g_free, NULL);
+	g_slist_free(entries);
+
+	return decode_result;
+}
+
+/* Decode WMT */
+static gboolean cdma_sms_decode_wmt(struct simple_iter *iter,
+					struct cdma_sms_bearer_data *bd)
+{
+	switch (bd->id.msg_type) {
+	case CDMA_SMS_MSG_TYPE_RESERVED:
+		return FALSE; /* Invalid */
+	case CDMA_SMS_MSG_TYPE_DELIVER:
+		/*
+		 * WMT DELIVER, table 4.3.4-1 of C.S0015-B v2.0
+		 * TODO: Not all optional subparameters supported.
+		 */
+		return decode_subparams(iter,
+					&bd->subparam_bitmap,
+					&bd->wmt_deliver.ud,
+					CDMA_SMS_SUBPARAM_ID_USER_DATA,
+					0,
+					NULL);
+		break;
+	case CDMA_SMS_MSG_TYPE_SUBMIT:
+	case CDMA_SMS_MSG_TYPE_CANCEL:
+		return FALSE; /* Invalid for MT WMT */
+	case CDMA_SMS_MSG_TYPE_DELIVER_ACK:
+	case CDMA_SMS_MSG_TYPE_USER_ACK:
+	case CDMA_SMS_MSG_TYPE_READ_ACK:
+		return FALSE; /* TODO: Not supported yet */
+	case CDMA_SMS_MSG_TYPE_DELIVER_REPORT:
+	case CDMA_SMS_MSG_TYPE_SUBMIT_REPORT:
+		return FALSE; /* Invalid for MT WMT */
+	}
+
+	return FALSE;
+}
+
+static gboolean p2p_decode_bearer_data(const guint8 *buf, guint8 len,
+					enum cdma_sms_teleservice_id tele_id,
+					struct cdma_sms_bearer_data *bd)
+{
+	struct simple_iter iter;
+
+	simple_iter_init(&iter, buf, len);
+
+	/* Message Identifier is mandatory, * Section 4 of C.S0015-B v2.0 */
+	if (find_and_decode(&iter,
+				CDMA_SMS_SUBPARAM_ID_MESSAGE_ID,
+				cdma_sms_decode_message_id,
+				&bd->id) !=3D TRUE)
+		return FALSE;
+
+	set_bitmap(&bd->subparam_bitmap, CDMA_SMS_SUBPARAM_ID_MESSAGE_ID);
+
+	simple_iter_init(&iter, buf, len);
+
+	switch (tele_id) {
+	case CDMA_SMS_TELESERVICE_ID_CMT91:
+	case CDMA_SMS_TELESERVICE_ID_WPT:
+		return FALSE; /* TODO */
+	case CDMA_SMS_TELESERVICE_ID_WMT:
+		return cdma_sms_decode_wmt(&iter, bd);
+	case CDMA_SMS_TELESERVICE_ID_VMN:
+	case CDMA_SMS_TELESERVICE_ID_WAP:
+	case CDMA_SMS_TELESERVICE_ID_WEMT:
+	case CDMA_SMS_TELESERVICE_ID_SCPT:
+	case CDMA_SMS_TELESERVICE_ID_CATPT:
+		return FALSE; /* TODO */
+	}
+
+	return FALSE;
+}
+
+/* Decode Bearer Data */
+static gboolean cdma_sms_decode_bearer_data(const guint8 *buf, guint8 len,
+								void *data)
+{
+	struct cdma_sms *msg =3D data;
+
+	switch (msg->type) {
+	case CDMA_SMS_TP_MSG_TYPE_P2P:
+		return p2p_decode_bearer_data(buf, len,
+						msg->p2p_msg.teleservice_id,
+						&msg->p2p_msg.bd);
+	case CDMA_SMS_TP_MSG_TYPE_BCAST:
+		return FALSE; /* TODO */
+	case CDMA_SMS_TP_MSG_TYPE_ACK:
+		return FALSE; /* Invalid */
+	}
+
+	return FALSE;
+}
+
+static rec_handler param_handler_for_id(enum cdma_sms_param_id id,
+						struct cdma_sms *incoming,
+						void **data)
+{
+	if (incoming->type !=3D CDMA_SMS_TP_MSG_TYPE_P2P)
+		return NULL; /* TODO: Other types not supported yet */
+
+	switch (id) {
+	case CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER:
+		*data =3D &incoming->p2p_msg.teleservice_id;
+		return cdma_sms_decode_teleservice;
+	case CDMA_SMS_PARAM_ID_SERVICE_CATEGORY:
+		return NULL; /* TODO */
+	case CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS:
+		*data =3D &incoming->p2p_msg.oaddr;
+		return cdma_sms_decode_addr;
+	case CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS:
+	case CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS:
+	case CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS:
+	case CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION:
+	case CDMA_SMS_PARAM_ID_CAUSE_CODE:
+		return NULL; /* TODO */
+	case CDMA_SMS_PARAM_ID_BEARER_DATA:
+		*data =3D incoming;
+		return cdma_sms_decode_bearer_data;
+	}
+
+	return NULL;
+}
+
+static gboolean cdma_sms_p2p_decode(const guint8 *pdu, guint8 len,
+					struct cdma_sms *incoming)
+{
+	struct simple_iter iter;
+
+	simple_iter_init(&iter, pdu, len);
+
+	/*
+	 * Teleservice Identifier is mandatory,
+	 * Table 3.4.2.1-1 of C.S0015-B v2.0
+	 */
+	if (find_and_decode(&iter,
+				CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER,
+				cdma_sms_decode_teleservice,
+				&incoming->p2p_msg.teleservice_id) !=3D TRUE)
+		return FALSE;
+
+	set_bitmap(&incoming->p2p_msg.param_bitmap,
+			CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER);
+
+	simple_iter_init(&iter, pdu, len);
+
+	while (simple_iter_next(&iter) =3D=3D TRUE) {
+		rec_handler handler;
+		enum cdma_sms_param_id rec_id;
+		guint8 rec_len;
+		const guint8 *rec_buf;
+		void *dataobj;
+
+		rec_id =3D simple_iter_get_id(&iter);
+		if (rec_id =3D=3D CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER)
+			continue;
+
+		rec_len =3D simple_iter_get_length(&iter);
+		rec_buf =3D simple_iter_get_data(&iter);
+
+		handler =3D param_handler_for_id(rec_id, incoming, &dataobj);
+		if (handler !=3D NULL) {
+			if (handler(rec_buf, rec_len, dataobj) =3D=3D FALSE)
+				return FALSE;
+
+			set_bitmap(&incoming->p2p_msg.param_bitmap, rec_id);
+		}
+	}
+
+	/*
+	 * Originating Address is mandatory field,
+	 * Table 3.4.2.1-1 of C.S0015-B v2.0
+	 */
+	if ((incoming->p2p_msg.param_bitmap &
+			(1 << CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS)) =3D=3D 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+gboolean cdma_sms_decode(const guint8 *pdu, guint8 len,
+				struct cdma_sms *incoming)
+{
+	incoming->type =3D bit_field_unpack(pdu, 0, 8);
+	pdu +=3D 1;
+	len -=3D 1;
+
+	switch (incoming->type) {
+	case CDMA_SMS_TP_MSG_TYPE_P2P:
+		return cdma_sms_p2p_decode(pdu, len, incoming);
+	case CDMA_SMS_TP_MSG_TYPE_BCAST:
+	case CDMA_SMS_TP_MSG_TYPE_ACK:
+		/* TODO: Not supported yet */
+		return FALSE;
+	}
+
+	return FALSE;
+}
diff --git a/src/cdma-smsutil.h b/src/cdma-smsutil.h
new file mode 100644
index 0000000..0ac6228
--- /dev/null
+++ b/src/cdma-smsutil.h
@@ -0,0 +1,299 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 U=
SA
+ *
+ */
+
+#define CDMA_SMS_MAX_ADDR_FIELDS 256
+#define CDMA_SMS_UD_LEN 512
+
+/* 3GPP2 C.S0015-B v2.0, Table 3.4-1 */
+enum cdma_sms_tp_msg_type {
+	CDMA_SMS_TP_MSG_TYPE_P2P =3D	0,
+	CDMA_SMS_TP_MSG_TYPE_BCAST =3D	1,
+	CDMA_SMS_TP_MSG_TYPE_ACK =3D	2
+};
+
+/*
+ * 3GPP2 X.S0004-550-E, Section 2.256
+ * Only supported by 3GPP2 C.S0015-B v2.0 Section 3.4.3.1 listed.
+ */
+enum cdma_sms_teleservice_id {
+	CDMA_SMS_TELESERVICE_ID_CMT91 =3D	4096,
+	CDMA_SMS_TELESERVICE_ID_WPT =3D	4097,
+	CDMA_SMS_TELESERVICE_ID_WMT =3D	4098,
+	CDMA_SMS_TELESERVICE_ID_VMN =3D	4099,
+	CDMA_SMS_TELESERVICE_ID_WAP =3D	4100,
+	CDMA_SMS_TELESERVICE_ID_WEMT =3D	4101,
+	CDMA_SMS_TELESERVICE_ID_SCPT =3D	4102,
+	CDMA_SMS_TELESERVICE_ID_CATPT =3D	4103
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
+enum cdma_sms_num_mode {
+	CDMA_SMS_NUM_MODE_DIGIT =3D	0,
+	CDMA_SMS_NUM_MODE_DATA_NW =3D	1
+};
+
+/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-2 */
+enum cdma_sms_digi_num_type {
+	CDMA_SMS_DIGI_NUM_TYPE_UNKNOWN =3D	0,
+	CDMA_SMS_DIGI_NUM_TYPE_INTERNATIONAL =3D	1,
+	CDMA_SMS_DIGI_NUM_TYPE_NATIONAL =3D	2,
+	CDMA_SMS_DIGI_NUM_TYPE_NETWORK =3D	3,
+	CDMA_SMS_DIGI_NUM_TYPE_SUBSCRIBER =3D	4,
+	CDMA_SMS_DIGI_NUM_TYPE_RESERVED1 =3D 	5,
+	CDMA_SMS_DIGI_NUM_TYPE_ABBREVIATED =3D	6,
+	CDMA_SMS_DIGI_NUM_TYPE_RESERVED2 =3D 	7
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.3.3-1 */
+enum cdma_sms_data_nw_num_type {
+	CDMA_SMS_DATA_NW_NUM_TYPE_UNKNOWN =3D			0,
+	CDMA_SMS_DATA_NW_NUM_TYPE_INTERNET_PROTOCOL =3D		1,
+	CDMA_SMS_DATA_NW_NUM_TYPE_INTERNET_EMAIL_ADDRESS =3D	2,
+	/* All Other Values Reserved */
+};
+
+/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-3 */
+enum cdma_sms_numbering_plan {
+	CDMA_SMS_NUMBERING_PLAN_UNKNOWN =3D	0,
+	CDMA_SMS_NUMBERING_PLAN_ISDN =3D		1,
+	CDMA_SMS_NUMBERING_PLAN_DATA =3D		3,
+	CDMA_SMS_NUMBERING_PLAN_TELEX =3D		4,
+	CDMA_SMS_NUMBERING_PLAN_PRIVATE =3D	9,
+	CDMA_SMS_NUMBERING_PLAN_RESERVED =3D	15
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */
+enum cdma_sms_msg_type {
+	CDMA_SMS_MSG_TYPE_RESERVED =3D		0,
+	CDMA_SMS_MSG_TYPE_DELIVER =3D		1,
+	CDMA_SMS_MSG_TYPE_SUBMIT =3D		2,
+	CDMA_SMS_MSG_TYPE_CANCEL =3D		3,
+	CDMA_SMS_MSG_TYPE_DELIVER_ACK =3D		4,
+	CDMA_SMS_MSG_TYPE_USER_ACK =3D		5,
+	CDMA_SMS_MSG_TYPE_READ_ACK =3D		6,
+	CDMA_SMS_MSG_TYPE_DELIVER_REPORT =3D	7,
+	CDMA_SMS_MSG_TYPE_SUBMIT_REPORT =3D	8,
+};
+
+/* C.R1001-G_v1.0 Table 9.1-1 */
+enum cdma_sms_msg_encoding {
+	CDMA_SMS_MSG_ENCODING_OCTET =3D			0,
+	CDMA_SMS_MSG_ENCODING_EXTENDED_PROTOCOL_MSG =3D	1,
+	CDMA_SMS_MSG_ENCODING_7BIT_ASCII =3D		2,
+	CDMA_SMS_MSG_ENCODING_IA5 =3D			3,
+	CDMA_SMS_MSG_ENCODING_UNICODE =3D			4,
+	CDMA_SMS_MSG_ENCODING_SHIFT_JIS =3D		5,
+	CDMA_SMS_MSG_ENCODING_KOREAN =3D			6,
+	CDMA_SMS_MSG_ENCODING_LATIN_HEBREW =3D		7,
+	CDMA_SMS_MSG_ENCODING_LATIN =3D			8,
+	CDMA_SMS_MSG_ENCODING_GSM_7BIT =3D		9,
+	CDMA_SMS_MSG_ENCODING_GSM_DATA_CODING =3D		10
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.3-1 */
+enum cdma_sms_param_id {
+	CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER  =3D	0x00,
+	CDMA_SMS_PARAM_ID_SERVICE_CATEGORY =3D		0x01,
+	CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS =3D		0x02,
+	CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS =3D	0x03,
+	CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS =3D		0x04,
+	CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS =3D	0x05,
+	CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION =3D		0x06,
+	CDMA_SMS_PARAM_ID_CAUSE_CODE =3D			0x07,
+	CDMA_SMS_PARAM_ID_BEARER_DATA =3D			0x08
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 4.5-1 */
+enum cdma_sms_subparam_id {
+	CDMA_SMS_SUBPARAM_ID_MESSAGE_ID =3D			0x00,
+	CDMA_SMS_SUBPARAM_ID_USER_DATA =3D			0x01,
+	CDMA_SMS_SUBPARAM_ID_USER_RESPONSE_CODE =3D		0x02,
+	CDMA_SMS_SUBPARAM_ID_MC_TIME_STAMP =3D			0x03,
+	CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_ABSOLUTE =3D		0x04,
+	CDMA_SMS_SUBPARAM_ID_VALIDITY_PERIOD_RELATIVE =3D 	0x05,
+	CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_ABSOLUTE =3D	0x06,
+	CDMA_SMS_SUBPARAM_ID_DEFERRED_DELIVERY_TIME_RELATIVE =3D	0x07,
+	CDMA_SMS_SUBPARAM_ID_PRIORITY_INDICATOR =3D		0x08,
+	CDMA_SMS_SUBPARAM_ID_PRIVACY_INDICATOR =3D		0x09,
+	CDMA_SMS_SUBPARAM_ID_REPLY_OPTION =3D			0x0A,
+	CDMA_SMS_SUBPARAM_ID_NUMBER_OF_MESSAGES =3D		0x0B,
+	CDMA_SMS_SUBPARAM_ID_ALERT_ON_MESSAGE_DELIVERY =3D	0x0C,
+	CDMA_SMS_SUBPARAM_ID_LANGUAGE_INDICATOR =3D		0x0D,
+	CDMA_SMS_SUBPARAM_ID_CALL_BACK_NUMBER =3D			0x0E,
+	CDMA_SMS_SUBPARAM_ID_MESSAGE_DISPLAY_MODE =3D		0x0F,
+	CDMA_SMS_SUBPARAM_ID_MULTIPLE_ENCODING_USER_DATA =3D	0x10,
+	CDMA_SMS_SUBPARAM_ID_MESSAGE_DEPOSIT_INDEX =3D		0x11,
+	CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_DATA =3D	0x12,
+	CDMA_SMS_SUBPARAM_ID_SERVICE_CATEGORY_PROGRAM_RESULT =3D	0x13,
+	CDMA_SMS_SUBPARAM_ID_MESSAGE_STATUS =3D			0x14,
+	CDMA_SMS_SUBPARAM_ID_TP_FAILURE_CAUSE =3D			0x15,
+	CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN =3D			0x16,
+	CDMA_SMS_SUBPARAM_ID_ENHANCED_VMN_ACK =3D			0x17
+};
+
+/* 3GPP2 C.R1001-G Table 9.3.1-1 and 9.3.3-1 */
+enum cdma_sms_service_cat {
+	CDMA_SMS_SERVICE_CAT_EMERGENCY_BROADCAST =3D		0x0001,
+	CDMA_SMS_SERVICE_CAT_ADMINISTRATIVE =3D			0x0002,
+	CDMA_SMS_SERVICE_CAT_MAINTENANCE =3D			0x0003,
+	CDMA_SMS_SERVICE_CAT_GEN_NEWS_LOCAL =3D			0x0004,
+	CDMA_SMS_SERVICE_CAT_GEN_NEWS_REGIONAL =3D		0x0005,
+	CDMA_SMS_SERVICE_CAT_GEN_NEWS_NATIONAL =3D		0x0006,
+	CDMA_SMS_SERVICE_CAT_GEN_NEWS_INT =3D			0x0007,
+	CDMA_SMS_SERVICE_CAT_FIN_NEWS_LOCAL =3D			0x0008,
+	CDMA_SMS_SERVICE_CAT_FIN_NEWS_REGIONAL =3D		0x0009,
+	CDMA_SMS_SERVICE_CAT_FIN_NEWS_NATIONAL =3D		0x000A,
+	CDMA_SMS_SERVICE_CAT_FIN_NEWS_INT =3D			0x000B,
+	CDMA_SMS_SERVICE_CAT_SPORTS_NEWS_LOCAL =3D		0x000C,
+	CDMA_SMS_SERVICE_CAT_SPORTS_NEWS_REGIONAL =3D		0x000D,
+	CDMA_SMS_SERVICE_CAT_SPORTS_NEWS_NATIONAL =3D		0x000E,
+	CDMA_SMS_SERVICE_CAT_SPORTS_NEWS_INT =3D			0x000F,
+	CDMA_SMS_SERVICE_CAT_ENT_NEWS_LOCAL =3D			0x0010,
+	CDMA_SMS_SERVICE_CAT_ENT_NEWS_REGIONAL =3D		0x0011,
+	CDMA_SMS_SERVICE_CAT_ENT_NEWS_NATIONAL =3D		0x0012,
+	CDMA_SMS_SERVICE_CAT_ENT_NEWS_INT =3D			0x0013,
+	CDMA_SMS_SERVICE_CAT_LOCAL_WEATHER =3D			0x0014,
+	CDMA_SMS_SERVICE_CAT_TRAFFIC_REPORT =3D			0x0015,
+	CDMA_SMS_SERVICE_CAT_FLIGHT_SCHED =3D			0x0016,
+	CDMA_SMS_SERVICE_CAT_RESTAURANT =3D			0x0017,
+	CDMA_SMS_SERVICE_CAT_LODGINGS =3D				0x0018,
+	CDMA_SMS_SERVICE_CAT_RETAIL_DIR =3D			0x0019,
+	CDMA_SMS_SERVICE_CAT_ADVERTISEMENTS =3D			0x001A,
+	CDMA_SMS_SERVICE_CAT_STOCK_QUOTES =3D			0x001B,
+	CDMA_SMS_SERVICE_CAT_EMPLOYMENT =3D			0x001C,
+	CDMA_SMS_SERVICE_CAT_HOSPITAL =3D				0x001D,
+	CDMA_SMS_SERVICE_CAT_TECH_NEWS =3D			0x001E,
+	CDMA_SMS_SERVICE_CAT_MULTICATEGORY =3D			0x001F,
+	CDMA_SMS_SERVICE_CAT_CAPT =3D				0x0020,
+	CDMA_SMS_SERVICE_CAT_PRESIDENTIAL_ALERT =3D 		0x1000,
+	CDMA_SMS_SERVICE_CAT_EXTREME_THREAT =3D 			0x1001,
+	CDMA_SMS_SERVICE_CAT_SEVERE_THREAT =3D 			0x1002,
+	CDMA_SMS_SERVICE_CAT_AMBER =3D	 			0x1003,
+	CDMA_SMS_SERVICE_CAT_CMAS_TEST =3D	 		0x1004
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
+enum cdma_sms_digit_mode {
+	CDMA_SMS_DIGIT_MODE_4BIT_DTMF =3D		0,
+	CDMA_SMS_DIGIT_MODE_8BIT_ASCII =3D	1
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
+struct cdma_sms_address {
+	enum cdma_sms_digit_mode digit_mode;
+	enum cdma_sms_num_mode number_mode;
+	union {
+		enum cdma_sms_digi_num_type digi_num_type;
+		enum cdma_sms_data_nw_num_type data_nw_num_type;
+	};
+	enum cdma_sms_numbering_plan number_plan;
+	guint8 num_fields;
+	guint8 address[CDMA_SMS_MAX_ADDR_FIELDS];
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.6 */
+struct cdma_sms_cause_code {
+	guint8 reply_seq;
+	guint8 error_class;
+	guint8 cause_code;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.1 */
+struct cdma_sms_identifier {
+	enum cdma_sms_msg_type msg_type;
+	guint16 msg_id;
+	gboolean header_ind;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5.2 */
+struct cdma_sms_ud {
+	enum cdma_sms_msg_encoding msg_encoding;
+	guint8 num_fields;
+	guint8 chari[CDMA_SMS_UD_LEN];
+};
+
+/*
+ * 3GPP2 C.S0015-B v2.0 Table 4.3.4-1.
+ * TODO: Not all subparameter records defined
+ *       and supported yet.
+ */
+struct cdma_sms_wmt_deliver {
+	struct cdma_sms_ud ud;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 4.5 */
+struct cdma_sms_bearer_data {
+	guint32 subparam_bitmap;
+	struct cdma_sms_identifier id;
+	union {
+		struct cdma_sms_wmt_deliver wmt_deliver;
+	};
+};
+
+/*
+ * 3GPP2 C.S0015-B v2.0 Table 3.4.2.1-1.
+ * TODO: Not all parameter records defined
+ *       and supported yet.
+ */
+struct cdma_sms_p2p_msg {
+	guint32 param_bitmap;
+	enum cdma_sms_teleservice_id teleservice_id;
+	struct cdma_sms_address oaddr;
+	struct cdma_sms_bearer_data bd;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Table 3.4.2.2-1 */
+struct cdma_sms_broadcast_msg {
+	enum cdma_sms_service_cat service_category;
+	struct cdma_sms_bearer_data bd;
+};
+
+/*
+ * 3GPP2 C.S0015-B v2.0 Table 3.4.2.3-1
+ * TODO: Not all parameter records defined
+ *       and supported yet.
+ */
+struct cdma_sms_ack_msg {
+	struct cdma_sms_address daddr;
+	struct cdma_sms_cause_code cause_code;
+};
+
+/* 3GPP2 C.S0015-B v2.0 Section 3.4.1 */
+struct cdma_sms {
+	enum cdma_sms_tp_msg_type type;
+	union {
+		struct cdma_sms_p2p_msg p2p_msg;
+		struct cdma_sms_broadcast_msg broadcast_msg;
+		struct cdma_sms_ack_msg ack_msg;
+	};
+};
+
+static inline gboolean check_bitmap(guint32 bitmap, guint32 pos)
+{
+	guint32 mask =3D 0x1 << pos;
+
+	return bitmap & mask ? TRUE : FALSE;
+}
+
+gboolean cdma_sms_decode(const guint8 *pdu, guint8 len,
+				struct cdma_sms *out);
+char *cdma_sms_decode_text(const struct cdma_sms_ud *ud);
+const char *cdma_sms_address_to_string(const struct cdma_sms_address *addr=
);
-- =

1.7.0.4


--===============3248623216698683588==--

