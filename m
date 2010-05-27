Content-Type: multipart/mixed; boundary="===============0149694477651157564=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/20] test-stkutil: Add Run AT Command response builder tests
Date: Thu, 27 May 2010 06:59:53 +0200
Message-ID: <1274936399-20710-14-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0149694477651157564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 2dfb0c5..c25c0b2 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -17556,6 +17556,74 @@ static const struct terminal_response_test
 	},
 };
 =

+static const unsigned char run_at_command_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x34, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0xA9, 0x05, 0x2b, 0x43,
+	0x47, 0x4d, 0x49,
+};
+
+static const struct terminal_response_test run_at_command_response_data_11=
1 =3D {
+	.pdu =3D run_at_command_response_111,
+	.pdu_len =3D sizeof(run_at_command_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_RUN_AT_COMMAND,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .run_at_command =3D {
+			.at_response =3D "+CGMI",
+		}},
+	},
+};
+
+static const unsigned char run_at_command_response_211b[] =3D {
+	0x81, 0x03, 0x01, 0x34, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04, 0xA9, 0x05, 0x2b, 0x43,
+	0x47, 0x4d, 0x49,
+};
+
+static const struct terminal_response_test run_at_command_response_data_21=
1b =3D {
+	.pdu =3D run_at_command_response_211b,
+	.pdu_len =3D sizeof(run_at_command_response_211b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_RUN_AT_COMMAND,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+		{ .run_at_command =3D {
+			.at_response =3D "+CGMI",
+		}},
+	},
+};
+
+static const unsigned char run_at_command_response_251[] =3D {
+	0x81, 0x03, 0x01, 0x34, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x32,
+};
+
+static const struct terminal_response_test run_at_command_response_data_25=
1 =3D {
+	.pdu =3D run_at_command_response_251,
+	.pdu_len =3D sizeof(run_at_command_response_251),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_RUN_AT_COMMAND,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -19021,6 +19089,16 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Run At Command 6.1.1",
 			&run_at_command_data_611, test_run_at_command);
 =

+	g_test_add_data_func("/teststk/Run AT Command response 1.1.1",
+			&run_at_command_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Run AT Command response 2.1.1B",
+			&run_at_command_response_data_211b,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Run AT Command response 2.5.1",
+			&run_at_command_response_data_251,
+			test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Send DTMF 1.1.1",
 			&send_dtmf_data_111, test_send_dtmf);
 	g_test_add_data_func("/teststk/Send DTMF 1.2.1",
-- =

1.7.1.86.g0e460.dirty


--===============0149694477651157564==--

