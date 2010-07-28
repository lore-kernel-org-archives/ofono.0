Content-Type: multipart/mixed; boundary="===============5304954167357096966=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] stk: Utilities to deal with menus.
Date: Wed, 28 Jul 2010 08:09:34 +0200
Message-ID: <1280297377-20692-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280297377-20692-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5304954167357096966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c |   37 +++++++++++++++++++++++++++++++
 src/stkagent.h |   18 +++++++++++++++
 3 files changed, 122 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8109d48..852c251 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -224,6 +224,73 @@ static void stk_command_cb(const struct ofono_error *e=
rror, void *data)
 	DBG("TERMINAL RESPONSE to a command reported no errors");
 }
 =

+static struct stk_menu *stk_menu_create(const char *title,
+		const struct stk_text_attribute *title_attr, GSList *items,
+		const struct stk_item_text_attribute_list *item_attrs,
+		int default_id, gboolean soft_key, gboolean has_help)
+{
+	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
+	GSList *l;
+	int i;
+
+	ret->title =3D g_strdup(title ? title : "");
+	ret->icon_id =3D 0;
+	ret->items =3D g_new0(struct stk_menu_item, g_slist_length(items) + 1);
+	ret->default_item =3D -1;
+	ret->soft_key =3D soft_key;
+	ret->has_help =3D has_help;
+
+	for (l =3D items, i =3D 0; l; l =3D l->next, i++) {
+		struct stk_item *item =3D l->data;
+
+		ret->items[i].text =3D g_strdup(item->text);
+		ret->items[i].item_id =3D item->id;
+
+		if (item->id =3D=3D default_id)
+			ret->default_item =3D i;
+	}
+
+	return ret;
+}
+
+static struct stk_menu *stk_menu_create_from_set_up_menu(
+						const struct stk_command *cmd)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 0)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	return stk_menu_create(cmd->setup_menu.alpha_id,
+				&cmd->setup_menu.text_attr,
+				cmd->setup_menu.items,
+				&cmd->setup_menu.item_text_attr_list,
+				0, soft_key, has_help);
+}
+
+static struct stk_menu *stk_menu_create_from_select_item(
+						const struct stk_command *cmd)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 2)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	return stk_menu_create(cmd->select_item.alpha_id,
+				&cmd->select_item.text_attr,
+				cmd->select_item.items,
+				&cmd->select_item.item_text_attr_list,
+				cmd->select_item.item_id, soft_key, has_help);
+}
+
+static void stk_menu_free(struct stk_menu *menu)
+{
+	struct stk_menu_item *i;
+
+	for (i =3D menu->items; i->text; i++)
+		g_free(i->text);
+
+	g_free(menu->items);
+	g_free(menu->title);
+	g_free(menu);
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
 {
 	/* TODO */
diff --git a/src/stkagent.c b/src/stkagent.c
index 8feda6d..0daf7d0 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -292,3 +292,40 @@ struct stk_app_agent *app_agent_create(const char *pat=
h, const char *sender,
 =

 	return agent;
 }
+
+static void append_menu_items(DBusMessageIter *iter,
+				const struct stk_menu *menu)
+{
+	DBusMessageIter array, entry;
+	const struct stk_menu_item *i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+						"(sy)", &array);
+
+	for (i =3D menu->items; i->text; i++) {
+		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
+							NULL, &entry);
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&i->text);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_BYTE,
+						&i->icon_id);
+
+		dbus_message_iter_close_container(&array, &entry);
+	}
+
+	dbus_message_iter_close_container(iter, &array);
+}
+
+void append_menu_items_variant(DBusMessageIter *iter,
+				const struct stk_menu *menu)
+{
+	DBusMessageIter variant;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						"a(sy)", &variant);
+
+	append_menu_items(&variant, menu);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 23a65fc..d1f3ffb 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -19,6 +19,21 @@
  *
  */
 =

+struct stk_menu_item {
+	char *text;
+	uint8_t icon_id;
+	uint8_t item_id;
+};
+
+struct stk_menu {
+	char *title;
+	uint8_t icon_id;
+	struct stk_menu_item *items;
+	int default_item;
+	gboolean soft_key;
+	gboolean has_help;
+};
+
 enum stk_agent_result {
 	STK_AGENT_RESULT_OK,
 	STK_AGENT_RESULT_BACK,
@@ -44,3 +59,6 @@ ofono_bool_t app_agent_matches(struct stk_app_agent *agen=
t,
 				const char *path, const char *sender);
 =

 void app_agent_request_cancel(struct stk_app_agent *agent);
+
+void append_menu_items_variant(DBusMessageIter *iter,
+				const struct stk_menu *menu);
-- =

1.7.1.86.g0e460.dirty


--===============5304954167357096966==--

