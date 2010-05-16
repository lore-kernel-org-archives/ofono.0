Content-Type: multipart/mixed; boundary="===============7513954498494143980=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/27] Add a BER-TLV encoding tests.
Date: Sun, 16 May 2010 16:04:28 +0200
Message-ID: <1274018668-6328-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7513954498494143980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c |  271 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 268 insertions(+), 3 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 2c8cb30..7aa09b4 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -48,16 +48,15 @@ const unsigned char valid_mms_params[] =3D {
 	0x6D, 0x65, 0x00, 0x1B, 0x64, 0x75, 0x6D, 0x6D, 0x79, 0x5F, 0x70, 0x61,
 	0x73, 0x73, 0x77, 0x6F, 0x72, 0x64, 0x00 };
 =

-static void test_ber_tlv_iter()
+static void test_buffer(const unsigned char *buf, size_t size)
 {
 	struct ber_tlv_iter iter;
 	struct ber_tlv_iter cont;
 =

-	ber_tlv_iter_init(&iter, valid_mms_params, sizeof(valid_mms_params));
+	ber_tlv_iter_init(&iter, buf, size);
 =

 	g_assert(ber_tlv_iter_next(&iter) =3D=3D TRUE);
 	g_assert(ber_tlv_iter_get_short_tag(&iter) =3D=3D 0xAB);
-	g_assert(ber_tlv_iter_get_length(&iter) =3D=3D 136);
 =

 	ber_tlv_iter_recurse(&iter, &cont);
 =

@@ -81,6 +80,266 @@ static void test_ber_tlv_iter()
 	g_assert(ber_tlv_iter_next(&iter) =3D=3D FALSE);
 }
 =

+static void test_ber_tlv_iter()
+{
+	test_buffer(valid_mms_params, sizeof(valid_mms_params));
+}
+
+static void test_ber_tlv_builder_mms()
+{
+	struct ber_tlv_iter top_iter, nested_iter;
+	struct ber_tlv_builder top_builder, nested_builder;
+	unsigned char buf[512], *pdu;
+	unsigned int pdulen;
+
+	ber_tlv_iter_init(&top_iter, valid_mms_params,
+				sizeof(valid_mms_params));
+	g_assert(ber_tlv_builder_init(&top_builder, buf, sizeof(buf)));
+
+	/* Copy the structure */
+	while (ber_tlv_iter_next(&top_iter) =3D=3D TRUE) {
+		g_assert(ber_tlv_builder_next(&top_builder,
+					ber_tlv_iter_get_class(&top_iter),
+					ber_tlv_iter_get_encoding(&top_iter),
+					ber_tlv_iter_get_tag(&top_iter)));
+
+		ber_tlv_iter_recurse(&top_iter, &nested_iter);
+		g_assert(ber_tlv_builder_recurse(&top_builder,
+							&nested_builder));
+
+		while (ber_tlv_iter_next(&nested_iter) =3D=3D TRUE) {
+			g_assert(ber_tlv_builder_next(&nested_builder,
+					ber_tlv_iter_get_class(&nested_iter),
+					ber_tlv_iter_get_encoding(&nested_iter),
+					ber_tlv_iter_get_tag(&nested_iter)));
+
+			g_assert(ber_tlv_builder_set_length(&nested_builder,
+					ber_tlv_iter_get_length(&nested_iter)));
+			memcpy(ber_tlv_builder_get_data(&nested_builder),
+					ber_tlv_iter_get_data(&nested_iter),
+					ber_tlv_iter_get_length(&nested_iter));
+		}
+
+		ber_tlv_builder_optimize(&nested_builder, NULL, NULL);
+	}
+
+	ber_tlv_builder_optimize(&top_builder, &pdu, &pdulen);
+
+	test_buffer(pdu, pdulen);
+}
+
+static void test_ber_tlv_builder_efpnn()
+{
+	struct sim_eons *eons_info;
+	unsigned char efpnn0[64], efpnn1[64];
+	struct ber_tlv_builder builder;
+
+	g_assert(ber_tlv_builder_init(&builder, efpnn0, sizeof(efpnn0)));
+	g_assert(ber_tlv_builder_next(&builder,
+					BER_TLV_DATA_TYPE_APPLICATION,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x03));
+	g_assert(ber_tlv_builder_set_length(&builder, 10));
+	ber_tlv_builder_get_data(&builder)[0] =3D 0x00;
+	ber_tlv_builder_get_data(&builder)[1] =3D 0x54;
+	ber_tlv_builder_get_data(&builder)[2] =3D 0x75;
+	ber_tlv_builder_get_data(&builder)[3] =3D 0x78;
+	ber_tlv_builder_get_data(&builder)[4] =3D 0x20;
+	ber_tlv_builder_get_data(&builder)[5] =3D 0x43;
+	ber_tlv_builder_get_data(&builder)[6] =3D 0x6f;
+	ber_tlv_builder_get_data(&builder)[7] =3D 0x6d;
+	ber_tlv_builder_get_data(&builder)[8] =3D 0x6d;
+	ber_tlv_builder_get_data(&builder)[9] =3D 0xff;
+	ber_tlv_builder_get_data(&builder)[10] =3D 0xff;
+	ber_tlv_builder_optimize(&builder, NULL, NULL);
+
+	g_assert(ber_tlv_builder_init(&builder, efpnn1, sizeof(efpnn1)));
+	g_assert(ber_tlv_builder_next(&builder,
+					BER_TLV_DATA_TYPE_APPLICATION,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x03));
+	g_assert(ber_tlv_builder_set_length(&builder, 3));
+	ber_tlv_builder_get_data(&builder)[0] =3D 0x00;
+	ber_tlv_builder_get_data(&builder)[1] =3D 0x4c;
+	ber_tlv_builder_get_data(&builder)[2] =3D 0x6f;
+	ber_tlv_builder_get_data(&builder)[3] =3D 0x6e;
+	ber_tlv_builder_get_data(&builder)[4] =3D 0x67;
+	g_assert(ber_tlv_builder_next(&builder,
+					BER_TLV_DATA_TYPE_APPLICATION,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x05));
+	g_assert(ber_tlv_builder_set_length(&builder, 6));
+	ber_tlv_builder_get_data(&builder)[0] =3D 0x00;
+	ber_tlv_builder_get_data(&builder)[1] =3D 0x53;
+	ber_tlv_builder_get_data(&builder)[2] =3D 0x68;
+	ber_tlv_builder_get_data(&builder)[3] =3D 0x6f;
+	ber_tlv_builder_get_data(&builder)[4] =3D 0x72;
+	ber_tlv_builder_get_data(&builder)[5] =3D 0x74;
+	ber_tlv_builder_optimize(&builder, NULL, NULL);
+
+	eons_info =3D sim_eons_new(1);
+	sim_eons_add_pnn_record(eons_info, 1, efpnn0, sizeof(efpnn0));
+	g_assert(!sim_eons_pnn_is_empty(eons_info));
+	sim_eons_free(eons_info);
+
+	eons_info =3D sim_eons_new(1);
+	sim_eons_add_pnn_record(eons_info, 1, efpnn1, sizeof(efpnn1));
+	g_assert(!sim_eons_pnn_is_empty(eons_info));
+	sim_eons_free(eons_info);
+}
+
+static void test_ber_tlv_builder_3g_status()
+{
+	unsigned char buf[512];
+	struct ber_tlv_builder top_builder, nested_builder;
+	unsigned char *response;
+	unsigned int len;
+	int flen, rlen, str;
+	unsigned char access[3];
+	unsigned short efid;
+
+	/* Build a binary EF status response */
+	g_assert(ber_tlv_builder_init(&top_builder, buf, sizeof(buf)));
+
+	g_assert(ber_tlv_builder_next(&top_builder,
+					BER_TLV_DATA_TYPE_APPLICATION,
+					BER_TLV_DATA_ENCODING_TYPE_CONSTRUCTED,
+					0x02));
+	g_assert(ber_tlv_builder_recurse(&top_builder, &nested_builder));
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x02));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 2));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x41;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x21;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x03));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 2));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x2f;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x05;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x0a));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 1));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x05;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x0b));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 3));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x2f;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x06;
+	ber_tlv_builder_get_data(&nested_builder)[2] =3D 0x0f;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x00));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 2));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x00;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x0a;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x08));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 1));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x28;
+
+	ber_tlv_builder_optimize(&nested_builder, NULL, NULL);
+	ber_tlv_builder_optimize(&top_builder, &response, &len);
+
+	sim_parse_3g_get_response(response, len, &flen, &rlen, &str,
+					access, &efid);
+
+	g_assert(flen =3D=3D 10);
+	g_assert(rlen =3D=3D 0);
+	g_assert(str =3D=3D 0);
+	g_assert(access[0] =3D=3D 0x01);
+	g_assert(access[1] =3D=3D 0xff);
+	g_assert(access[2] =3D=3D 0x44);
+	g_assert(efid =3D=3D 0x2F05);
+
+	/* Build a record-based EF status response */
+	g_assert(ber_tlv_builder_init(&top_builder, buf, sizeof(buf)));
+
+	g_assert(ber_tlv_builder_next(&top_builder,
+					BER_TLV_DATA_TYPE_APPLICATION,
+					BER_TLV_DATA_ENCODING_TYPE_CONSTRUCTED,
+					0x02));
+	g_assert(ber_tlv_builder_recurse(&top_builder, &nested_builder));
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x02));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 5));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x42;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x21;
+	ber_tlv_builder_get_data(&nested_builder)[2] =3D 0x00;
+	ber_tlv_builder_get_data(&nested_builder)[3] =3D 0x20;
+	ber_tlv_builder_get_data(&nested_builder)[4] =3D 0x04;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x03));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 2));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x6f;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x40;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x0a));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 1));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x05;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x0b));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 3));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x2f;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x06;
+	ber_tlv_builder_get_data(&nested_builder)[2] =3D 0x07;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x00));
+	g_assert(ber_tlv_builder_set_length(&nested_builder, 2));
+	ber_tlv_builder_get_data(&nested_builder)[0] =3D 0x00;
+	ber_tlv_builder_get_data(&nested_builder)[1] =3D 0x80;
+
+	g_assert(ber_tlv_builder_next(&nested_builder,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0x08));
+
+	ber_tlv_builder_optimize(&nested_builder, NULL, NULL);
+	ber_tlv_builder_optimize(&top_builder, &response, &len);
+
+	sim_parse_3g_get_response(response, len, &flen, &rlen, &str,
+					access, &efid);
+
+	g_assert(flen =3D=3D 0x80);
+	g_assert(rlen =3D=3D 0x20);
+	g_assert(str =3D=3D 1);
+	g_assert(access[0] =3D=3D 0x11);
+	g_assert(access[1] =3D=3D 0xff);
+	g_assert(access[2] =3D=3D 0x44);
+	g_assert(efid =3D=3D 0x6F40);
+}
+
 const unsigned char valid_efopl[] =3D {
 	0x42, 0xf6, 0x1d, 0x00, 0x00, 0xff, 0xfe, 0x01,
 };
@@ -190,6 +449,12 @@ int main(int argc, char **argv)
 	g_test_init(&argc, &argv, NULL);
 =

 	g_test_add_func("/testsimutil/ber tlv iter", test_ber_tlv_iter);
+	g_test_add_func("/testsimutil/ber tlv encode MMS",
+			test_ber_tlv_builder_mms);
+	g_test_add_func("/testsimutil/ber tlv encode EFpnn",
+			test_ber_tlv_builder_efpnn);
+	g_test_add_func("/testsimutil/ber tlv encode 3G Status response",
+			test_ber_tlv_builder_3g_status);
 	g_test_add_func("/testsimutil/EONS Handling", test_eons);
 	g_test_add_func("/testsimutil/Elementary File DB", test_ef_db);
 	g_test_add_func("/testsimutil/3G Status response", test_3g_status_data);
-- =

1.7.1.86.g0e460.dirty


--===============7513954498494143980==--

