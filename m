Content-Type: multipart/mixed; boundary="===============6496480939913002710=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] test-stkutil: Add a More Time response builder test
Date: Thu, 17 Jun 2010 15:42:10 +0200
Message-ID: <1276782135-26871-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276782135-26871-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6496480939913002710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 0c38dab..31dc41e 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -16179,6 +16179,26 @@ static const struct terminal_response_test get_inp=
ut_response_data_1221 =3D {
 	},
 };
 =

+static const unsigned char more_time_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x02, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00,
+};
+
+static const struct terminal_response_test more_time_response_data_111 =3D=
 {
+	.pdu =3D more_time_response_111,
+	.pdu_len =3D sizeof(more_time_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_MORE_TIME,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+	},
+};
+
 static const unsigned char send_sms_response_111[] =3D {
 	0x81, 0x03, 0x01, 0x13, 0x00, 0x82, 0x02, 0x82,
 	0x81, 0x83, 0x01, 0x00,
@@ -21027,6 +21047,10 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/More Time 1.1.1",
 				&more_time_data_111, test_more_time);
 =

+	g_test_add_data_func("/teststk/More Time response 1.1.1",
+				&more_time_response_data_111,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Play Tone 1.1.1",
 				&play_tone_data_111, test_play_tone);
 	g_test_add_data_func("/teststk/Play Tone 1.1.2",
-- =

1.7.1.86.g0e460.dirty


--===============6496480939913002710==--

