Content-Type: multipart/mixed; boundary="===============0865439601853526346=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] stk: Utilities to deal with menus.
Date: Mon, 26 Jul 2010 15:14:37 +0200
Message-ID: <1280150080-6257-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280150080-6257-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0865439601853526346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  132 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a4a091c..29174d7 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -47,6 +47,17 @@ struct stk_timer {
 	time_t start;
 };
 =

+struct stk_menu {
+	char *title;
+	GSList *items;
+	struct stk_items_next_action_indicator next_action;
+	int default_item;
+	struct stk_text_attribute title_attr;
+	struct stk_item_text_attribute_list item_attrs;
+	gboolean soft_key;
+	gboolean has_help;
+};
+
 struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
@@ -223,6 +234,127 @@ static void stk_command_cb(const struct ofono_error *=
error, void *data)
 	DBG("TERMINAL RESPONSE to a command reported no errors");
 }
 =

+static struct stk_menu *stk_menu_create(const char *title,
+		const struct stk_text_attribute *title_attr, GSList *items,
+		const struct stk_item_text_attribute_list *item_attrs,
+		const struct stk_items_next_action_indicator *next_action,
+		int default_id, gboolean soft_key, gboolean has_help)
+{
+	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
+	GSList *l;
+	int i;
+
+	ret->title =3D g_strdup(title ?: "");
+	ret->items =3D g_slist_copy((GSList *) items);
+	ret->default_item =3D -1;
+	memcpy(&ret->next_action, next_action, sizeof(ret->next_action));
+	memcpy(&ret->title_attr, title_attr, sizeof(ret->title_attr));
+	memcpy(&ret->item_attrs, item_attrs, sizeof(ret->item_attrs));
+	ret->soft_key =3D soft_key;
+	ret->has_help =3D has_help;
+
+	for (l =3D ret->items, i =3D 0; l; l =3D l->next, i++) {
+		struct stk_item *j =3D g_memdup(l->data, sizeof(*j));
+
+		j->text =3D g_strdup(j->text);
+		l->data =3D j;
+
+		if (j->id =3D=3D default_id)
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
+				&cmd->setup_menu.next_act,
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
+				&cmd->select_item.next_act,
+				cmd->select_item.item_id, soft_key, has_help);
+}
+
+static void stk_menu_free(struct stk_menu *menu)
+{
+	GSList *l;
+
+	for (l =3D menu->items; l; l =3D l->next) {
+		struct stk_item *i =3D l->data;
+
+		g_free(i->text);
+		g_free(i);
+	}
+
+	g_slist_free(menu->items);
+	g_free(menu->title);
+	g_free(menu);
+}
+
+static void append_menu_items(DBusMessageIter *iter, struct stk_menu *menu)
+{
+	DBusMessageIter variant, array, entry;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						"a(sy)", &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						"(sy)", &array);
+
+	for (l =3D menu->items; l; l =3D l->next) {
+		struct stk_item *item =3D l->data;
+		unsigned char icon_id =3D 0;
+
+		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
+							NULL, &entry);
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&item->text);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_BYTE,
+						&icon_id);
+
+		dbus_message_iter_close_container(&array, &entry);
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
+static void append_menu(DBusMessage *msg, struct stk_menu *menu)
+{
+	dbus_int16_t default_item =3D menu->default_item;
+	unsigned char icon_id =3D 0;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &menu->title);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &icon_id);
+	append_menu_items(&iter, menu);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
 {
 	/* TODO */
-- =

1.7.1.86.g0e460.dirty


--===============0865439601853526346==--

