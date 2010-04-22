Content-Type: multipart/mixed; boundary="===============8788524382461530649=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3][RfC] Add a BTLV encoding test.
Date: Thu, 22 Apr 2010 10:11:54 +0200
Message-ID: <1271923914-3378-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8788524382461530649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 2c8cb30..8a90ad1 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -81,6 +81,57 @@ static void test_ber_tlv_iter()
 	g_assert(ber_tlv_iter_next(&iter) =3D=3D FALSE);
 }
 =

+static void test_ber_tlv_constr()
+{
+	struct ber_tlv_constr constr;
+	struct ber_tlv_constr cont;
+	unsigned char pdu[256];
+
+	g_assert(ber_tlv_constr_init(&constr, pdu, sizeof(pdu)));
+
+	g_assert(ber_tlv_constr_set_tag(&constr,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_CONSTRUCTED,
+					0xB));
+
+	g_assert(ber_tlv_constr_recurse(&constr, &cont));
+
+	g_assert(ber_tlv_constr_set_tag(&cont,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					0));
+	g_assert(ber_tlv_constr_set_length(&cont, 1));
+	memcpy(ber_tlv_constr_get_data(&cont), valid_mms_params + 5, 1);
+
+	g_assert(ber_tlv_constr_next(&cont));
+	g_assert(ber_tlv_constr_set_tag(&cont,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					1));
+	g_assert(ber_tlv_constr_set_length(&cont, 23));
+	memcpy(ber_tlv_constr_get_data(&cont), valid_mms_params + 8, 23);
+
+	g_assert(ber_tlv_constr_next(&cont));
+	g_assert(ber_tlv_constr_set_tag(&cont,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					2));
+	g_assert(ber_tlv_constr_set_length(&cont, 50));
+	memcpy(ber_tlv_constr_get_data(&cont), valid_mms_params + 33, 50);
+
+	g_assert(ber_tlv_constr_next(&cont));
+	g_assert(ber_tlv_constr_set_tag(&cont,
+					BER_TLV_DATA_TYPE_CONTEXT_SPECIFIC,
+					BER_TLV_DATA_ENCODING_TYPE_PRIMITIVE,
+					3));
+	g_assert(ber_tlv_constr_set_length(&cont, 54));
+	memcpy(ber_tlv_constr_get_data(&cont), valid_mms_params + 85, 54);
+
+	g_assert(ber_tlv_constr_next(&constr));
+	g_assert(constr.pos =3D=3D sizeof(valid_mms_params));
+	g_assert(memcmp(pdu, valid_mms_params, sizeof(valid_mms_params)) =3D=3D 0=
);
+}
+
 const unsigned char valid_efopl[] =3D {
 	0x42, 0xf6, 0x1d, 0x00, 0x00, 0xff, 0xfe, 0x01,
 };
@@ -190,6 +241,7 @@ int main(int argc, char **argv)
 	g_test_init(&argc, &argv, NULL);
 =

 	g_test_add_func("/testsimutil/ber tlv iter", test_ber_tlv_iter);
+	g_test_add_func("/testsimutil/ber tlv constr", test_ber_tlv_constr);
 	g_test_add_func("/testsimutil/EONS Handling", test_eons);
 	g_test_add_func("/testsimutil/Elementary File DB", test_ef_db);
 	g_test_add_func("/testsimutil/3G Status response", test_3g_status_data);
-- =

1.6.1


--===============8788524382461530649==--

