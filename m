Content-Type: multipart/mixed; boundary="===============3202348813043696548=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [RFC PATCH] stk: add support of next action for menu
Date: Thu, 09 Dec 2010 13:00:49 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136D961EA@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3202348813043696548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

According to the 3GPP 31.124 the support of next action
in SIM toolkit menus is mandatory.
---
 doc/stk-api.txt    |    5 +++--
 src/stk.c          |    6 ++++++
 src/stkagent.c     |    6 ++++--
 src/stkagent.h     |    1 +
 test/test-stk-menu |    6 +++---
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 79daee6..f5bcae4 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -66,13 +66,14 @@ Properties	string IdleModeText [readonly]
 			Contains the identifier of the icon accompanying
 			the idle mode text.
 =

-		array{struct{string, byte}} MainMenu [readonly]
+		array{struct{string, byte, byte}} MainMenu [readonly]
 =

 			Contains the items that make up the main menu.  This
 			is populated by the SIM when it sends the Setup Menu
 			Proactive Command.  The main menu is always available,
 			but its contents can be changed at any time.  Each
-			item contains the item label and icon identifier.
+			item contains the item label, the icon identifier and
+			the next action identifier.
 =

 		string MainMenuTitle [readonly]
 =

diff --git a/src/stk.c b/src/stk.c
index 7b39f7e..086b540 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -320,6 +320,7 @@ static struct stk_menu *stk_menu_create(const char *tit=
le,
 		const struct stk_icon_id *icon, GSList *items,
 		const struct stk_item_text_attribute_list *item_attrs,
 		const struct stk_item_icon_id_list *item_icon_ids,
+		const struct stk_items_next_action_indicator *next_act,
 		int default_id, gboolean soft_key, gboolean has_help)
 {
 	unsigned int len =3D g_slist_length(items);
@@ -374,6 +375,9 @@ static struct stk_menu *stk_menu_create(const char *tit=
le,
 		if (item_icon_ids && item_icon_ids->len)
 			ret->items[i].icon_id =3D item_icon_ids->list[i];
 =

+		if (next_act && next_act->len)
+			ret->items[i].next_act =3D next_act->list[i];
+
 		if (item->id =3D=3D default_id)
 			ret->default_item =3D i;
 	}
@@ -393,6 +397,7 @@ static struct stk_menu *stk_menu_create_from_set_up_men=
u(
 				cmd->setup_menu.items,
 				&cmd->setup_menu.item_text_attr_list,
 				&cmd->setup_menu.item_icon_id_list,
+				&cmd->setup_menu.next_act,
 				0, soft_key, has_help);
 }
 =

@@ -408,6 +413,7 @@ static struct stk_menu *stk_menu_create_from_select_ite=
m(
 				cmd->select_item.items,
 				&cmd->select_item.item_text_attr_list,
 				&cmd->select_item.item_icon_id_list,
+				&cmd->select_item.next_act,
 				cmd->select_item.item_id, soft_key, has_help);
 }
 =

diff --git a/src/stkagent.c b/src/stkagent.c
index e1a6f48..5175776 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -246,7 +246,7 @@ static void append_menu_items(DBusMessageIter *iter,
 	DBusMessageIter array, entry;
 =

 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-						"(sy)", &array);
+						"(syy)", &array);
 =

 	while (item && item->text) {
 		dbus_message_iter_open_container(&array, DBUS_TYPE_STRUCT,
@@ -256,6 +256,8 @@ static void append_menu_items(DBusMessageIter *iter,
 						&item->text);
 		dbus_message_iter_append_basic(&entry, DBUS_TYPE_BYTE,
 						&item->icon_id);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_BYTE,
+						&item->next_act);
 =

 		dbus_message_iter_close_container(&array, &entry);
 		item++;
@@ -270,7 +272,7 @@ void append_menu_items_variant(DBusMessageIter *iter,
 	DBusMessageIter variant;
 =

 	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
-						"a(sy)", &variant);
+						"a(syy)", &variant);
 =

 	append_menu_items(&variant, items);
 =

diff --git a/src/stkagent.h b/src/stkagent.h
index 517bcfe..938b2f8 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -33,6 +33,7 @@ struct stk_menu_item {
 	char *text;
 	uint8_t icon_id;
 	uint8_t item_id;
+	uint8_t next_act;
 };
 =

 struct stk_menu {
diff --git a/test/test-stk-menu b/test/test-stk-menu
index 94d2d6b..32976a5 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -27,12 +27,12 @@ class StkAgent(dbus.service.Object):
 			mainloop.quit()
 =

 	@dbus.service.method("org.ofono.SimToolkitAgent",
-				in_signature=3D"sya(sy)n", out_signature=3D"y")
+				in_signature=3D"sya(syy)n", out_signature=3D"y")
 	def RequestSelection(self, title, icon, items, default):
 		print "Title: (%s)" % (title)
 		index =3D 0;
 		for item in items:
-			print "%d. %s" % (index, item[0])
+			print "%d. %s (%d, %d)" % (index, item[0], item[1], item[2])
 			index +=3D 1
 =

 		print "\nDefault: %d" % (default)
@@ -175,7 +175,7 @@ if __name__ =3D=3D '__main__':
 		print "Items:"
 		index =3D 0
 		for item in properties["MainMenu"]:
-			print "%d. %s" % (index, item[0])
+			print "%d. %s (%d, %d)" % (index, item[0], item[1], item[2])
 			index +=3D 1
 =

 	path =3D "/test/agent"
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3202348813043696548==--

