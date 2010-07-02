Content-Type: multipart/mixed; boundary="===============6730920420597858451=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/9] test-stkutil: add unit test for html text attributes
Date: Fri, 02 Jul 2010 06:46:01 -0700
Message-ID: <1278078368-32565-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1278078368-32565-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6730920420597858451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 0b95265..5d1c5f1 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -478,6 +478,29 @@ static inline void check_cdma_sms_tpdu(
 	check_common_byte_array(command, test);
 }
 =

+static void check_text_attr_html(const struct stk_text_attribute *test,
+				char *text, const char *expected_html)
+{
+	char *html;
+	unsigned short attrs[256];
+	int i;
+
+	if (expected_html =3D=3D NULL)
+		return;
+
+	for (i =3D 0; i < test->len; i +=3D 4) {
+		attrs[i] =3D test->attributes[i];
+		attrs[i + 1] =3D test->attributes[i + 1];
+		attrs[i + 2] =3D test->attributes[i + 2];
+		attrs[i + 3] =3D test->attributes[i + 3];
+	}
+	html =3D stk_text_to_html(text, attrs, test->len / 4);
+
+	g_assert(memcmp(html, expected_html, strlen(expected_html)) =3D=3D 0);
+
+	g_free(html);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static void check_text_attr(const struct stk_text_attribute *command,
 					const struct stk_text_attribute *test)
@@ -22129,6 +22152,87 @@ static const struct envelope_test timer_expiration=
_data_221a =3D {
 	},
 };
 =

+struct html_attr_test {
+	char *text;
+	struct stk_text_attribute text_attr;
+	char *html;
+};
+
+static struct html_attr_test html_attr_data_1 =3D {
+	.text =3D "EMS messages can contain italic, bold, large, small and "
+		"colored text",
+	.text_attr =3D {
+		.len =3D 20,
+		.attributes =3D { 0x19, 0x06, 0x20, 0x00, 0x21, 0x04, 0x10, 0x00,
+				0x27, 0x05, 0x04, 0x00, 0x2E, 0x05, 0x08, 0x00,
+				0x38, 0x07, 0x00, 0x2B },
+	},
+	.html =3D "EMS messages can contain <span style=3D\"font-style: "
+		"italic;\">italic</span>, <span style=3D\"font-weight: bold;\">"
+		"bold</span>, <span style=3D\"font-size: big;\">large</span>, "
+		"<span style=3D\"font-size: small;\">small</span> and "
+		"<span style=3D\"color: #FFFF00;background-color: #C11B17;\">"
+		"colored</span> text",
+};
+
+static struct html_attr_test html_attr_data_2 =3D {
+	.text =3D "Blue green green green",
+	.text_attr =3D {
+		.len =3D 8,
+		.attributes =3D {	0x00, 0x00, 0x00, 0x94, 0x00, 0x04, 0x00,
+				0x96 },
+	},
+	.html =3D "<span style=3D\"color: #0000A0;background-color: #FFFFFF;\">"
+		"Blue</span><span style=3D\"color: #347235;background-color: "
+		"#FFFFFF;\"> green green green</span>",
+};
+
+static struct html_attr_test html_attr_data_3 =3D {
+	.text =3D "abc",
+	.text_attr =3D {
+		.len =3D 8,
+		.attributes =3D { 0x00, 0x02, 0x00, 0x94, 0x01, 0x02, 0x00,
+				0x96 },
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFFFF;\">"
+		"a</span><span style=3D\"color: #0000A0;background-color: "
+		"#FFFFFF;\">bc</span>",
+};
+
+static struct html_attr_test html_attr_data_4 =3D {
+	.text =3D "1 < 2, 2 > 1, 1 & 0 =3D=3D 0\nSpecial Chars are Fun\r\nTo Writ=
e",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x00, 0x00, 0x00 },
+	},
+	.html =3D "1 &lt; 2, 2 &gt; 1, 1 &amp; 0 =3D=3D 0<br/>Special Chars are F=
un"
+		"<br/>To Write",
+};
+
+static struct html_attr_test html_attr_data_5 =3D {
+	.text =3D "=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x00, 0x00, 0x94 },
+	},
+	.html =3D "<span style=3D\"color: #347235;background-color: #FFFFFF;\">"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=
=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=
=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC"
+		"=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=
=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC=E2=82=AC</span>",
+};
+
+static void test_html_attr(gconstpointer data)
+{
+	const struct html_attr_test *test =3D data;
+	check_text_attr_html(&test->text_attr, test->text, test->html);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -24136,5 +24240,16 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Timer Expiration 2.2.1A",
 			&timer_expiration_data_221a, test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/HTML Attribute Test 1",
+				&html_attr_data_1, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 2",
+				&html_attr_data_2, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 3",
+				&html_attr_data_3, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 4",
+				&html_attr_data_4, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 5",
+				&html_attr_data_5, test_html_attr);
+
 	return g_test_run();
 }
-- =

1.6.6.1


--===============6730920420597858451==--

