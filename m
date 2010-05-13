Content-Type: multipart/mixed; boundary="===============1846490711228464369=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 25/27] test-stk: Add test for get reader status parser
Date: Thu, 13 May 2010 18:48:42 +0800
Message-ID: <1273747724-28019-25-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1846490711228464369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 340f15f..5a6d2a4 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -9421,6 +9421,48 @@ static void test_perform_card_apdu(gconstpointer dat=
a)
 	stk_command_free(command);
 }
 =

+struct get_reader_status_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+};
+
+static unsigned char get_reader_status_111[] =3D { 0xD0, 0x09, 0x81, 0x03,=
 0x01,
+						0x33, 0x00, 0x82, 0x02, 0x81,
+						0x82 };
+
+static struct get_reader_status_test get_reader_status_data_111 =3D {
+	.pdu =3D get_reader_status_111,
+	.pdu_len =3D sizeof(get_reader_status_111),
+	.qualifier =3D STK_QUALIFIER_TYPE_CARD_READER_STATUS,
+};
+
+static void test_get_reader_status(gconstpointer data)
+{
+	const struct get_reader_status_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_GET_READER_STATUS);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+
+	if (command->qualifier =3D=3D STK_QUALIFIER_TYPE_CARD_READER_STATUS)
+		g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+	else
+		g_assert(command->dst <
+				STK_DEVICE_IDENTITY_TYPE_CARD_READER_0 ||
+			command->dst >
+				STK_DEVICE_IDENTITY_TYPE_CARD_READER_7);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -10100,5 +10142,8 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Perform Card APDU 2.1.1",
 			&perform_card_apdu_data_211, test_perform_card_apdu);
 =

+	g_test_add_data_func("/teststk/Get Reader Status 1.1.1",
+			&get_reader_status_data_111, test_get_reader_status);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============1846490711228464369==--

