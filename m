Content-Type: multipart/mixed; boundary="===============0810524448066220785=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 17/19] test-stkutil: Refactor test for send sms parser
Date: Mon, 10 May 2010 18:39:00 +0800
Message-ID: <1273487942-27213-17-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0810524448066220785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |  132 ++++++++++++++++++++++++++++++++---------------=
---
 1 files changed, 84 insertions(+), 48 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 52aa050..ffe0a3f 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -70,6 +70,27 @@ static inline void check_common_text(const char *command=
, const char *test)
 	g_assert(g_str_equal(command, test));
 }
 =

+static inline void check_common_byte_array(
+				const struct stk_common_byte_array *command,
+				const struct stk_common_byte_array *test)
+{
+	if (test->len =3D=3D 0) {
+		g_assert(command->len =3D=3D 0);
+		return;
+	}
+
+	g_assert(command->len !=3D 0);
+	g_assert(g_mem_equal(command->array, test->array, test->len));
+}
+
+/* Defined in TS 102.223 Section 8.1 */
+static inline void check_address(const struct stk_address *command,
+					const struct stk_address *test)
+{
+	g_assert(command->ton_npi =3D=3D test->ton_npi);
+	g_assert(g_str_equal(command->number, test->number));
+}
+
 /* Defined in TS 102.223 Section 8.2 */
 static inline void check_alpha_id(const char *command, const char *test)
 {
@@ -121,6 +142,18 @@ static void check_response_length(const struct stk_res=
ponse_length *command,
 	g_assert(command->max =3D=3D test->max);
 }
 =

+/* Defined in TS 102.223 Section 8.13 */
+static void check_gsm_sms_tpdu(const struct sms *command,
+					const struct sms *test)
+{
+	g_assert(command->submit.mr =3D=3D test->submit.mr);
+	g_assert(command->submit.udl =3D=3D test->submit.udl);
+	g_assert(g_str_equal(command->submit.daddr.address,
+					test->submit.daddr.address));
+	g_assert(g_mem_equal(command->submit.ud, test->submit.ud,
+					test->submit.udl));
+}
+
 /* Defined in TS 102.223 Section 8.15 */
 static inline void check_text(const char *command, const char *test)
 {
@@ -173,6 +206,14 @@ static inline void check_imm_resp(const unsigned char =
command,
 	check_common_byte(command, test);
 }
 =

+/* Defined in TS 102.223 Section 8.71 */
+static inline void check_cdma_sms_tpdu(
+				const struct stk_common_byte_array *command,
+				const struct stk_common_byte_array *test)
+{
+	check_common_byte_array(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static void check_text_attr(const struct stk_text_attribute *command,
 					const struct stk_text_attribute *test)
@@ -7443,45 +7484,51 @@ struct send_sms_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
 	unsigned char qualifier;
-	const char *alpha_id;
-	unsigned char ton_npi;
-	const char *address;
-	unsigned char sms_mr;
-	const char *sms_address;
-	unsigned char sms_udl;
-	const char *sms_ud;
+	char *alpha_id;
+	struct stk_address address;
+	struct sms gsm_sms;
+	struct stk_common_byte_array cdma_sms;
+	struct stk_icon_id icon_id;
+	struct stk_text_attribute text_attr;
+	struct stk_frame_id frame_id;
 };
 =

 /* 3GPP TS 31.124 Section 27.22.4.10.1.4.2 */
-static unsigned char send_sms_11[] =3D { 0xD0, 0x37, 0x81, 0x03, 0x01, 0x1=
3, 0x00,
-					0x82, 0x02, 0x81, 0x83, 0x85, 0x07,
-					0x53, 0x65, 0x6E, 0x64, 0x20, 0x53,
-					0x4D, 0x86, 0x09, 0x91, 0x11, 0x22,
-					0x33, 0x44, 0x55, 0x66, 0x77, 0xF8,
-					0x8B, 0x18, 0x01, 0x00, 0x09, 0x91,
-					0x10, 0x32, 0x54, 0x76, 0xF8, 0x40,
-					0xF4, 0x0C, 0x54, 0x65, 0x73, 0x74,
-					0x20, 0x4D, 0x65, 0x73, 0x73, 0x61,
-					0x67, 0x65 };
-
-static struct send_sms_test send_sms_data_11 =3D {
-	.pdu =3D send_sms_11,
-	.pdu_len =3D sizeof(send_sms_11),
+static unsigned char send_sms_111[] =3D { 0xD0, 0x37, 0x81, 0x03, 0x01, 0x=
13,
+					0x00, 0x82, 0x02, 0x81, 0x83, 0x85,
+					0x07, 0x53, 0x65, 0x6E, 0x64, 0x20,
+					0x53, 0x4D, 0x86, 0x09, 0x91, 0x11,
+					0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+					0xF8, 0x8B, 0x18, 0x01, 0x00, 0x09,
+					0x91, 0x10, 0x32, 0x54, 0x76, 0xF8,
+					0x40, 0xF4, 0x0C, 0x54, 0x65, 0x73,
+					0x74, 0x20, 0x4D, 0x65, 0x73, 0x73,
+					0x61, 0x67, 0x65 };
+
+static struct send_sms_test send_sms_data_111 =3D {
+	.pdu =3D send_sms_111,
+	.pdu_len =3D sizeof(send_sms_111),
 	.qualifier =3D 0x00,
 	.alpha_id =3D "Send SM",
-	.ton_npi =3D 0x91,
-	.address =3D "112233445566778",
-	.sms_mr =3D 0x00,
-	.sms_address =3D "012345678",
-	.sms_udl =3D 12,
-	.sms_ud =3D "Test Message",
+	.address =3D {
+		.ton_npi =3D 0x91,
+		.number =3D "112233445566778"
+	},
+	.gsm_sms =3D {
+		{}, SMS_TYPE_SUBMIT,
+		{.submit =3D {
+			.mr =3D 0x00,
+			.daddr.address =3D "012345678",
+			.udl =3D 12,
+			.ud =3D "Test Message"
+		} }
+	}
 };
 =

 static void test_send_sms(gconstpointer data)
 {
 	const struct send_sms_test *test =3D data;
 	struct stk_command *command;
-	int i;
 =

 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

@@ -7494,24 +7541,13 @@ static void test_send_sms(gconstpointer data)
 	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_NETWORK);
 =

-	if (test->alpha_id)
-		g_assert(g_str_equal(test->alpha_id,
-					command->send_sms.alpha_id));
-
-	if (test->address) {
-		g_assert(test->ton_npi =3D=3D command->send_sms.address.ton_npi);
-		g_assert(g_str_equal(test->address,
-					command->send_sms.address.number));
-	}
-
-	g_assert(test->sms_mr =3D=3D command->send_sms.gsm_sms.submit.mr);
-	g_assert(test->sms_udl =3D=3D command->send_sms.gsm_sms.submit.udl);
-	g_assert(g_str_equal(test->sms_address,
-			command->send_sms.gsm_sms.submit.daddr.address));
-
-	for (i =3D 0; i < test->sms_udl; i++)
-		g_assert(test->sms_ud[i] =3D=3D
-				command->send_sms.gsm_sms.submit.ud[i]);
+	check_alpha_id(command->send_sms.alpha_id, test->alpha_id);
+	check_address(&command->send_sms.address, &test->address);
+	check_gsm_sms_tpdu(&command->send_sms.gsm_sms, &test->gsm_sms);
+	check_cdma_sms_tpdu(&command->send_sms.cdma_sms, &test->cdma_sms);
+	check_icon_id(&command->select_item.icon_id, &test->icon_id);
+	check_text_attr(&command->select_item.text_attr, &test->text_attr);
+	check_frame_id(&command->select_item.frame_id, &test->frame_id);
 =

 	stk_command_free(command);
 }
@@ -8048,8 +8084,8 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Select Item 12.3.1",
 				&select_item_data_1231, test_select_item);
 =

-	g_test_add_data_func("/teststk/Send SMS 1.1",
-				&send_sms_data_11, test_send_sms);
+	g_test_add_data_func("/teststk/Send SMS 1.1.1",
+				&send_sms_data_111, test_send_sms);
 =

 	return g_test_run();
 }
-- =

1.7.0.4


--===============0810524448066220785==--

