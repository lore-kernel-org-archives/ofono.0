Content-Type: multipart/mixed; boundary="===============0526670338828373060=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 14/16] test-stkutil: Add Language Notification response tests.
Date: Sun, 23 May 2010 12:16:46 +0200
Message-ID: <1274609806-7216-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0526670338828373060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 744efda..2065646 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13800,6 +13800,48 @@ static const struct terminal_response_test send_dt=
mf_response_data_211b =3D {
 	},
 };
 =

+static const unsigned char language_notification_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x35, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test
+		language_notification_response_data_111 =3D {
+	.pdu =3D language_notification_response_111,
+	.pdu_len =3D sizeof(language_notification_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION,
+		.qualifier =3D 0x01,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char language_notification_response_121[] =3D {
+	0x81, 0x03, 0x01, 0x35, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test
+		language_notification_response_data_121 =3D {
+	.pdu =3D language_notification_response_121,
+	.pdu_len =3D sizeof(language_notification_response_121),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -15047,5 +15089,12 @@ int main(int argc, char **argv)
 			&send_dtmf_response_data_211b,
 			test_terminal_response_encoding);
 =

+	g_test_add_data_func("/teststk/Language Notification response 1.1.1",
+			&language_notification_response_data_111,
+			test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Language Notification response 1.2.1",
+			&language_notification_response_data_121,
+			test_terminal_response_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============0526670338828373060==--

