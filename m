Content-Type: multipart/mixed; boundary="===============4191943721797715953=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/3][RfC] Add encoding for the four TERMINAL RESPONSEs.
Date: Thu, 22 Apr 2010 12:14:20 +0200
Message-ID: <1271931260-7327-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4191943721797715953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds encoding support for the TERMINAL RESPONSEs of the
four commands that we already support decoding of, and the three CTLVs
that these TERMINAL RESPONSEs use.  It's untested and is just a
proposal.
---
 src/stkutil.c |  262 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   41 +++++++++
 2 files changed, 303 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 50471ee..2bbeaaf 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2073,3 +2073,265 @@ void stk_command_free(struct stk_command *command)
 =

 	g_free(command);
 }
+
+/* Described in TS 102.223 Section 8.8 */
+static gboolean build_dataobj_duration(struct comprehension_tlv_constr *co=
nstr,
+					void *user)
+{
+	struct stk_duration *duration =3D user;
+	unsigned char *data;
+
+	if (comprehension_tlv_constr_set_length(constr, 2) !=3D TRUE)
+		return FALSE;
+
+	data =3D comprehension_tlv_constr_get_data(constr);
+
+	data[0] =3D duration->unit;
+	data[1] =3D duration->interval;
+
+	return TRUE;
+}
+
+/* Described in TS 102.223 Section 8.12 */
+static gboolean build_dataobj_result(struct comprehension_tlv_constr *cons=
tr,
+					void *user)
+{
+	struct stk_result *result =3D user;
+	unsigned char *data;
+
+	if (comprehension_tlv_constr_set_length(constr,
+					result->additional_len + 1) !=3D TRUE)
+		return FALSE;
+
+	data =3D comprehension_tlv_constr_get_data(constr);
+	data[0] =3D result->type;
+	if (result->additional_len)
+		memcpy(data + 1, result->additional, result->additional_len);
+
+	return TRUE;
+}
+
+/* Defined in TS 102.223 Section 8.15 */
+static gboolean build_dataobj_text(struct comprehension_tlv_constr *constr,
+					void *user)
+{
+	struct stk_answer_text *text =3D user;
+	unsigned int len;
+	unsigned char *data;
+	unsigned char *gsm;
+	long written;
+
+	if (text->yesno =3D=3D TRUE) {
+		if (comprehension_tlv_constr_set_length(constr, 1) !=3D TRUE)
+			return FALSE;
+
+		/* Section 6.8.5:
+		 * When the terminal issues [...] command qualifier set
+		 * to "Yes/No", it shall supply the value "01" when the
+		 * answer is "positive" and the value '00' when the
+		 * answer is "negative" in the text string data object.
+		 *
+		 * TODO: Does that mean the byte should be the sole
+		 * content of the data object or in addition to the DCS?
+		 * Or a string saying "01" in GSM alphabet?
+		 */
+		data =3D comprehension_tlv_constr_get_data(constr);
+		data[0] =3D text->text ? 0x01 : 0x00;
+
+		return TRUE;
+	}
+
+	if (text->text =3D=3D NULL)
+		return comprehension_tlv_constr_set_length(constr, 0);
+
+	len =3D strlen(text->text);
+
+	if (text->packed) {
+		unsigned char *packed;
+
+		gsm =3D convert_utf8_to_gsm(text->text, len, NULL, NULL, 0);
+		if (gsm =3D=3D NULL)
+			return FALSE;
+
+		packed =3D pack_7bit(gsm, len, 0, FALSE, &written, 0);
+		g_free(gsm);
+		if (packed =3D=3D NULL)
+			return FALSE;
+
+		if (comprehension_tlv_constr_set_length(constr,
+							written + 1) !=3D TRUE) {
+			g_free(packed);
+			return FALSE;
+		}
+
+		data =3D comprehension_tlv_constr_get_data(constr);
+		data[0] =3D 0x00;
+		memcpy(data + 1, packed, written);
+
+		g_free(packed);
+
+		return TRUE;
+	}
+
+	/* Now we have a choice between UCS2 and unpacked GSM alphabet.
+	 * See if the string can be encoded in GSM.  */
+	gsm =3D convert_utf8_to_gsm(text->text, len, NULL, &written, 0);
+	if (gsm =3D=3D NULL) {
+		/* Use UCS2. */
+		gsize written;
+		unsigned char *ucs2 =3D (unsigned char *)
+			g_convert((const gchar *) text->text, len,
+					"UCS-2BE", "UTF-8//TRANSLIT",
+					NULL, &written, NULL);
+		if (ucs2 =3D=3D NULL)
+			return FALSE;
+
+		if (comprehension_tlv_constr_set_length(constr,
+							written + 1) !=3D TRUE) {
+			g_free(ucs2);
+			return FALSE;
+		}
+
+		data =3D comprehension_tlv_constr_get_data(constr);
+		data[0] =3D 0x08;
+		memcpy(data + 1, ucs2, written);
+
+		g_free(ucs2);
+
+		return TRUE;
+	}
+
+	if (comprehension_tlv_constr_set_length(constr,
+						written + 1) !=3D TRUE) {
+		g_free(gsm);
+		return FALSE;
+	}
+
+	data =3D comprehension_tlv_constr_get_data(constr);
+	data[0] =3D 0x04;
+	memcpy(data + 1, gsm, written);
+
+	g_free(gsm);
+
+	return TRUE;
+}
+
+static gboolean build_dataobj(struct comprehension_tlv_constr *constr,
+				enum stk_data_object_type type, ...)
+{
+	va_list args;
+
+	va_start(args, type);
+
+	while (type !=3D STK_DATA_OBJECT_TYPE_INVALID) {
+		void *data =3D va_arg(args, void *);
+		gboolean ok;
+
+		if (comprehension_tlv_constr_set_tag(constr, FALSE, type) !=3D
+				TRUE)
+			return FALSE;
+
+		switch (type) {
+		case STK_DATA_OBJECT_TYPE_DURATION:
+			ok =3D build_dataobj_duration(constr, data);
+			break;
+		case STK_DATA_OBJECT_TYPE_RESULT:
+			ok =3D build_dataobj_result(constr, data);
+			break;
+		case STK_DATA_OBJECT_TYPE_TEXT:
+			ok =3D build_dataobj_text(constr, data);
+			break;
+		default:
+			ok =3D FALSE;
+		}
+
+		if (ok !=3D TRUE)
+			return FALSE;
+
+		type =3D va_arg(args, enum stk_data_object_type);
+	}
+
+	return TRUE;
+}
+
+unsigned int stk_pdu_from_response(struct stk_response *response,
+					unsigned char *pdu, unsigned int size)
+{
+	struct comprehension_tlv_constr constr;
+	unsigned char *data;
+	gboolean ok =3D TRUE;
+
+	comprehension_tlv_constr_init(&constr, pdu, size);
+
+	/*
+	 * Encode command details, they come in order with
+	 * Command Details TLV first, followed by Device Identities TLV
+	 * and the Result TLV.  Comprehension required everywhere.
+	 */
+	if (comprehension_tlv_constr_set_tag(&constr, TRUE,
+				STK_DATA_OBJECT_TYPE_COMMAND_DETAILS) !=3D TRUE)
+		return 0;
+
+	if (comprehension_tlv_constr_set_length(&constr, 0x03) !=3D TRUE)
+		return 0;
+
+	data =3D comprehension_tlv_constr_get_data(&constr);
+	data[0] =3D response->number;
+	data[1] =3D response->type;
+	data[2] =3D response->qualifier;
+
+	if (comprehension_tlv_constr_next(&constr) !=3D TRUE)
+		return 0;
+
+	if (comprehension_tlv_constr_set_tag(&constr, FALSE,
+			STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES) !=3D TRUE)
+		return 0;
+
+	if (comprehension_tlv_constr_set_length(&constr, 0x02) !=3D TRUE)
+		return 0;
+
+	data =3D comprehension_tlv_constr_get_data(&constr);
+	data[0] =3D response->src;
+	data[1] =3D response->dst;
+
+	if (comprehension_tlv_constr_next(&constr) !=3D TRUE)
+		return 0;
+
+	if (comprehension_tlv_constr_set_tag(&constr, TRUE,
+				STK_DATA_OBJECT_TYPE_RESULT) !=3D TRUE)
+		return 0;
+
+	if (build_dataobj_result(&constr, &response->result) !=3D TRUE)
+		return 0;
+
+	switch (response->type) {
+	case STK_COMMAND_TYPE_DISPLAY_TEXT:
+		break;
+	case STK_COMMAND_TYPE_GET_INKEY:
+		ok =3D build_dataobj(&constr,
+					STK_DATA_OBJECT_TYPE_TEXT,
+					&response->get_inkey.text,
+					STK_DATA_OBJECT_TYPE_DURATION,
+					&response->get_inkey.duration,
+					STK_DATA_OBJECT_TYPE_INVALID);
+		break;
+	case STK_COMMAND_TYPE_GET_INPUT:
+		ok =3D build_dataobj(&constr,
+					STK_DATA_OBJECT_TYPE_TEXT,
+					&response->get_input.text,
+					STK_DATA_OBJECT_TYPE_INVALID);
+		break;
+	case STK_COMMAND_TYPE_SEND_SMS:
+		break;
+	default:
+		return 0;
+	};
+
+	if (ok !=3D TRUE)
+		return 0;
+
+	if (comprehension_tlv_constr_next(&constr) !=3D TRUE)
+		return 0;
+
+	return constr.pos;
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 98da709..b0d082d 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -737,6 +737,47 @@ struct stk_command {
 	void (*destructor)(struct stk_command *command);
 };
 =

+/* TERMINAL RESPONSEs defined in TS 102.223 Section 6.8 */
+struct stk_response_generic {
+};
+
+struct stk_answer_text {
+	char *text;
+	ofono_bool_t packed;
+	ofono_bool_t yesno;
+};
+
+struct stk_response_get_inkey {
+	struct stk_answer_text *text;
+	struct stk_duration duration;
+};
+
+struct stk_response_get_input {
+	struct stk_answer_text *text;
+};
+
+struct stk_response {
+	unsigned char number;
+	unsigned char type;
+	unsigned char qualifier;
+	enum stk_device_identity_type src;
+	enum stk_device_identity_type dst;
+	struct stk_result result;
+
+	union {
+		struct stk_response_generic display_text;
+		struct stk_response_get_inkey get_inkey;
+		struct stk_response_get_input get_input;
+		struct stk_response_generic send_sms;
+	};
+
+	void (*destructor)(struct stk_response *response);
+};
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len);
 void stk_command_free(struct stk_command *command);
+
+/* Returns # of bytes written or zero on error */
+unsigned int stk_pdu_from_response(struct stk_response *response,
+					unsigned char *pdu, unsigned int size);
-- =

1.6.1


--===============4191943721797715953==--

