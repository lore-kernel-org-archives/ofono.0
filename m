Content-Type: multipart/mixed; boundary="===============2114000850473267313=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] test-stkutil: add html attribute test for Display Text
 tests
Date: Tue, 29 Jun 2010 04:22:14 -0700
Message-ID: <1277810534-25450-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277810534-25450-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2114000850473267313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  204 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 204 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 57e894b..bc0e018 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -524,6 +524,7 @@ struct display_text_test {
 	struct stk_duration duration;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	const char *html;
 };
 =

 unsigned char display_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, 0x21,=
 0x80,
@@ -619,6 +620,69 @@ unsigned char display_text_711[] =3D { 0xD0, 0x19, 0x8=
1, 0x03, 0x01, 0x21, 0x80,
 					0x63, 0x6F, 0x6E, 0x64, 0x84, 0x02,
 					0x01, 0x0A };
 =

+unsigned char display_text_811[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x00, 0xB4 };
+
+unsigned char display_text_821[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x01, 0xB4 };
+
+unsigned char display_text_831[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x02, 0xB4 };
+
+unsigned char display_text_841[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x04, 0xB4 };
+
+unsigned char display_text_851[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x08, 0xB4 };
+
+unsigned char display_text_861[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x10, 0xB4 };
+
+unsigned char display_text_871[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x20, 0xB4 };
+
+unsigned char display_text_881[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x40, 0xB4 };
+
+unsigned char display_text_891[] =3D { 0xD0, 0x22, 0x81, 0x03, 0x01, 0x21,=
 0x80,
+					0x82, 0x02, 0x81, 0x02, 0x8D, 0x11,
+					0x04, 0x54, 0x65, 0x78, 0x74, 0x20,
+					0x41, 0x74, 0x74, 0x72, 0x69, 0x62,
+					0x75, 0x74, 0x65, 0x20, 0x31, 0xD0,
+					0x04, 0x00, 0x10, 0x80, 0xB4 };
+
 unsigned char display_text_911[] =3D { 0xD0, 0x10, 0x81, 0x03, 0x01, 0x21,=
 0x80,
 					0x82, 0x02, 0x81, 0x02, 0x8D, 0x05,
 					0x08, 0x4F, 0x60, 0x59, 0x7D };
@@ -724,6 +788,125 @@ static struct display_text_test display_text_data_711=
 =3D {
 	}
 };
 =

+static struct display_text_test display_text_data_811 =3D {
+	.pdu =3D display_text_811,
+	.pdu_len =3D sizeof(display_text_811),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x00, 0xB4 },
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFF00;\">"
+		"Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_821 =3D {
+	.pdu =3D display_text_821,
+	.pdu_len =3D sizeof(display_text_821),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x01, 0xB4 },
+	},
+	.html =3D "<div style=3D\"text-align: center;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>"
+		"</div>",
+};
+
+static struct display_text_test display_text_data_831 =3D {
+	.pdu =3D display_text_831,
+	.pdu_len =3D sizeof(display_text_831),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x02, 0xB4 },
+	},
+	.html =3D "<div style=3D\"text-align: right;\"><span style=3D\"color: "
+		"#347235;background-color: #FFFF00;\">Text Attribute 1</span>"
+		"</div>",
+};
+
+static struct display_text_test display_text_data_841 =3D {
+	.pdu =3D display_text_841,
+	.pdu_len =3D sizeof(display_text_841),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x04, 0xB4 },
+	},
+	.html =3D "<span style=3D\"font-size: big;color: #347235;background-color=
:"
+		" #FFFF00;\">Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_851 =3D {
+	.pdu =3D display_text_851,
+	.pdu_len =3D sizeof(display_text_851),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x08, 0xB4 },
+	},
+	.html =3D "<span style=3D\"font-size: small;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_861 =3D {
+	.pdu =3D display_text_861,
+	.pdu_len =3D sizeof(display_text_861),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x10, 0xB4 },
+	},
+	.html =3D "<span style=3D\"font-weight: bold;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_871 =3D {
+	.pdu =3D display_text_871,
+	.pdu_len =3D sizeof(display_text_871),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x20, 0xB4 },
+	},
+	.html =3D "<span style=3D\"font-style: italic;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_881 =3D {
+	.pdu =3D display_text_881,
+	.pdu_len =3D sizeof(display_text_881),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x40, 0xB4 },
+	},
+	.html =3D "<span style=3D\"text-decoration: underline;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span>",
+};
+
+static struct display_text_test display_text_data_891 =3D {
+	.pdu =3D display_text_891,
+	.pdu_len =3D sizeof(display_text_891),
+	.qualifier =3D 0x80,
+	.text =3D "Text Attribute 1",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x10, 0x80, 0xB4 },
+	},
+	.html =3D "<span style=3D\"text-decoration: line-through;color: #347235;"
+		"background-color: #FFFF00;\">Text Attribute 1</span>",
+};
+
 static struct display_text_test display_text_data_911 =3D {
 	.pdu =3D display_text_911,
 	.pdu_len =3D sizeof(display_text_911),
@@ -764,6 +947,9 @@ static void test_display_text(gconstpointer data)
 	check_duration(&command->display_text.duration, &test->duration);
 	check_text_attr(&command->display_text.text_attr,
 						&test->text_attr);
+	check_text_attr_html(&command->display_text.text_attr,
+				command->display_text.text,
+				test->html);
 	check_frame_id(&command->display_text.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
@@ -22018,6 +22204,24 @@ int main(int argc, char **argv)
 				&display_text_data_611, test_display_text);
 	g_test_add_data_func("/teststk/Display Text 7.1.1",
 				&display_text_data_711, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.1.1",
+				&display_text_data_811, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.2.1",
+				&display_text_data_821, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.3.1",
+				&display_text_data_831, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.4.1",
+				&display_text_data_841, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.5.1",
+				&display_text_data_851, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.6.1",
+				&display_text_data_861, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.7.1",
+				&display_text_data_871, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.8.1",
+				&display_text_data_881, test_display_text);
+	g_test_add_data_func("/teststk/Display Text 8.9.1",
+				&display_text_data_891, test_display_text);
 	g_test_add_data_func("/teststk/Display Text 9.1.1",
 				&display_text_data_911, test_display_text);
 	g_test_add_data_func("/teststk/Display Text 10.1.1",
-- =

1.6.6.1


--===============2114000850473267313==--

