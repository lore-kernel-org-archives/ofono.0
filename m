Content-Type: multipart/mixed; boundary="===============5243448561039203704=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 06/19] Replace check_text with check_common_text
Date: Mon, 10 May 2010 18:38:49 +0800
Message-ID: <1273487942-27213-6-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5243448561039203704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index e1f6a3e..11b088b 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -52,6 +52,17 @@ static inline void check_common_bool(const ofono_bool_t =
command,
 	g_assert(command =3D=3D test);
 }
 =

+static inline void check_common_text(const char *command, const char *test)
+{
+	if (test =3D=3D NULL) {
+		g_assert(command =3D=3D NULL);
+		return;
+	}
+
+	g_assert(command !=3D NULL);
+	g_assert(g_str_equal(command, test));
+}
+
 /* Defined in TS 102.223 Section 8.8 */
 static void check_duration(const struct stk_duration *command,
 					const struct stk_duration *test)
@@ -68,18 +79,6 @@ static void check_response_length(const struct stk_respo=
nse_length *command,
 	g_assert(command->max =3D=3D test->max);
 }
 =

-/* Defined in TS 102.223 Section 8.15 */
-static inline void check_text(const char *command, const char *test)
-{
-	if (test =3D=3D NULL) {
-		g_assert(command =3D=3D NULL);
-		return;
-	}
-
-	g_assert(command !=3D NULL);
-	g_assert(g_str_equal(command, test));
-}
-
 /* Defined in TS 102.223 Section 8.31 */
 static void check_icon_id(const struct stk_icon_id *command,
 					const struct stk_icon_id *test)
@@ -347,7 +346,7 @@ static void test_display_text(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_DISPLAY);
 =

 	g_assert(command->display_text.text);
-	check_text(command->display_text.text, test->text);
+	check_common_text(command->display_text.text, test->text);
 	check_icon_id(&command->display_text.icon_id, &test->icon_id);
 	check_common_bool(command->display_text.immediate_response,
 						test->immediate_response);
@@ -1284,7 +1283,7 @@ static void test_get_inkey(gconstpointer data)
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
 =

 	g_assert(command->get_inkey.text);
-	check_text(command->get_inkey.text, test->text);
+	check_common_text(command->get_inkey.text, test->text);
 	check_icon_id(&command->get_inkey.icon_id, &test->icon_id);
 	check_duration(&command->get_inkey.duration, &test->duration);
 	check_text_attr(&command->get_inkey.text_attr,
@@ -2590,9 +2589,9 @@ static void test_get_input(gconstpointer data)
 =

 	if (test->text)
 		g_assert(command->get_input.text);
-	check_text(command->get_input.text, test->text);
+	check_common_text(command->get_input.text, test->text);
 	check_response_length(&command->get_input.resp_len, &test->resp_len);
-	check_text(command->get_input.default_text, test->default_text);
+	check_common_text(command->get_input.default_text, test->default_text);
 	check_icon_id(&command->get_input.icon_id, &test->icon_id);
 	check_text_attr(&command->get_input.text_attr,
 						&test->text_attr);
-- =

1.7.0.4


--===============5243448561039203704==--

