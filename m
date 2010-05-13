Content-Type: multipart/mixed; boundary="===============3254639190978884510=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 19/27] test-stkutil: Add test for event list parser
Date: Thu, 13 May 2010 18:48:36 +0800
Message-ID: <1273747724-28019-19-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3254639190978884510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  131 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 54e24a0..66aa091 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -225,6 +225,14 @@ static void check_items_next_action_indicator(
 	g_assert(g_mem_equal(command->list, test->list, test->len));
 }
 =

+/* Defined in TS 102.223 Section 8.25 */
+static void check_event_list(const struct stk_event_list *command,
+				const struct stk_event_list *test)
+{
+	g_assert(command->len =3D=3D test->len);
+	g_assert(g_mem_equal(command->list, test->list, test->len));
+}
+
 /* Defined in TS 102.223 Section 8.31 */
 static void check_icon_id(const struct stk_icon_id *command,
 					const struct stk_icon_id *test)
@@ -9063,6 +9071,116 @@ static void test_provide_local_info(gconstpointer d=
ata)
 	stk_command_free(command);
 }
 =

+struct setup_event_list_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	struct stk_event_list event_list;
+};
+
+static unsigned char setup_event_list_111[] =3D { 0xD0, 0x0C, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x01, 0x04 };
+
+static unsigned char setup_event_list_121[] =3D { 0xD0, 0x0D, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x02, 0x05, 0x07 };
+
+static unsigned char setup_event_list_122[] =3D { 0xD0, 0x0C, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x01, 0x07 };
+
+static unsigned char setup_event_list_131[] =3D { 0xD0, 0x0C, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x01, 0x07 };
+
+static unsigned char setup_event_list_132[] =3D { 0xD0, 0x0B, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x00 };
+
+static unsigned char setup_event_list_141[] =3D { 0xD0, 0x0C, 0x81, 0x03, =
0x01,
+						0x05, 0x00, 0x82, 0x02, 0x81,
+						0x82, 0x99, 0x01, 0x07 };
+
+static struct setup_event_list_test setup_event_list_data_111 =3D {
+	.pdu =3D setup_event_list_111,
+	.pdu_len =3D sizeof(setup_event_list_111),
+	.qualifier =3D 0x00,
+	.event_list =3D {
+		.len =3D 1,
+		.list =3D { STK_EVENT_TYPE_USER_ACTIVITY }
+	}
+};
+
+static struct setup_event_list_test setup_event_list_data_121 =3D {
+	.pdu =3D setup_event_list_121,
+	.pdu_len =3D sizeof(setup_event_list_121),
+	.qualifier =3D 0x00,
+	.event_list =3D {
+		.len =3D 2,
+		.list =3D { STK_EVENT_TYPE_IDLE_SCREEN_AVAILABLE,
+				STK_EVENT_TYPE_LANGUAGE_SELECTION }
+	}
+};
+
+static struct setup_event_list_test setup_event_list_data_122 =3D {
+	.pdu =3D setup_event_list_122,
+	.pdu_len =3D sizeof(setup_event_list_122),
+	.qualifier =3D 0x00,
+	.event_list =3D {
+		.len =3D 1,
+		.list =3D { STK_EVENT_TYPE_LANGUAGE_SELECTION }
+	}
+};
+
+static struct setup_event_list_test setup_event_list_data_131 =3D {
+	.pdu =3D setup_event_list_131,
+	.pdu_len =3D sizeof(setup_event_list_131),
+	.qualifier =3D 0x00,
+	.event_list =3D {
+		.len =3D 1,
+		.list =3D { STK_EVENT_TYPE_LANGUAGE_SELECTION }
+	}
+};
+
+static struct setup_event_list_test setup_event_list_data_132 =3D {
+	.pdu =3D setup_event_list_132,
+	.pdu_len =3D sizeof(setup_event_list_132),
+	.qualifier =3D 0x00
+};
+
+static struct setup_event_list_test setup_event_list_data_141 =3D {
+	.pdu =3D setup_event_list_141,
+	.pdu_len =3D sizeof(setup_event_list_141),
+	.qualifier =3D 0x00,
+	.event_list =3D {
+		.len =3D 1,
+		.list =3D { STK_EVENT_TYPE_LANGUAGE_SELECTION }
+	}
+};
+
+static void test_setup_event_list(gconstpointer data)
+{
+	const struct setup_event_list_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_EVENT_LIST);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_event_list(&command->setup_event_list.event_list,
+						&test->event_list);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -9710,5 +9828,18 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Provide Local Info 1.11.1",
 			&provide_local_info_data_1111, test_provide_local_info);
 =

+	g_test_add_data_func("/teststk/Setup Event List 1.1.1",
+			&setup_event_list_data_111, test_setup_event_list);
+	g_test_add_data_func("/teststk/Setup Event List 1.2.1",
+			&setup_event_list_data_121, test_setup_event_list);
+	g_test_add_data_func("/teststk/Setup Event List 1.2.2",
+			&setup_event_list_data_122, test_setup_event_list);
+	g_test_add_data_func("/teststk/Setup Event List 1.3.1",
+			&setup_event_list_data_131, test_setup_event_list);
+	g_test_add_data_func("/teststk/Setup Event List 1.3.2",
+			&setup_event_list_data_132, test_setup_event_list);
+	g_test_add_data_func("/teststk/Setup Event List 1.4.1",
+			&setup_event_list_data_141, test_setup_event_list);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============3254639190978884510==--

