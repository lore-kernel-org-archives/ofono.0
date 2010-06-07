Content-Type: multipart/mixed; boundary="===============8906508080007572417=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/20] test-stkutil: Tests for Call Control envelope builder
Date: Mon, 07 Jun 2010 12:08:35 +0200
Message-ID: <1275905322-14768-13-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8906508080007572417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  154 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 154 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 2a33c30..d8f6cf2 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18303,6 +18303,151 @@ static const struct envelope_test menu_selection_=
data_641 =3D {
 	},
 };
 =

+static const unsigned char call_control_111a[] =3D {
+	0xd4, 0x25, 0x82, 0x02, 0x82, 0x81, 0x86, 0x0b,
+	0x91, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32,
+	0x54, 0x76, 0x98, 0x07, 0x07, 0x06, 0x60, 0x04,
+	0x02, 0x00, 0x05, 0x81, 0x13, 0x09, 0x00, 0xf1,
+	0x10, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01,
+};
+
+static const struct envelope_test call_control_data_111a =3D {
+	.pdu =3D call_control_111a,
+	.pdu_len =3D sizeof(call_control_111a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_CALL_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .call_control =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "01234567890123456789",
+			},
+			.ccp1 =3D {
+				.ccp =3D {
+					0x60, 0x04, 0x02, 0x00, 0x05, 0x81,
+				},
+				.len =3D 6,
+			},
+			.location =3D {
+				.mcc =3D "001",
+				.mnc =3D "01",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+				.has_ext_ci =3D TRUE,
+				.ext_ci =3D 0x0001,
+			},
+		}},
+	},
+};
+
+static const unsigned char call_control_111b[] =3D {
+	0xd4, 0x23, 0x82, 0x02, 0x82, 0x81, 0x86, 0x0b,
+	0x91, 0x10, 0x32, 0x54, 0x76, 0x98, 0x10, 0x32,
+	0x54, 0x76, 0x98, 0x07, 0x07, 0x06, 0x60, 0x04,
+	0x02, 0x00, 0x05, 0x81, 0x13, 0x07, 0x00, 0x11,
+	0x10, 0x00, 0x01, 0x00, 0x01,
+};
+
+static const struct envelope_test call_control_data_111b =3D {
+	.pdu =3D call_control_111b,
+	.pdu_len =3D sizeof(call_control_111b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_CALL_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .call_control =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "01234567890123456789",
+			},
+			.ccp1 =3D {
+				.ccp =3D {
+					0x60, 0x04, 0x02, 0x00, 0x05, 0x81,
+				},
+				.len =3D 6,
+			},
+			.location =3D {
+				.mcc =3D "001",
+				.mnc =3D "011",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+			},
+		}},
+	},
+};
+
+static const unsigned char call_control_131a[] =3D {
+	0xd4, 0x18, 0x82, 0x02, 0x82, 0x81, 0x86, 0x07,
+	0x91, 0x10, 0x32, 0x04, 0x21, 0x43, 0x65, 0x13,
+	0x09, 0x00, 0xf1, 0x10, 0x00, 0x01, 0x00, 0x01,
+	0x00, 0x01,
+	/*
+	 * Byte 3 changed to 0x82 and byte 7 changed to 0x86 (Comprehension
+	 * Required should be set according to TS 102 223 7.3.1.6)
+	 */
+};
+
+static const struct envelope_test call_control_data_131a =3D {
+	.pdu =3D call_control_131a,
+	.pdu_len =3D sizeof(call_control_131a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_CALL_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .call_control =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "012340123456",
+			},
+			.location =3D {
+				.mcc =3D "001",
+				.mnc =3D "01",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+				.has_ext_ci =3D TRUE,
+				.ext_ci =3D 0x0001,
+			},
+		}},
+	},
+};
+
+static const unsigned char call_control_131b[] =3D {
+	0xd4, 0x16, 0x82, 0x02, 0x82, 0x81, 0x86, 0x07,
+	0x91, 0x10, 0x32, 0x04, 0x21, 0x43, 0x65, 0x13,
+	0x07, 0x00, 0x11, 0x10, 0x00, 0x01, 0x00, 0x01,
+	/*
+	 * Byte 3 changed to 0x82 and byte 7 changed to 0x86 (Comprehension
+	 * Required should be set according to TS 102 223 7.3.1.6)
+	 */
+};
+
+static const struct envelope_test call_control_data_131b =3D {
+	.pdu =3D call_control_131b,
+	.pdu_len =3D sizeof(call_control_131b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_CALL_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .call_control =3D {
+			.address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "012340123456",
+			},
+			.location =3D {
+				.mcc =3D "001",
+				.mnc =3D "011",
+				.lac_tac =3D 0x0001,
+				.has_ci =3D TRUE,
+				.ci =3D 0x0001,
+			},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -20005,5 +20150,14 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Menu Selection 6.4.1",
 			&menu_selection_data_641, test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/Call Control 1.1.1A",
+			&call_control_data_111a, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Call Control 1.1.1B",
+			&call_control_data_111b, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Call Control 1.3.1A",
+			&call_control_data_131a, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Call Control 1.3.1B",
+			&call_control_data_131b, test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============8906508080007572417==--

