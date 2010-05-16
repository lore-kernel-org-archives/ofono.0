Content-Type: multipart/mixed; boundary="===============6772782532604762704=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/27] test-stkutil: Add Play Tone response tests.
Date: Sun, 16 May 2010 16:06:09 +0200
Message-ID: <1274018769-6680-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6772782532604762704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   93 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 4936745..afe002e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -11312,6 +11312,86 @@ static const struct terminal_response_test send_sm=
s_response_data_311b =3D {
 	},
 };
 =

+static const unsigned char play_tone_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x20, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test play_tone_response_data_111 =3D=
 {
+	.pdu =3D play_tone_response_111,
+	.pdu_len =3D sizeof(play_tone_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PLAY_TONE,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char play_tone_response_119b[] =3D {
+	0x81, 0x03, 0x01, 0x20, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x30,
+};
+
+static const struct terminal_response_test play_tone_response_data_119b =
=3D {
+	.pdu =3D play_tone_response_119b,
+	.pdu_len =3D sizeof(play_tone_response_119b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PLAY_TONE,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NOT_CAPABLE,
+		},
+	},
+};
+
+static const unsigned char play_tone_response_1114[] =3D {
+	0x81, 0x03, 0x01, 0x20, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x10,
+};
+
+static const struct terminal_response_test play_tone_response_data_1114 =
=3D {
+	.pdu =3D play_tone_response_1114,
+	.pdu_len =3D sizeof(play_tone_response_1114),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PLAY_TONE,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_USER_TERMINATED,
+		},
+	},
+};
+
+static const unsigned char play_tone_response_311b[] =3D {
+	0x81, 0x03, 0x01, 0x20, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test play_tone_response_data_311b =
=3D {
+	.pdu =3D play_tone_response_311b,
+	.pdu_len =3D sizeof(play_tone_response_311b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_PLAY_TONE,
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
@@ -11820,6 +11900,19 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Play Tone 6.1.3",
 				&play_tone_data_613, test_play_tone);
 =

+	g_test_add_data_func("/teststk/Play Tone response 1.1.1",
+				&play_tone_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Play Tone response 1.1.9B",
+				&play_tone_response_data_119b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Play Tone response 1.1.14",
+				&play_tone_response_data_1114,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Play Tone response 3.1.1B",
+				&play_tone_response_data_311b,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Poll Interval 1.1.1",
 				&poll_interval_data_111, test_poll_interval);
 =

-- =

1.7.1.86.g0e460.dirty


--===============6772782532604762704==--

