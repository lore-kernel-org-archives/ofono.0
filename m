Content-Type: multipart/mixed; boundary="===============7865872621060187689=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/20] test-stkutil: Tests for MO Short Message Control
 envelope builder
Date: Mon, 07 Jun 2010 12:08:37 +0200
Message-ID: <1275905322-14768-15-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275905322-14768-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7865872621060187689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index d8f6cf2..8769bfe 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18448,6 +18448,78 @@ static const struct envelope_test call_control_dat=
a_131b =3D {
 	},
 };
 =

+static const unsigned char mo_short_message_control_111a[] =3D {
+	0xd5, 0x22, 0x02, 0x02, 0x82, 0x81, 0x06, 0x09,
+	0x91, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0xf8, 0x06, 0x06, 0x91, 0x10, 0x32, 0x54, 0x76,
+	0xf8, 0x13, 0x09, 0x00, 0xf1, 0x10, 0x00, 0x01,
+	0x00, 0x01, 0x00, 0x01,
+};
+
+static const struct envelope_test mo_short_message_control_data_111a =3D {
+	.pdu =3D mo_short_message_control_111a,
+	.pdu_len =3D sizeof(mo_short_message_control_111a),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MO_SMS_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .sms_mo_control =3D {
+			.sc_address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "112233445566778",
+			},
+			.dest_address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "012345678",
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
+static const unsigned char mo_short_message_control_111b[] =3D {
+	0xd5, 0x20, 0x02, 0x02, 0x82, 0x81, 0x06, 0x09,
+	0x91, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+	0xf8, 0x06, 0x06, 0x91, 0x10, 0x32, 0x54, 0x76,
+	0xf8, 0x13, 0x07, 0x00, 0x11, 0x10, 0x00, 0x01,
+	0x00, 0x01,
+};
+
+static const struct envelope_test mo_short_message_control_data_111b =3D {
+	.pdu =3D mo_short_message_control_111b,
+	.pdu_len =3D sizeof(mo_short_message_control_111b),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MO_SMS_CONTROL,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .sms_mo_control =3D {
+			.sc_address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "112233445566778",
+			},
+			.dest_address =3D {
+				.ton_npi =3D 0x91, /* Intl, ISDN */
+				.number =3D "012345678",
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
@@ -20159,5 +20231,12 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Call Control 1.3.1B",
 			&call_control_data_131b, test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/MO Short Message Control 1.1.1A",
+			&mo_short_message_control_data_111a,
+			test_envelope_encoding);
+	g_test_add_data_func("/teststk/MO Short Message Control 1.1.1B",
+			&mo_short_message_control_data_111b,
+			test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============7865872621060187689==--

