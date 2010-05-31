Content-Type: multipart/mixed; boundary="===============6244699720569934868=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/2] stktest: Add negative cases for setup menu
Date: Mon, 31 May 2010 19:13:22 +0800
Message-ID: <1275304402-23708-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1275304402-23708-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6244699720569934868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 7793f3a..b4a5618 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -4893,6 +4893,31 @@ static unsigned char setup_menu_913[] =3D { 0xD0, 0x=
0D, 0x81, 0x03, 0x01, 0x25,
 						0x00, 0x82, 0x02, 0x81, 0x82,
 						0x85, 0x00, 0x8F, 0x00 };
 =

+/* Negative case: No item is present */
+static unsigned char setup_menu_neg_1[] =3D { 0xD0, 0x0B, 0x81, 0x03, 0x01=
, 0x25,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0x85, 0x00 };
+
+/* Negative case: Two empty items*/
+static unsigned char setup_menu_neg_2[] =3D { 0xD0, 0x0F, 0x81, 0x03, 0x01=
, 0x25,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0x85, 0x00, 0x8F, 0x00, 0x8F,
+						0x00 };
+
+/* Negative case: valid item + empty item */
+static unsigned char setup_menu_neg_3[] =3D { 0xD0, 0x16, 0x81, 0x03, 0x01=
, 0x25,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0x85, 0x00, 0x8F, 0x07, 0x01,
+						0x49, 0x74, 0x65, 0x6D, 0x20,
+						0x31, 0x8F, 0x00 };
+
+/* Negative case: empty item + valid item */
+static unsigned char setup_menu_neg_4[] =3D { 0xD0, 0x16, 0x81, 0x03, 0x01=
, 0x25,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0x85, 0x00, 0x8F, 0x00, 0x8F,
+						0x07, 0x01, 0x49, 0x74, 0x65,
+						0x6D, 0x20, 0x31 };
+
 static struct setup_menu_test setup_menu_data_111 =3D {
 	.pdu =3D setup_menu_111,
 	.pdu_len =3D sizeof(setup_menu_111),
@@ -5451,6 +5476,26 @@ static struct setup_menu_test setup_menu_data_913 =
=3D {
 	.qualifier =3D 0x00
 };
 =

+static struct setup_menu_test setup_menu_data_neg_1 =3D {
+	.pdu =3D setup_menu_neg_1,
+	.pdu_len =3D sizeof(setup_menu_neg_1)
+};
+
+static struct setup_menu_test setup_menu_data_neg_2 =3D {
+	.pdu =3D setup_menu_neg_2,
+	.pdu_len =3D sizeof(setup_menu_neg_2)
+};
+
+static struct setup_menu_test setup_menu_data_neg_3 =3D {
+	.pdu =3D setup_menu_neg_3,
+	.pdu_len =3D sizeof(setup_menu_neg_3)
+};
+
+static struct setup_menu_test setup_menu_data_neg_4 =3D {
+	.pdu =3D setup_menu_neg_4,
+	.pdu_len =3D sizeof(setup_menu_neg_4)
+};
+
 /* Defined in TS 102.384 Section 27.22.4.7 */
 static void test_setup_menu(gconstpointer data)
 {
@@ -5484,6 +5529,16 @@ static void test_setup_menu(gconstpointer data)
 	stk_command_free(command);
 }
 =

+static void test_setup_menu_neg(gconstpointer data)
+{
+	const struct setup_menu_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(!command);
+}
+
 struct select_item_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -16558,6 +16613,15 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Menu 9.1.3",
 				&setup_menu_data_913, test_setup_menu);
 =

+	g_test_add_data_func("/teststk/Setup Menu Negative 1",
+			&setup_menu_data_neg_1, test_setup_menu_neg);
+	g_test_add_data_func("/teststk/Setup Menu Negative 2",
+			&setup_menu_data_neg_2, test_setup_menu_neg);
+	g_test_add_data_func("/teststk/Setup Menu Negative 3",
+			&setup_menu_data_neg_3, test_setup_menu_neg);
+	g_test_add_data_func("/teststk/Setup Menu Negative 4",
+			&setup_menu_data_neg_4, test_setup_menu_neg);
+
 	g_test_add_data_func("/teststk/Set Up Menu response 1.1.1",
 				&set_up_menu_response_data_111,
 				test_terminal_response_encoding);
-- =

1.7.0.4


--===============6244699720569934868==--

