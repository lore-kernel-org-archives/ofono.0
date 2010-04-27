Content-Type: multipart/mixed; boundary="===============8762178244892400276=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 5/7] test-stkutil: Add unit test for more time parser
Date: Tue, 27 Apr 2010 17:47:10 +0800
Message-ID: <1272361632-21352-5-git-send-email-yang.gu@intel.com>
In-Reply-To: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8762178244892400276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 0961368..427d7a2 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -405,6 +405,41 @@ static void test_get_input(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct more_time_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+};
+
+static unsigned char more_time_111[] =3D { 0xD0, 0x09, 0x81, 0x03, 0x01, 0=
x02,
+						0x00, 0x82, 0x02, 0x81, 0x82 };
+
+static struct more_time_test more_time_data_111 =3D {
+	.pdu =3D more_time_111,
+	.pdu_len =3D sizeof(more_time_111),
+	.qualifier =3D 0x00,
+};
+
+/* Defined in TS 102.384 Section 27.22.4.4 */
+static void test_more_time(gconstpointer data)
+{
+	const struct get_input_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_MORE_TIME);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	stk_command_free(command);
+}
+
 struct send_sms_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -516,6 +551,9 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Get Input 1.1.1",
 				&get_input_data_111, test_get_input);
 =

+	g_test_add_data_func("/teststk/More Time 1.1.1",
+				&more_time_data_111, test_more_time);
+
 	g_test_add_data_func("/teststk/Send SMS 1.1",
 				&send_sms_data_11, test_send_sms);
 =

-- =

1.7.0.4


--===============8762178244892400276==--

