Content-Type: multipart/mixed; boundary="===============6839202595146174510=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/27] test-stkutil: Add Get Input response tests.
Date: Sun, 16 May 2010 16:05:29 +0200
Message-ID: <1274018729-6552-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6839202595146174510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  709 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 709 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index b042f62..932e364 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -10610,6 +10610,648 @@ static const struct terminal_response_test get_in=
key_response_data_1311 =3D {
 	},
 };
 =

+static const unsigned char get_input_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x04, 0x31,
+	0x32, 0x33, 0x34, 0x35,
+};
+
+static const struct terminal_response_test get_input_response_data_111 =3D=
 {
+	.pdu =3D get_input_response_111,
+	.pdu_len =3D sizeof(get_input_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "12345",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x08, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x00, 0xb6,
+	0x9b, 0x6a, 0xb4, 0x02,
+};
+
+static const struct terminal_response_test get_input_response_data_121 =3D=
 {
+	.pdu =3D get_input_response_121,
+	.pdu_len =3D sizeof(get_input_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x08, /* Input is packed */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "67*#+",
+				.packed =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x04, 0x41,
+	0x62, 0x43, 0x64, 0x45,
+};
+
+static const struct terminal_response_test get_input_response_data_131 =3D=
 {
+	.pdu =3D get_input_response_131,
+	.pdu_len =3D sizeof(get_input_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x01, /* Allow all SMS characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "AbCdE",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x08, 0x04, 0x32,
+	0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+};
+
+static const struct terminal_response_test get_input_response_data_141 =3D=
 {
+	.pdu =3D get_input_response_141,
+	.pdu_len =3D sizeof(get_input_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x04, /* Hide text */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "2345678",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x15, 0x04, 0x31,
+	0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x30,
+};
+
+static const struct terminal_response_test get_input_response_data_151 =3D=
 {
+	.pdu =3D get_input_response_151,
+	.pdu_len =3D sizeof(get_input_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "12345678901234567890",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_161[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x11,
+};
+
+static const struct terminal_response_test get_input_response_data_161 =3D=
 {
+	.pdu =3D get_input_response_161,
+	.pdu_len =3D sizeof(get_input_response_161),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_GO_BACK,
+		},
+	},
+};
+
+static const unsigned char get_input_response_171[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x10,
+};
+
+static const struct terminal_response_test get_input_response_data_171 =3D=
 {
+	.pdu =3D get_input_response_171,
+	.pdu_len =3D sizeof(get_input_response_171),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_TERMINATED,
+		},
+	},
+};
+
+static const unsigned char get_input_response_181[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x81, 0xa1, 0x04,
+	0x2a, 0x2a, 0x2a, 0x31, 0x31, 0x31, 0x31, 0x31,
+	0x31, 0x31, 0x31, 0x31, 0x31, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x32, 0x32, 0x32, 0x32, 0x32,
+	0x32, 0x32, 0x32, 0x32, 0x32, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x33, 0x33, 0x33, 0x33, 0x33,
+	0x33, 0x33, 0x33, 0x33, 0x33, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x34, 0x34, 0x34, 0x34, 0x34,
+	0x34, 0x34, 0x34, 0x34, 0x34, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x35, 0x35, 0x35, 0x35, 0x35,
+	0x35, 0x35, 0x35, 0x35, 0x35, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x36, 0x36, 0x36, 0x36, 0x36,
+	0x36, 0x36, 0x36, 0x36, 0x36, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x37, 0x37, 0x37, 0x37, 0x37,
+	0x37, 0x37, 0x37, 0x37, 0x37, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x38, 0x38, 0x38, 0x38, 0x38,
+	0x38, 0x38, 0x38, 0x38, 0x38, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x39, 0x39, 0x39, 0x39, 0x39,
+	0x39, 0x39, 0x39, 0x39, 0x39, 0x23, 0x23, 0x23,
+	0x2a, 0x2a, 0x2a, 0x30, 0x30, 0x30, 0x30, 0x30,
+	0x30, 0x30, 0x30, 0x30, 0x30, 0x23, 0x23, 0x23,
+};
+
+static const struct terminal_response_test get_input_response_data_181 =3D=
 {
+	.pdu =3D get_input_response_181,
+	.pdu_len =3D sizeof(get_input_response_181),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "***1111111111###***2222222222###"
+					"***3333333333###***4444444444###"
+					"***5555555555###***6666666666###"
+					"***7777777777###***8888888888###"
+					"***9999999999###***0000000000###",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_191a[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x01, 0x04,
+};
+
+static const unsigned char get_input_response_191b[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x00,
+};
+
+static const struct terminal_response_test get_input_response_data_191 =3D=
 {
+	/* Either get_input_response_191a or get_input_response_191b is ok */
+	.pdu =3D get_input_response_191a,
+	.pdu_len =3D sizeof(get_input_response_191a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x01, /* Allow all SMS characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_211[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x12,
+};
+
+static const struct terminal_response_test get_input_response_data_211 =3D=
 {
+	.pdu =3D get_input_response_211,
+	.pdu_len =3D sizeof(get_input_response_211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_RESPONSE,
+		},
+	},
+};
+
+static const unsigned char get_input_response_311[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x04, 0x48,
+	0x45, 0x4c, 0x4c, 0x4f,
+};
+
+static const struct terminal_response_test get_input_response_data_311 =3D=
 {
+	.pdu =3D get_input_response_311,
+	.pdu_len =3D sizeof(get_input_response_311),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x01, /* Allow all SMS characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "HELLO",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_411[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x19, 0x08, 0x04,
+	0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10, 0x04,
+	0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12, 0x04,
+	0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+};
+
+static const struct terminal_response_test get_input_response_data_411 =3D=
 {
+	.pdu =3D get_input_response_411,
+	.pdu_len =3D sizeof(get_input_response_411),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_421[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x81, 0x8d, 0x08,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19, 0x04, 0x22, 0x04, 0x15,
+	0x04, 0x17, 0x04, 0x14, 0x04, 0x20, 0x04, 0x10,
+	0x04, 0x12, 0x04, 0x21, 0x04, 0x22, 0x04, 0x12,
+	0x04, 0x23, 0x04, 0x19,
+};
+
+static const struct terminal_response_test get_input_response_data_421 =3D=
 {
+	.pdu =3D get_input_response_421,
+	.pdu_len =3D sizeof(get_input_response_421),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=
=99=D0=A2=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=
=D0=A2=D0=95"
+					"=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=
=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=D0=
=95"
+					"=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99=D0=A2=
=D0=95=D0=97=D0=94=D0=A0=D0=90=D0=92=D0=A1=D0=A2=D0=92=D0=A3=D0=99",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_611a[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x2b,
+};
+
+static const struct terminal_response_test get_input_response_data_611a =
=3D {
+	.pdu =3D get_input_response_611a,
+	.pdu_len =3D sizeof(get_input_response_611a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "+",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_611b[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04, 0x8d, 0x02, 0x04, 0x2b,
+};
+
+static const struct terminal_response_test get_input_response_data_611b =
=3D {
+	.pdu =3D get_input_response_611b,
+	.pdu_len =3D sizeof(get_input_response_611b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "+",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_711[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x13,
+};
+
+static const struct terminal_response_test get_input_response_data_711 =3D=
 {
+	.pdu =3D get_input_response_711,
+	.pdu_len =3D sizeof(get_input_response_711),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_HELP_REQUESTED,
+		},
+	},
+};
+
+static const unsigned char get_input_response_812[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x04, 0x32,
+	0x32, 0x32, 0x32, 0x32,
+};
+
+static const struct terminal_response_test get_input_response_data_812 =3D=
 {
+	.pdu =3D get_input_response_812,
+	.pdu_len =3D sizeof(get_input_response_812),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "22222",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_843[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x06, 0x04, 0x33,
+	0x33, 0x33, 0x33, 0x33,
+};
+
+static const struct terminal_response_test get_input_response_data_843 =3D=
 {
+	.pdu =3D get_input_response_843,
+	.pdu_len =3D sizeof(get_input_response_843),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "33333",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_1011[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x05, 0x08, 0x4f,
+	0x60, 0x59, 0x7d,
+};
+
+static const struct terminal_response_test get_input_response_data_1011 =
=3D {
+	.pdu =3D get_input_response_1011,
+	.pdu_len =3D sizeof(get_input_response_1011),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=E4=BD=A0=E5=A5=BD",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_1021[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x81, 0x8d, 0x08,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d, 0x4f, 0x60, 0x59, 0x7d,
+	0x4f, 0x60, 0x59, 0x7d,
+};
+
+static const struct terminal_response_test get_input_response_data_1021 =
=3D {
+	.pdu =3D get_input_response_1021,
+	.pdu_len =3D sizeof(get_input_response_1021),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=
=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
+					"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=
=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
+					"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=
=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
+					"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=
=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
+					"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=
=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD"
+					"=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=A5=BD=E4=BD=A0=E5=
=A5=BD=E4=BD=A0=E5=A5=BD",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_1211[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x05, 0x08, 0x30,
+	0xeb, 0x30, 0xeb,
+};
+
+static const struct terminal_response_test get_input_response_data_1211 =
=3D {
+	.pdu =3D get_input_response_1211,
+	.pdu_len =3D sizeof(get_input_response_1211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=E3=83=AB=E3=83=AB",
+			},
+		}},
+	},
+};
+
+static const unsigned char get_input_response_1221[] =3D {
+	0x81, 0x03, 0x01, 0x23, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x81, 0x8d, 0x08,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb, 0x30, 0xeb,
+	0x30, 0xeb, 0x30, 0xeb,
+};
+
+static const struct terminal_response_test get_input_response_data_1221 =
=3D {
+	.pdu =3D get_input_response_1221,
+	.pdu_len =3D sizeof(get_input_response_1221),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INPUT,
+		.qualifier =3D 0x03, /* Allow all UCS2 characters */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .get_input =3D {
+			.text =3D {
+				.text =3D "=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
+					"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
+					"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
+					"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
+					"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB"
+					"=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=83=AB=E3=
=83=AB=E3=83=AB=E3=83=AB",
+			},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -10939,6 +11581,73 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Get Input 12.2.1",
 				&get_input_data_1221, test_get_input);
 =

+	g_test_add_data_func("/teststk/Get Input response 1.1.1",
+				&get_input_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.2.1",
+				&get_input_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.3.1",
+				&get_input_response_data_131,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.4.1",
+				&get_input_response_data_141,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.5.1",
+				&get_input_response_data_151,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.6.1",
+				&get_input_response_data_161,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.7.1",
+				&get_input_response_data_171,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.8.1",
+				&get_input_response_data_181,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 1.9.1",
+				&get_input_response_data_191,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 2.1.1",
+				&get_input_response_data_211,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 3.1.1",
+				&get_input_response_data_311,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 4.1.1",
+				&get_input_response_data_411,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 4.2.1",
+				&get_input_response_data_421,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 6.1.1A",
+				&get_input_response_data_611a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 6.1.1B",
+				&get_input_response_data_611b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 7.1.1",
+				&get_input_response_data_711,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 8.1.2",
+				&get_input_response_data_812,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 8.4.3",
+				&get_input_response_data_843,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 10.1.1",
+				&get_input_response_data_1011,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 10.2.1",
+				&get_input_response_data_1021,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 12.1.1",
+				&get_input_response_data_1211,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Input response 12.2.1",
+				&get_input_response_data_1221,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/More Time 1.1.1",
 				&more_time_data_111, test_more_time);
 =

-- =

1.7.1.86.g0e460.dirty


--===============6839202595146174510==--

