Content-Type: multipart/mixed; boundary="===============3173552557080854294=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v3 3/3] unit: add validate_utf8_tlv tests
Date: Sat, 16 Jan 2021 22:21:07 +0300
Message-ID: <20210116192107.18568-4-geomatsi@gmail.com>
In-Reply-To: <20210116192107.18568-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3173552557080854294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-simutil.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-simutil.c b/unit/test-simutil.c
index 083bd4b2..6f8419b4 100644
--- a/unit/test-simutil.c
+++ b/unit/test-simutil.c
@@ -86,6 +86,27 @@ static void test_ber_tlv_iter(void)
 	test_buffer(valid_mms_params, sizeof(valid_mms_params));
 }
 =

+static void test_validate_tlv(void)
+{
+	unsigned char impi_none[] =3D { 0x80, 0x0 };
+	unsigned char impi_empty[] =3D { 0x80, 0x1, '\0' };
+	unsigned char impi_term1[] =3D { 0x80, 0x3, 'F', 'O', 'O' };
+	unsigned char impi_term2[] =3D { 0x80, 0x4, 'F', 'O', 'O', '\0' };
+	unsigned char impi_term3[] =3D { 0x80, 0x3, 'F', 'O', 'O', 0xff, 0xff };
+	unsigned char impi_term4[] =3D { 0x80, 0x4, 'F', 'O', 'O', '\0', 0xff };
+	unsigned char impi_invalid1[] =3D { 0x80, 0x4, 'F', '\0', 'O', '\0' };
+	unsigned char impi_invalid2[] =3D { 0x80, 0x4, 0xff, 0xff, 0xff, 0xff };
+
+	g_assert(validate_utf8_tlv(impi_none) =3D=3D FALSE);
+	g_assert(validate_utf8_tlv(impi_empty) =3D=3D TRUE);
+	g_assert(validate_utf8_tlv(impi_term1) =3D=3D TRUE);
+	g_assert(validate_utf8_tlv(impi_term2) =3D=3D TRUE);
+	g_assert(validate_utf8_tlv(impi_term3) =3D=3D TRUE);
+	g_assert(validate_utf8_tlv(impi_term4) =3D=3D TRUE);
+	g_assert(validate_utf8_tlv(impi_invalid1) =3D=3D FALSE);
+	g_assert(validate_utf8_tlv(impi_invalid2) =3D=3D FALSE);
+}
+
 static void test_ber_tlv_builder_mms(void)
 {
 	struct ber_tlv_iter top_iter, nested_iter;
@@ -610,6 +631,7 @@ int main(int argc, char **argv)
 	g_test_init(&argc, &argv, NULL);
 =

 	g_test_add_func("/testsimutil/ber tlv iter", test_ber_tlv_iter);
+	g_test_add_func("/testsimutil/ber tlv validate utf8", test_validate_tlv);
 	g_test_add_func("/testsimutil/ber tlv encode MMS",
 			test_ber_tlv_builder_mms);
 	g_test_add_func("/testsimutil/ber tlv encode EFpnn",
--===============3173552557080854294==--

