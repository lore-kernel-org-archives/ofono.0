Content-Type: multipart/mixed; boundary="===============2224139915331993107=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 21/24] stkutil: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-22-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-21-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2224139915331993107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/stkutil.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a03e9b7..ec3f825 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -649,8 +649,7 @@ static gboolean parse_dataobj_file_list(struct comprehe=
nsion_tlv_iter *iter,
 	return TRUE;
 =

 error:
-	g_slist_foreach(*fl, (GFunc) g_free, NULL);
-	g_slist_free(*fl);
+	g_slist_free_full(*fl, g_free);
 	return FALSE;
 }
 =

@@ -2253,8 +2252,9 @@ static dataobj_handler handler_for_type(enum stk_data=
_object_type type)
 	}
 }
 =

-static void destroy_stk_item(struct stk_item *item)
+static void destroy_stk_item(gpointer pointer)
 {
+	struct stk_item *item =3D pointer;
 	g_free(item->text);
 	g_free(item);
 }
@@ -2297,8 +2297,7 @@ static gboolean parse_item_list(struct comprehension_=
tlv_iter *iter,
 	if (count =3D=3D 1)
 		return TRUE;
 =

-	g_slist_foreach(list, (GFunc) destroy_stk_item, NULL);
-	g_slist_free(list);
+	g_slist_free_full(list, destroy_stk_item);
 	return FALSE;
 =

 }
@@ -2420,8 +2419,7 @@ static enum stk_command_parse_result parse_dataobj(
 			minimum_set =3D FALSE;
 	}
 =

-	g_slist_foreach(entries, (GFunc) g_free, NULL);
-	g_slist_free(entries);
+	g_slist_free_full(entries, g_free);
 =

 	if (minimum_set =3D=3D FALSE)
 		return STK_PARSE_RESULT_MISSING_VALUE;
@@ -2624,9 +2622,7 @@ static enum stk_command_parse_result parse_poll_inter=
val(
 static void destroy_setup_menu(struct stk_command *command)
 {
 	g_free(command->setup_menu.alpha_id);
-	g_slist_foreach(command->setup_menu.items,
-				(GFunc) destroy_stk_item, NULL);
-	g_slist_free(command->setup_menu.items);
+	g_slist_free_full(command->setup_menu.items, destroy_stk_item);
 }
 =

 static enum stk_command_parse_result parse_setup_menu(
@@ -2671,9 +2667,7 @@ static enum stk_command_parse_result parse_setup_menu(
 static void destroy_select_item(struct stk_command *command)
 {
 	g_free(command->select_item.alpha_id);
-	g_slist_foreach(command->select_item.items,
-				(GFunc) destroy_stk_item, NULL);
-	g_slist_free(command->select_item.items);
+	g_slist_free_full(command->select_item.items, destroy_stk_item);
 }
 =

 static enum stk_command_parse_result parse_select_item(
@@ -2948,8 +2942,7 @@ static enum stk_command_parse_result parse_setup_call(
 =

 static void destroy_refresh(struct stk_command *command)
 {
-	g_slist_foreach(command->refresh.file_list, (GFunc) g_free, NULL);
-	g_slist_free(command->refresh.file_list);
+	g_slist_free_full(command->refresh.file_list, g_free);
 	g_free(command->refresh.alpha_id);
 }
 =

@@ -3264,9 +3257,7 @@ static void destroy_launch_browser(struct stk_command=
 *command)
 {
 	g_free(command->launch_browser.url);
 	g_free(command->launch_browser.bearer.array);
-	g_slist_foreach(command->launch_browser.prov_file_refs,
-				(GFunc) g_free, NULL);
-	g_slist_free(command->launch_browser.prov_file_refs);
+	g_slist_free_full(command->launch_browser.prov_file_refs, g_free);
 	g_free(command->launch_browser.text_gateway_proxy_id);
 	g_free(command->launch_browser.alpha_id);
 	g_free(command->launch_browser.network_name.array);
@@ -3652,9 +3643,7 @@ static enum stk_command_parse_result parse_get_frames=
_status(
 static void destroy_retrieve_mms(struct stk_command *command)
 {
 	g_free(command->retrieve_mms.alpha_id);
-	g_slist_foreach(command->retrieve_mms.mms_rec_files,
-						(GFunc) g_free, NULL);
-	g_slist_free(command->retrieve_mms.mms_rec_files);
+	g_slist_free_full(command->retrieve_mms.mms_rec_files, g_free);
 }
 =

 static enum stk_command_parse_result parse_retrieve_mms(
@@ -3701,9 +3690,7 @@ static enum stk_command_parse_result parse_retrieve_m=
ms(
 static void destroy_submit_mms(struct stk_command *command)
 {
 	g_free(command->submit_mms.alpha_id);
-	g_slist_foreach(command->submit_mms.mms_subm_files,
-						(GFunc) g_free, NULL);
-	g_slist_free(command->submit_mms.mms_subm_files);
+	g_slist_free_full(command->submit_mms.mms_subm_files, g_free);
 }
 =

 static enum stk_command_parse_result parse_submit_mms(
@@ -3743,9 +3730,7 @@ static enum stk_command_parse_result parse_submit_mms(
 =

 static void destroy_display_mms(struct stk_command *command)
 {
-	g_slist_foreach(command->display_mms.mms_subm_files,
-						(GFunc) g_free, NULL);
-	g_slist_free(command->display_mms.mms_subm_files);
+	g_slist_free_full(command->display_mms.mms_subm_files, g_free);
 }
 =

 static enum stk_command_parse_result parse_display_mms(
-- =

1.9.1

--===============2224139915331993107==--

