Content-Type: multipart/mixed; boundary="===============2675252585046936292=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 17/27] test-stk: Add test for provide local info parser
Date: Thu, 13 May 2010 18:48:34 +0800
Message-ID: <1273747724-28019-17-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2675252585046936292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 1672202..54e24a0 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -8978,6 +8978,91 @@ static void test_polling_off(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct provide_local_info_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+};
+
+static unsigned char provide_local_info_121[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+						0x26, 0x01, 0x82, 0x02, 0x81,
+						0x82 };
+
+static unsigned char provide_local_info_141[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+						0x26, 0x03, 0x82, 0x02, 0x81,
+						0x82 };
+
+static unsigned char provide_local_info_151[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+						0x26, 0x04, 0x82, 0x02, 0x81,
+						0x82 };
+
+static unsigned char provide_local_info_181[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+						0x26, 0x07, 0x82, 0x02, 0x81,
+						0x82 };
+
+static unsigned char provide_local_info_191[] =3D { 0xD0, 0x09, 0x81, 0x03=
, 0x01,
+						0x26, 0x08, 0x82, 0x02, 0x81,
+						0x82 };
+
+static unsigned char provide_local_info_1111[] =3D { 0xD0, 0x09, 0x81, 0x0=
3, 0x01,
+						0x26, 0x0A, 0x82, 0x02, 0x81,
+						0x82 };
+
+static struct provide_local_info_test provide_local_info_data_121 =3D {
+	.pdu =3D provide_local_info_121,
+	.pdu_len =3D sizeof(provide_local_info_121),
+	.qualifier =3D 0x01
+};
+
+static struct provide_local_info_test provide_local_info_data_141 =3D {
+	.pdu =3D provide_local_info_141,
+	.pdu_len =3D sizeof(provide_local_info_141),
+	.qualifier =3D 0x03
+};
+
+static struct provide_local_info_test provide_local_info_data_151 =3D {
+	.pdu =3D provide_local_info_151,
+	.pdu_len =3D sizeof(provide_local_info_151),
+	.qualifier =3D 0x04
+};
+
+static struct provide_local_info_test provide_local_info_data_181 =3D {
+	.pdu =3D provide_local_info_181,
+	.pdu_len =3D sizeof(provide_local_info_181),
+	.qualifier =3D 0x07
+};
+
+static struct provide_local_info_test provide_local_info_data_191 =3D {
+	.pdu =3D provide_local_info_191,
+	.pdu_len =3D sizeof(provide_local_info_191),
+	.qualifier =3D 0x08
+};
+
+static struct provide_local_info_test provide_local_info_data_1111 =3D {
+	.pdu =3D provide_local_info_1111,
+	.pdu_len =3D sizeof(provide_local_info_1111),
+	.qualifier =3D 0x0A
+};
+
+static void test_provide_local_info(gconstpointer data)
+{
+	const struct provide_local_info_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -9612,5 +9697,18 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Polling off 1.1.2",
 				&polling_off_data_112, test_polling_off);
 =

+	g_test_add_data_func("/teststk/Provide Local Info 1.2.1",
+			&provide_local_info_data_121, test_provide_local_info);
+	g_test_add_data_func("/teststk/Provide Local Info 1.4.1",
+			&provide_local_info_data_141, test_provide_local_info);
+	g_test_add_data_func("/teststk/Provide Local Info 1.5.1",
+			&provide_local_info_data_151, test_provide_local_info);
+	g_test_add_data_func("/teststk/Provide Local Info 1.8.1",
+			&provide_local_info_data_181, test_provide_local_info);
+	g_test_add_data_func("/teststk/Provide Local Info 1.9.1",
+			&provide_local_info_data_191, test_provide_local_info);
+	g_test_add_data_func("/teststk/Provide Local Info 1.11.1",
+			&provide_local_info_data_1111, test_provide_local_info);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============2675252585046936292==--

