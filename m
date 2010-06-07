Content-Type: multipart/mixed; boundary="===============2698852735136705018=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/20] stkutil: Add SMS-PP Data Download envelope builder
Date: Mon, 07 Jun 2010 12:08:24 +0200
Message-ID: <1275905322-14768-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2698852735136705018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkutil.h |   17 +++++++++
 2 files changed, 127 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 14958a8..661cfc6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3142,6 +3142,20 @@ static gboolean stk_tlv_builder_init(struct stk_tlv_=
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
@@ -3322,6 +3336,27 @@ static inline gboolean stk_tlv_builder_append_bytes(=
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
+	unsigned int len;
+	unsigned char number[128];
+
+	if (addr->number =3D=3D NULL)
+		return TRUE;
+
+	len =3D (strlen(addr->number) + 1) / 2;
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
@@ -3374,6 +3409,28 @@ static gboolean build_dataobj_result(struct stk_tlv_=
builder *tlv,
 	return stk_tlv_builder_close_container(tlv);
 }
 =

+/* Described in TS 131.111 Section 8.13 */
+static gboolean build_dataobj_gsm_sms_tpdu(struct stk_tlv_builder *tlv,
+						const void *data, gboolean cr)
+{
+	const struct sms_deliver *msg =3D data;
+	struct sms sms;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_GSM_SMS_TPDU;
+	unsigned char tpdu[165];
+	int tpdu_len;
+
+	sms.type =3D SMS_TYPE_DELIVER;
+	memset(&sms.sc_addr, 0, sizeof(sms.sc_addr));
+	memcpy(&sms.deliver, msg, sizeof(sms.deliver));
+
+	if (sms_encode(&sms, NULL, &tpdu_len, tpdu) =3D=3D FALSE)
+		return FALSE;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, TRUE) &&
+		stk_tlv_builder_append_bytes(tlv, tpdu + 1, tpdu_len) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
 /* Defined in TS 102.223 Section 8.15 */
 static gboolean build_dataobj_text(struct stk_tlv_builder *tlv,
 					const void *data, gboolean cr)
@@ -4117,3 +4174,56 @@ const unsigned char *stk_pdu_from_response(const str=
uct stk_response *response,
 =

 	return pdu;
 }
+
+/* Described in TS 102.223 Section 8.7 */
+static gboolean build_envelope_dataobj_device_ids(struct stk_tlv_builder *=
tlv,
+						const void *data, gboolean cr)
+{
+	const struct stk_envelope *envelope =3D data;
+	unsigned char tag =3D STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
+
+	return stk_tlv_builder_open_container(tlv, cr, tag, FALSE) &&
+		stk_tlv_builder_append_byte(tlv, envelope->src) &&
+		stk_tlv_builder_append_byte(tlv, envelope->dst) &&
+		stk_tlv_builder_close_container(tlv);
+}
+
+const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
+						unsigned int *out_length)
+{
+	struct ber_tlv_builder btlv;
+	struct stk_tlv_builder builder;
+	gboolean ok =3D TRUE;
+	static unsigned char buffer[512];
+	unsigned char *pdu;
+
+	if (ber_tlv_builder_init(&btlv, buffer, sizeof(buffer)) !=3D TRUE)
+		return NULL;
+
+	if (stk_tlv_builder_recurse(&builder, &btlv, envelope->type) !=3D TRUE)
+		return NULL;
+
+	switch (envelope->type) {
+	case STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD:
+		ok =3D build_dataobj(&builder,
+					build_envelope_dataobj_device_ids,
+					DATAOBJ_FLAG_CR,
+					envelope,
+					build_dataobj_address, 0,
+					&envelope->sms_pp_download.address,
+					build_dataobj_gsm_sms_tpdu,
+					DATAOBJ_FLAG_CR,
+					&envelope->sms_pp_download.message,
+					NULL);
+		break;
+	default:
+		return NULL;
+	};
+
+	if (ok !=3D TRUE)
+		return NULL;
+
+	ber_tlv_builder_optimize(&btlv, &pdu, out_length);
+
+	return pdu;
+}
diff --git a/src/stkutil.h b/src/stkutil.h
index 7dd0d6c..cc293ca 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -1172,9 +1172,26 @@ struct stk_response {
 	void (*destructor)(struct stk_response *response);
 };
 =

+/* ENVELOPEs defined in TS 102.223 Section 7 */
+struct stk_envelope_sms_pp_download {
+	struct stk_address address;
+	struct sms_deliver message;
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
 =

 const unsigned char *stk_pdu_from_response(const struct stk_response *resp=
onse,
 						unsigned int *out_length);
+const unsigned char *stk_pdu_from_envelope(const struct stk_envelope *enve=
lope,
+						unsigned int *out_length);
-- =

1.7.1.86.g0e460.dirty


--===============2698852735136705018==--

