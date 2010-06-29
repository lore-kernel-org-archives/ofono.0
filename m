Content-Type: multipart/mixed; boundary="===============5054922679342136345=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3] test-stkutil: add unit test for html text attributes
Date: Tue, 29 Jun 2010 04:22:13 -0700
Message-ID: <1277810534-25450-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277810534-25450-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5054922679342136345==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8b7e254..57e894b 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -472,6 +472,22 @@ static inline void check_cdma_sms_tpdu(
 	check_common_byte_array(command, test);
 }
 =

+static void check_text_attr_html(const struct stk_text_attribute *test,
+				char *text, const char *expected_html)
+{
+	char *html;
+
+	if (expected_html =3D=3D NULL)
+		return;
+
+	html =3D stk_text_to_html(text, strlen(text), test->attributes,
+				test->len);
+
+	g_assert(memcmp(html, expected_html, strlen(expected_html)) =3D=3D 0);
+
+	g_free(html);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static void check_text_attr(const struct stk_text_attribute *command,
 					const struct stk_text_attribute *test)
@@ -21923,6 +21939,59 @@ static const struct envelope_test timer_expiration=
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
+static void test_html_attr(gconstpointer data)
+{
+	const struct html_attr_test *test =3D data;
+	check_text_attr_html(&test->text_attr, test->text, test->html);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -23930,5 +23999,12 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Timer Expiration 2.2.1A",
 			&timer_expiration_data_221a, test_envelope_encoding);
 =

+	g_test_add_data_func("/teststk/HTML Attribute Test 1",
+				&html_attr_data_1, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 2",
+				&html_attr_data_2, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 3",
+				&html_attr_data_3, test_html_attr);
+
 	return g_test_run();
 }
-- =

1.6.6.1


--===============5054922679342136345==--

