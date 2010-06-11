Content-Type: multipart/mixed; boundary="===============6407494928868997001=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/15] test-stkutil: Tests for Event Download envelope builder
Date: Fri, 11 Jun 2010 12:39:51 +0200
Message-ID: <1276252800-27515-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276252800-27515-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6407494928868997001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c | 1204 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 1204 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 88a9870..aaa5bcc 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18525,6 +18525,1084 @@ static const struct envelope_test mo_short_messa=
ge_control_data_111b =3D {
 	},
 };
 =

+static const unsigned char event_download_mt_call_111[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x00, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x00,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c (Comprehension
+	 * Required should be set according to TS 102 223 7.5.1.2)
+	 */
+};
+
+static const struct envelope_test event_download_mt_call_data_111 =3D {
+	.pdu =3D event_download_mt_call_111,
+	.pdu_len =3D sizeof(event_download_mt_call_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_MT_CALL,
+			{ .mt_call =3D {
+				.transaction_id =3D 0,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_mt_call_112[] =3D {
+	0xd6, 0x0f, 0x99, 0x01, 0x00, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x00, 0x06, 0x03, 0x81, 0x89,
+	0x67,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 0x06 (Comprehension Required should be set according to
+	 * TS 102 223 7.5.1.2)
+	 */
+};
+
+static const struct envelope_test event_download_mt_call_data_112 =3D {
+	.pdu =3D event_download_mt_call_112,
+	.pdu_len =3D sizeof(event_download_mt_call_112),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_MT_CALL,
+			{ .mt_call =3D {
+				.transaction_id =3D 0,
+				.caller_address =3D {
+					.ton_npi =3D 0x81, /* Unknown, ISDN */
+					.number =3D "9876",
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_connected_111[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x80,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c (Comprehension
+	 * Required should be set according to TS 102 223 7.5.2.2)
+	 */
+};
+
+static const struct envelope_test event_download_call_connected_data_111 =
=3D {
+	.pdu =3D event_download_call_connected_111,
+	.pdu_len =3D sizeof(event_download_call_connected_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_CONNECTED,
+			{ .call_connected =3D {
+				.transaction_id =3D 0x80,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_connected_112[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x01, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x80,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c (Comprehension
+	 * Required should be set according to TS 102 223 7.5.2.2)
+	 */
+};
+
+static const struct envelope_test event_download_call_connected_data_112 =
=3D {
+	.pdu =3D event_download_call_connected_112,
+	.pdu_len =3D sizeof(event_download_call_connected_112),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_CONNECTED,
+			{ .call_connected =3D {
+				.transaction_id =3D 0x80,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_111[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x02, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x80,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c (Comprehension
+	 * Required should be set according to TS 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test event_download_call_disconnected_data_11=
1 =3D {
+	.pdu =3D event_download_call_disconnected_111,
+	.pdu_len =3D sizeof(event_download_call_disconnected_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0x80 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_112a[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x80,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c (Comprehension
+	 * Required should be set according to TS 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_112a =3D {
+	.pdu =3D event_download_call_disconnected_112a,
+	.pdu_len =3D sizeof(event_download_call_disconnected_112a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0x80 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_112b[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x80, 0x1a, 0x02, 0x60, 0x90,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_112b =3D {
+	.pdu =3D event_download_call_disconnected_112b,
+	.pdu_len =3D sizeof(event_download_call_disconnected_112b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0x80 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					.len =3D 2,
+					/* Normal call clearing */
+					.cause =3D { 0x60, 0x90 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_112c[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x80, 0x1a, 0x02, 0xe0, 0x90,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_112c =3D {
+	.pdu =3D event_download_call_disconnected_112c,
+	.pdu_len =3D sizeof(event_download_call_disconnected_112c),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0x80 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					.len =3D 2,
+					/* Normal call clearing */
+					.cause =3D { 0xe0, 0x90 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_113a[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x02, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x00, 0x1a, 0x02, 0x60, 0x90,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_113a =3D {
+	.pdu =3D event_download_call_disconnected_113a,
+	.pdu_len =3D sizeof(event_download_call_disconnected_113a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					.len =3D 2,
+					/* Normal call clearing */
+					.cause =3D { 0x60, 0x90 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_113b[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x02, 0x82, 0x02, 0x83,
+	0x81, 0x9c, 0x01, 0x00, 0x1a, 0x02, 0xe0, 0x90,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_113b =3D {
+	.pdu =3D event_download_call_disconnected_113b,
+	.pdu_len =3D sizeof(event_download_call_disconnected_113b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					.len =3D 2,
+					/* Normal call clearing */
+					.cause =3D { 0xe0, 0x90 },
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_114a[] =3D {
+	0xd6, 0x0c, 0x99, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x80, 0x1a, 0x00,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_114a =3D {
+	.pdu =3D event_download_call_disconnected_114a,
+	.pdu_len =3D sizeof(event_download_call_disconnected_114a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0x80 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					/* Radio link failure */
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_call_disconnected_114b[] =3D {
+	0xd6, 0x0c, 0x99, 0x01, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x9c, 0x01, 0x00, 0x1a, 0x00,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9c and byte 13 to
+	 * 1a (Comprehension Required should be set according to TS
+	 * 102 223 7.5.3.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_call_disconnected_data_114b =3D {
+	.pdu =3D event_download_call_disconnected_114b,
+	.pdu_len =3D sizeof(event_download_call_disconnected_114b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CALL_DISCONNECTED,
+			{ .call_disconnected =3D {
+				.transaction_ids =3D {
+					.len =3D 1,
+					.list =3D { 0 },
+				},
+				.cause =3D {
+					.has_cause =3D TRUE,
+					/* Radio link failure */
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_location_status_111[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x9b, 0x01, 0x02,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9b (Comprehension
+	 * Required should be set according to TS 102 223 7.5.4.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_location_status_data_111 =3D {
+	.pdu =3D event_download_location_status_111,
+	.pdu_len =3D sizeof(event_download_location_status_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LOCATION_STATUS,
+			{ .location_status =3D {
+				.state =3D STK_NO_SERVICE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_location_status_112a[] =3D {
+	0xd6, 0x15, 0x99, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x9b, 0x01, 0x00, 0x13, 0x09, 0x00, 0xf1,
+	0x10, 0x00, 0x02, 0x00, 0x02, 0x00, 0x01,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9b (Comprehension
+	 * Required should be set according to TS 102 223 7.5.4.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_location_status_data_112a =3D {
+	.pdu =3D event_download_location_status_112a,
+	.pdu_len =3D sizeof(event_download_location_status_112a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LOCATION_STATUS,
+			{ .location_status =3D {
+				.state =3D STK_NORMAL_SERVICE,
+				.info =3D {
+					.mcc =3D "001",
+					.mnc =3D "01",
+					.lac_tac =3D 0x0002,
+					.has_ci =3D TRUE,
+					.ci =3D 0x0002,
+					.has_ext_ci =3D TRUE,
+					.ext_ci =3D 0x0001,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_location_status_112b[] =3D {
+	0xd6, 0x13, 0x99, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x9b, 0x01, 0x00, 0x13, 0x07, 0x00, 0x11,
+	0x10, 0x00, 0x02, 0x00, 0x02,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9b (Comprehension
+	 * Required should be set according to TS 102 223 7.5.4.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_location_status_data_112b =3D {
+	.pdu =3D event_download_location_status_112b,
+	.pdu_len =3D sizeof(event_download_location_status_112b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LOCATION_STATUS,
+			{ .location_status =3D {
+				.state =3D STK_NORMAL_SERVICE,
+				.info =3D {
+					.mcc =3D "001",
+					.mnc =3D "011",
+					.lac_tac =3D 0x0002,
+					.has_ci =3D TRUE,
+					.ci =3D 0x0002,
+				},
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_location_status_122[] =3D {
+	0xd6, 0x15, 0x99, 0x01, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x9b, 0x01, 0x00, 0x13, 0x09, 0x00, 0xf1,
+	0x10, 0x00, 0x02, 0x00, 0x00, 0x00, 0x2f,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0x9b (Comprehension
+	 * Required should be set according to TS 102 223 7.5.4.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_location_status_data_122 =3D {
+	.pdu =3D event_download_location_status_122,
+	.pdu_len =3D sizeof(event_download_location_status_122),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LOCATION_STATUS,
+			{ .location_status =3D {
+				.state =3D STK_NORMAL_SERVICE,
+				.info =3D {
+					.mcc =3D "001",
+					.mnc =3D "01",
+					.lac_tac =3D 0x0002,
+					.has_eutran_ci =3D TRUE,
+					.eutran_ci =3D 0x0000002,
+				},
+			}},
+		}},
+	},
+};
+
+/*
+ * This is from 27.22.7.5.  The ENVELOPE given in 27.22.4.16.1.1 seems to
+ * have invalid length value (2nd byte), but in turn the Comprehension
+ * Required bit is set correctly..
+ */
+static const unsigned char event_download_user_activity_111[] =3D {
+	0xd6, 0x07, 0x99, 0x01, 0x04, 0x82, 0x02, 0x82,
+	0x81,
+	/*
+	 * Byte 3 changed to 0x99 (Comprehension Required should be
+	 * set according to TS 102 223 7.5.5.2)
+	 */
+};
+
+static const struct envelope_test event_download_user_activity_data_111 =
=3D {
+	.pdu =3D event_download_user_activity_111,
+	.pdu_len =3D sizeof(event_download_user_activity_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_USER_ACTIVITY,
+		}},
+	},
+};
+
+static const unsigned char event_download_idle_screen_available_111[] =3D {
+	0xd6, 0x07, 0x99, 0x01, 0x05, 0x82, 0x02, 0x02,
+	0x81,
+	/*
+	 * Byte 3 changed to 0x99 (Comprehension Required should be
+	 * set according to TS 102 223 7.5.6.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_idle_screen_available_data_111 =3D {
+	.pdu =3D event_download_idle_screen_available_111,
+	.pdu_len =3D sizeof(event_download_idle_screen_available_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_DISPLAY,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_IDLE_SCREEN_AVAILABLE,
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_111a[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x79,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_111a =3D {
+	.pdu =3D event_download_card_reader_status_111a,
+	.pdu_len =3D sizeof(event_download_card_reader_status_111a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D TRUE,
+				.id1_size =3D TRUE,
+				.card_present =3D TRUE,
+				.card_powered =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_111b[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x59,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_111b =3D {
+	.pdu =3D event_download_card_reader_status_111b,
+	.pdu_len =3D sizeof(event_download_card_reader_status_111b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D TRUE,
+				.id1_size =3D FALSE,
+				.card_present =3D TRUE,
+				.card_powered =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_111c[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x71,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_111c =3D {
+	.pdu =3D event_download_card_reader_status_111c,
+	.pdu_len =3D sizeof(event_download_card_reader_status_111c),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D FALSE,
+				.present =3D TRUE,
+				.id1_size =3D TRUE,
+				.card_present =3D TRUE,
+				.card_powered =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_111d[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x51,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_111d =3D {
+	.pdu =3D event_download_card_reader_status_111d,
+	.pdu_len =3D sizeof(event_download_card_reader_status_111d),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D FALSE,
+				.present =3D TRUE,
+				.id1_size =3D FALSE,
+				.card_present =3D TRUE,
+				.card_powered =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_112a[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x39,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_112a =3D {
+	.pdu =3D event_download_card_reader_status_112a,
+	.pdu_len =3D sizeof(event_download_card_reader_status_112a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D TRUE,
+				.id1_size =3D TRUE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_112b[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x19,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_112b =3D {
+	.pdu =3D event_download_card_reader_status_112b,
+	.pdu_len =3D sizeof(event_download_card_reader_status_112b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D TRUE,
+				.id1_size =3D FALSE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_112c[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x31,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_112c =3D {
+	.pdu =3D event_download_card_reader_status_112c,
+	.pdu_len =3D sizeof(event_download_card_reader_status_112c),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D FALSE,
+				.present =3D TRUE,
+				.id1_size =3D TRUE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_112d[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x11,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_112d =3D {
+	.pdu =3D event_download_card_reader_status_112d,
+	.pdu_len =3D sizeof(event_download_card_reader_status_112d),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D FALSE,
+				.present =3D TRUE,
+				.id1_size =3D FALSE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_212a[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x29,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_212a =3D {
+	.pdu =3D event_download_card_reader_status_212a,
+	.pdu_len =3D sizeof(event_download_card_reader_status_212a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D FALSE,
+				.id1_size =3D TRUE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_card_reader_status_212b[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x06, 0x82, 0x02, 0x82,
+	0x81, 0xa0, 0x01, 0x09,
+};
+
+static const struct envelope_test
+		event_download_card_reader_status_data_212b =3D {
+	.pdu =3D event_download_card_reader_status_212b,
+	.pdu_len =3D sizeof(event_download_card_reader_status_212b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CARD_READER_STATUS,
+			{ .card_reader_status =3D {
+				.id =3D 1,
+				.removable =3D TRUE,
+				.present =3D FALSE,
+				.id1_size =3D FALSE,
+				.card_present =3D FALSE,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_language_selection_111[] =3D {
+	0xd6, 0x0b, 0x99, 0x01, 0x07, 0x82, 0x02, 0x82,
+	0x81, 0xad, 0x02, 0x64, 0x65,
+	/*
+	 * Byte 3 changed to 0x99 and byte 10 to 0xad (Comprehension
+	 * Required should be set according to TS 102 223 7.5.8.2)
+	 */
+};
+
+static const struct envelope_test
+		event_download_language_selection_data_111 =3D {
+	.pdu =3D event_download_language_selection_111,
+	.pdu_len =3D sizeof(event_download_language_selection_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LANGUAGE_SELECTION,
+			{ .language_selection =3D "de" },
+		}},
+	},
+};
+
+static const unsigned char event_download_language_selection_122[] =3D {
+	0xd6, 0x0b, 0x99, 0x01, 0x07, 0x82, 0x02, 0x82,
+	0x81, 0xad, 0x02, 0x73, 0x65,
+	/* Byte 5 changed to 0x07 (Event: Language Selection) */
+	/* Byte 8 changed to 0x82 (Source device: Terminal) */
+	/* Removed the (unexpected?) Transaction ID data object (0x2d) */
+};
+
+static const struct envelope_test
+		event_download_language_selection_data_122 =3D {
+	.pdu =3D event_download_language_selection_122,
+	.pdu_len =3D sizeof(event_download_language_selection_122),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_LANGUAGE_SELECTION,
+			{ .language_selection =3D "se" },
+		}},
+	},
+};
+
+static const unsigned char event_download_browser_termination_111[] =3D {
+	0xd6, 0x0a, 0x99, 0x01, 0x08, 0x82, 0x02, 0x82,
+	0x81, 0xb4, 0x01, 0x00,
+};
+
+static const struct envelope_test
+		event_download_browser_termination_data_111 =3D {
+	.pdu =3D event_download_browser_termination_111,
+	.pdu_len =3D sizeof(event_download_browser_termination_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_BROWSER_TERMINATION,
+			{ .browser_termination =3D {
+				.cause =3D STK_BROWSER_USER_TERMINATION,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_data_available_111[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x09, 0x82, 0x02, 0x82,
+	0x81, 0xb8, 0x02, 0x81, 0x00, 0xb7, 0x01, 0xff,
+};
+
+static const struct envelope_test event_download_data_available_data_111 =
=3D {
+	.pdu =3D event_download_data_available_111,
+	.pdu_len =3D sizeof(event_download_data_available_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_DATA_AVAILABLE,
+			{ .data_available =3D {
+				/* Channel 1 open, Link established */
+				.channel_status =3D { 0x81, 0x00 },
+				.channel_data_len =3D 255,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_data_available_211[] =3D {
+	0xd6, 0x0e, 0x99, 0x01, 0x09, 0x82, 0x02, 0x82,
+	0x81, 0xb8, 0x02, 0x81, 0x01, 0xb7, 0x01, 0xff,
+};
+
+static const struct envelope_test event_download_data_available_data_211 =
=3D {
+	.pdu =3D event_download_data_available_211,
+	.pdu_len =3D sizeof(event_download_data_available_211),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_DATA_AVAILABLE,
+			{ .data_available =3D {
+				/* Channel 1 open, Link established */
+				.channel_status =3D { 0x81, 0x01 },
+				.channel_data_len =3D 255,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_channel_status_131[] =3D {
+	0xd6, 0x0b, 0x99, 0x01, 0x0a, 0x82, 0x02, 0x82,
+	0x81, 0xb8, 0x02, 0x01, 0x05,
+};
+
+static const struct envelope_test event_download_channel_status_data_131 =
=3D {
+	.pdu =3D event_download_channel_status_131,
+	.pdu_len =3D sizeof(event_download_channel_status_131),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
+			{ .channel_status =3D {
+				/* Channel 1, Link dropped */
+				.status =3D { 0x01, 0x05 },
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_channel_status_211[] =3D {
+	0xd6, 0x0b, 0x99, 0x01, 0x0a, 0x82, 0x02, 0x82,
+	0x81, 0xb8, 0x02, 0x41, 0x00,
+	/*
+	 * Byte 10 changed to 0xb8 (Comprehension Required should be
+	 * set according to TS 102 223 7.5.11.2)
+	 */
+};
+
+static const struct envelope_test event_download_channel_status_data_211 =
=3D {
+	.pdu =3D event_download_channel_status_211,
+	.pdu_len =3D sizeof(event_download_channel_status_211),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
+			{ .channel_status =3D {
+				/* Channel 1, TCP in LISTEN state */
+				.status =3D { 0x41, 0x00 },
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_channel_status_221[] =3D {
+	0xd6, 0x0b, 0x99, 0x01, 0x0a, 0x82, 0x02, 0x82,
+	0x81, 0xb8, 0x02, 0x81, 0x01,
+	/*
+	 * Byte 10 changed to 0xb8 (Comprehension Required should be
+	 * set according to TS 102 223 7.5.11.2)
+	 */
+};
+
+static const struct envelope_test event_download_channel_status_data_221 =
=3D {
+	.pdu =3D event_download_channel_status_221,
+	.pdu_len =3D sizeof(event_download_channel_status_221),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_CHANNEL_STATUS,
+			{ .channel_status =3D {
+				/* Channel 1 open, TCP Link established */
+				.status =3D { 0x81, 0x01 },
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_network_rejection_111[] =3D {
+	0xd6, 0x17, 0x99, 0x01, 0x12, 0x82, 0x02, 0x83,
+	0x81, 0x7d, 0x05, 0x00, 0xf1, 0x10, 0x00, 0x01,
+	0xbf, 0x01, 0x08, 0xf4, 0x01, 0x09, 0xf5, 0x01,
+	0x0b,
+	/*
+	 * Byte 3 changed to 99, byte 17 changed to bf, byte 19 to f4 and
+	 * byte 22 to f5 (Comprehension Required should be set according
+	 * to TS 131 111 7.5.2.2)
+	 */
+};
+
+static const struct envelope_test event_download_network_rejection_data_11=
1 =3D {
+	.pdu =3D event_download_network_rejection_111,
+	.pdu_len =3D sizeof(event_download_network_rejection_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_NETWORK_REJECTION,
+			{ .network_rejection =3D {
+				.tai =3D {
+					.mcc =3D "001",
+					.mnc =3D "01",
+					.tac =3D 0x0001,
+				},
+				.access_tech =3D STK_ACCESS_TECHNOLOGY_EUTRAN,
+				.update_attach =3D STK_UPDATE_ATTACH_EPS_ATTACH,
+				.cause =3D STK_CAUSE_EMM_PLMN_NOT_ALLOWED,
+			}},
+		}},
+	},
+};
+
+static const unsigned char event_download_network_rejection_121[] =3D {
+	0xd6, 0x17, 0x99, 0x01, 0x12, 0x82, 0x02, 0x83,
+	0x81, 0x7d, 0x05, 0x00, 0xf1, 0x10, 0x00, 0x01,
+	0xbf, 0x01, 0x08, 0xf4, 0x01, 0x0b, 0xf5, 0x01,
+	0x0c,
+	/*
+	 * Byte 3 changed to 99, byte 17 changed to bf, byte 19 to f4 and
+	 * byte 22 to f5 (Comprehension Required should be set according
+	 * to TS 131 111 7.5.2.2)
+	 */
+};
+
+static const struct envelope_test event_download_network_rejection_data_12=
1 =3D {
+	.pdu =3D event_download_network_rejection_121,
+	.pdu_len =3D sizeof(event_download_network_rejection_121),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_EVENT_DOWNLOAD,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .event_download =3D {
+			.type =3D STK_EVENT_TYPE_NETWORK_REJECTION,
+			{ .network_rejection =3D {
+				.tai =3D {
+					.mcc =3D "001",
+					.mnc =3D "01",
+					.tac =3D 0x0001,
+				},
+				.access_tech =3D STK_ACCESS_TECHNOLOGY_EUTRAN,
+				.update_attach =3D STK_UPDATE_ATTACH_TA_UPDATING,
+				.cause =3D STK_CAUSE_EMM_TAC_NOT_ALLOWED,
+			}},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -20243,5 +21321,131 @@ int main(int argc, char **argv)
 			&mo_short_message_control_data_111b,
 			test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/Event: MT Call 1.1.1",
+			&event_download_mt_call_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: MT Call 1.1.2",
+			&event_download_mt_call_data_112,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Call Connected 1.1.1",
+			&event_download_call_connected_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Connected 1.1.2",
+			&event_download_call_connected_data_112,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.1",
+			&event_download_call_disconnected_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.2A",
+			&event_download_call_disconnected_data_112a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.2B",
+			&event_download_call_disconnected_data_112b,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.2C",
+			&event_download_call_disconnected_data_112c,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.3A",
+			&event_download_call_disconnected_data_113a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.3B",
+			&event_download_call_disconnected_data_113b,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.4A",
+			&event_download_call_disconnected_data_114a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Call Disconnected 1.1.4B",
+			&event_download_call_disconnected_data_114b,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Location Status 1.1.1",
+			&event_download_location_status_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Location Status 1.1.2A",
+			&event_download_location_status_data_112a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Location Status 1.1.2B",
+			&event_download_location_status_data_112b,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Location Status 1.2.2",
+			&event_download_location_status_data_122,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: User Activity 1.1.1",
+			&event_download_user_activity_data_111,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Idle Screen Available 1.1.1",
+			&event_download_idle_screen_available_data_111,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.1A",
+			&event_download_card_reader_status_data_111a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.1B",
+			&event_download_card_reader_status_data_111b,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.1C",
+			&event_download_card_reader_status_data_111c,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.1D",
+			&event_download_card_reader_status_data_111d,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.2A",
+			&event_download_card_reader_status_data_112a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.2B",
+			&event_download_card_reader_status_data_112b,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.2C",
+			&event_download_card_reader_status_data_112c,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 1.1.2D",
+			&event_download_card_reader_status_data_112d,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 2.1.2A",
+			&event_download_card_reader_status_data_212a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Card Reader Status 2.1.2B",
+			&event_download_card_reader_status_data_212b,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Language Selection 1.1.1",
+			&event_download_language_selection_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Language Selection 1.2.2",
+			&event_download_language_selection_data_122,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Browser Termination 1.1.1",
+			&event_download_browser_termination_data_111,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Data Available 1.1.1",
+			&event_download_data_available_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Data Available 2.1.1",
+			&event_download_data_available_data_211,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Channel Status 1.3.1",
+			&event_download_channel_status_data_131,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Channel Status 2.1.1",
+			&event_download_channel_status_data_211,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Channel Status 2.2.1",
+			&event_download_channel_status_data_221,
+			test_envelope_encoding);
+
+	g_test_add_data_func("/teststk/Event: Network Rejection 1.1.1",
+			&event_download_network_rejection_data_111,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/Event: Network Rejection 1.2.1",
+			&event_download_network_rejection_data_121,
+			test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============6407494928868997001==--

