Content-Type: multipart/mixed; boundary="===============5768462111831173236=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 07/27] test-stkutil: Use dedicated functions to check
Date: Thu, 13 May 2010 18:48:24 +0800
Message-ID: <1273747724-28019-7-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5768462111831173236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   50 +++++++++++++++++++++++++++++++++++++++++------=
---
 1 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 2fa449d..8ec380f 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -71,6 +71,12 @@ static inline void check_common_text(const char *command=
, const char *test)
 	g_assert(g_str_equal(command, test));
 }
 =

+/* Defined in TS 102.223 Section 8.2 */
+static inline void check_alpha_id(const char *command, const char *test)
+{
+	check_common_text(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.8 */
 static void check_duration(const struct stk_duration *command,
 					const struct stk_duration *test)
@@ -116,6 +122,25 @@ static void check_response_length(const struct stk_res=
ponse_length *command,
 	g_assert(command->max =3D=3D test->max);
 }
 =

+/* Defined in TS 102.223 Section 8.15 */
+static inline void check_text(const char *command, const char *test)
+{
+	check_common_text(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.16 */
+static inline void check_tone(const ofono_bool_t command,
+					const ofono_bool_t test)
+{
+	check_common_bool(command, test);
+}
+
+/* Defined in TS 102.223 Section 8.23 */
+static inline void check_default_text(const char *command, const char *tes=
t)
+{
+	check_common_text(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.24 */
 static void check_items_next_action_indicator(
 			const struct stk_items_next_action_indicator *command,
@@ -142,6 +167,13 @@ static void check_item_icon_id_list(const struct stk_i=
tem_icon_id_list *command,
 	g_assert(g_mem_equal(command->list, test->list, test->len));
 }
 =

+/* Defined in TS 102.223 Section 8.43 */
+static inline void check_imm_resp(const unsigned char command,
+					const unsigned char test)
+{
+	check_common_byte(command, test);
+}
+
 /* Defined in TS 102.223 Section 8.72 */
 static void check_text_attr(const struct stk_text_attribute *command,
 					const struct stk_text_attribute *test)
@@ -410,9 +442,9 @@ static void test_display_text(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY);
 =

 	g_assert(command->display_text.text);
-	check_common_text(command->display_text.text, test->text);
+	check_text(command->display_text.text, test->text);
 	check_icon_id(&command->display_text.icon_id, &test->icon_id);
-	check_common_bool(command->display_text.immediate_response,
+	check_imm_resp(command->display_text.immediate_response,
 						test->immediate_response);
 	check_duration(&command->display_text.duration, &test->duration);
 	check_text_attr(&command->display_text.text_attr,
@@ -1347,7 +1379,7 @@ static void test_get_inkey(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
 =

 	g_assert(command->get_inkey.text);
-	check_common_text(command->get_inkey.text, test->text);
+	check_text(command->get_inkey.text, test->text);
 	check_icon_id(&command->get_inkey.icon_id, &test->icon_id);
 	check_duration(&command->get_inkey.duration, &test->duration);
 	check_text_attr(&command->get_inkey.text_attr,
@@ -2653,9 +2685,9 @@ static void test_get_input(gconstpointer data)
 =

 	if (test->text)
 		g_assert(command->get_input.text);
-	check_common_text(command->get_input.text, test->text);
+	check_text(command->get_input.text, test->text);
 	check_response_length(&command->get_input.resp_len, &test->resp_len);
-	check_common_text(command->get_input.default_text, test->default_text);
+	check_default_text(command->get_input.default_text, test->default_text);
 	check_icon_id(&command->get_input.icon_id, &test->icon_id);
 	check_text_attr(&command->get_input.text_attr,
 						&test->text_attr);
@@ -3931,8 +3963,8 @@ static void test_play_tone(gconstpointer data)
 	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_EARPIECE);
 =

-	check_common_text(command->play_tone.alpha_id, test->alpha_id);
-	check_common_byte(command->play_tone.tone, test->tone);
+	check_alpha_id(command->play_tone.alpha_id, test->alpha_id);
+	check_tone(command->play_tone.tone, test->tone);
 	check_duration(&command->play_tone.duration, &test->duration);
 	check_icon_id(&command->play_tone.icon_id, &test->icon_id);
 	check_text_attr(&command->play_tone.text_attr, &test->text_attr);
@@ -5464,7 +5496,7 @@ static void test_setup_menu(gconstpointer data)
 =

 	if (test->alpha_id)
 		g_assert(command->setup_menu.alpha_id);
-	check_common_text(command->setup_menu.alpha_id, test->alpha_id);
+	check_alpha_id(command->setup_menu.alpha_id, test->alpha_id);
 	check_items(command->setup_menu.items, test->items);
 	check_items_next_action_indicator(&command->setup_menu.next_act,
 						&test->next_act);
@@ -7392,7 +7424,7 @@ static void test_select_item(gconstpointer data)
 	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
 =

-	check_common_text(command->select_item.alpha_id, test->alpha_id);
+	check_alpha_id(command->select_item.alpha_id, test->alpha_id);
 	check_items(command->select_item.items, test->items);
 	check_items_next_action_indicator(&command->select_item.next_act,
 						&test->next_act);
-- =

1.7.0.4


--===============5768462111831173236==--

