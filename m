Content-Type: multipart/mixed; boundary="===============1905257969323783943=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] Encoding of the four TERMINAL RESPONSE pdus.
Date: Mon, 10 May 2010 11:34:09 +0200
Message-ID: <1273484049-32218-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1905257969323783943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  171 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   45 +++++++++++++++
 2 files changed, 216 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e51090c..1205f40 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2498,3 +2498,174 @@ static inline gboolean stk_tlv_append_bytes(struct =
stk_tlv_builder *iter,
 =

 	return TRUE;
 }
+
+/* Described in TS 102.223 Section 8.8 */
+static gboolean build_dataobj_duration(struct stk_tlv_builder *tlv,
+					const void *data)
+{
+	const struct stk_duration *duration =3D data;
+
+	if (duration->interval =3D=3D 0x00)
+		return TRUE;
+
+	if (stk_tlv_open_container(tlv, FALSE, STK_DATA_OBJECT_TYPE_DURATION,
+					FALSE) !=3D TRUE)
+		return FALSE;
+
+	stk_tlv_append_byte(tlv, duration->unit);
+	stk_tlv_append_byte(tlv, duration->interval);
+
+	return stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.12 */
+static gboolean build_dataobj_result(struct stk_tlv_builder *tlv,
+					const void *data)
+{
+	const struct stk_result *result =3D data;
+
+	if (stk_tlv_open_container(tlv, TRUE, STK_DATA_OBJECT_TYPE_RESULT,
+					FALSE) !=3D TRUE)
+		return FALSE;
+
+	stk_tlv_append_byte(tlv, result->type);
+	if (result->additional_len)
+		if (stk_tlv_append_bytes(tlv, result->additional,
+						result->additional_len) !=3D
+				TRUE)
+			return FALSE;
+
+	return stk_tlv_close_container(tlv);
+}
+
+/* Defined in TS 102.223 Section 8.15 */
+static gboolean build_dataobj_text(struct stk_tlv_builder *tlv,
+					const void *data)
+{
+	const struct stk_answer_text *text =3D data;
+
+	if (!text->text && !text->yesno)
+		return TRUE;
+
+	/* See note about CR in stk_pdu_from_response */
+	if (stk_tlv_open_container(tlv, TRUE, STK_DATA_OBJECT_TYPE_TEXT,
+					TRUE) !=3D TRUE)
+		return FALSE;
+
+	if (text->yesno =3D=3D TRUE) {
+		/* Section 6.8.5:
+		 * When the terminal issues [...] command qualifier set
+		 * to "Yes/No", it shall supply the value "01" when the
+		 * answer is "positive" and the value '00' when the
+		 * answer is "negative" in the text string data object.
+		 */
+		stk_tlv_append_byte(tlv, 0x04);
+		stk_tlv_append_byte(tlv, text->text ? 0x01 : 0x00);
+	} else if (text->packed) {
+		if (stk_tlv_append_text(tlv, 0x00, text->text) !=3D TRUE)
+			return FALSE;
+	} else {
+		if (stk_tlv_append_text(tlv, -1, text->text) !=3D TRUE)
+			return FALSE;
+	}
+	return stk_tlv_close_container(tlv);
+}
+
+static gboolean build_dataobj(struct stk_tlv_builder *tlv, gboolean
+				(*builder_func)(struct stk_tlv_builder *,
+						const void *), ...)
+{
+	va_list args;
+
+	va_start(args, builder_func);
+
+	while (builder_func) {
+		const void *data =3D va_arg(args, const void *);
+
+		if (builder_func(tlv, data) !=3D TRUE)
+			return FALSE;
+
+		builder_func =3D va_arg(args, gboolean (*)(
+						struct stk_tlv_builder *,
+						const void *));
+	}
+
+	return TRUE;
+}
+
+unsigned int stk_pdu_from_response(const struct stk_response *response,
+					unsigned char *pdu, unsigned int size)
+{
+	struct stk_tlv_builder builder;
+	gboolean ok =3D TRUE;
+
+	stk_tlv_builder_init(&builder, pdu, size);
+
+	/*
+	 * Encode command details, they come in order with
+	 * Command Details TLV first, followed by Device Identities TLV
+	 * and the Result TLV.  Comprehension required everywhere.
+	 */
+	if (stk_tlv_open_container(&builder, TRUE,
+					STK_DATA_OBJECT_TYPE_COMMAND_DETAILS,
+					FALSE) !=3D TRUE)
+		return 0;
+
+	stk_tlv_append_byte(&builder, response->number);
+	stk_tlv_append_byte(&builder, response->type);
+	stk_tlv_append_byte(&builder, response->qualifier);
+
+	if (stk_tlv_close_container(&builder) !=3D TRUE)
+		return 0;
+
+	/* TS 102 223 section 6.8 states:
+	 * "For all COMPREHENSION-TLV objects with Min =3D N, the terminal
+	 * should set the CR flag to comprehension not required."
+	 * All the data objects except "Command Details" and "Result" have
+	 * Min =3D N.
+	 *
+	 * However comprehension required is set for all of the TLVs in
+	 * TS 102 384 conformace tests so we set it everywhere too.
+	 */
+	if (stk_tlv_open_container(&builder, TRUE,
+					STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES,
+					FALSE) !=3D TRUE)
+		return 0;
+
+	stk_tlv_append_byte(&builder, response->src);
+	stk_tlv_append_byte(&builder, response->dst);
+
+	if (stk_tlv_close_container(&builder) !=3D TRUE)
+		return 0;
+
+	if (build_dataobj_result(&builder, &response->result) !=3D TRUE)
+		return 0;
+
+	switch (response->type) {
+	case STK_COMMAND_TYPE_DISPLAY_TEXT:
+		break;
+	case STK_COMMAND_TYPE_GET_INKEY:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_text,
+					&response->get_inkey.text,
+					build_dataobj_duration,
+					&response->get_inkey.duration,
+					NULL);
+		break;
+	case STK_COMMAND_TYPE_GET_INPUT:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_text,
+					&response->get_input.text,
+					NULL);
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
+	return stk_tlv_get_length(&builder);
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 41c03a7..6879909 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -841,6 +841,51 @@ struct stk_command {
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
+	/* If a "Yes/No" answer was requested in a GET INKEY command,
+	 * .yesno must be TRUE and text should be non-NULL to indicate
+	 * a Yes response or NULL to indicate a No response.
+	 */
+};
+
+struct stk_response_get_inkey {
+	struct stk_answer_text text;
+	struct stk_duration duration;
+};
+
+struct stk_response_get_input {
+	struct stk_answer_text text;
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
+unsigned int stk_pdu_from_response(const struct stk_response *response,
+					unsigned char *pdu, unsigned int size);
-- =

1.6.1


--===============1905257969323783943==--

