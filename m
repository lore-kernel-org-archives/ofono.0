Content-Type: multipart/mixed; boundary="===============3185181442251708780=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] test-stkutil: Add unit test for Display Text response
 encoding.
Date: Mon, 10 May 2010 11:34:19 +0200
Message-ID: <1273484059-32247-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3185181442251708780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 236 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 82f2a1c..8e703e5 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -1452,6 +1452,214 @@ static void test_send_sms(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct terminal_response_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	struct stk_response response;
+};
+
+static void test_terminal_response_encoding(gconstpointer data)
+{
+	const struct terminal_response_test *test =3D data;
+	unsigned char buf[512];
+	unsigned int len;
+
+	len =3D stk_pdu_from_response(&test->response, buf, sizeof(buf));
+
+	g_assert(len =3D=3D test->pdu_len);
+	g_assert(memcmp(buf, test->pdu, len) =3D=3D 0);
+}
+
+static const unsigned char display_text_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test display_text_response_data_111 =
=3D {
+	.pdu =3D display_text_response_111,
+	.pdu_len =3D sizeof(display_text_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x20, 0x01,
+};
+
+static const struct terminal_response_test display_text_response_data_121 =
=3D {
+	.pdu =3D display_text_response_121,
+	.pdu_len =3D sizeof(display_text_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TERMINAL_BUSY,
+			.additional_len =3D 1, /* Screen is busy */
+			.additional =3D (unsigned char *) "\1",
+		},
+	},
+};
+
+static const unsigned char display_text_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x81, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test display_text_response_data_131 =
=3D {
+	.pdu =3D display_text_response_131,
+	.pdu_len =3D sizeof(display_text_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x81,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test display_text_response_data_151 =
=3D {
+	.pdu =3D display_text_response_151,
+	.pdu_len =3D sizeof(display_text_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
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
+static const unsigned char display_text_response_171[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x11,
+};
+
+static const struct terminal_response_test display_text_response_data_171 =
=3D {
+	.pdu =3D display_text_response_171,
+	.pdu_len =3D sizeof(display_text_response_171),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_GO_BACK,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_181[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x10,
+};
+
+static const struct terminal_response_test display_text_response_data_181 =
=3D {
+	.pdu =3D display_text_response_181,
+	.pdu_len =3D sizeof(display_text_response_181),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_TERMINATED,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_191[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x32,
+};
+
+static const struct terminal_response_test display_text_response_data_191 =
=3D {
+	.pdu =3D display_text_response_191,
+	.pdu_len =3D sizeof(display_text_response_191),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_211[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x12,
+};
+
+static const struct terminal_response_test display_text_response_data_211 =
=3D {
+	.pdu =3D display_text_response_211,
+	.pdu_len =3D sizeof(display_text_response_211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_RESPONSE,
+			.additional_len =3D 0,
+		},
+	},
+};
+
+static const unsigned char display_text_response_511b[] =3D {
+	0x81, 0x03, 0x01, 0x21, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test display_text_response_data_511b=
 =3D {
+	.pdu =3D display_text_response_511b,
+	.pdu_len =3D sizeof(display_text_response_511b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_DISPLAY_TEXT,
+		.qualifier =3D 0x80,
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
@@ -1483,6 +1691,34 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Display Text 10.1.1",
 				&display_text_data_1011, test_display_text);
 =

+	g_test_add_data_func("/teststk/Display Text response 1.1.1",
+				&display_text_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.2.1",
+				&display_text_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.3.1",
+				&display_text_response_data_131,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.5.1",
+				&display_text_response_data_151,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.7.1",
+				&display_text_response_data_171,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.8.1",
+				&display_text_response_data_181,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 1.9.1",
+				&display_text_response_data_191,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 2.1.1",
+				&display_text_response_data_211,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Display Text response 5.1.1B",
+				&display_text_response_data_511b,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Get Inkey 1.1.1",
 				&get_inkey_data_111, test_get_inkey);
 	g_test_add_data_func("/teststk/Get Inkey 1.2.1",
-- =

1.6.1


--===============3185181442251708780==--

