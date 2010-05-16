Content-Type: multipart/mixed; boundary="===============0868069602640032457=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 23/27] test-stkutil: Add Set Up Call response tests.
Date: Sun, 16 May 2010 16:07:46 +0200
Message-ID: <1274018866-7000-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0868069602640032457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  262 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 262 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index e84a99a..20c30cb 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -12070,6 +12070,234 @@ static const struct terminal_response_test select=
_item_response_data_811 =3D {
 	},
 };
 =

+static const unsigned char set_up_call_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_call_response_data_111 =
=3D {
+	.pdu =3D set_up_call_response_111,
+	.pdu_len =3D sizeof(set_up_call_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x00, /* Only if not busy on another call */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x22,
+};
+
+static const struct terminal_response_test set_up_call_response_data_121 =
=3D {
+	.pdu =3D set_up_call_response_121,
+	.pdu_len =3D sizeof(set_up_call_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x00, /* Only if not busy on another call */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_REJECT,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_call_response_data_141 =
=3D {
+	.pdu =3D set_up_call_response_141,
+	.pdu_len =3D sizeof(set_up_call_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x02, /* Put all other calls on hold */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_call_response_data_151 =
=3D {
+	.pdu =3D set_up_call_response_151,
+	.pdu_len =3D sizeof(set_up_call_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x04, /* Disconnect all other calls */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_161[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x20, 0x02,
+};
+
+static const struct terminal_response_test set_up_call_response_data_161 =
=3D {
+	.pdu =3D set_up_call_response_161,
+	.pdu_len =3D sizeof(set_up_call_response_161),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x00, /* Only if not busy on another call */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TERMINAL_BUSY,
+			.additional_len =3D 1, /* ME currently busy on call */
+			.additional =3D (unsigned char *) "\2",
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_171a[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x21, 0x00,
+};
+
+static const struct terminal_response_test set_up_call_response_data_171a =
=3D {
+	.pdu =3D set_up_call_response_171a,
+	.pdu_len =3D sizeof(set_up_call_response_171a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x02, /* Put all other calls on hold */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE,
+			.additional_len =3D 1, /* No specific cause given */
+			.additional =3D (unsigned char *) "\0",
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_171b[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x21, 0x9d,
+};
+
+static const struct terminal_response_test set_up_call_response_data_171b =
=3D {
+	.pdu =3D set_up_call_response_171b,
+	.pdu_len =3D sizeof(set_up_call_response_171b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x02, /* Put all other calls on hold */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE,
+			.additional_len =3D 1, /* Facility rejected */
+			.additional =3D (unsigned char *) "\x9d",
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_1101[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_call_response_data_1101 =
=3D {
+	.pdu =3D set_up_call_response_1101,
+	.pdu_len =3D sizeof(set_up_call_response_1101),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x01, /* Only if not busy, with redial */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_1111b[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x30,
+};
+
+static const struct terminal_response_test set_up_call_response_data_1111b=
 =3D {
+	.pdu =3D set_up_call_response_1111b,
+	.pdu_len =3D sizeof(set_up_call_response_1111b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x00, /* Only if not busy on another call */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NOT_CAPABLE,
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_1121[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x21, 0x91,
+};
+
+static const struct terminal_response_test set_up_call_response_data_1121 =
=3D {
+	.pdu =3D set_up_call_response_1121,
+	.pdu_len =3D sizeof(set_up_call_response_1121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x01, /* Only if not busy, with redial */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE,
+			.additional_len =3D 1, /* User busy */
+			.additional =3D (unsigned char *) "\x91",
+		},
+	},
+};
+
+static const unsigned char set_up_call_response_311b[] =3D {
+	0x81, 0x03, 0x01, 0x10, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test set_up_call_response_data_311b =
=3D {
+	.pdu =3D set_up_call_response_311b,
+	.pdu_len =3D sizeof(set_up_call_response_311b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_CALL,
+		.qualifier =3D 0x00, /* Only if not busy on another call */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -12923,6 +13151,40 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Call 7.2.1",
 				&setup_call_data_721, test_setup_call);
 =

+	g_test_add_data_func("/teststk/Set Up Call response 1.1.1",
+				&set_up_call_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.2.1",
+				&set_up_call_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.4.1",
+				&set_up_call_response_data_141,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.5.1",
+				&set_up_call_response_data_151,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.6.1",
+				&set_up_call_response_data_161,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.7.1A",
+				&set_up_call_response_data_171a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.7.1B",
+				&set_up_call_response_data_171b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.10.1",
+				&set_up_call_response_data_1101,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.11.1B",
+				&set_up_call_response_data_1111b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 1.12.1",
+				&set_up_call_response_data_1121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Call response 3.1.1B",
+				&set_up_call_response_data_311b,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Refresh 1.2.1",
 				&refresh_data_121, test_refresh);
 	g_test_add_data_func("/teststk/Refresh 1.5.1",
-- =

1.7.1.86.g0e460.dirty


--===============0868069602640032457==--

