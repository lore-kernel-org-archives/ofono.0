Content-Type: multipart/mixed; boundary="===============6630721381214886483=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 8/8] teststk: Add test for language notification parser
Date: Wed, 19 May 2010 18:24:46 +0800
Message-ID: <1274264686-9706-8-git-send-email-yang.gu@intel.com>
In-Reply-To: <1274264686-9706-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6630721381214886483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index b236e59..97f3c47 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -305,6 +305,12 @@ static inline void check_dtmf_string(const char *comma=
nd, const char *test)
 	check_common_text(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.45 */
+static inline void check_language(const char *command, const char *test)
+{
+	check_common_text(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.60 */
 static inline void check_aid(const struct stk_aid *command,
 					const struct stk_aid *test)
@@ -12147,6 +12153,56 @@ static void test_send_dtmf(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct language_notification_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	char language[3];
+};
+
+static unsigned char language_notification_111[] =3D { 0xD0, 0x0D, 0x81, 0=
x03,
+						0x01, 0x35, 0x01, 0x82, 0x02,
+						0x81, 0x82, 0xAD, 0x02, 0x73,
+						0x65 };
+
+static unsigned char language_notification_121[] =3D { 0xD0, 0x09, 0x81, 0=
x03,
+						0x01, 0x35, 0x00, 0x82, 0x02,
+						0x81, 0x82 };
+
+static struct language_notification_test language_notification_data_111 =
=3D {
+	.pdu =3D language_notification_111,
+	.pdu_len =3D sizeof(language_notification_111),
+	.qualifier =3D 0x01,
+	.language =3D "se"
+};
+
+static struct language_notification_test language_notification_data_121 =
=3D {
+	.pdu =3D language_notification_121,
+	.pdu_len =3D sizeof(language_notification_121),
+	.qualifier =3D 0x00
+};
+
+static void test_language_notification(gconstpointer data)
+{
+	const struct language_notification_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_LANGUAGE_NOTIFICATION);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_language(command->language_notification.language, test->language);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -13127,5 +13183,10 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Send DTMF 6.1.1",
 			&send_dtmf_data_611, test_send_dtmf);
 =

+	g_test_add_data_func("/teststk/Language Notification 1.1.1",
+		&language_notification_data_111, test_language_notification);
+	g_test_add_data_func("/teststk/Language Notification 1.2.1",
+		&language_notification_data_121, test_language_notification);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============6630721381214886483==--

