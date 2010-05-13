Content-Type: multipart/mixed; boundary="===============8510842052696922044=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/27] test-stkutil: Add test for refresh parser
Date: Thu, 13 May 2010 18:48:30 +0800
Message-ID: <1273747724-28019-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8510842052696922044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 75ca258..1f66631 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -194,6 +194,22 @@ static inline void check_tone(const ofono_bool_t comma=
nd,
 	check_common_bool(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.18 */
+static void check_file_list(GSList *command, const struct stk_file *test)
+{
+	struct stk_file *sf;
+	GSList *l;
+	unsigned int i =3D 0;
+
+	for (l =3D command; l; l =3D l->next) {
+		sf =3D l->data;
+		g_assert(sf->len =3D=3D test[i].len);
+		g_assert(g_mem_equal(sf->file, test[i++].file, sf->len));
+	}
+
+	g_assert(test[i].len =3D=3D 0);
+}
+
 /* Defined in TS 102.223 Section 8.23 */
 static inline void check_default_text(const char *command, const char *tes=
t)
 {
@@ -233,6 +249,13 @@ static inline void check_imm_resp(const unsigned char =
command,
 	check_common_byte(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.60 */
+static inline void check_aid(const struct stk_aid *command,
+					const struct stk_aid *test)
+{
+	g_assert(g_mem_equal(command->aid, test->aid, test->len));
+}
+
 /* Defined in TS 102.223 Section 8.71 */
 static inline void check_cdma_sms_tpdu(
 				const struct stk_common_byte_array *command,
@@ -8858,6 +8881,69 @@ static void test_setup_call(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct refresh_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	struct stk_file fl[MAX_ITEM];
+	struct stk_aid aid;
+	char *alpha_id;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
+};
+
+static unsigned char refresh_121[] =3D { 0xD0, 0x10, 0x81, 0x03, 0x01, 0x0=
1,
+						0x01, 0x82, 0x02, 0x81, 0x82,
+						0x92, 0x05, 0x01, 0x3F, 0x00,
+						0x2F, 0xE2 };
+
+static unsigned char refresh_151[] =3D { 0xD0, 0x09, 0x81, 0x03, 0x01, 0x0=
1,
+						0x04, 0x82, 0x02, 0x81, 0x82 };
+
+static struct refresh_test refresh_data_121 =3D {
+	.pdu =3D refresh_121,
+	.pdu_len =3D sizeof(refresh_121),
+	.qualifier =3D 0x01,
+	.fl[0] =3D {
+		.len =3D 4,
+		.file =3D { 0x3F, 0x00, 0x2F, 0xE2 }
+	}
+};
+
+static struct refresh_test refresh_data_151 =3D {
+	.pdu =3D refresh_151,
+	.pdu_len =3D sizeof(refresh_151),
+	.qualifier =3D 0x04
+};
+
+/* Defined in TS 102.384 Section 27.22.4.7 */
+static void test_refresh(gconstpointer data)
+{
+	const struct refresh_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_REFRESH);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_file_list(command->refresh.fl, test->fl);
+	check_aid(&command->refresh.aid, &test->aid);
+	check_alpha_id(command->refresh.alpha_id, test->alpha_id);
+	check_icon_id(&command->refresh.icon_id, &test->icon_id);
+	check_text_attr(&command->refresh.text_attr, &test->text_attr);
+	check_frame_id(&command->refresh.frame_id, &test->frame_id);
+
+	stk_command_free(command);
+}
+
 int main(int argc, char **argv)
 {
 	g_test_init(&argc, &argv, NULL);
@@ -9484,5 +9570,10 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Setup Call 7.2.1",
 				&setup_call_data_721, test_setup_call);
 =

+	g_test_add_data_func("/teststk/Refresh 1.2.1",
+				&refresh_data_121, test_refresh);
+	g_test_add_data_func("/teststk/Refresh 1.5.1",
+				&refresh_data_151, test_refresh);
+
 	return g_test_run();
 }
-- =

1.7.0.4


--===============8510842052696922044==--

