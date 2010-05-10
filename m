Content-Type: multipart/mixed; boundary="===============5592904272757515597=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/8] Add a BER-TLV encoding test.
Date: Mon, 10 May 2010 11:33:50 +0200
Message-ID: <1273484030-32160-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5592904272757515597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++=
+--
 1 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 2c8cb30..49a40cd 100644
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

@@ -81,6 +80,59 @@ static void test_ber_tlv_iter()
 	g_assert(ber_tlv_iter_next(&iter) =3D=3D FALSE);
 }
 =

+static void test_ber_tlv_iter()
+{
+	test_buffer(valid_mms_params, sizeof(valid_mms_params));
+}
+
+static void test_ber_tlv_builder()
+{
+	struct ber_tlv_iter iter[2];
+	struct ber_tlv_builder builder[2];
+	unsigned char buf[512], *pdu;
+	unsigned int pdulen, i[2];
+
+	ber_tlv_iter_init(&iter[0], valid_mms_params, sizeof(valid_mms_params));
+	g_assert(ber_tlv_builder_init(&builder[0], buf, sizeof(buf)));
+
+	i[0] =3D 0;
+	while (ber_tlv_iter_next(&iter[0]) =3D=3D TRUE) {
+		if (i[0]++)
+			g_assert(ber_tlv_builder_next(&builder[1]));
+
+		g_assert(ber_tlv_builder_set_tag(&builder[0],
+					ber_tlv_iter_get_class(&iter[0]),
+					ber_tlv_iter_get_encoding(&iter[0]),
+					ber_tlv_iter_get_tag(&iter[0])));
+
+		ber_tlv_iter_recurse(&iter[0], &iter[1]);
+		g_assert(ber_tlv_builder_recurse(&builder[0], &builder[1]));
+
+		i[1] =3D 0;
+		while (ber_tlv_iter_next(&iter[1]) =3D=3D TRUE) {
+			if (i[1]++)
+				g_assert(ber_tlv_builder_next(&builder[1]));
+
+			g_assert(ber_tlv_builder_set_tag(&builder[1],
+					ber_tlv_iter_get_class(&iter[1]),
+					ber_tlv_iter_get_encoding(&iter[1]),
+					ber_tlv_iter_get_tag(&iter[1])));
+			g_assert(ber_tlv_builder_set_length(&builder[1],
+					ber_tlv_iter_get_length(&iter[1])));
+
+			memcpy(ber_tlv_builder_get_data(&builder[1]),
+					ber_tlv_iter_get_data(&iter[1]),
+					ber_tlv_iter_get_length(&iter[1]));
+		}
+
+		ber_tlv_builder_optimize(&builder[1], NULL, NULL);
+	}
+
+	ber_tlv_builder_optimize(&builder[0], &pdu, &pdulen);
+
+	test_buffer(pdu, pdulen);
+}
+
 const unsigned char valid_efopl[] =3D {
 	0x42, 0xf6, 0x1d, 0x00, 0x00, 0xff, 0xfe, 0x01,
 };
@@ -190,6 +242,7 @@ int main(int argc, char **argv)
 	g_test_init(&argc, &argv, NULL);
 =

 	g_test_add_func("/testsimutil/ber tlv iter", test_ber_tlv_iter);
+	g_test_add_func("/testsimutil/ber tlv builder", test_ber_tlv_builder);
 	g_test_add_func("/testsimutil/EONS Handling", test_eons);
 	g_test_add_func("/testsimutil/Elementary File DB", test_ef_db);
 	g_test_add_func("/testsimutil/3G Status response", test_3g_status_data);
-- =

1.6.1


--===============5592904272757515597==--

