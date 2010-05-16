Content-Type: multipart/mixed; boundary="===============0291293502687018640=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 17/27] test-stkutil: Add Refresh response tests.
Date: Sun, 16 May 2010 16:06:43 +0200
Message-ID: <1274018803-6808-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0291293502687018640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c       |    2 +-
 unit/test-stkutil.c |  304 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 305 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 9d9cfa6..d0c11a6 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -3207,7 +3207,7 @@ unsigned int stk_pdu_from_response(const struct stk_r=
esponse *response,
 					&response->poll_interval.max_interval,
 					NULL);
 		break;
-	case STK_COMMAND_TYPE_PLAY_REFRESH:
+	case STK_COMMAND_TYPE_REFRESH:
 		break;
 	default:
 		return 0;
diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 1304714..953cb03 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -11452,6 +11452,270 @@ static const struct terminal_response_test poll_i=
nterval_response_data_111a =3D {
 	},
 };
 =

+static const unsigned char refresh_response_111a[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_111a =3D {
+	.pdu =3D refresh_response_111a,
+	.pdu_len =3D sizeof(refresh_response_111a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x03, /* USIM Initialization */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_111b[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x03,
+};
+
+static const struct terminal_response_test refresh_response_data_111b =3D {
+	.pdu =3D refresh_response_111b,
+	.pdu_len =3D sizeof(refresh_response_111b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x03, /* USIM Initialization */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_REFRESH_WITH_EFS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_121a[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_121a =3D {
+	.pdu =3D refresh_response_121a,
+	.pdu_len =3D sizeof(refresh_response_121a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x01, /* File Change Notification */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_121b[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x03,
+};
+
+static const struct terminal_response_test refresh_response_data_121b =3D {
+	.pdu =3D refresh_response_121b,
+	.pdu_len =3D sizeof(refresh_response_121b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x01, /* File Change Notification */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_REFRESH_WITH_EFS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_131a[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_131a =3D {
+	.pdu =3D refresh_response_131a,
+	.pdu_len =3D sizeof(refresh_response_131a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x02, /* USIM Initialization & File Change */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_131b[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x03,
+};
+
+static const struct terminal_response_test refresh_response_data_131b =3D {
+	.pdu =3D refresh_response_131b,
+	.pdu_len =3D sizeof(refresh_response_131b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x02, /* USIM Initialization & File Change */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_REFRESH_WITH_EFS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_141a[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_141a =3D {
+	.pdu =3D refresh_response_141a,
+	.pdu_len =3D sizeof(refresh_response_141a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x00, /* USIM Initialization & Full File Change */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_141b[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x03,
+};
+
+static const struct terminal_response_test refresh_response_data_141b =3D {
+	.pdu =3D refresh_response_141b,
+	.pdu_len =3D sizeof(refresh_response_141b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x00, /* USIM Initialization & Full File Change */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_REFRESH_WITH_EFS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_171[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x05, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_171 =3D {
+	.pdu =3D refresh_response_171,
+	.pdu_len =3D sizeof(refresh_response_171),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x05, /* USIM Application Reset */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char refresh_response_241a[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x20, 0x02,
+};
+
+static const struct terminal_response_test refresh_response_data_241a =3D {
+	.pdu =3D refresh_response_241a,
+	.pdu_len =3D sizeof(refresh_response_241a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x06, /* 3G Session Reset */
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
+static const unsigned char refresh_response_241b[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x20, 0x01,
+};
+
+static const struct terminal_response_test refresh_response_data_241b =3D {
+	.pdu =3D refresh_response_241b,
+	.pdu_len =3D sizeof(refresh_response_241b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x06, /* 3G Session Reset */
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
+static const unsigned char refresh_response_311[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x07, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x20,
+};
+
+static const struct terminal_response_test refresh_response_data_311 =3D {
+	.pdu =3D refresh_response_311,
+	.pdu_len =3D sizeof(refresh_response_311),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x07, /* Steering of roaming */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TERMINAL_BUSY,
+		},
+	},
+};
+
+static const unsigned char refresh_response_312[] =3D {
+	0x81, 0x03, 0x01, 0x01, 0x07, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test refresh_response_data_312 =3D {
+	.pdu =3D refresh_response_312,
+	.pdu_len =3D sizeof(refresh_response_312),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_REFRESH,
+		.qualifier =3D 0x07, /* Steering of roaming */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -12260,6 +12524,46 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Refresh 1.5.1",
 				&refresh_data_151, test_refresh);
 =

+	g_test_add_data_func("/teststk/Refresh response 1.1.1A",
+				&refresh_response_data_111a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.1.1B",
+				&refresh_response_data_111b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.2.1A",
+				&refresh_response_data_121a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.2.1B",
+				&refresh_response_data_121b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.3.1A",
+				&refresh_response_data_131a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.3.1B",
+				&refresh_response_data_141b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.4.1A",
+				&refresh_response_data_141a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.4.1B",
+				&refresh_response_data_141b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 1.7.1",
+				&refresh_response_data_171,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 2.4.1A",
+				&refresh_response_data_241a,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 2.4.1B",
+				&refresh_response_data_241b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 3.1.1",
+				&refresh_response_data_311,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Refresh response 3.1.2",
+				&refresh_response_data_312,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Polling off 1.1.2",
 				&polling_off_data_112, test_polling_off);
 =

-- =

1.7.1.86.g0e460.dirty


--===============0291293502687018640==--

