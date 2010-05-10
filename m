Content-Type: multipart/mixed; boundary="===============7484016712741913266=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 13/19] stkutil: Add select item proactive command parser
Date: Mon, 10 May 2010 18:38:56 +0800
Message-ID: <1273487942-27213-13-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7484016712741913266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/stkutil.h |   13 +++++++++++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 45bb285..ebe1114 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2360,6 +2360,56 @@ error:
 	return FALSE;
 }
 =

+static void destroy_select_item(struct stk_command *command)
+{
+	g_free(command->select_item.alpha_id);
+	g_slist_foreach(command->select_item.items,
+				(GFunc)destroy_stk_item, NULL);
+	g_slist_free(command->select_item.items);
+}
+
+static gboolean parse_select_item(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_select_item *obj =3D &command->select_item;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		return FALSE;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		return FALSE;
+
+	ret =3D parse_dataobj(iter,
+			STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
+			&obj->alpha_id,
+			STK_DATA_OBJECT_TYPE_ITEM,
+			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+			&obj->items,
+			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR, 0,
+			&obj->next_act,
+			STK_DATA_OBJECT_TYPE_ITEM_ID, 0,
+			&obj->item_id,
+			STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+			&obj->icon_id,
+			STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST, 0,
+			&obj->item_icon_id_list,
+			STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+			&obj->text_attr,
+			STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST, 0,
+			&obj->item_text_attr_list,
+			STK_DATA_OBJECT_TYPE_FRAME_ID, 0,
+			&obj->frame_id,
+			STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		return FALSE;
+
+	command->destructor =3D destroy_select_item;
+
+	return TRUE;
+}
+
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
@@ -2486,6 +2536,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_SETUP_MENU:
 		ok =3D parse_setup_menu(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SELECT_ITEM:
+		ok =3D parse_select_item(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index d91ac66..143679f 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -834,6 +834,18 @@ struct stk_command_setup_menu {
 	struct stk_item_text_attribute_list item_text_attr_list;
 };
 =

+struct stk_command_select_item {
+	char *alpha_id;
+	GSList *items;
+	struct stk_items_next_action_indicator next_act;
+	unsigned char item_id;
+	struct stk_icon_id icon_id;
+	struct stk_item_icon_id_list item_icon_id_list;
+	struct stk_text_attribute text_attr;
+	struct stk_item_text_attribute_list item_text_attr_list;
+	struct stk_frame_id frame_id;
+};
+
 struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
@@ -857,6 +869,7 @@ struct stk_command {
 		struct stk_command_get_input get_input;
 		struct stk_command_play_tone play_tone;
 		struct stk_command_setup_menu setup_menu;
+		struct stk_command_select_item select_item;
 		struct stk_command_send_sms send_sms;
 	};
 =

-- =

1.7.0.4


--===============7484016712741913266==--

