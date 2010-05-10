Content-Type: multipart/mixed; boundary="===============5395862349950058158=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/8] test-stkutil: Add unit test for Send Short Message
 response encoding.
Date: Mon, 10 May 2010 11:34:44 +0200
Message-ID: <1273484084-32334-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5395862349950058158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 2f2a725..005885e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -2853,6 +2853,69 @@ static const struct terminal_response_test get_input=
_response_data_1221 =3D {
 	},
 };
 =

+static const unsigned char send_sms_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x13, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test send_sms_response_data_111 =3D {
+	.pdu =3D send_sms_response_111,
+	.pdu_len =3D sizeof(send_sms_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_SMS,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char send_sms_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x13, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test send_sms_response_data_121 =3D {
+	.pdu =3D send_sms_response_121,
+	.pdu_len =3D sizeof(send_sms_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_SMS,
+		.qualifier =3D 0x01,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char send_sms_response_311b[] =3D {
+	0x81, 0x03, 0x01, 0x13, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test send_sms_response_data_311b =3D=
 {
+	.pdu =3D send_sms_response_311b,
+	.pdu_len =3D sizeof(send_sms_response_311b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_SMS,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+			.additional_len =3D 0,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -3145,5 +3208,15 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Send SMS 1.1",
 				&send_sms_data_11, test_send_sms);
 =

+	g_test_add_data_func("/teststk/Send SMS response 1.1.1",
+				&send_sms_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send SMS response 1.2.1",
+				&send_sms_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send SMS response 3.1.1B",
+				&send_sms_response_data_311b,
+				test_terminal_response_encoding);
+
 	return g_test_run();
 }
-- =

1.6.1


--===============5395862349950058158==--

