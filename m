Content-Type: multipart/mixed; boundary="===============5446646656977863844=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 19/27] test-stkutil: Add Set Up Menu response tests.
Date: Sun, 16 May 2010 16:07:00 +0200
Message-ID: <1274018820-6872-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5446646656977863844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 953cb03..ed18bbf 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -11716,6 +11716,66 @@ static const struct terminal_response_test refresh=
_response_data_312 =3D {
 	},
 };
 =

+static const unsigned char set_up_menu_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x25, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_menu_response_data_111 =
=3D {
+	.pdu =3D set_up_menu_response_111,
+	.pdu_len =3D sizeof(set_up_menu_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_MENU,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
+static const unsigned char set_up_menu_response_411b[] =3D {
+	0x81, 0x03, 0x01, 0x25, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x04,
+};
+
+static const struct terminal_response_test set_up_menu_response_data_411b =
=3D {
+	.pdu =3D set_up_menu_response_411b,
+	.pdu_len =3D sizeof(set_up_menu_response_411b),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_MENU,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_NO_ICON,
+		},
+	},
+};
+
+static const unsigned char set_up_menu_response_511[] =3D {
+	0x81, 0x03, 0x01, 0x25, 0x01, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test set_up_menu_response_data_511 =
=3D {
+	.pdu =3D set_up_menu_response_511,
+	.pdu_len =3D sizeof(set_up_menu_response_511),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_MENU,
+		.qualifier =3D 0x01, /* Soft key selection preferred */
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
@@ -12318,6 +12378,16 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Menu 9.1.3",
 				&setup_menu_data_913, test_setup_menu);
 =

+	g_test_add_data_func("/teststk/Set Up Menu response 1.1.1",
+				&set_up_menu_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Menu response 4.1.1B",
+				&set_up_menu_response_data_411b,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Set Up Menu response 5.1.1",
+				&set_up_menu_response_data_511,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Select Item 1.1.1",
 				&select_item_data_111, test_select_item);
 	g_test_add_data_func("/teststk/Select Item 1.2.1",
-- =

1.7.1.86.g0e460.dirty


--===============5446646656977863844==--

