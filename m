Content-Type: multipart/mixed; boundary="===============0125363571447190654=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/27] test-stkutil: Add Poll Interval response tests.
Date: Sun, 16 May 2010 16:06:26 +0200
Message-ID: <1274018786-6744-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0125363571447190654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index afe002e..1304714 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -11392,6 +11392,66 @@ static const struct terminal_response_test play_to=
ne_response_data_311b =3D {
 	},
 };
 =

+/* TS 102 384 */
+static const unsigned char poll_interval_response_111[] =3D {
+	0x81, 0x03, 0x01, 0x03, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x84, 0x02, 0x01, 0x14,
+};
+
+static const struct terminal_response_test poll_interval_response_data_111=
 =3D {
+	.pdu =3D poll_interval_response_111,
+	.pdu_len =3D sizeof(poll_interval_response_111),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_POLL_INTERVAL,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .poll_interval =3D {
+			.max_interval =3D {
+				.unit =3D STK_DURATION_TYPE_SECONDS,
+				.interval =3D 20,
+			},
+		}},
+	},
+};
+
+/* 3GPP TS 31.124 */
+static const unsigned char poll_interval_response_111a[] =3D {
+	0x81, 0x03, 0x01, 0x03, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x84, 0x02, 0x00, 0x01,
+};
+
+static const unsigned char poll_interval_response_111b[] =3D {
+	0x81, 0x03, 0x01, 0x03, 0x00, 0x82, 0x02, 0x82,
+	0x81, 0x83, 0x01, 0x00, 0x84, 0x02, 0x01, 0x3c,
+};
+
+static const struct terminal_response_test poll_interval_response_data_111=
a =3D {
+	/* Either poll_interval_response_111a or b is ok */
+	.pdu =3D poll_interval_response_111a,
+	.pdu_len =3D sizeof(poll_interval_response_111a),
+	.response =3D {
+		.number =3D 1,
+		.type =3D STK_COMMAND_TYPE_POLL_INTERVAL,
+		.qualifier =3D 0x00,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_TERMINAL,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		.result =3D {
+			.type =3D STK_RESULT_TYPE_SUCCESS,
+		},
+		{ .poll_interval =3D {
+			.max_interval =3D {
+				.unit =3D STK_DURATION_TYPE_MINUTES,
+				.interval =3D 1,
+			},
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -11916,6 +11976,13 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Poll Interval 1.1.1",
 				&poll_interval_data_111, test_poll_interval);
 =

+	g_test_add_data_func("/teststk/Poll Interval response 1.1.1",
+				&poll_interval_response_data_111,
+				test_terminal_response_encoding);
+	g_test_add_data_func("/teststk/Poll Interval response 1.1.1A",
+				&poll_interval_response_data_111a,
+				test_terminal_response_encoding);
+
 	g_test_add_data_func("/teststk/Setup Menu 1.1.1",
 				&setup_menu_data_111, test_setup_menu);
 	g_test_add_data_func("/teststk/Setup Menu 1.1.2",
-- =

1.7.1.86.g0e460.dirty


--===============0125363571447190654==--

