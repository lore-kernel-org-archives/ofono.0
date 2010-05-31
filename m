Content-Type: multipart/mixed; boundary="===============6490681747369934934=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 01/11] stkutil: Add SMS-PP Data Download envelope builder
Date: Mon, 31 May 2010 14:47:14 +0200
Message-ID: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6490681747369934934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Note that the sms_tpdu member could be of type struct sms_deliver, but the
users may more often have access to the raw tpdu so there's no point
decoding and reencoding it.
---
 src/stkutil.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   21 +++++++++++++
 2 files changed, 114 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 7bbd1c9..a29abfe 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3128,6 +3128,20 @@ static gboolean stk_tlv_builder_init(struct stk_tlv_=
builder *iter,
 	return comprehension_tlv_builder_init(&iter->ctlv, pdu, size);
 }
 =

+static gboolean stk_tlv_builder_recurse(struct stk_tlv_builder *iter,
+					struct ber_tlv_builder *btlv,
+					unsigned char tag)
+{
+	iter->value =3D NULL;
+	iter->len =3D 0;
+
+	if (ber_tlv_builder_next(btlv, tag >> 6, (tag >> 5) & 1,
+					tag & 0x1f) !=3D TRUE)
+		return FALSE;
+
+	return ber_tlv_builder_recurse_comprehension(btlv, &iter->ctlv);
+}
+
 static gboolean stk_tlv_builder_open_container(struct stk_tlv_builder *ite=
r,
 						gboolean cr,
 						unsigned char shorttag,
@@ -3308,6 +3322,23 @@ static inline gboolean stk_tlv_builder_append_bytes(=
struct stk_tlv_builder *iter
 	return TRUE;
 }
 =

+/* Described in TS 102.223 Section 8.1 */
+static gboolean build_dataobj_address(struct stk_tlv_builder *tlv,
+					const void *data, gboolean cr)
+{
+	const struct stk_address *addr =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_ADDRESS;
+	unsigned int len =3D (strlen(addr->number) + 1) / 2;
+	unsigned char number[len];
+
+	sim_encode_bcd_number(addr->number, number);
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, addr->ton_npi) &&
+		stk_tlv_builder_append_bytes(tlv, number, len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Described in TS 102.223 Section 8.6 */
 static gboolean build_dataobj_item_id(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -3360,6 +3391,18 @@ static gboolean build_dataobj_result(struct stk_tlv_=
builder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.13 */
+static gboolean build_dataobj_gsm_sms_tpdu(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_common_byte_array *tpdu =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, tpdu->array, tpdu->len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Defined in TS 102.223 Section 8.15 */
 static gboolean build_dataobj_text(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4099,3 +4142,53 @@ unsigned int stk_pdu_from_response(const struct stk_=
response *response,
 =

 	return stk_tlv_builder_get_length(&builder);
 }
+
+ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelope,
+					unsigned char *pdu, unsigned int size,
+					unsigned char **out_pdu,
+					unsigned int *out_size)
+{
+	struct ber_tlv_builder btlv;
+	struct stk_tlv_builder builder;
+	gboolean ok =3D TRUE;
+	unsigned char tag;
+
+	if (ber_tlv_builder_init(&btlv, pdu, size) !=3D TRUE)
+		return FALSE;
+
+	if (stk_tlv_builder_recurse(&builder, &btlv, envelope->type) !=3D TRUE)
+		return FALSE;
+
+	tag =3D STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
+	if (stk_tlv_builder_open_container(&builder, TRUE, tag, FALSE) =3D=3D FAL=
SE)
+		return FALSE;
+
+	if (stk_tlv_builder_append_byte(&builder, envelope->src) =3D=3D FALSE)
+		return FALSE;
+
+	if (stk_tlv_builder_append_byte(&builder, envelope->dst) =3D=3D FALSE)
+		return FALSE;
+
+	if (stk_tlv_builder_close_container(&builder) =3D=3D FALSE)
+		return FALSE;
+
+	switch (envelope->type) {
+	case STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD:
+		ok =3D build_dataobj(&builder,
+					build_dataobj_address, 0,
+					&envelope->sms_pp_download.address,
+					build_dataobj_gsm_sms_tpdu,
+					DATAOBJ_FLAG_CR,
+					&envelope->sms_pp_download.sms_tpdu,
+					NULL);
+		break;
+	default:
+		return FALSE;
+	};
+
+	if (ok !=3D TRUE)
+		return ok;
+
+	ber_tlv_builder_optimize(&btlv, out_pdu, out_size);
+	return TRUE;
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index cc5801c..8f4ae36 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1172,6 +1172,21 @@ struct stk_response {
 	void (*destructor)(struct stk_response *response);
 };
 =

+/* ENVELOPEs defined in TS 102.223 Section 7 */
+struct stk_envelope_sms_pp_download {
+	struct stk_address address;
+	struct stk_common_byte_array sms_tpdu;
+};
+
+struct stk_envelope {
+	enum stk_envelope_type type;
+	enum stk_device_identity_type src;
+	enum stk_device_identity_type dst;
+	union {
+		struct stk_envelope_sms_pp_download sms_pp_download;
+	};
+};
+
 struct stk_command *stk_command_new_from_pdu(const unsigned char *pdu,
 						unsigned int len);
 void stk_command_free(struct stk_command *command);
@@ -1179,3 +1194,9 @@ void stk_command_free(struct stk_command *command);
 /* Returns # of bytes written or zero on error */
 unsigned int stk_pdu_from_response(const struct stk_response *response,
 					unsigned char *pdu, unsigned int size);
+
+/* Returns TRUE on success */
+ofono_bool_t stk_pdu_from_envelope(const struct stk_envelope *envelope,
+					unsigned char *pdu, unsigned int size,
+					unsigned char **out_pdu,
+					unsigned int *out_size);
-- =

1.7.1.86.g0e460.dirty


--===============6490681747369934934==--

