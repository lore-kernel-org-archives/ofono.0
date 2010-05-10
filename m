Content-Type: multipart/mixed; boundary="===============6172652874023559614=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 11/19] stkutil: Add setup menu proactive command parser
Date: Mon, 10 May 2010 18:38:54 +0800
Message-ID: <1273487942-27213-11-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273487942-27213-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6172652874023559614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++--=
---
 src/stkutil.h |   11 +++++
 2 files changed, 132 insertions(+), 12 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 2074d19..45bb285 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -281,8 +281,9 @@ static gboolean parse_dataobj_alpha_id(struct comprehen=
sion_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 1)
-		return FALSE;
+
+	if (len =3D=3D 0)
+		return TRUE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 	utf8 =3D sim_string_to_utf8(data, len);
@@ -373,8 +374,10 @@ static gboolean parse_dataobj_item(struct comprehensio=
n_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 2)
-		return FALSE;
+
+	if (len =3D=3D 0)
+		return TRUE;
+
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 =

@@ -2006,6 +2009,7 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 	GSList *l;
 	va_list args;
 	gboolean minimum_set =3D TRUE;
+	GSList **list =3D NULL;
 =

 	va_start(args, type);
 =

@@ -2022,29 +2026,74 @@ static gboolean parse_dataobj(struct comprehension_=
tlv_iter *iter,
 		entries =3D g_slist_prepend(entries, entry);
 	}
 =

-
 	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
 		goto out;
 =

 	entries =3D g_slist_reverse(entries);
 =

-	for (l =3D entries; l; l =3D l->next) {
+	for (l =3D entries; l;) {
 		dataobj_handler handler;
 		struct dataobj_handler_entry *entry =3D l->data;
+		unsigned short tag;
+		gboolean ret;
+		void *dataobj;
 =

 		handler =3D handler_for_type(entry->type);
-		if (handler =3D=3D NULL)
+		if (handler =3D=3D NULL) {
+			l =3D l->next;
 			continue;
+		}
 =

-		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
-			if (handler(iter, entry->data))
-				entry->parsed =3D TRUE;
-			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
-				break;
+		tag =3D comprehension_tlv_iter_get_tag(iter);
+		if (tag !=3D entry->type) {
+			l =3D l->next;
+			continue;
 		}
+
+		if (tag =3D=3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE ||
+			tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
+
+			if (tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM)
+				dataobj =3D g_try_new0(struct stk_item, 1);
+			else
+				dataobj =3D g_try_new0(struct stk_file, 1);
+
+			if (!dataobj)
+				goto out;
+
+			if (!list)
+				list =3D entry->data;
+
+			ret =3D handler(iter, dataobj);
+		} else
+			ret =3D handler(iter, entry->data);
+
+		if (ret)
+			entry->parsed =3D TRUE;
+
+		if (tag =3D=3D STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE ||
+			tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
+
+			if (tag =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
+				struct stk_item *item =3D dataobj;
+				/* either return is FALSE or item is empty */
+				if (item->id =3D=3D 0)
+					g_free(item);
+				else
+					*list =3D g_slist_prepend(*list, item);
+			} else
+				*list =3D g_slist_prepend(*list, dataobj);
+		} else
+			l =3D l->next;
+
+		if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
+			break;
 	}
 =

 out:
+	if (list)
+		*list =3D g_slist_reverse(*list);
+
 	for (l =3D entries; l; l =3D l->next) {
 		struct dataobj_handler_entry *entry =3D l->data;
 =

@@ -2254,6 +2303,63 @@ static gboolean parse_poll_interval(struct stk_comma=
nd *command,
 	return TRUE;
 }
 =

+static void destroy_stk_item(struct stk_item *item)
+{
+	g_free(item->text);
+	g_free(item);
+}
+
+static void destroy_setup_menu(struct stk_command *command)
+{
+	g_free(command->setup_menu.alpha_id);
+	g_slist_foreach(command->setup_menu.items,
+				(GFunc)destroy_stk_item, NULL);
+	g_slist_free(command->setup_menu.items);
+}
+
+static gboolean parse_setup_menu(struct stk_command *command,
+					struct comprehension_tlv_iter *iter)
+{
+	struct stk_command_setup_menu *obj =3D &command->setup_menu;
+	gboolean ret;
+
+	if (command->src !=3D STK_DEVICE_IDENTITY_TYPE_UICC)
+		goto error;
+
+	if (command->dst !=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL)
+		goto error;
+
+	ret =3D parse_dataobj(iter,
+			STK_DATA_OBJECT_TYPE_ALPHA_ID,
+			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+			&obj->alpha_id,
+			STK_DATA_OBJECT_TYPE_ITEM,
+			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+			&obj->items,
+			STK_DATA_OBJECT_TYPE_ITEMS_NEXT_ACTION_INDICATOR, 0,
+			&obj->next_act,
+			STK_DATA_OBJECT_TYPE_ICON_ID, 0,
+			&obj->icon_id,
+			STK_DATA_OBJECT_TYPE_ITEM_ICON_ID_LIST, 0,
+			&obj->item_icon_id_list,
+			STK_DATA_OBJECT_TYPE_TEXT_ATTRIBUTE, 0,
+			&obj->text_attr,
+			STK_DATA_OBJECT_TYPE_ITEM_TEXT_ATTRIBUTE_LIST, 0,
+			&obj->item_text_attr_list,
+			STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		goto error;
+
+	command->destructor =3D destroy_setup_menu;
+
+	return TRUE;
+
+error:
+	destroy_setup_menu(command);
+	return FALSE;
+}
+
 static void destroy_send_sms(struct stk_command *command)
 {
 	g_free(command->send_sms.alpha_id);
@@ -2377,6 +2483,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	case STK_COMMAND_TYPE_POLL_INTERVAL:
 		ok =3D parse_poll_interval(command, &iter);
 		break;
+	case STK_COMMAND_TYPE_SETUP_MENU:
+		ok =3D parse_setup_menu(command, &iter);
+		break;
 	case STK_COMMAND_TYPE_SEND_SMS:
 		ok =3D parse_send_sms(command, &iter);
 		break;
diff --git a/src/stkutil.h b/src/stkutil.h
index dc25f99..d91ac66 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -824,6 +824,16 @@ struct stk_command_play_tone {
 	struct stk_frame_id frame_id;
 };
 =

+struct stk_command_setup_menu {
+	char *alpha_id;
+	GSList *items;
+	struct stk_items_next_action_indicator next_act;
+	struct stk_icon_id icon_id;
+	struct stk_item_icon_id_list item_icon_id_list;
+	struct stk_text_attribute text_attr;
+	struct stk_item_text_attribute_list item_text_attr_list;
+};
+
 struct stk_command_send_sms {
 	char *alpha_id;
 	struct stk_address address;
@@ -846,6 +856,7 @@ struct stk_command {
 		struct stk_command_get_inkey get_inkey;
 		struct stk_command_get_input get_input;
 		struct stk_command_play_tone play_tone;
+		struct stk_command_setup_menu setup_menu;
 		struct stk_command_send_sms send_sms;
 	};
 =

-- =

1.7.0.4


--===============6172652874023559614==--

