Content-Type: multipart/mixed; boundary="===============3808632373866609599=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/20] test-stkutil: Add Set Up Idle Mode response builder
 tests
Date: Thu, 27 May 2010 06:59:51 +0200
Message-ID: <1274936399-20710-12-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3808632373866609599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 092e343..2dfb0c5 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -17493,6 +17493,69 @@ static const struct terminal_response_test timer_m=
gmt_response_data_167 =3D {
 	},
 };
 =

+static const unsigned char set_up_idle_mode_text_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x28, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test
+		set_up_idle_mode_text_response_data_111 =3D {
+	.pdu =3D set_up_idle_mode_text_response_111,
+	.pdu_len =3D sizeof(set_up_idle_mode_text_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_idle_mode_text_response_211b[] =3D {
+	0x81, 0x03, 0x01, 0x28, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test
+		set_up_idle_mode_text_response_data_211b =3D {
+	.pdu =3D set_up_idle_mode_text_response_211b,
+	.pdu_len =3D sizeof(set_up_idle_mode_text_response_211b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+	},
+};
+
+static const unsigned char set_up_idle_mode_text_response_241[] =3D {
+	0x81, 0x03, 0x01, 0x28, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x32,
+};
+
+static const struct terminal_response_test
+		set_up_idle_mode_text_response_data_241 =3D {
+	.pdu =3D set_up_idle_mode_text_response_241,
+	.pdu_len =3D sizeof(set_up_idle_mode_text_response_241),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT,
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
@@ -18873,6 +18936,16 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Idle Mode Text 6.1.1",
 		&setup_idle_mode_text_data_611, test_setup_idle_mode_text);
 =

+	g_test_add_data_func("/teststk/Set Up Idle Mode Text response 1.1.1",
+			&set_up_idle_mode_text_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Idle Mode Text response 2.1.1B",
+			&set_up_idle_mode_text_response_data_211b,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Idle Mode Text response 2.4.1",
+			&set_up_idle_mode_text_response_data_241,
+			test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Run At Command 1.1.1",
 			&run_at_command_data_111, test_run_at_command);
 	g_test_add_data_func("/teststk/Run At Command 1.2.1",
-- =

1.7.1.86.g0e460.dirty


--===============3808632373866609599==--

