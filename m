Content-Type: multipart/mixed; boundary="===============0372189997653645014=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] test-stkutil: add html attribute display tests
Date: Thu, 24 Jun 2010 07:00:32 -0700
Message-ID: <1277388032-13901-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277388032-13901-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0372189997653645014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 8b7e254..3c0ac78 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -21923,6 +21923,63 @@ static const struct envelope_test timer_expiration=
_data_221a =3D {
 	},
 };
 =

+struct html_attr_test {
+	char *text;
+	const unsigned char *attrs;
+	unsigned int attrs_len;
+	char *output;
+};
+
+unsigned char html_attr_1[] =3D { 0x19, 0x06, 0x20, 0x00, 0x21, 0x04, 0x10=
, 0x00,
+				0x27, 0x05, 0x04, 0x00, 0x2E, 0x05, 0x08, 0x00,
+				0x38, 0x07, 0x00, 0x2B };
+
+unsigned char html_attr_2[] =3D {	0x00, 0x00, 0x00, 0x94, 0x00, 0x04, 0x00=
, 0x96 };
+
+unsigned char html_attr_3[] =3D { 0x00, 0x02, 0x00, 0x94, 0x01, 0x02, 0x00=
, 0x96 };
+
+static struct html_attr_test html_attr_data_1 =3D {
+	.text =3D "EMS messages can contain italic, bold, large, small and "
+		"colored text",
+	.attrs =3D html_attr_1,
+	.attrs_len =3D sizeof(html_attr_1),
+	.output =3D "EMS messages can contain <span style=3D\"font-style: italic;=
\">"
+		"italic</span>, <span style=3D\"font-weight: bold;\">bold</span>, "
+		"<span style=3D\"font-size: big;\">large</span>, "
+		"<span style=3D\"font-size: small;\">small</span> and "
+		"<span style=3D\"color: #FFFF00;background-color: #C11B17;\">colored"
+		"</span> text",
+};
+
+static struct html_attr_test html_attr_data_2 =3D {
+	.text =3D "Blue green green green",
+	.attrs =3D html_attr_2,
+	.attrs_len =3D sizeof(html_attr_2),
+	.output =3D "<span style=3D\"color: #0000A0;background-color: #FFFFFF;\">=
Blue"
+		"</span><span style=3D\"color: #347235;background-color: #FFFFFF;\">"
+		" green green green</span>",
+};
+
+static struct html_attr_test html_attr_data_3 =3D {
+	.text =3D "abc",
+	.attrs =3D html_attr_3,
+	.attrs_len =3D sizeof(html_attr_3),
+	.output =3D "<span style=3D\"color: #347235;background-color: #FFFFFF;\">"
+		"a</span><span style=3D\"color: #0000A0;background-color: #FFFFFF;\""
+		">bc</span>",
+};
+
+static void test_html_attr(gconstpointer data)
+{
+	const struct html_attr_test *test =3D data;
+	char *html;
+
+	html =3D stk_text_to_html(test->text, strlen(test->text), test->attrs,
+					test->attrs_len);
+	g_assert(memcmp(html, test->output, strlen(test->output)) =3D=3D 0);
+	g_free(html);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -23930,5 +23987,12 @@ int main(int argc, char **argv)
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


--===============0372189997653645014==--

