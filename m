Content-Type: multipart/mixed; boundary="===============1358260789971313096=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] test-stkutil: Add unit test for Get Inkey response
 encoding.
Date: Mon, 10 May 2010 11:34:26 +0200
Message-ID: <1273484066-32276-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1358260789971313096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  534 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 534 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8e703e5..7574fa1 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -1660,6 +1660,488 @@ static const struct terminal_response_test display_=
text_response_data_511b =3D {
 	},
 };
 =

+#define NO_DURATION { .interval =3D 0x00, }
+#define NO_TEXT { .text =3D NULL, .yesno =3D FALSE, }
+
+static const unsigned char get_inkey_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x2b,
+};
+
+static const struct terminal_response_test get_inkey_response_data_111 =3D=
 {
+	.pdu =3D get_inkey_response_111,
+	.pdu_len =3D sizeof(get_inkey_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "+",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x30,
+};
+
+static const struct terminal_response_test get_inkey_response_data_121 =3D=
 {
+	.pdu =3D get_inkey_response_121,
+	.pdu_len =3D sizeof(get_inkey_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "0",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x11,
+};
+
+static const struct terminal_response_test get_inkey_response_data_131 =3D=
 {
+	.pdu =3D get_inkey_response_131,
+	.pdu_len =3D sizeof(get_inkey_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_GO_BACK,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D NO_TEXT,
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x10,
+};
+
+static const struct terminal_response_test get_inkey_response_data_141 =3D=
 {
+	.pdu =3D get_inkey_response_141,
+	.pdu_len =3D sizeof(get_inkey_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_TERMINATED,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D NO_TEXT,
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x71,
+};
+
+static const struct terminal_response_test get_inkey_response_data_151 =3D=
 {
+	.pdu =3D get_inkey_response_151,
+	.pdu_len =3D sizeof(get_inkey_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x01,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "q",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_161[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x78,
+};
+
+static const struct terminal_response_test get_inkey_response_data_161 =3D=
 {
+	.pdu =3D get_inkey_response_161,
+	.pdu_len =3D sizeof(get_inkey_response_161),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x01,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "x",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_211[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x12,
+};
+
+static const struct terminal_response_test get_inkey_response_data_211 =3D=
 {
+	.pdu =3D get_inkey_response_211,
+	.pdu_len =3D sizeof(get_inkey_response_211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_RESPONSE,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D NO_TEXT,
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_411[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x03, 0x08, 0x04,
+	0x14,
+};
+
+static const struct terminal_response_test get_inkey_response_data_411 =3D=
 {
+	.pdu =3D get_inkey_response_411,
+	.pdu_len =3D sizeof(get_inkey_response_411),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x03,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "=D0=94",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_511[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x01,
+};
+
+static const struct terminal_response_test get_inkey_response_data_511 =3D=
 {
+	.pdu =3D get_inkey_response_511,
+	.pdu_len =3D sizeof(get_inkey_response_511),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x04,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "Yes",
+				.packed =3D FALSE,
+				.yesno =3D TRUE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_512[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x00,
+};
+
+static const struct terminal_response_test get_inkey_response_data_512 =3D=
 {
+	.pdu =3D get_inkey_response_512,
+	.pdu_len =3D sizeof(get_inkey_response_512),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x04,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D NULL,
+				.packed =3D FALSE,
+				.yesno =3D TRUE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_611b[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04, 0x8d, 0x02, 0x04, 0x2b,
+};
+
+static const struct terminal_response_test get_inkey_response_data_611b =
=3D {
+	.pdu =3D get_inkey_response_611b,
+	.pdu_len =3D sizeof(get_inkey_response_611b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "+",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_711[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x13,
+};
+
+static const struct terminal_response_test get_inkey_response_data_711 =3D=
 {
+	.pdu =3D get_inkey_response_711,
+	.pdu_len =3D sizeof(get_inkey_response_711),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_HELP_REQUESTED,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D NO_TEXT,
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_712[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x2b,
+};
+
+static const struct terminal_response_test get_inkey_response_data_712 =3D=
 {
+	.pdu =3D get_inkey_response_712,
+	.pdu_len =3D sizeof(get_inkey_response_712),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x80,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "+",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_811[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x12, 0x04, 0x02, 0x01, 0x11,
+};
+
+static const struct terminal_response_test get_inkey_response_data_811 =3D=
 {
+	.pdu =3D get_inkey_response_811,
+	.pdu_len =3D sizeof(get_inkey_response_811),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_RESPONSE,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D NO_TEXT,
+			.duration =3D {
+				.unit =3D STK_DURATION_TYPE_SECONDS,
+				.interval =3D 17,
+			},
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_912[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x02, 0x04, 0x23,
+};
+
+static const struct terminal_response_test get_inkey_response_data_912 =3D=
 {
+	.pdu =3D get_inkey_response_912,
+	.pdu_len =3D sizeof(get_inkey_response_912),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "#",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_1111[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x03, 0x08, 0x59,
+	0x7d,
+};
+
+static const struct terminal_response_test get_inkey_response_data_1111 =
=3D {
+	.pdu =3D get_inkey_response_1111,
+	.pdu_len =3D sizeof(get_inkey_response_1111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x03,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "=E5=A5=BD",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
+static const unsigned char get_inkey_response_1311[] =3D {
+	0x81, 0x03, 0x01, 0x22, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x8d, 0x03, 0x08, 0x30,
+	0xeb,
+};
+
+static const struct terminal_response_test get_inkey_response_data_1311 =
=3D {
+	.pdu =3D get_inkey_response_1311,
+	.pdu_len =3D sizeof(get_inkey_response_1311),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_GET_INKEY,
+		.qualifier =3D 0x03,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+			.additional_len =3D 0,
+		},
+		{ .get_inkey =3D {
+			.text =3D {
+				.text =3D "=E3=83=AB",
+				.packed =3D FALSE,
+				.yesno =3D FALSE,
+			},
+			.duration =3D NO_DURATION,
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -1824,6 +2306,58 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Get Inkey 13.1.1",
 				&get_inkey_data_1311, test_get_inkey);
 =

+	g_test_add_data_func("/teststk/Get Inkey response 1.1.1",
+				&get_inkey_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 1.2.1",
+				&get_inkey_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 1.3.1",
+				&get_inkey_response_data_131,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 1.4.1",
+				&get_inkey_response_data_141,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 1.5.1",
+				&get_inkey_response_data_151,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 1.6.1",
+				&get_inkey_response_data_161,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 2.1.1",
+				&get_inkey_response_data_211,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 4.1.1",
+				&get_inkey_response_data_411,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 5.1.1",
+				&get_inkey_response_data_511,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 5.1.2",
+				&get_inkey_response_data_512,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 6.1.1B",
+				&get_inkey_response_data_611b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 7.1.1",
+				&get_inkey_response_data_711,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 7.1.2",
+				&get_inkey_response_data_712,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 8.1.1",
+				&get_inkey_response_data_811,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 9.1.2",
+				&get_inkey_response_data_912,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 11.1.1",
+				&get_inkey_response_data_1111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Get Inkey response 13.1.1",
+				&get_inkey_response_data_1311,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Get Input 1.1.1",
 				&get_input_data_111, test_get_input);
 =

-- =

1.6.1


--===============1358260789971313096==--

