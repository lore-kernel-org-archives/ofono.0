Content-Type: multipart/mixed; boundary="===============2006056287892793240=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] unit: fix broken alpha id unit test cases
Date: Sat, 19 Mar 2011 00:09:23 -0700
Message-ID: <1300518563-22068-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2006056287892793240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index f1cad78..aa62aac 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -129,7 +129,10 @@ static inline void check_address(const struct stk_addr=
ess *command,
 /* Defined in TS 102.223 Section 8.2 */
 static inline void check_alpha_id(const char *command, const char *test)
 {
-	check_common_text(command, test);
+	if (test !=3D NULL && strlen(test) > 0)
+		check_common_text(command, test);
+	else
+		g_assert(command =3D=3D NULL);
 }
 =

 /* Defined in TS 102.223 Section 8.3 */
@@ -5937,8 +5940,6 @@ static void test_setup_menu(gconstpointer data)
 	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
 	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
 =

-	if (test->alpha_id)
-		g_assert(command->setup_menu.alpha_id);
 	check_alpha_id(command->setup_menu.alpha_id, test->alpha_id);
 	check_items(command->setup_menu.items, test->items);
 	check_items_next_action_indicator(&command->setup_menu.next_act,
-- =

1.7.0.4


--===============2006056287892793240==--

