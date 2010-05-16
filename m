Content-Type: multipart/mixed; boundary="===============5617607601551192629=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/27] stkutil: Add Display Text response builder.
Date: Sun, 16 May 2010 16:04:46 +0200
Message-ID: <1274018686-6392-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5617607601551192629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   23 ++++++++++++++++++
 2 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e4dcdfb..6f5dc7b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3045,3 +3045,73 @@ static inline gboolean stk_tlv_append_bytes(struct s=
tk_tlv_builder *iter,
 =

 	return TRUE;
 }
+
+static gboolean build_dataobj_result(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_result *result =3D data;
+
+	return stk_tlv_open_container(tlv, cr, STK_DATA_OBJECT_TYPE_RESULT,
+					FALSE) &&
+		stk_tlv_append_byte(tlv, result->type) &&
+		(result->additional_len =3D=3D 0 ||
+		 stk_tlv_append_bytes(tlv, result->additional,
+					result->additional_len)) &&
+		stk_tlv_close_container(tlv);
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
+	if ((stk_tlv_open_container(&builder, TRUE,
+					STK_DATA_OBJECT_TYPE_COMMAND_DETAILS,
+					FALSE) &&
+			stk_tlv_append_byte(&builder, response->number) &&
+			stk_tlv_append_byte(&builder, response->type) &&
+			stk_tlv_append_byte(&builder, response->qualifier) &&
+			stk_tlv_close_container(&builder)) !=3D TRUE)
+		return 0;
+
+	/* TS 102 223 section 6.8 states:
+	 * "For all COMPREHENSION-TLV objects with Min =3D N, the terminal
+	 * should set the CR flag to comprehension not required."
+	 * All the data objects except "Command Details" and "Result" have
+	 * Min =3D N.
+	 *
+	 * However comprehension required is set for many of the TLVs in
+	 * TS 102 384 conformace tests so we set it per command and per
+	 * data object type.
+	 */
+	if ((stk_tlv_open_container(&builder, TRUE,
+					STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES,
+					FALSE) &&
+			stk_tlv_append_byte(&builder, response->src) &&
+			stk_tlv_append_byte(&builder, response->dst) &&
+			stk_tlv_close_container(&builder)) !=3D TRUE)
+		return 0;
+
+	if (build_dataobj_result(&builder, &response->result, TRUE) !=3D TRUE)
+		return 0;
+
+	switch (response->type) {
+	case STK_COMMAND_TYPE_DISPLAY_TEXT:
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
index 4adbe6b..382ef0c 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -991,6 +991,29 @@ struct stk_command {
 	void (*destructor)(struct stk_command *command);
 };
 =

+/* TERMINAL RESPONSEs defined in TS 102.223 Section 6.8 */
+struct stk_response_generic {
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

1.7.1.86.g0e460.dirty


--===============5617607601551192629==--

