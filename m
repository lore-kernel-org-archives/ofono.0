Content-Type: multipart/mixed; boundary="===============7625325169170335716=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 21/27] test-stk: Add test for perform card apdu parser
Date: Thu, 13 May 2010 18:48:38 +0800
Message-ID: <1273747724-28019-21-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7625325169170335716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  259 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 259 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 66aa091..340f15f 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -45,6 +45,7 @@ static gboolean g_mem_equal(const unsigned char *v1, cons=
t unsigned char *v2,
 	for (i =3D 0; i < len; i++)
 		if (v1[i] !=3D v2[i])
 			return FALSE;
+
 	return TRUE;
 }
 =

@@ -250,6 +251,21 @@ static void check_item_icon_id_list(const struct stk_i=
tem_icon_id_list *command,
 	g_assert(g_mem_equal(command->list, test->list, test->len));
 }
 =

+/* Defined in TS 102.223 Section 8.35 */
+static void check_c_apdu(const struct stk_c_apdu *command,
+				const struct stk_c_apdu *test)
+{
+	g_assert(command->cla =3D=3D test->cla);
+	g_assert(command->ins =3D=3D test->ins);
+	g_assert(command->p1 =3D=3D test->p1);
+	g_assert(command->p2 =3D=3D test->p2);
+	g_assert(command->lc =3D=3D test->lc);
+	g_assert(g_mem_equal(command->data, test->data, test->lc));
+
+	if (test->has_le)
+		g_assert(command->le =3D=3D test->le);
+}
+
 /* Defined in TS 102.223 Section 8.43 */
 static inline void check_imm_resp(const unsigned char command,
 					const unsigned char test)
@@ -9181,6 +9197,230 @@ static void test_setup_event_list(gconstpointer dat=
a)
 	stk_command_free(command);
 }
 =

+struct perform_card_apdu_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	unsigned char dst;
+	struct stk_c_apdu c_apdu;
+};
+
+static unsigned char perform_card_apdu_111[] =3D { 0xD0, 0x12, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x07, 0xA0, 0xA4,
+						0x00, 0x00, 0x02, 0x3F, 0x00 };
+
+static unsigned char perform_card_apdu_112[] =3D { 0xD0, 0x10, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x05, 0xA0, 0xC0,
+						0x00, 0x00, 0x1B };
+
+static unsigned char perform_card_apdu_121[] =3D { 0xD0, 0x12, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x07, 0xA0, 0xA4,
+						0x00, 0x00, 0x02, 0x7F, 0x20 };
+
+static unsigned char perform_card_apdu_122[] =3D { 0xD0, 0x12, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x07, 0xA0, 0xA4,
+						0x00, 0x00, 0x02, 0x6F, 0x30 };
+
+static unsigned char perform_card_apdu_123[] =3D { 0xD0, 0x28, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x1D, 0xA0, 0xD6,
+						0x00, 0x00, 0x18, 0x00, 0x01,
+						0x02, 0x03, 0x04, 0x05, 0x06,
+						0x07, 0x08, 0x09, 0x0A, 0x0B,
+						0x0C, 0x0D, 0x0E, 0x0F, 0x10,
+						0x11, 0x12, 0x13, 0x14, 0x15,
+						0x16, 0x17 };
+
+static unsigned char perform_card_apdu_124[] =3D { 0xD0, 0x10, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x05, 0xA0, 0xB0,
+						0x00, 0x00, 0x18 };
+
+static unsigned char perform_card_apdu_125[] =3D { 0xD0, 0x28, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x1D, 0xA0, 0xD6,
+						0x00, 0x00, 0x18, 0xFF, 0xFF,
+						0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+						0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+						0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+						0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+						0xFF, 0xFF };
+
+static unsigned char perform_card_apdu_151[] =3D { 0xD0, 0x12, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x17, 0xA2, 0x07, 0xA0, 0xA4,
+						0x00, 0x00, 0x02, 0x3F, 0x00 };
+
+static unsigned char perform_card_apdu_211[] =3D { 0xD0, 0x12, 0x81, 0x03,=
 0x01,
+						0x30, 0x00, 0x82, 0x02, 0x81,
+						0x11, 0xA2, 0x07, 0xA0, 0xA4,
+						0x00, 0x00, 0x02, 0x3F, 0x00 };
+
+static struct perform_card_apdu_test perform_card_apdu_data_111 =3D {
+	.pdu =3D perform_card_apdu_111,
+	.pdu_len =3D sizeof(perform_card_apdu_111),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_SELECT,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x02,
+		.data =3D { 0x3F, 0x00 }
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_112 =3D {
+	.pdu =3D perform_card_apdu_112,
+	.pdu_len =3D sizeof(perform_card_apdu_112),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_GET_RESPONSE,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.has_le =3D 1,
+		.le =3D 0x1B
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_121 =3D {
+	.pdu =3D perform_card_apdu_121,
+	.pdu_len =3D sizeof(perform_card_apdu_121),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_SELECT,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x02,
+		.data =3D { 0x7F, 0x20 }
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_122 =3D {
+	.pdu =3D perform_card_apdu_122,
+	.pdu_len =3D sizeof(perform_card_apdu_122),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_SELECT,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x02,
+		.data =3D { 0x6F, 0x30 }
+	}
+};
+
+/* Byte 14 of Data is not correct in spec. */
+static struct perform_card_apdu_test perform_card_apdu_data_123 =3D {
+	.pdu =3D perform_card_apdu_123,
+	.pdu_len =3D sizeof(perform_card_apdu_123),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_UPDATE_BINARY_D6,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x18,
+		.data =3D { 0x00, 0x01, 0x02, 0x03, 0x04,	0x05, 0x06, 0x07, 0x08,
+				0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10,
+				0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17 }
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_124 =3D {
+	.pdu =3D perform_card_apdu_124,
+	.pdu_len =3D sizeof(perform_card_apdu_124),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_READ_BINARY_B0,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.has_le =3D 1,
+		.le =3D 0x18
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_125 =3D {
+	.pdu =3D perform_card_apdu_125,
+	.pdu_len =3D sizeof(perform_card_apdu_125),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_UPDATE_BINARY_D6,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x18,
+		.data =3D { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF }
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_151 =3D {
+	.pdu =3D perform_card_apdu_151,
+	.pdu_len =3D sizeof(perform_card_apdu_151),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_7,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_SELECT,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x02,
+		.data =3D { 0x3F, 0x00 }
+	}
+};
+
+static struct perform_card_apdu_test perform_card_apdu_data_211 =3D {
+	.pdu =3D perform_card_apdu_211,
+	.pdu_len =3D sizeof(perform_card_apdu_211),
+	.qualifier =3D 0x00,
+	.dst =3D STK_DEVICE_IDENTITY_TYPE_CARD_READER_1,
+	.c_apdu =3D {
+		.cla =3D 0xA0,
+		.ins =3D STK_INS_SELECT,
+		.p1 =3D 0x00,
+		.p2 =3D 0x00,
+		.lc =3D 0x02,
+		.data =3D { 0x3F, 0x00 }
+	}
+};
+
+static void test_perform_card_apdu(gconstpointer data)
+{
+	const struct perform_card_apdu_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PERFORM_CARD_APDU);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D test->dst);
+
+	check_c_apdu(&command->perform_card_apdu.c_apdu, &test->c_apdu);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -9841,5 +10081,24 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Event List 1.4.1",
 			&setup_event_list_data_141, test_setup_event_list);
 =

+	g_test_add_data_func("/teststk/Perform Card APDU 1.1.1",
+			&perform_card_apdu_data_111, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.1.2",
+			&perform_card_apdu_data_112, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.2.1",
+			&perform_card_apdu_data_121, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.2.2",
+			&perform_card_apdu_data_122, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.2.3",
+			&perform_card_apdu_data_123, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.2.4",
+			&perform_card_apdu_data_124, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.2.5",
+			&perform_card_apdu_data_125, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 1.5.1",
+			&perform_card_apdu_data_151, test_perform_card_apdu);
+	g_test_add_data_func("/teststk/Perform Card APDU 2.1.1",
+			&perform_card_apdu_data_211, test_perform_card_apdu);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============7625325169170335716==--

