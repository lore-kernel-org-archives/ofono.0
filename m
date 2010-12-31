Content-Type: multipart/mixed; boundary="===============6824182372415125871=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 3/3] unit: add error status support for failure cases
Date: Fri, 31 Dec 2010 14:30:47 +0200
Message-ID: <1293798647-4256-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1293798647-4256-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6824182372415125871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 185dfdd..f1cad78 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -13999,6 +13999,7 @@ struct setup_idle_mode_text_test {
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
 	char *html;
+	enum stk_command_parse_result status;
 };
 =

 static unsigned char setup_idle_mode_text_111[] =3D { 0xD0, 0x1A, 0x81, 0x=
03,
@@ -14415,7 +14416,8 @@ static struct setup_idle_mode_text_test setup_idle_=
mode_text_data_241 =3D {
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
 		.id =3D 0x01
-	}
+	},
+	.status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD
 };
 =

 static struct setup_idle_mode_text_test setup_idle_mode_text_data_311 =3D {
@@ -14742,7 +14744,7 @@ static void test_setup_idle_mode_text(gconstpointer=
 data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
-	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+	g_assert(command->status =3D=3D test->status);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT);
@@ -14772,6 +14774,7 @@ struct run_at_command_test {
 	struct stk_icon_id icon_id;
 	struct stk_text_attribute text_attr;
 	struct stk_frame_id frame_id;
+	enum stk_command_parse_result status;
 };
 =

 static unsigned char run_at_command_111[] =3D { 0xD0, 0x12, 0x81, 0x03, 0x=
01,
@@ -15193,7 +15196,8 @@ static struct run_at_command_test run_at_command_da=
ta_251 =3D {
 	.icon_id =3D {
 		.qualifier =3D STK_ICON_QUALIFIER_TYPE_NON_SELF_EXPLANATORY,
 		.id =3D 0x01
-	}
+	},
+	.status =3D STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD
 };
 =

 static struct run_at_command_test run_at_command_data_311 =3D {
@@ -15500,7 +15504,7 @@ static void test_run_at_command(gconstpointer data)
 	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
 =

 	g_assert(command);
-	g_assert(command->status =3D=3D STK_PARSE_RESULT_OK);
+	g_assert(command->status =3D=3D test->status);
 =

 	g_assert(command->number =3D=3D 1);
 	g_assert(command->type =3D=3D STK_COMMAND_TYPE_RUN_AT_COMMAND);
-- =

1.7.0.4


--===============6824182372415125871==--

