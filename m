Content-Type: multipart/mixed; boundary="===============0250545344541407234=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 21/27] test-stkutil: Add Select Item response tests.
Date: Sun, 16 May 2010 16:07:30 +0200
Message-ID: <1274018850-6936-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0250545344541407234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  334 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 334 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index ed18bbf..e84a99a 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -11776,6 +11776,300 @@ static const struct terminal_response_test set_up=
_menu_response_data_511 =3D {
 	},
 };
 =

+static const unsigned char select_item_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x02,
+};
+
+static const struct terminal_response_test select_item_response_data_111 =
=3D {
+	.pdu =3D select_item_response_111,
+	.pdu_len =3D sizeof(select_item_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 2,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x3d,
+};
+
+static const struct terminal_response_test select_item_response_data_121 =
=3D {
+	.pdu =3D select_item_response_121,
+	.pdu_len =3D sizeof(select_item_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 61,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0xfb,
+};
+
+static const struct terminal_response_test select_item_response_data_131 =
=3D {
+	.pdu =3D select_item_response_131,
+	.pdu_len =3D sizeof(select_item_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 251,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x11,
+};
+
+static const struct terminal_response_test select_item_response_data_141 =
=3D {
+	/* The response can be select_item_response_141 or it can optionally
+	 * have an ITEM_ID data object appended with any id (90 01 XX).  */
+	.pdu =3D select_item_response_141,
+	.pdu_len =3D sizeof(select_item_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_GO_BACK,
+		},
+	},
+};
+
+static const unsigned char select_item_response_142[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x10,
+};
+
+static const struct terminal_response_test select_item_response_data_142 =
=3D {
+	/* The response can be select_item_response_142 or it can optionally
+	 * have an ITEM_ID data object appended with any id (90 01 XX).  */
+	.pdu =3D select_item_response_142,
+	.pdu_len =3D sizeof(select_item_response_142),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_TERMINATED,
+		},
+	},
+};
+
+static const unsigned char select_item_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_151 =
=3D {
+	.pdu =3D select_item_response_151,
+	.pdu_len =3D sizeof(select_item_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_311[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x03,
+};
+
+static const struct terminal_response_test select_item_response_data_311 =
=3D {
+	.pdu =3D select_item_response_311,
+	.pdu_len =3D sizeof(select_item_response_311),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 3,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_411[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x80, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x13, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_411 =
=3D {
+	.pdu =3D select_item_response_411,
+	.pdu_len =3D sizeof(select_item_response_411),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x80, /* Help information available */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_HELP_REQUESTED,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_511b[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_511b =
=3D {
+	.pdu =3D select_item_response_511b,
+	.pdu_len =3D sizeof(select_item_response_511b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_611[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_611 =
=3D {
+	.pdu =3D select_item_response_611,
+	.pdu_len =3D sizeof(select_item_response_611),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x03, /* Choice of navigation options */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_621[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_621 =
=3D {
+	.pdu =3D select_item_response_621,
+	.pdu_len =3D sizeof(select_item_response_621),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x01, /* Choice of data values presentation */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_711[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x90, 0x01, 0x01,
+};
+
+static const struct terminal_response_test select_item_response_data_711 =
=3D {
+	.pdu =3D select_item_response_711,
+	.pdu_len =3D sizeof(select_item_response_711),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x04, /* Selection using soft keys preferred */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .select_item =3D {
+			.item_id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char select_item_response_811[] =3D {
+	0x81, 0x03, 0x01, 0x24, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x12,
+};
+
+static const struct terminal_response_test select_item_response_data_811 =
=3D {
+	.pdu =3D select_item_response_811,
+	.pdu_len =3D sizeof(select_item_response_811),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SELECT_ITEM,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_RESPONSE,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -12485,6 +12779,46 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Select Item 12.3.1",
 				&select_item_data_1231, test_select_item);
 =

+	g_test_add_data_func("/teststk/Select Item response 1.1.1",
+				&select_item_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 1.2.1",
+				&select_item_response_data_121,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 1.3.1",
+				&select_item_response_data_131,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 1.4.1",
+				&select_item_response_data_141,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 1.4.2",
+				&select_item_response_data_142,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 1.5.1",
+				&select_item_response_data_151,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 3.1.1",
+				&select_item_response_data_311,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 4.1.1",
+				&select_item_response_data_411,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 5.1.1B",
+				&select_item_response_data_511b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 6.1.1",
+				&select_item_response_data_611,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 6.2.1",
+				&select_item_response_data_621,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 7.1.1",
+				&select_item_response_data_711,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Select Item response 8.1.1",
+				&select_item_response_data_811,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Send SMS 1.1.1",
 				&send_sms_data_111, test_send_sms);
 =

-- =

1.7.1.86.g0e460.dirty


--===============0250545344541407234==--

