Content-Type: multipart/mixed; boundary="===============7872971497408381905=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] stk: Add menu related utilities.
Date: Thu, 15 Jul 2010 15:18:07 +0200
Message-ID: <1279199891-22746-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279199891-22746-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7872971497408381905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 28a1beb..f3d8247 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -55,6 +55,17 @@ enum stk_agent_result {
 	STK_AGENT_RESULT_CANCEL,
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
 struct stk_app_agent {
 	char *path;
 	char *bus;
@@ -246,6 +257,87 @@ static void stk_command_cb(const struct ofono_error *e=
rror, void *data)
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
+static char **stk_menu_items_strlist(struct stk_menu *menu)
+{
+	char **items =3D g_new0(char *, g_slist_length(menu->items) + 1);
+	int i;
+	GSList *l;
+
+	for (i =3D 0, l =3D menu->items; l; l =3D l->next, i++) {
+		struct stk_item *item =3D l->data;
+		items[i] =3D item->text;
+	}
+
+	return items;
+}
+
+static void append_menu(DBusMessage *msg, struct stk_menu *menu,
+			dbus_bool_t main_menu)
+{
+	char **items;
+	dbus_bool_t has_help =3D menu->has_help;
+	dbus_int16_t default_item =3D menu->default_item;
+
+	items =3D stk_menu_items_strlist(menu);
+	dbus_message_append_args(msg,
+					DBUS_TYPE_ARRAY, DBUS_TYPE_STRING,
+					&items, g_slist_length(menu->items),
+					DBUS_TYPE_STRING, &menu->title,
+					DBUS_TYPE_BOOLEAN, &has_help,
+					DBUS_TYPE_INT16, &default_item,
+					DBUS_TYPE_BOOLEAN, &main_menu,
+					DBUS_TYPE_INVALID);
+	g_free(items);
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
 {
 	/* TODO */
-- =

1.7.1.86.g0e460.dirty


--===============7872971497408381905==--

