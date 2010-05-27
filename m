Content-Type: multipart/mixed; boundary="===============8852227761240954809=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/20] test-stkutil: Add a Set Up Event List response test
Date: Thu, 27 May 2010 06:59:47 +0200
Message-ID: <1274936399-20710-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8852227761240954809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 45f47d1..8256f4e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -16707,6 +16707,27 @@ static const struct terminal_response_test
 	},
 };
 =

+static const unsigned char set_up_event_list_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x05, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test
+		set_up_event_list_response_data_111 =3D {
+	.pdu =3D set_up_event_list_response_111,
+	.pdu_len =3D sizeof(set_up_event_list_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_SETUP_EVENT_LIST,
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
@@ -17812,6 +17833,10 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Event List 1.4.1",
 			&setup_event_list_data_141, test_setup_event_list);
 =

+	g_test_add_data_func("/teststk/Set Up Event List response 1.1.1",
+			&set_up_event_list_response_data_111,
+			test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Perform Card APDU 1.1.1",
 			&perform_card_apdu_data_111, test_perform_card_apdu);
 	g_test_add_data_func("/teststk/Perform Card APDU 1.1.2",
-- =

1.7.1.86.g0e460.dirty


--===============8852227761240954809==--

