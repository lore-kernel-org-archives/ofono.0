Content-Type: multipart/mixed; boundary="===============0067285483578750376=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/11] test-stkutil: Tests for the Menu Selection envelope
 builder
Date: Mon, 31 May 2010 14:47:20 +0200
Message-ID: <1275310044-27469-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1275310044-27469-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0067285483578750376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 162 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 5410334..4a822ef 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -18066,6 +18066,151 @@ static const struct envelope_test cbs_pp_data_dow=
nload_data_17 =3D {
 	},
 };
 =

+static const unsigned char menu_selection_111[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x02,
+};
+
+static const struct envelope_test menu_selection_data_111 =3D {
+	.pdu =3D menu_selection_111,
+	.pdu_len =3D sizeof(menu_selection_111),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x2,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_112[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x12,
+};
+
+static const struct envelope_test menu_selection_data_112 =3D {
+	.pdu =3D menu_selection_112,
+	.pdu_len =3D sizeof(menu_selection_112),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x12,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_121[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x3d,
+};
+
+static const struct envelope_test menu_selection_data_121 =3D {
+	.pdu =3D menu_selection_121,
+	.pdu_len =3D sizeof(menu_selection_121),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x3d,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_122[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0xfb,
+};
+
+static const struct envelope_test menu_selection_data_122 =3D {
+	.pdu =3D menu_selection_122,
+	.pdu_len =3D sizeof(menu_selection_122),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0xfb,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_123[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x01,
+};
+
+static const struct envelope_test menu_selection_data_123 =3D {
+	.pdu =3D menu_selection_123,
+	.pdu_len =3D sizeof(menu_selection_123),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x1,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_211[] =3D {
+	0xd3, 0x09, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x02, 0x15, 0x00,
+};
+
+static const struct envelope_test menu_selection_data_211 =3D {
+	.pdu =3D menu_selection_211,
+	.pdu_len =3D sizeof(menu_selection_211),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x2,
+			.help_request =3D TRUE,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_612[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x05,
+};
+
+static const struct envelope_test menu_selection_data_612 =3D {
+	.pdu =3D menu_selection_612,
+	.pdu_len =3D sizeof(menu_selection_612),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x5,
+		}},
+	},
+};
+
+static const unsigned char menu_selection_641[] =3D {
+	0xd3, 0x07, 0x82, 0x02, 0x01, 0x81, 0x90, 0x01,
+	0x08,
+};
+
+static const struct envelope_test menu_selection_data_641 =3D {
+	.pdu =3D menu_selection_641,
+	.pdu_len =3D sizeof(menu_selection_641),
+	.envelope =3D {
+		.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION,
+		.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		.dst =3D STK_DEVICE_IDENTITY_TYPE_UICC,
+		{ .menu_selection =3D {
+			.item_id =3D 0x8,
+		}},
+	},
+};
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -19742,5 +19887,22 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/CBS-PP data download 1.7",
 			&cbs_pp_data_download_data_17, test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/Menu Selection 1.1.1",
+			&menu_selection_data_111, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 1.1.2",
+			&menu_selection_data_112, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 1.2.1",
+			&menu_selection_data_121, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 1.2.2",
+			&menu_selection_data_122, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 1.2.3",
+			&menu_selection_data_123, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 2.1.1",
+			&menu_selection_data_211, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 6.1.2",
+			&menu_selection_data_612, test_envelope_encoding);
+	g_test_add_data_func("/teststk/Menu Selection 6.4.1",
+			&menu_selection_data_641, test_envelope_encoding);
+
 	return g_test_run();
 }
-- =

1.7.1.86.g0e460.dirty


--===============0067285483578750376==--

