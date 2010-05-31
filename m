Content-Type: multipart/mixed; boundary="===============2320774624153611845=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/11] test-stkutil: Tests for SMS-PP Data Download envelope
 builder
Date: Mon, 31 May 2010 14:47:15 +0200
Message-ID: <1275310044-27469-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2320774624153611845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  158 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 158 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 06d40a3..681043a 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -17838,6 +17838,154 @@ static const struct terminal_response_test launch=
_browser_response_data_411b =3D {
 	},
 };
 =

+struct envelope_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	struct stk_envelope envelope;
+};
+
+static void test_envelope_encoding(gconstpointer data)
+{
+	const struct envelope_test *test =3D data;
+	unsigned char buf[512], *pdu;
+	unsigned int len;
+
+	g_assert(stk_pdu_from_envelope(&test->envelope,
+					buf, sizeof(buf), &pdu, &len) =3D=3D TRUE);
+
+	g_assert(len =3D=3D test->pdu_len);
+	g_assert(memcmp(pdu, test->pdu, len) =3D=3D 0);
+}
+
+static const unsigned char sms_pp_data_download_161[] =3D {
+	0xd1, 0x2d, 0x82, 0x02, 0x83, 0x81, 0x06, 0x09,
+	0x91, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0xf8, 0x8b, 0x1c, 0x04, 0x04, 0x91, 0x21, 0x43,
+	0x7f, 0x16, 0x89, 0x10, 0x10, 0x00, 0x00, 0x00,
+	0x00, 0x0d, 0x53, 0x68, 0x6f, 0x72, 0x74, 0x20,
+	0x4d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65,
+};
+
+static const struct envelope_test sms_pp_data_download_data_161 =3D {
+	.pdu =3D sms_pp_data_download_161,
+	.pdu_len =3D sizeof(sms_pp_data_download_161),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .sms_pp_download =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "112233445566778",
+			},
+			.sms_tpdu =3D {
+				.array =3D (unsigned char[28]) {
+					0x04, 0x04, 0x91, 0x21, 0x43, 0x7f,
+					0x16, 0x89, 0x10, 0x10, 0x00, 0x00,
+					0x00, 0x00, 0x0d, 0x53, 0x68, 0x6f,
+					0x72, 0x74, 0x20, 0x4d, 0x65, 0x73,
+					0x73, 0x61, 0x67, 0x65,
+				},
+				.len =3D 28,
+			},
+			/* Corresponds to (struct sms_deliver) {
+			 *	.oaddr =3D {
+			 *		.number_type =3D
+			 *			SMS_NUMBER_TYPE_INTERNATIONAL,
+			 *		.numbering_plan =3D
+			 *			SMS_NUMBERING_PLAN_ISDN,
+			 *		.address =3D "1234",
+			 *	},
+			 *	.pid =3D SMS_PID_TYPE_USIM_DOWNLOAD,
+			 *	.dcs =3D 0x16, // General, uncompr, Class 2, 8-bit
+			 *	.scts =3D {
+			 *		.year =3D 98,
+			 *		.month =3D 0,
+			 *		.day =3D 0,
+			 *	},
+			 *	.udl =3D 13,
+			 *	.ud =3D "Short Message",
+			 * }
+			 */
+		}},
+	},
+};
+
+static const unsigned char sms_pp_data_download_162[] =3D {
+	0xd1, 0x2d, 0x82, 0x02, 0x83, 0x81, 0x06, 0x09,
+	0x91, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0xf8, 0x8b, 0x1c, 0x04, 0x04, 0x91, 0x21, 0x43,
+	0x7f, 0xf6, 0x89, 0x10, 0x10, 0x00, 0x00, 0x00,
+	0x00, 0x0d, 0x53, 0x68, 0x6f, 0x72, 0x74, 0x20,
+	0x4d, 0x65, 0x73, 0x73, 0x61, 0x67, 0x65,
+};
+
+static const struct envelope_test sms_pp_data_download_data_162 =3D {
+	.pdu =3D sms_pp_data_download_162,
+	.pdu_len =3D sizeof(sms_pp_data_download_162),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .sms_pp_download =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "112233445566778",
+			},
+			.sms_tpdu =3D {
+				.array =3D (unsigned char[28]) {
+					0x04, 0x04, 0x91, 0x21, 0x43, 0x7f,
+					0xf6, 0x89, 0x10, 0x10, 0x00, 0x00,
+					0x00, 0x00, 0x0d, 0x53, 0x68, 0x6f,
+					0x72, 0x74, 0x20, 0x4d, 0x65, 0x73,
+					0x73, 0x61, 0x67, 0x65,
+				},
+				.len =3D 28,
+			},
+		}},
+	},
+};
+
+static const unsigned char sms_pp_data_download_182[] =3D {
+	0xd1, 0x3e, 0x82, 0x02, 0x83, 0x81, 0x06, 0x09,
+	0x91, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0xf8, 0x8b, 0x2d, 0x44, 0x04, 0x91, 0x21, 0x43,
+	0x7f, 0xf6, 0x89, 0x10, 0x10, 0x00, 0x00, 0x00,
+	0x00, 0x1e, 0x02, 0x70, 0x00, 0x00, 0x19, 0x00,
+	0x0d, 0x00, 0x00, 0x00, 0x00, 0xbf, 0xff, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0xdc, 0xdc,
+	0xdc, 0xdc, 0xdc, 0xdc, 0xdc, 0xdc, 0xdc, 0xdc,
+};
+
+static const struct envelope_test sms_pp_data_download_data_182 =3D {
+	.pdu =3D sms_pp_data_download_182,
+	.pdu_len =3D sizeof(sms_pp_data_download_182),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .sms_pp_download =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "112233445566778",
+			},
+			.sms_tpdu =3D {
+				.array =3D (unsigned char[45]) {
+					0x44, 0x04, 0x91, 0x21, 0x43, 0x7f,
+					0xf6, 0x89, 0x10, 0x10, 0x00, 0x00,
+					0x00, 0x00, 0x1e, 0x02, 0x70, 0x00,
+					0x00, 0x19, 0x00, 0x0d, 0x00, 0x00,
+					0x00, 0x00, 0xbf, 0xff, 0x00, 0x00,
+					0x00, 0x00, 0x00, 0x01, 0x00, 0xdc,
+					0xdc, 0xdc, 0xdc, 0xdc, 0xdc, 0xdc,
+					0xdc, 0xdc, 0xdc,
+				},
+				.len =3D 45,
+			},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -19499,5 +19647,15 @@ int main(int argc, char **argv)
 			&launch_browser_response_data_411b,
 			test_terminal_response_encoding);
 =

+	g_test_add_data_func("/teststk/SMS-PP data download 1.6.1",
+			&sms_pp_data_download_data_161,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/SMS-PP data download 1.6.2",
+			&sms_pp_data_download_data_162,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/SMS-PP data download 1.8.2",
+			&sms_pp_data_download_data_182,
+			test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============2320774624153611845==--

