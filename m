Content-Type: multipart/mixed; boundary="===============8174862852353696462=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/20] test-stkutil: Add a Polling Off response test
Date: Thu, 27 May 2010 06:59:43 +0200
Message-ID: <1274936399-20710-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1274936399-20710-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8174862852353696462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 34fc63e..35301f3 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -16184,6 +16184,26 @@ static const struct terminal_response_test set_up_=
call_response_data_311b =3D {
 	},
 };
 =

+static const unsigned char polling_off_response_112[] =3D {
+	0x81, 0x03, 0x01, 0x04, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test polling_off_response_data_112 =
=3D {
+	.pdu =3D polling_off_response_112,
+	.pdu_len =3D sizeof(polling_off_response_112),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_POLLING_OFF,
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
@@ -17207,6 +17227,10 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Polling off 1.1.2",
 				&polling_off_data_112, test_polling_off);
 =

+	g_test_add_data_func("/teststk/Polling off response 1.1.2",
+				&polling_off_response_data_112,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Provide Local Info 1.2.1",
 			&provide_local_info_data_121, test_provide_local_info);
 	g_test_add_data_func("/teststk/Provide Local Info 1.4.1",
-- =

1.7.1.86.g0e460.dirty


--===============8174862852353696462==--

