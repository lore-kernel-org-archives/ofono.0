Content-Type: multipart/mixed; boundary="===============2153628345631008852=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 10/10] test-stkutil: add html_attr_test for special chars
Date: Thu, 01 Jul 2010 08:31:25 -0700
Message-ID: <1277998285-30207-11-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277998285-30207-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2153628345631008852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 74e2ec2..c2e1327 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -22383,6 +22383,16 @@ static struct html_attr_test html_attr_data_3 =3D {
 		"#FFFFFF;\">bc</span>",
 };
 =

+static struct html_attr_test html_attr_data_4 =3D {
+	.text =3D "1 < 2, 2 > 1, 1 & 0 =3D=3D 0\nSpecial Chars are Fun\r\nTo Writ=
e",
+	.text_attr =3D {
+		.len =3D 4,
+		.attributes =3D { 0x00, 0x00, 0x00 },
+	},
+	.html =3D "1 &lt; 2, 2 &gt; 1, 1 &amp; 0 =3D=3D 0<br/>Special Chars are F=
un"
+		"<br/>To Write",
+};
+
 static void test_html_attr(gconstpointer data)
 {
 	const struct html_attr_test *test =3D data;
@@ -24420,6 +24430,8 @@ int main(int argc, char **argv)
 				&html_attr_data_2, test_html_attr);
 	g_test_add_data_func("/teststk/HTML Attribute Test 3",
 				&html_attr_data_3, test_html_attr);
+	g_test_add_data_func("/teststk/HTML Attribute Test 4",
+				&html_attr_data_4, test_html_attr);
 =

 	return g_test_run();
 }
-- =

1.6.6.1


--===============2153628345631008852==--

