Content-Type: multipart/mixed; boundary="===============4500746103753379667=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/13] stk: Add icon ID information in stk_menu.
Date: Wed, 13 Oct 2010 15:54:10 +0200
Message-ID: <1286978056-16600-7-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4500746103753379667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   25 ++++++++++++++++++++++---
 src/stkagent.c |    2 +-
 src/stkagent.h |    2 +-
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index c5478b8..3635579 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -256,19 +256,28 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, =
const struct cbs *msg)
 }
 =

 static struct stk_menu *stk_menu_create(const char *title,
-		const struct stk_text_attribute *title_attr, GSList *items,
+		const struct stk_text_attribute *title_attr,
+		const struct stk_icon_id *icon, GSList *items,
 		const struct stk_item_text_attribute_list *item_attrs,
+		const struct stk_item_icon_id_list *item_icon_ids,
 		int default_id, gboolean soft_key, gboolean has_help)
 {
 	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
+	unsigned int len =3D g_slist_length(items);
 	GSList *l;
 	int i;
 =

 	DBG("");
 =

+	if (item_attrs && item_attrs->len && item_attrs->len !=3D len * 4)
+		goto error;
+
+	if (item_icon_ids && item_icon_ids->len && item_icon_ids->len !=3D len)
+		goto error;
+
 	ret->title =3D g_strdup(title ? title : "");
-	ret->icon_id =3D 0;
-	ret->items =3D g_new0(struct stk_menu_item, g_slist_length(items) + 1);
+	memcpy(&ret->icon, icon, sizeof(ret->icon));
+	ret->items =3D g_new0(struct stk_menu_item, len + 1);
 	ret->default_item =3D -1;
 	ret->soft_key =3D soft_key;
 	ret->has_help =3D has_help;
@@ -278,12 +287,18 @@ static struct stk_menu *stk_menu_create(const char *t=
itle,
 =

 		ret->items[i].text =3D g_strdup(item->text);
 		ret->items[i].item_id =3D item->id;
+		if (item_icon_ids && item_icon_ids->len)
+			ret->items[i].icon_id =3D item_icon_ids->list[i];
 =

 		if (item->id =3D=3D default_id)
 			ret->default_item =3D i;
 	}
 =

 	return ret;
+
+error:
+	g_free(ret);
+	return NULL;
 }
 =

 static struct stk_menu *stk_menu_create_from_set_up_menu(
@@ -294,8 +309,10 @@ static struct stk_menu *stk_menu_create_from_set_up_me=
nu(
 =

 	return stk_menu_create(cmd->setup_menu.alpha_id,
 				&cmd->setup_menu.text_attr,
+				&cmd->setup_menu.icon_id,
 				cmd->setup_menu.items,
 				&cmd->setup_menu.item_text_attr_list,
+				&cmd->setup_menu.item_icon_id_list,
 				0, soft_key, has_help);
 }
 =

@@ -307,8 +324,10 @@ static struct stk_menu *stk_menu_create_from_select_it=
em(
 =

 	return stk_menu_create(cmd->select_item.alpha_id,
 				&cmd->select_item.text_attr,
+				&cmd->select_item.icon_id,
 				cmd->select_item.items,
 				&cmd->select_item.item_text_attr_list,
+				&cmd->select_item.item_icon_id_list,
 				cmd->select_item.item_id, soft_key, has_help);
 }
 =

diff --git a/src/stkagent.c b/src/stkagent.c
index 82518f1..354b87d 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -345,7 +345,7 @@ int stk_agent_request_selection(struct stk_agent *agent,
 	dbus_message_iter_init_append(agent->msg, &iter);
 =

 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &menu->title);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon_id);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon.id);
 	append_menu_items(&iter, menu->items);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
 =

diff --git a/src/stkagent.h b/src/stkagent.h
index ea84a49..97c4eca 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -36,7 +36,7 @@ struct stk_menu_item {
 =

 struct stk_menu {
 	char *title;
-	uint8_t icon_id;
+	struct stk_icon_id icon;
 	struct stk_menu_item *items;
 	int default_item;
 	gboolean soft_key;
-- =

1.7.1.86.g0e460.dirty


--===============4500746103753379667==--

