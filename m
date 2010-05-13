Content-Type: multipart/mixed; boundary="===============4885789353700762578=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 03/27] stkutil: Add setup menu proactive command parser
Date: Thu, 13 May 2010 18:48:20 +0800
Message-ID: <1273747724-28019-3-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4885789353700762578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.c |   12 +++++
 src/simutil.h |    3 +
 src/stkutil.c |  138 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/stkutil.h |   11 +++++
 4 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 941c551..b98c011 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -307,6 +307,18 @@ const unsigned char *comprehension_tlv_iter_get_data(
 	return iter->data;
 }
 =

+void comprehension_tlv_iter_copy(struct comprehension_tlv_iter *from,
+					struct comprehension_tlv_iter *to)
+{
+	to->max =3D from->max;
+	to->pos =3D from->pos;
+	to->pdu =3D from->pdu;
+	to->tag =3D from->tag;
+	to->cr =3D from->cr;
+	to->len =3D from->len;
+	to->data =3D from->data;
+}
+
 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len)
 {
diff --git a/src/simutil.h b/src/simutil.h
index 7590cca..45b6847 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -132,6 +132,9 @@ unsigned int comprehension_tlv_iter_get_length(
 const unsigned char *comprehension_tlv_iter_get_data(
 					struct comprehension_tlv_iter *iter);
 =

+void comprehension_tlv_iter_copy(struct comprehension_tlv_iter *from,
+					struct comprehension_tlv_iter *to);
+
 void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *pdu,
 			unsigned int len);
 /*
diff --git a/src/stkutil.c b/src/stkutil.c
index 46f4796..1698321 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -281,8 +281,8 @@ static gboolean parse_dataobj_alpha_id(struct comprehen=
sion_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 1)
-		return FALSE;
+	if (len =3D=3D 0)
+		return TRUE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
 	utf8 =3D sim_string_to_utf8(data, len);
@@ -373,7 +373,11 @@ static gboolean parse_dataobj_item(struct comprehensio=
n_tlv_iter *iter,
 	char *utf8;
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
-	if (len < 2)
+
+	if (len =3D=3D 0)
+		return TRUE;
+
+	if (len =3D=3D 1)
 		return FALSE;
 =

 	data =3D comprehension_tlv_iter_get_data(iter);
@@ -2022,7 +2026,6 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 		entries =3D g_slist_prepend(entries, entry);
 	}
 =

-
 	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
 		goto out;
 =

@@ -2039,6 +2042,10 @@ static gboolean parse_dataobj(struct comprehension_t=
lv_iter *iter,
 		if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type) {
 			if (handler(iter, entry->data))
 				entry->parsed =3D TRUE;
+
+			if (l->next =3D=3D NULL)
+				break;
+
 			if (comprehension_tlv_iter_next(iter) =3D=3D FALSE)
 				break;
 		}
@@ -2255,6 +2262,126 @@ static gboolean parse_poll_interval(struct stk_comm=
and *command,
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
+static gboolean parse_list(struct comprehension_tlv_iter *iter,
+		enum stk_data_object_type type,	int flags, GSList **list)
+{
+	struct comprehension_tlv_iter iter_old;
+	void *dataobj;
+	gboolean has_obj =3D FALSE;
+	dataobj_handler handler =3D handler_for_type(type);
+	gboolean ret;
+
+	if ((type !=3D STK_DATA_OBJECT_TYPE_ITEM) && (type !=3D
+			STK_DATA_OBJECT_TYPE_PROVISIONING_FILE_REFERENCE))
+		return FALSE;
+
+	comprehension_tlv_iter_copy(iter, &iter_old);
+
+	while (comprehension_tlv_iter_next(iter)) {
+		if (comprehension_tlv_iter_get_tag(iter) !=3D type)
+			break;
+
+		comprehension_tlv_iter_copy(iter, &iter_old);
+
+		if (type =3D=3D STK_DATA_OBJECT_TYPE_ITEM)
+			dataobj =3D g_try_new0(struct stk_item, 1);
+		else
+			dataobj =3D g_try_new0(struct stk_file, 1);
+
+		if (!dataobj)
+			goto out;
+
+		ret =3D handler(iter, dataobj);
+		has_obj |=3D ret;
+
+		if (type =3D=3D STK_DATA_OBJECT_TYPE_ITEM) {
+			struct stk_item *item =3D dataobj;
+
+			/* either return is FALSE or item is empty */
+			if (item->id =3D=3D 0)
+				g_free(dataobj);
+			else
+				*list =3D g_slist_prepend(*list, dataobj);
+		} else
+			*list =3D g_slist_prepend(*list, dataobj);
+	}
+
+	comprehension_tlv_iter_copy(&iter_old, iter);
+out:
+	if ((flags & DATAOBJ_FLAG_MANDATORY) && !has_obj)
+		return FALSE;
+
+	*list =3D g_slist_reverse(*list);
+
+	return TRUE;
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
+			STK_DATA_OBJECT_TYPE_INVALID);
+
+	if (ret =3D=3D FALSE)
+		goto error;
+
+	ret =3D parse_list(iter, STK_DATA_OBJECT_TYPE_ITEM,
+				DATAOBJ_FLAG_MANDATORY, &obj->items);
+
+	if (ret =3D=3D FALSE)
+		goto error;
+
+	ret =3D parse_dataobj(iter,
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
@@ -2386,6 +2513,9 @@ struct stk_command *stk_command_new_from_pdu(const un=
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
index 02451b4..e22292b 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -828,6 +828,16 @@ struct stk_command_poll_interval {
 	struct stk_duration duration;
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
@@ -852,6 +862,7 @@ struct stk_command {
 		struct stk_command_play_tone play_tone;
 		struct stk_command_send_sms send_sms;
 		struct stk_command_poll_interval poll_interval;
+		struct stk_command_setup_menu setup_menu;
 	};
 =

 	void (*destructor)(struct stk_command *command);
-- =

1.7.0.4


--===============4885789353700762578==--

