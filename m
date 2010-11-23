Content-Type: multipart/mixed; boundary="===============0959973153171420750=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH] SMS character set unit tests.
Date: Tue, 23 Nov 2010 17:21:33 +0200
Message-ID: <1290525693-22150-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0959973153171420750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-sms.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 506 insertions(+), 0 deletions(-)

diff --git a/unit/test-sms.c b/unit/test-sms.c
index c8a9d9c..426d7d3 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -471,6 +471,488 @@ static void test_submit_encode()
 	g_free(encoded_pdu);
 }
 =

+static void test_charset_default_alphabet_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "1000008080" "8060402818" "0E888462C1"
+		"68381E9088" "6442A9582E" "988C06C4E9" "783EA09068" "442A994EA8"
+		"946AC56AB9" "5EB0986C46" "ABD96EB89C" "6EC7EBF97E" "C0A070482C"
+		"1A8FC8A472" "C96C3A9FD0" "A8744AAD5A" "AFD8AC76CB" "ED7ABFE0B0"
+		"784C2E9BCF" "E8B47ACD6E" "BBDFF0B87C" "4EAFDBEFF8" "BC7ECFEFFB"
+		"FF";
+	gchar *text, expected_text[] =3D {
+		0x40, 0xc2, 0xa3, 0x24, 0xc2, 0xa5, 0xc3, 0xa8, 0xc3, 0xa9,
+		0xc3, 0xb9, 0xc3, 0xac, 0xc3, 0xb2, 0xc3, 0x87, 0x0a, 0xc3,
+		0x98, 0xc3, 0xb8, 0x0d, 0xc3, 0x85, 0xc3, 0xa5, 0xce, 0x94,
+		0x5f, 0xce, 0xa6, 0xce, 0x93, 0xce, 0x9b, 0xce, 0xa9, 0xce,
+		0xa0, 0xce, 0xa8, 0xce, 0xa3, 0xce, 0x98, 0xce, 0x9e, 0x20,
+		0xc3, 0x86, 0xc3, 0xa6, 0xc3, 0x9f, 0xc3, 0x89, 0x20, 0x21,
+		0x22, 0x23, 0xc2, 0xa4, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a,
+		0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34,
+		0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e,
+		0x3f, 0xc2, 0xa1, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
+		0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51,
+		0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0xc3,
+		0x84, 0xc3, 0x96, 0xc3, 0x91, 0xc3, 0x9c, 0xc2, 0xa7, 0xc2,
+		0xbf, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69,
+		0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73,
+		0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0xc3, 0xa4, 0xc3,
+		0xb6, 0xc3, 0xb1, 0xc3, 0xbc, 0xc3, 0xa0, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	g_assert(sms.deliver.udl =3D=3D 128);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 112);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8(data, -1, NULL, NULL, 0xff);
+
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_default_alphabet_ext_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "100000151B" "C58602DAA0" "36A9CD6BC3"
+		"DBF436BE0D" "705306";
+	gchar *text, expected_text[] =3D {
+		0x0c, 0x5e, 0x20, 0x7b,	0x7d, 0x5c, 0x5b, 0x7e,	0x5d, 0x7c,
+		0xe2, 0x82, 0xac, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	g_assert(sms.deliver.udl =3D=3D 21);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 19);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8(data, -1, NULL, NULL, 0xff);
+
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_turkey_locking_shift_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "1000008080" "8060402818" "0E888462C1"
+		"68381E9088" "6442A9582E" "988C06C4E9" "783EA09068" "442A994EA8"
+		"946AC56AB9" "5EB0986C46" "ABD96EB89C" "6EC7EBF97E" "C0A070482C"
+		"1A8FC8A472" "C96C3A9FD0" "A8744AAD5A" "AFD8AC76CB" "ED7ABFE0B0"
+		"784C2E9BCF" "E8B47ACD6E" "BBDFF0B87C" "4EAFDBEFF8" "BC7ECFEFFB"
+		"FF";
+	gchar *text, expected_text[] =3D {
+		0x40, 0xc2, 0xa3, 0x24, 0xc2, 0xa5, 0xe2, 0x82, 0xac, 0xc3,
+		0xa9, 0xc3, 0xb9, 0xc4, 0xb1, 0xc3, 0xb2, 0xc3, 0x87, 0x0a,
+		0xc4, 0x9e, 0xc4, 0x9f, 0x0d, 0xc3, 0x85, 0xc3, 0xa5, 0xce,
+		0x94, 0x5f, 0xce, 0xa6, 0xce, 0x93, 0xce, 0x9b, 0xce, 0xa9,
+		0xce, 0xa0, 0xce, 0xa8, 0xce, 0xa3, 0xce, 0x98, 0xce, 0x9e,
+		0x20, 0xc5, 0x9e, 0xc5, 0x9f, 0xc3, 0x9f, 0xc3, 0x89, 0x20,
+		0x21, 0x22, 0x23, 0xc2, 0xa4, 0x25, 0x26, 0x27, 0x28, 0x29,
+		0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33,
+		0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d,
+		0x3e, 0x3f, 0xc4, 0xb0, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46,
+		0x47, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50,
+		0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a,
+		0xc3, 0x84, 0xc3, 0x96, 0xc3, 0x91, 0xc3, 0x9c, 0xc2, 0xa7,
+		0xc3, 0xa7, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+		0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72,
+		0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0xc3, 0xa4,
+		0xc3, 0xb6, 0xc3, 0xb1, 0xc3, 0xbc, 0xc3, 0xa0, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 112);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8_with_lang(data, -1, NULL, NULL, 0xff,
+					     GSM_DIALECT_TURKISH,
+					     GSM_DIALECT_DEFAULT);
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_turkey_ext_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "1000001A1B" "C586B2416D" "529BD786B7"
+		"E96D7C1BE0" "02C8011318" "870E";
+	gchar *text, expected_text[] =3D {
+		0x0c, 0x5e, 0x7b, 0x7d, 0x5c, 0x5b, 0x7e, 0x5d, 0x7c, 0xc4,
+		0x9e, 0xc4, 0xb0, 0xc5, 0x9e, 0xc3, 0xa7, 0xe2, 0x82, 0xac,
+		0xc4, 0x9f, 0xc4, 0xb1, 0xc5, 0x9f, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 23);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8_with_lang(data, -1, NULL, NULL, 0xff,
+					     GSM_DIALECT_TURKISH,
+					     GSM_DIALECT_TURKISH);
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_portugal_locking_shift_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "1000008080" "8060402818" "0E888462C1"
+		"68381E9088" "6442A9582E" "988C06C4E9" "783EA09068" "442A994EA8"
+		"946AC56AB9" "5EB0986C46" "ABD96EB89C" "6EC7EBF97E" "C0A070482C"
+		"1A8FC8A472" "C96C3A9FD0" "A8744AAD5A" "AFD8AC76CB" "ED7ABFE0B0"
+		"784C2E9BCF" "E8B47ACD6E" "BBDFF0B87C" "4EAFDBEFF8" "BC7ECFEFFB"
+		"FF";
+	gchar *text, expected_text[] =3D {
+		0x40, 0xc2, 0xa3, 0x24, 0xc2, 0xa5, 0xc3, 0xaa, 0xc3, 0xa9,
+		0xc3, 0xba, 0xc3, 0xad, 0xc3, 0xb3, 0xc3, 0xa7, 0x0a, 0xc3,
+		0x94, 0xc3, 0xb4, 0x0d, 0xc3, 0x81, 0xc3, 0xa1, 0xce, 0x94,
+		0x5f, 0xc2, 0xaa, 0xc3, 0x87, 0xc3, 0x80, 0xe2, 0x88, 0x9e,
+		0x5e, 0x5c, 0xe2, 0x82, 0xac, 0xc3, 0x93, 0x7c, 0x20, 0xc3,
+		0x82, 0xc3, 0xa2, 0xc3, 0x8a, 0xc3, 0x89, 0x20, 0x21, 0x22,
+		0x23, 0xc2, 0xba, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
+		0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
+		0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+		0xc3, 0x8d, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48,
+		0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52,
+		0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0xc3, 0x83,
+		0xc3, 0x95, 0xc3, 0x9a, 0xc3, 0x9c, 0xc2, 0xa7, 0x7e, 0x61,
+		0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b,
+		0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75,
+		0x76, 0x77, 0x78, 0x79, 0x7a, 0xc3, 0xa3, 0xc3, 0xb5, 0x60,
+		0xc3, 0xbc, 0xc3, 0xa0, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 112);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8_with_lang(data, -1, NULL, NULL, 0xff,
+					     GSM_DIALECT_PORTUGUESE,
+					     GSM_DIALECT_DEFAULT);
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_portugal_ext_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "1000003184" "C446B16038" "1E1BC96662"
+		"D9543696CD" "6583D9643C" "1BD42675D9" "F0C01B9F86" "02CC74B75C"
+		"0EE68030EC" "F91D";
+	gchar *text, expected_text[] =3D {
+		0xc3, 0xaa, 0xc3, 0xa7, 0x0c, 0xc3, 0x94, 0xc3, 0xb4, 0xc3,
+		0x81, 0xc3, 0xa1, 0xce, 0xa6, 0xce, 0x93, 0x5e, 0xce, 0xa9,
+		0xce, 0xa0, 0xce, 0xa8, 0xce, 0xa3, 0xce, 0x98, 0xc3, 0x8a,
+		0x7b, 0x7d, 0x5c, 0x5b, 0x7e, 0x5d, 0x7c, 0xc3, 0x80, 0xc3,
+		0x8d, 0xc3, 0x93, 0xc3, 0x9a, 0xc3, 0x83, 0xc3, 0x95, 0xc3,
+		0x82, 0xe2, 0x82, 0xac, 0xc3, 0xad, 0xc3, 0xb3, 0xc3, 0xba,
+		0xc3, 0xa3, 0xc3, 0xb5, 0xc3, 0xa2, 0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 43);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8_with_lang(data, -1, NULL, NULL, 0xff,
+					     GSM_DIALECT_PORTUGUESE,
+					     GSM_DIALECT_PORTUGUESE);
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
+static void test_charset_spain_decode()
+{
+	gboolean ret;
+	struct sms sms;
+	guint8 *pdu, *data;
+	gint64 pdu_len;
+	gint data_len;
+	enum sms_charset sms_charset;
+	gboolean sms_compressed;
+	gchar *spdu =3D
+		"0001000B91" "5310101010" "100000269B" "C446B1A16C" "509BD4E6B5"
+		"E16D7A1BDF" "06B8096E92" "9BE7A6BA09" "6FCA9BF4E6" "BDA903";
+	gchar *text, expected_text[] =3D {
+		0xc3, 0xa7, 0x0c, 0x5e, 0x7b, 0x7d, 0x5c, 0x5b, 0x7e, 0x5d,
+		0x7c, 0xc3, 0x81, 0xc3, 0x8d, 0xc3, 0x93, 0xc3, 0x9a, 0xc3,
+		0xa1, 0xe2, 0x82, 0xac, 0xc3, 0xad, 0xc3, 0xb3, 0xc3, 0xba,
+		0x00
+	};
+
+	pdu =3D decode_hex(spdu, -1, &pdu_len, 0);
+
+	g_assert(pdu);
+
+	g_assert(pdu_len =3D=3D (gint64)strlen(spdu) / 2);
+
+	ret =3D sms_decode(pdu, pdu_len, FALSE, pdu_len, &sms);
+
+	g_assert(ret);
+
+	g_free(pdu);
+
+	g_assert(sms.type =3D=3D SMS_TYPE_DELIVER);
+
+	ret =3D sms_dcs_decode(sms.deliver.dcs, NULL, &sms_charset,
+			     &sms_compressed, NULL);
+	g_assert(ret);
+
+	g_assert(sms_charset =3D=3D SMS_CHARSET_7BIT);
+
+	g_assert(sms_compressed =3D=3D FALSE);
+
+	data_len =3D sms_udl_in_bytes(sms.deliver.udl, sms.deliver.dcs);
+
+	g_assert(data_len =3D=3D 34);
+
+	data =3D unpack_7bit(sms.deliver.ud, data_len, 0, FALSE,
+			   sms.deliver.udl, NULL, 0xff);
+	g_assert(data);
+
+	text =3D convert_gsm_to_utf8_with_lang(data, -1, NULL, NULL, 0xff,
+					     GSM_DIALECT_SPANISH,
+					     GSM_DIALECT_SPANISH);
+	g_assert(text);
+
+	g_free(data);
+
+	g_assert(strcmp(expected_text, text) =3D=3D 0);
+
+	g_free(text);
+}
+
 struct text_format_header {
 	unsigned char len;
 	unsigned char start;
@@ -1461,6 +1943,30 @@ int main(int argc, char **argv)
 	g_test_add_func("/testsms/Test Simple Submit", test_simple_submit);
 	g_test_add_func("/testsms/Test Submit Encode", test_submit_encode);
 =

+	g_test_add_func("/testsms/Test "
+			"GSM 7 bit Default Alphabet Decode",
+			test_charset_default_alphabet_decode);
+	g_test_add_func("/testsms/Test "
+			"GSM 7 bit Default Alphabet Extension Table Decode",
+			test_charset_default_alphabet_ext_decode);
+	g_test_add_func("/testsms/Test "
+			"Turkish National Language Locking Shift Table Decode",
+			test_charset_turkey_locking_shift_decode);
+	g_test_add_func("/testsms/Test "
+			"Turkish National Language Single Shift Table Decode",
+			test_charset_turkey_ext_decode);
+	g_test_add_func("/testsms/Test "
+			"Portuguese National Language Locking Shift "
+			"Table Decode",
+			test_charset_portugal_locking_shift_decode);
+	g_test_add_func("/testsms/Test "
+			"Portuguese National Language Single Shift "
+			"Table Decode",
+			test_charset_portugal_ext_decode);
+	g_test_add_func("/testsms/Test "
+			"Spanish National Language Single Shift Table Decode",
+			test_charset_spain_decode);
+
 	g_test_add_data_func("/testsms/Test EMS UDH 1",
 			&ems_udh_test_1, test_ems_udh);
 	g_test_add_data_func("/testsms/Test EMS UDH 2",
-- =

1.7.1


--===============0959973153171420750==--

