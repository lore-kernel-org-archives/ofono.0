Content-Type: multipart/mixed; boundary="===============0753259440297030792=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/27] stkutil: Add Get Inkey response builder.
Date: Sun, 16 May 2010 16:05:04 +0200
Message-ID: <1274018704-6456-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0753259440297030792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkutil.h |   16 ++++++++++
 2 files changed, 103 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 6f5dc7b..29a1760 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -36,7 +36,8 @@
 =

 enum stk_data_object_flag {
 	DATAOBJ_FLAG_MANDATORY =3D 1,
-	DATAOBJ_FLAG_MINIMUM =3D 2
+	DATAOBJ_FLAG_MINIMUM =3D 2,
+	DATAOBJ_FLAG_CR =3D 4
 };
 =

 struct stk_file_iter {
@@ -3046,6 +3047,23 @@ static inline gboolean stk_tlv_append_bytes(struct s=
tk_tlv_builder *iter,
 	return TRUE;
 }
 =

+/* Described in TS 102.223 Section 8.8 */
+static gboolean build_dataobj_duration(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_duration *duration =3D data;
+
+	if (duration->interval =3D=3D 0x00)
+		return TRUE;
+
+	return stk_tlv_open_container(tlv, cr,
+				STK_DATA_OBJECT_TYPE_DURATION, FALSE) &&
+		stk_tlv_append_byte(tlv, duration->unit) &&
+		stk_tlv_append_byte(tlv, duration->interval) &&
+		stk_tlv_close_container(tlv);
+}
+
+/* Described in TS 102.223 Section 8.12 */
 static gboolean build_dataobj_result(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
 {
@@ -3060,6 +3078,65 @@ static gboolean build_dataobj_result(struct stk_tlv_=
builder *tlv,
 		stk_tlv_close_container(tlv);
 }
 =

+/* Defined in TS 102.223 Section 8.15 */
+static gboolean build_dataobj_text(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_answer_text *text =3D data;
+
+	if (!text->text && !text->yesno)
+		return TRUE;
+
+	if (stk_tlv_open_container(tlv, cr, STK_DATA_OBJECT_TYPE_TEXT,
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
+		if (stk_tlv_append_byte(tlv, 0x04) !=3D TRUE)
+			return FALSE;
+		if (stk_tlv_append_byte(tlv, text->text ? 0x01 : 0x00) !=3D TRUE)
+			return FALSE;
+	} else if (text->packed) {
+		if (stk_tlv_append_text(tlv, 0x00, text->text) !=3D TRUE)
+			return FALSE;
+	} else {
+		if (stk_tlv_append_text(tlv, -1, text->text) !=3D TRUE)
+			return FALSE;
+	}
+
+	return stk_tlv_close_container(tlv);
+}
+
+static gboolean build_dataobj(struct stk_tlv_builder *tlv, gboolean
+				(*builder_func)(struct stk_tlv_builder *,
+						const void *, gboolean), ...)
+{
+	va_list args;
+
+	va_start(args, builder_func);
+
+	while (builder_func) {
+		unsigned int flags =3D va_arg(args, enum stk_data_object_flag);
+		const void *data =3D va_arg(args, const void *);
+		gboolean cr =3D (flags & DATAOBJ_FLAG_CR) ? TRUE : FALSE;
+
+		if (builder_func(tlv, data, cr) !=3D TRUE)
+			return FALSE;
+
+		builder_func =3D va_arg(args, gboolean (*)(
+						struct stk_tlv_builder *,
+						const void *, gboolean));
+	}
+
+	return TRUE;
+}
+
 unsigned int stk_pdu_from_response(const struct stk_response *response,
 					unsigned char *pdu, unsigned int size)
 {
@@ -3106,6 +3184,14 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 	switch (response->type) {
 	case STK_COMMAND_TYPE_DISPLAY_TEXT:
 		break;
+	case STK_COMMAND_TYPE_GET_INKEY:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_text, DATAOBJ_FLAG_CR,
+					&response->get_inkey.text,
+					build_dataobj_duration, 0,
+					&response->get_inkey.duration,
+					NULL);
+		break;
 	default:
 		return 0;
 	};
diff --git a/src/stkutil.h b/src/stkutil.h
index 382ef0c..9603dd7 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -995,6 +995,21 @@ struct stk_command {
 struct stk_response_generic {
 };
 =

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
 struct stk_response {
 	unsigned char number;
 	unsigned char type;
@@ -1005,6 +1020,7 @@ struct stk_response {
 =

 	union {
 		struct stk_response_generic display_text;
+		struct stk_response_get_inkey get_inkey;
 	};
 =

 	void (*destructor)(struct stk_response *response);
-- =

1.7.1.86.g0e460.dirty


--===============0753259440297030792==--

