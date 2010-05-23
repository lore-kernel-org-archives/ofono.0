Content-Type: multipart/mixed; boundary="===============2154004563584133779=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/16] test-stkutil: Add Timer Management response tests.
Date: Sun, 23 May 2010 12:15:26 +0200
Message-ID: <1274609726-6656-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2154004563584133779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  862 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 862 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 5993e11..f49b182 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -12842,6 +12842,771 @@ static const struct terminal_response_test
 	},
 };
 =

+static const unsigned char timer_mgmt_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x01,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_111 =
=3D {
+	.pdu =3D timer_mgmt_response_111,
+	.pdu_len =3D sizeof(timer_mgmt_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_112[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x01, 0xa5,
+	0x03, 0x00, 0x30, 0x95,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_112 =
=3D {
+	.pdu =3D timer_mgmt_response_112,
+	.pdu_len =3D sizeof(timer_mgmt_response_112),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 1,
+			.value =3D {
+				.minute =3D 3,
+				.second =3D 59,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_114[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x01, 0xa5,
+	0x03, 0x00, 0x00, 0x95,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_114 =
=3D {
+	.pdu =3D timer_mgmt_response_114,
+	.pdu_len =3D sizeof(timer_mgmt_response_114),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 1,
+			.value =3D {
+				.second =3D 59,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x02,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_121 =
=3D {
+	.pdu =3D timer_mgmt_response_121,
+	.pdu_len =3D sizeof(timer_mgmt_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 2,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_122[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x02, 0xa5,
+	0x03, 0x32, 0x85, 0x85,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_122 =
=3D {
+	.pdu =3D timer_mgmt_response_122,
+	.pdu_len =3D sizeof(timer_mgmt_response_122),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 2,
+			.value =3D {
+				.hour =3D 23,
+				.minute =3D 58,
+				.second =3D 58,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_124[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x02, 0xa5,
+	0x03, 0x00, 0x00, 0x95,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_124 =
=3D {
+	.pdu =3D timer_mgmt_response_124,
+	.pdu_len =3D sizeof(timer_mgmt_response_124),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 2,
+			.value =3D {
+				.second =3D 59,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_131[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x08,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_131 =
=3D {
+	.pdu =3D timer_mgmt_response_131,
+	.pdu_len =3D sizeof(timer_mgmt_response_131),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 8,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_132[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x08, 0xa5,
+	0x03, 0x00, 0x81, 0x95,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_132 =
=3D {
+	.pdu =3D timer_mgmt_response_132,
+	.pdu_len =3D sizeof(timer_mgmt_response_132),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 8,
+			.value =3D {
+				.minute =3D 18,
+				.second =3D 59,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_134[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x08, 0xa5,
+	0x03, 0x00, 0x95, 0x92,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_134 =
=3D {
+	.pdu =3D timer_mgmt_response_134,
+	.pdu_len =3D sizeof(timer_mgmt_response_134),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 8,
+			.value =3D {
+				.minute =3D 59,
+				.second =3D 29,
+				.has_value =3D TRUE,
+			},
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_141a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x01,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_141a =
=3D {
+	.pdu =3D timer_mgmt_response_141a,
+	.pdu_len =3D sizeof(timer_mgmt_response_141a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_141b[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_141b =
=3D {
+	.pdu =3D timer_mgmt_response_141b,
+	.pdu_len =3D sizeof(timer_mgmt_response_141b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+	},
+};
+
+static const unsigned char timer_mgmt_response_142a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x02,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_142a =
=3D {
+	.pdu =3D timer_mgmt_response_142a,
+	.pdu_len =3D sizeof(timer_mgmt_response_142a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 2,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_143a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x03,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_143a =
=3D {
+	.pdu =3D timer_mgmt_response_143a,
+	.pdu_len =3D sizeof(timer_mgmt_response_143a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 3,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_144a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x04,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_144a =
=3D {
+	.pdu =3D timer_mgmt_response_144a,
+	.pdu_len =3D sizeof(timer_mgmt_response_144a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 4,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_145a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x05,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_145a =
=3D {
+	.pdu =3D timer_mgmt_response_145a,
+	.pdu_len =3D sizeof(timer_mgmt_response_145a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 5,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_146a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x06,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_146a =
=3D {
+	.pdu =3D timer_mgmt_response_146a,
+	.pdu_len =3D sizeof(timer_mgmt_response_146a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 6,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_147a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x07,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_147a =
=3D {
+	.pdu =3D timer_mgmt_response_147a,
+	.pdu_len =3D sizeof(timer_mgmt_response_147a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 7,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_148a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x08,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_148a =
=3D {
+	.pdu =3D timer_mgmt_response_148a,
+	.pdu_len =3D sizeof(timer_mgmt_response_148a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x02, /* Get the current value of the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 8,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_151a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x01,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_151a =
=3D {
+	.pdu =3D timer_mgmt_response_151a,
+	.pdu_len =3D sizeof(timer_mgmt_response_151a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 1,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_151b[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_151b =
=3D {
+	.pdu =3D timer_mgmt_response_151b,
+	.pdu_len =3D sizeof(timer_mgmt_response_151b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+	},
+};
+
+static const unsigned char timer_mgmt_response_152a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x02,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_152a =
=3D {
+	.pdu =3D timer_mgmt_response_152a,
+	.pdu_len =3D sizeof(timer_mgmt_response_152a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 2,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_153a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x03,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_153a =
=3D {
+	.pdu =3D timer_mgmt_response_153a,
+	.pdu_len =3D sizeof(timer_mgmt_response_153a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 3,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_154a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x04,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_154a =
=3D {
+	.pdu =3D timer_mgmt_response_154a,
+	.pdu_len =3D sizeof(timer_mgmt_response_154a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 4,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_155a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x05,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_155a =
=3D {
+	.pdu =3D timer_mgmt_response_155a,
+	.pdu_len =3D sizeof(timer_mgmt_response_155a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 5,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_156a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x06,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_156a =
=3D {
+	.pdu =3D timer_mgmt_response_156a,
+	.pdu_len =3D sizeof(timer_mgmt_response_156a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 6,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_157a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x07,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_157a =
=3D {
+	.pdu =3D timer_mgmt_response_157a,
+	.pdu_len =3D sizeof(timer_mgmt_response_157a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 7,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_158a[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x24, 0xa4, 0x01, 0x08,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_158a =
=3D {
+	.pdu =3D timer_mgmt_response_158a,
+	.pdu_len =3D sizeof(timer_mgmt_response_158a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x01, /* Deactivate the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TIMER_CONFLICT,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 8,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_163[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x03,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_163 =
=3D {
+	.pdu =3D timer_mgmt_response_163,
+	.pdu_len =3D sizeof(timer_mgmt_response_163),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 3,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_164[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x04,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_164 =
=3D {
+	.pdu =3D timer_mgmt_response_164,
+	.pdu_len =3D sizeof(timer_mgmt_response_164),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 4,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_165[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x05,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_165 =
=3D {
+	.pdu =3D timer_mgmt_response_165,
+	.pdu_len =3D sizeof(timer_mgmt_response_165),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 5,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_166[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x06,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_166 =
=3D {
+	.pdu =3D timer_mgmt_response_166,
+	.pdu_len =3D sizeof(timer_mgmt_response_166),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 6,
+		}},
+	},
+};
+
+static const unsigned char timer_mgmt_response_167[] =3D {
+	0x81, 0x03, 0x01, 0x27, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xa4, 0x01, 0x07,
+};
+
+static const struct terminal_response_test timer_mgmt_response_data_167 =
=3D {
+	.pdu =3D timer_mgmt_response_167,
+	.pdu_len =3D sizeof(timer_mgmt_response_167),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_TIMER_MANAGEMENT,
+		.qualifier =3D 0x00, /* Start the Timer */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .timer_mgmt =3D {
+			.id =3D 7,
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -13962,5 +14727,102 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Timer Management 2.2.1",
 			&timer_mgmt_data_221, test_timer_mgmt);
 =

+	g_test_add_data_func("/teststk/Timer Management response 1.1.1",
+			&timer_mgmt_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.1.2",
+			&timer_mgmt_response_data_112,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.1.4",
+			&timer_mgmt_response_data_114,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.2.1",
+			&timer_mgmt_response_data_121,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.2.2",
+			&timer_mgmt_response_data_122,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.2.4",
+			&timer_mgmt_response_data_124,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.3.1",
+			&timer_mgmt_response_data_131,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.3.2",
+			&timer_mgmt_response_data_132,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.3.4",
+			&timer_mgmt_response_data_134,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.1A",
+			&timer_mgmt_response_data_141a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.1B",
+			&timer_mgmt_response_data_141b,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.2A",
+			&timer_mgmt_response_data_142a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.3A",
+			&timer_mgmt_response_data_143a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.4A",
+			&timer_mgmt_response_data_144a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.5A",
+			&timer_mgmt_response_data_145a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.6A",
+			&timer_mgmt_response_data_146a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.7A",
+			&timer_mgmt_response_data_147a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.4.8A",
+			&timer_mgmt_response_data_148a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.1A",
+			&timer_mgmt_response_data_151a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.1B",
+			&timer_mgmt_response_data_151b,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.2A",
+			&timer_mgmt_response_data_152a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.3A",
+			&timer_mgmt_response_data_153a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.4A",
+			&timer_mgmt_response_data_154a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.5A",
+			&timer_mgmt_response_data_155a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.6A",
+			&timer_mgmt_response_data_156a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.7A",
+			&timer_mgmt_response_data_157a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.5.8A",
+			&timer_mgmt_response_data_158a,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.6.3",
+			&timer_mgmt_response_data_163,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.6.4",
+			&timer_mgmt_response_data_164,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.6.5",
+			&timer_mgmt_response_data_165,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.6.6",
+			&timer_mgmt_response_data_166,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Timer Management response 1.6.7",
+			&timer_mgmt_response_data_167,
+			test_terminal_response_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============2154004563584133779==--

