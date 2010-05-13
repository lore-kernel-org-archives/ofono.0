Content-Type: multipart/mixed; boundary="===============4039761079153285880=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 15/27] test-stkutil: Add test for polling off parser
Date: Thu, 13 May 2010 18:48:32 +0800
Message-ID: <1273747724-28019-15-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4039761079153285880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 1f66631..1672202 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -8944,6 +8944,40 @@ static void test_refresh(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct polling_off_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+};
+
+static unsigned char polling_off_112[] =3D { 0xD0, 0x09, 0x81, 0x03, 0x01,=
 0x04,
+						0x00, 0x82, 0x02, 0x81, 0x82 };
+
+static struct polling_off_test polling_off_data_112 =3D {
+	.pdu =3D polling_off_112,
+	.pdu_len =3D sizeof(polling_off_112),
+	.qualifier =3D 0x00,
+};
+
+static void test_polling_off(gconstpointer data)
+{
+	const struct polling_off_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLLING_OFF);
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
@@ -9575,5 +9609,8 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Refresh 1.5.1",
 				&refresh_data_151, test_refresh);
 =

+	g_test_add_data_func("/teststk/Polling off 1.1.2",
+				&polling_off_data_112, test_polling_off);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============4039761079153285880==--

