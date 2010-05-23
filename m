Content-Type: multipart/mixed; boundary="===============7282394204795997831=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/16] test-stkutil: Add Provide Local Info response tests.
Date: Sun, 23 May 2010 12:14:38 +0200
Message-ID: <1274609678-6348-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7282394204795997831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  555 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 555 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index f883d0e..3b93a13 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -12318,6 +12318,509 @@ static const struct terminal_response_test pollin=
g_off_response_data_112 =3D {
 	},
 };
 =

+static const unsigned char provide_local_info_response_111a[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x93, 0x07, 0x00, 0xf1,
+	0x10, 0x00, 0x01, 0x00, 0x01,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_111a =3D {
+	.pdu =3D provide_local_info_response_111a,
+	.pdu_len =3D sizeof(provide_local_info_response_111a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x00, /* Location information (MCC MNC LAC CI) */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .location =3D {
+				.mcc =3D "001",
+				.mnc =3D "01",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_111b[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x93, 0x07, 0x00, 0x11,
+	0x10, 0x00, 0x01, 0x00, 0x01,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_111b =3D {
+	.pdu =3D provide_local_info_response_111b,
+	.pdu_len =3D sizeof(provide_local_info_response_111b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x00, /* Location information (MCC MNC LAC CI) */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .location =3D {
+				.mcc =3D "001",
+				.mnc =3D "011",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x94, 0x08, 0x1a, 0x32,
+	0x54, 0x76, 0x98, 0x10, 0x32, 0x54, /* Typo in TS 102 384? */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_121 =3D {
+	.pdu =3D provide_local_info_response_121,
+	.pdu_len =3D sizeof(provide_local_info_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x01, /* IMEI of the Terminal */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .imei =3D "123456789012345", }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x96, 0x10, 0x34, 0x34,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x9d, 0x0d,
+	0x8c, 0x63, 0x58, 0xe2, 0x39, 0x8f, 0x63, 0xf9,
+	0x06, 0x45, 0x91, 0xa4, 0x90,
+};
+
+static const short bcch_channels_131[] =3D {
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_131 =3D {
+	.pdu =3D provide_local_info_response_131,
+	.pdu_len =3D sizeof(provide_local_info_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x02, /* Network Measurement Results */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .nmr =3D {
+				.nmr =3D {
+					/* RXLEV-FULL-SERVING-CELL=3D52, no BA,
+					 * no DTX */
+					.array =3D (unsigned char[16]) {
+						0x34, 0x34, 0x00, 0x00,
+						0x00, 0x00, 0x00, 0x00,
+						0x00, 0x00, 0x00, 0x00,
+						0x00, 0x00, 0x00, 0x00,
+					},
+					.len =3D 16,
+				},
+				.bcch_ch_list =3D {
+					.channels =3D (short[]) {
+						561, 565, 568, 569, 573,
+						575, 577, 581, 582, 585,
+					},
+					.length =3D 10,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa6, 0x07, 0x20, 0x50,
+	0x70, 0x41, 0x80, 0x71, 0xff,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_141 =3D {
+	.pdu =3D provide_local_info_response_141,
+	.pdu_len =3D sizeof(provide_local_info_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x03, /* Date Time and Time Zone */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .datetime =3D {
+				.year =3D 2, /* 2002 - 1900 - 100 */
+				.month =3D 5,
+				.day =3D 7,
+				.hour =3D 14,
+				.minute =3D 8,
+				.second =3D 17,
+				.timezone =3D 0xff, /* No information */
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_151[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x04, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xad, 0x02, 0x65, 0x6e,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_151 =3D {
+	.pdu =3D provide_local_info_response_151,
+	.pdu_len =3D sizeof(provide_local_info_response_151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x04, /* Language setting */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .language =3D "en", }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_161[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x05, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xae, 0x02, 0x00, 0x00,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_161 =3D {
+	.pdu =3D provide_local_info_response_161,
+	.pdu_len =3D sizeof(provide_local_info_response_161),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x05, /* Timing Advance */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .tadv =3D {
+				.status =3D STK_TIMING_ADVANCE_ME_IDLE,
+				.advance =3D 0,
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_171[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x3f, 0x01, 0x03,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_171 =3D {
+	.pdu =3D provide_local_info_response_171,
+	.pdu_len =3D sizeof(provide_local_info_response_171),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x06, /* Access technology */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .access_technology =3D STK_ACCESS_TECHNOLOGY_UTRAN, }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_181[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x07, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xc6, 0x04, 0x01, 0x02,
+	0x03, 0x04,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_181 =3D {
+	.pdu =3D provide_local_info_response_181,
+	.pdu_len =3D sizeof(provide_local_info_response_181),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x07, /* ESN of the terminal */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .esn =3D 0x01020304, }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_191[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x08, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xe2, 0x09, 0x13, 0x32,
+	0x54, 0x76, 0x98, 0x10, 0x32, 0x54, 0xf6,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_191 =3D {
+	.pdu =3D provide_local_info_response_191,
+	.pdu_len =3D sizeof(provide_local_info_response_191),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x08, /* IMEISV of the terminal */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .imeisv =3D "1234567890123456", }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1111[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x0a, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xe3, 0x01, 0x04,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1111 =3D {
+	.pdu =3D provide_local_info_response_1111,
+	.pdu_len =3D sizeof(provide_local_info_response_1111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x0a, /* Charge state of the battery */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .battery_charge =3D STK_BATTERY_FULL, }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1121[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x96, 0x02, 0x80, 0x00,
+	/* Intra-frequency UTRAN Measurement report in ASN.1 goes here */
+	/* "The remaining bytes shall not be verified" */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1121 =3D {
+	.pdu =3D provide_local_info_response_1121,
+	.pdu_len =3D sizeof(provide_local_info_response_1121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x02, /* Network Measurement Results */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .nmr =3D {
+				.nmr =3D {
+					.array =3D (unsigned char[2])
+						{ 0x80, 0x00 },
+					.len =3D 2,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1131[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x96, 0x02, 0x80, 0x11,
+	/* Inter-frequency UTRAN Measurement report in ASN.1 goes here */
+	/* "The remaining bytes shall not be verified" */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1131 =3D {
+	.pdu =3D provide_local_info_response_1131,
+	.pdu_len =3D sizeof(provide_local_info_response_1131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x02, /* Network Measurement Results */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .nmr =3D {
+				.nmr =3D {
+					.array =3D (unsigned char[2])
+						{ 0x80, 0x11},
+					.len =3D 2,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1141[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x3f, 0x01, 0x08,
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1141 =3D {
+	.pdu =3D provide_local_info_response_1141,
+	.pdu_len =3D sizeof(provide_local_info_response_1141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x06, /* Access technology */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .access_technology =3D STK_ACCESS_TECHNOLOGY_EUTRAN, }
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1151[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x96, 0x02, 0x80, 0x00,
+	/* Intra-frequency E-UTRAN Measurement report in ASN.1 goes here */
+	/* "The remaining bytes shall not be verified" */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1151 =3D {
+	.pdu =3D provide_local_info_response_1151,
+	.pdu_len =3D sizeof(provide_local_info_response_1151),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x02, /* Network Measurement Results */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .nmr =3D {
+				.nmr =3D {
+					.array =3D (unsigned char[2])
+						{ 0x80, 0x00},
+					.len =3D 2,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1161[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x96, 0x02, 0x80, 0x11,
+	/* Inter-frequency E-UTRAN Measurement report in ASN.1 goes here */
+	/* "The remaining bytes shall not be verified" */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1161 =3D {
+	.pdu =3D provide_local_info_response_1161,
+	.pdu_len =3D sizeof(provide_local_info_response_1161),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x02, /* Network Measurement Results */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .nmr =3D {
+				.nmr =3D {
+					.array =3D (unsigned char[2])
+						{ 0x80, 0x11},
+					.len =3D 2,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char provide_local_info_response_1171[] =3D {
+	0x81, 0x03, 0x01, 0x26, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x93, 0x09, 0x00, 0xf1,
+	0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x1f,
+	/* Typo in TS 102 223?  Byte 18 changed to 01 here */
+};
+
+static const struct terminal_response_test
+		provide_local_info_response_data_1171 =3D {
+	.pdu =3D provide_local_info_response_1171,
+	.pdu_len =3D sizeof(provide_local_info_response_1171),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO,
+		.qualifier =3D 0x00, /* Location information (MCC MNC LAC CI) */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .provide_local_info =3D {
+			{ .location =3D {
+				.mcc =3D "001",
+				.mnc =3D "01",
+				.lac_tac =3D 0x0001,
+				.has_eutran_ci =3D TRUE,
+				.eutran_ci =3D 0x0000001,
+			}},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -13270,6 +13773,58 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Provide Local Info 1.11.1",
 			&provide_local_info_data_1111, test_provide_local_info);
 =

+	g_test_add_data_func("/teststk/Provide Local Info response 1.1.1A",
+			&provide_local_info_response_data_111a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.1.1B",
+			&provide_local_info_response_data_111b,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.2.1",
+			&provide_local_info_response_data_121,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.3.1",
+			&provide_local_info_response_data_131,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.4.1",
+			&provide_local_info_response_data_141,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.5.1",
+			&provide_local_info_response_data_151,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.6.1",
+			&provide_local_info_response_data_161,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.7.1",
+			&provide_local_info_response_data_171,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.8.1",
+			&provide_local_info_response_data_181,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.9.1",
+			&provide_local_info_response_data_191,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.11.1",
+			&provide_local_info_response_data_1111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.12.1",
+			&provide_local_info_response_data_1121,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.13.1",
+			&provide_local_info_response_data_1131,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.14.1",
+			&provide_local_info_response_data_1141,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.15.1",
+			&provide_local_info_response_data_1151,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.16.1",
+			&provide_local_info_response_data_1161,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Provide Local Info response 1.17.1",
+			&provide_local_info_response_data_1171,
+			test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Setup Event List 1.1.1",
 			&setup_event_list_data_111, test_setup_event_list);
 	g_test_add_data_func("/teststk/Setup Event List 1.2.1",
-- =

1.7.1.86.g0e460.dirty


--===============7282394204795997831==--

