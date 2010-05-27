Content-Type: multipart/mixed; boundary="===============0407488466495085856=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 20/20] test-stkutil: Add Launch Browser response builder tests
Date: Thu, 27 May 2010 06:59:59 +0200
Message-ID: <1274936399-20710-20-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0407488466495085856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 3eab970..0a47187 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -17728,6 +17728,108 @@ static const struct terminal_response_test
 	},
 };
 =

+static const unsigned char launch_browser_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x15, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test launch_browser_response_data_11=
1 =3D {
+	.pdu =3D launch_browser_response_111,
+	.pdu_len =3D sizeof(launch_browser_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LAUNCH_BROWSER,
+		.qualifier =3D 0x00, /* Launch browser, if not running */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char launch_browser_response_211[] =3D {
+	0x81, 0x03, 0x01, 0x15, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test launch_browser_response_data_21=
1 =3D {
+	.pdu =3D launch_browser_response_211,
+	.pdu_len =3D sizeof(launch_browser_response_211),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LAUNCH_BROWSER,
+		.qualifier =3D 0x02, /* Use the existing browser */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char launch_browser_response_221[] =3D {
+	0x81, 0x03, 0x01, 0x15, 0x03, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test launch_browser_response_data_22=
1 =3D {
+	.pdu =3D launch_browser_response_221,
+	.pdu_len =3D sizeof(launch_browser_response_221),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LAUNCH_BROWSER,
+		.qualifier =3D 0x03, /* Re-start browser session */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char launch_browser_response_231[] =3D {
+	0x81, 0x03, 0x01, 0x15, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x02, 0x26, 0x02,
+};
+
+static const struct terminal_response_test launch_browser_response_data_23=
1 =3D {
+	.pdu =3D launch_browser_response_231,
+	.pdu_len =3D sizeof(launch_browser_response_231),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LAUNCH_BROWSER,
+		.qualifier =3D 0x00, /* Launch browser, if not running */
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_BROWSER_TEMPORARY,
+			.additional_len =3D 1, /* Browser unavailable */
+			.additional =3D (unsigned char[1]) { 0x02 },
+		},
+	},
+};
+
+static const unsigned char launch_browser_response_411b[] =3D {
+	0x81, 0x03, 0x01, 0x15, 0x02, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test launch_browser_response_data_41=
1b =3D {
+	.pdu =3D launch_browser_response_411b,
+	.pdu_len =3D sizeof(launch_browser_response_411b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LAUNCH_BROWSER,
+		.qualifier =3D 0x02, /* Use the existing browser */
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
@@ -19373,5 +19475,21 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Launch Browser 7.1.1",
 			     &launch_browser_data_711, test_launch_browser);
 =

+	g_test_add_data_func("/teststk/Launch Browser response 1.1.1",
+			&launch_browser_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Launch Browser response 2.1.1",
+			&launch_browser_response_data_211,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Launch Browser response 2.2.1",
+			&launch_browser_response_data_221,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Launch Browser response 2.3.1",
+			&launch_browser_response_data_231,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Launch Browser response 4.1.1B",
+			&launch_browser_response_data_411b,
+			test_terminal_response_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============0407488466495085856==--

