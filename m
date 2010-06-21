Content-Type: multipart/mixed; boundary="===============2467193194659418393=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] test-stkutil: add html formatted text tests
Date: Mon, 21 Jun 2010 06:06:42 -0700
Message-ID: <1277125602-3996-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1277125602-3996-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2467193194659418393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  257 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 257 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index c586a7b..21fd02d 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -28,6 +28,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdint.h>
+#include <fcntl.h>
+
+#include <sys/stat.h>
 =

 #include <glib.h>
 #include <glib/gprintf.h>
@@ -508,6 +511,7 @@ struct display_text_test {
 	struct stk_duration duration;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	const char *test_name;
 };
 =

 unsigned char display_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x03, 0x01, 0x21,=
 0x80,
@@ -603,6 +607,69 @@ unsigned char display_text_711[] =3D { 0xD0, 0x19, 0x8=
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
@@ -708,6 +775,114 @@ static struct display_text_test display_text_data_711=
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
+	.test_name =3D "811.html",
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
+	.test_name =3D "821.html",
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
+	.test_name =3D "831.html",
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
+	.test_name =3D "841.html",
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
+	.test_name =3D "851.html",
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
+	.test_name =3D "861.html",
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
+	.test_name =3D "871.html",
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
+	.test_name =3D "881.html",
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
+	.test_name =3D "891.html",
+};
+
 static struct display_text_test display_text_data_911 =3D {
 	.pdu =3D display_text_911,
 	.pdu_len =3D sizeof(display_text_911),
@@ -722,6 +897,58 @@ static struct display_text_test display_text_data_1011=
 =3D {
 	.text =3D "80=E3=83=AB"
 };
 =

+static void do_html_test(char *text, int text_len, const unsigned char *at=
trs,
+				int attrs_len, const char *filename)
+{
+	int fd;
+	char html_header[] =3D "<html><body>";
+	char html_close[] =3D "</body></html>";
+	char *html;
+	ssize_t bytes_written;
+
+	if (filename =3D=3D NULL)
+		return;
+
+	/* open output file */
+	fd =3D open(filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR |
+				S_IRGRP | S_IROTH);
+	if (fd < 0) {
+		g_print("unable to open %s\n", filename);
+		return;
+	}
+
+	bytes_written =3D write(fd, html_header, strlen(html_header));
+	html =3D stk_text_to_html(text, text_len, attrs, attrs_len);
+	bytes_written =3D write(fd, html, strlen(html));
+	bytes_written =3D write(fd, html_close, strlen(html_close));
+	close(fd);
+	g_free(html);
+}
+
+static void test_html1(gconstpointer data)
+{
+	char html_test[] =3D "EMS messages can contain italic, bold,"
+				" large, small and colored text";
+	const unsigned char attrs[] =3D {	0x19, 0x06, 0x20, 0x00,
+					0x21, 0x04, 0x10, 0x00,
+					0x27, 0x05, 0x04, 0x00,
+					0x2E, 0x05, 0x08, 0x00,
+					0x38, 0x07, 0x00, 0x2B };
+	const char filename[] =3D "html1.html";
+
+	do_html_test(html_test, strlen(html_test), attrs, 20, filename);
+}
+
+static void test_html2(gconstpointer data)
+{
+	char html_test[] =3D "Blue green green green";
+	const unsigned char attrs[] =3D {	0x00, 0x00, 0x00, 0x94,
+					0x00, 0x04, 0x00, 0x96 };
+	const char filename[] =3D "html2.html";
+
+	do_html_test(html_test, strlen(html_test), attrs, 8, filename);
+}
+
 /* Defined in TS 102.384 Section 27.22.4.1 */
 static void test_display_text(gconstpointer data)
 {
@@ -747,6 +974,14 @@ static void test_display_text(gconstpointer data)
 	check_duration(&command->display_text.duration, &test->duration);
 	check_text_attr(&command->display_text.text_attr,
 						&test->text_attr);
+
+	if (command->display_text.text_attr.len > 0)
+		do_html_test(command->display_text.text,
+				strlen(command->display_text.text),
+				command->display_text.text_attr.attributes,
+				command->display_text.text_attr.len,
+				test->test_name);
+
 	check_frame_id(&command->display_text.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
@@ -21913,6 +22148,28 @@ int main(int argc, char **argv)
 				&display_text_data_611, test_display_text);
 	g_test_add_data_func("/teststk/Display Text 7.1.1",
 				&display_text_data_711, test_display_text);
+	g_test_add_data_func("/teststk/HTML test 1",
+				NULL, test_html1);
+	g_test_add_data_func("/teststk/HTML test 2",
+				NULL, test_html2);
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


--===============2467193194659418393==--

