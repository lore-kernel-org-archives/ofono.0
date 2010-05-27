Content-Type: multipart/mixed; boundary="===============2849906217324817915=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 16/20] test-stkutil: Add the Send DTMF response tests
Date: Thu, 27 May 2010 06:59:55 +0200
Message-ID: <1274936399-20710-16-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2849906217324817915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index c25c0b2..b411df3 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -17624,6 +17624,68 @@ static const struct terminal_response_test run_at_=
command_response_data_251 =3D {
 	},
 };
 =

+static const unsigned char send_dtmf_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x14, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test send_dtmf_response_data_111 =3D=
 {
+	.pdu =3D send_dtmf_response_111,
+	.pdu_len =3D sizeof(send_dtmf_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DTMF,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char send_dtmf_response_141[] =3D {
+	0x81, 0x03, 0x01, 0x14, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x20, 0x07,
+};
+
+static const struct terminal_response_test send_dtmf_response_data_141 =3D=
 {
+	.pdu =3D send_dtmf_response_141,
+	.pdu_len =3D sizeof(send_dtmf_response_141),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DTMF,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_TERMINAL_BUSY,
+			.additional_len =3D 1, /* Not in speech call */
+			.additional =3D (unsigned char[1]) { 0x07 },
+		},
+	},
+};
+
+static const unsigned char send_dtmf_response_211b[] =3D {
+	0x81, 0x03, 0x01, 0x14, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test send_dtmf_response_data_211b =
=3D {
+	.pdu =3D send_dtmf_response_211b,
+	.pdu_len =3D sizeof(send_dtmf_response_211b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SEND_DTMF,
+		.qualifier =3D 0x00,
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
@@ -19170,6 +19232,16 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Send DTMF 6.1.1",
 			&send_dtmf_data_611, test_send_dtmf);
 =

+	g_test_add_data_func("/teststk/Send DTMF response 1.1.1",
+			&send_dtmf_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send DTMF response 1.4.1",
+			&send_dtmf_response_data_141,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Send DTMF response 2.1.1B",
+			&send_dtmf_response_data_211b,
+			test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Language Notification 1.1.1",
 		&language_notification_data_111, test_language_notification);
 	g_test_add_data_func("/teststk/Language Notification 1.2.1",
-- =

1.7.1.86.g0e460.dirty


--===============2849906217324817915==--

