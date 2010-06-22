Content-Type: multipart/mixed; boundary="===============1177180744073441818=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] stk: Add SimApplication interface.
Date: Tue, 22 Jun 2010 13:20:47 +0200
Message-ID: <1277205651-29369-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1177180744073441818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 src/stk.c      |  585 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 585 insertions(+), 1 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index d988760..6b03dd7 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -49,6 +49,7 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_DATA_CONNECTION_MANAGER_INTERFACE "org.ofono.DataConnectionM=
anager"
 #define OFONO_DATA_CONTEXT_INTERFACE "org.ofono.PrimaryDataContext"
+#define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimApplication"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
diff --git a/src/stk.c b/src/stk.c
index e3f6253..3959dc7 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -34,6 +34,7 @@
 =

 #include "ofono.h"
 =

+#include "common.h"
 #include "smsutil.h"
 #include "stkutil.h"
 =

@@ -50,12 +51,29 @@ typedef gboolean (*command_handler_t)(const struct stk_=
command *cmd,
 					struct stk_response *rsp,
 					struct ofono_stk *stk);
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
 	struct ofono_atom *atom;
 	command_handler_t handlers[STK_COMMAND_TYPE_END_SESSION + 1];
 	struct stk_command *pending_cmd;
+	DBusMessage *pending;
+	gint cmd_timeout;
+
+	struct stk_menu *default_menu;
+	struct stk_menu *current_menu; /* For Select Item menus */
+	int timeout;
 };
 =

 static void stk_respond(struct ofono_stk *stk,
@@ -148,7 +166,8 @@ static void stk_command_cb(const struct ofono_error *er=
ror,
 	stk->pending_cmd =3D NULL;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
-		ofono_error("TERMINAL RESPONSE to a UICC command failed");
+		ofono_error("TERMINAL RESPONSE to a UICC command failed: %s",
+				telephony_error_to_str(error));
 		/* "The ME may retry to deliver the same Cell Broadcast
 		 * page." */
 		return;
@@ -229,6 +248,469 @@ static gboolean stk_command_handler_register(struct o=
fono_stk *stk,
 	return TRUE;
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
+	ret->title =3D g_strdup(title);
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
+static void emit_menu_changed(struct ofono_stk *stk)
+{
+	static struct stk_menu no_menu =3D {
+		.title =3D "",
+		.items =3D NULL,
+		.has_help =3D FALSE,
+		.default_item =3D -1,
+	};
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+	char **items;
+	struct stk_menu *menu =3D &no_menu;
+	dbus_uint16_t timeout =3D stk->timeout;
+	dbus_bool_t boolval;
+	uint8_t byteval;
+
+	if (stk->default_menu)
+		menu =3D stk->default_menu;
+	if (stk->current_menu)
+		menu =3D stk->current_menu;
+
+	if (stk->cmd_timeout && stk->current_menu)
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"Timeout",
+						DBUS_TYPE_UINT16, &timeout);
+
+	items =3D stk_menu_items_strlist(menu);
+	ofono_dbus_signal_array_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"MenuItems",
+						DBUS_TYPE_STRING, &items);
+	g_free(items);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"MenuTitle",
+						DBUS_TYPE_STRING, &menu->title);
+
+	boolval =3D menu->has_help;
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"HelpAvailable",
+						DBUS_TYPE_BOOLEAN, &boolval);
+
+	boolval =3D stk->current_menu ? FALSE : TRUE;
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"MainMenu",
+						DBUS_TYPE_BOOLEAN, &boolval);
+
+	if (menu->default_item >=3D 0) {
+		byteval =3D menu->default_item;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"DefaultSelection",
+						DBUS_TYPE_BYTE, &byteval);
+	}
+}
+
+static gboolean select_item_timeout(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_response rsp;
+
+	stk->cmd_timeout =3D 0;
+
+	if (stk->pending)
+		/*
+		 * A command is currently executing, do nothing.  The
+		 * command's callback will take care of freeing the
+		 * menu.
+		 */
+		return FALSE;
+
+	ofono_debug("Select Item command timed out");
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_NO_RESPONSE;
+
+	stk_respond(stk, &rsp, stk_command_cb);
+
+	stk_menu_free(stk->current_menu);
+	stk->current_menu =3D NULL;
+
+	emit_menu_changed(stk);
+
+	return FALSE;
+}
+
+static DBusMessage *stk_get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char **items;
+	struct stk_menu *menu =3D stk->default_menu;
+	dbus_uint16_t timeout =3D stk->timeout;
+	dbus_bool_t boolval;
+	uint8_t byteval;
+
+	if (stk->current_menu)
+		menu =3D stk->current_menu;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	if (!menu)
+		goto done;
+
+	if (stk->cmd_timeout && stk->current_menu)
+		ofono_dbus_dict_append(&dict, "Timeout",
+					DBUS_TYPE_UINT16, &timeout);
+
+	items =3D stk_menu_items_strlist(menu);
+	ofono_dbus_dict_append_array(&dict, "MenuItems",
+					DBUS_TYPE_STRING, &items);
+	g_free(items);
+
+	ofono_dbus_dict_append(&dict, "MenuTitle",
+				DBUS_TYPE_STRING, &menu->title);
+
+	boolval =3D menu->has_help;
+	ofono_dbus_dict_append(&dict, "HelpAvailable",
+				DBUS_TYPE_BOOLEAN, &boolval);
+
+	boolval =3D stk->current_menu ? FALSE : TRUE;
+	ofono_dbus_dict_append(&dict, "MainMenu",
+				DBUS_TYPE_BOOLEAN, &boolval);
+
+	if (menu->default_item >=3D 0) {
+		byteval =3D menu->default_item;
+		ofono_dbus_dict_append(&dict, "DefaultSelection",
+					DBUS_TYPE_BYTE, &byteval);
+	}
+
+done:
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *stk_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+	dbus_uint16_t timeout;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	if (!dbus_message_iter_next(&iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (stk->cmd_timeout && stk->current_menu &&
+			!strcmp(property, "Timeout")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT16)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &timeout);
+		if (dbus_message_iter_next(&iter))
+			return __ofono_error_invalid_args(msg);
+
+		stk->timeout =3D timeout;
+
+		g_source_remove(stk->cmd_timeout);
+		stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
+							select_item_timeout,
+							stk);
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"Timeout",
+						DBUS_TYPE_UINT16, &timeout);
+
+		return dbus_message_new_method_return(msg);
+	}
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static void select_item_cb(const struct ofono_error *error,
+				struct ofono_stk *stk)
+{
+	DBusMessage *reply;
+
+	if (stk->cmd_timeout) {
+		/*
+		 * If the command has not timed out yet, return error and
+		 * the user may then retry the selection.  Otherwise assume
+		 * the menu is no longer valid.
+		 */
+		if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+			goto out;
+
+		g_source_remove(stk->cmd_timeout);
+	}
+
+	stk_command_cb(error, stk);
+
+	stk_menu_free(stk->current_menu);
+	stk->current_menu =3D NULL;
+
+	emit_menu_changed(stk);
+
+out:
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(stk->pending);
+	else
+		reply =3D dbus_message_new_method_return(stk->pending);
+
+	__ofono_dbus_pending_reply(&stk->pending, reply);
+}
+
+static void select_item_respond(struct ofono_stk *stk, struct stk_item *it=
em,
+				gboolean help)
+{
+	struct stk_response rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	if (help)
+		rsp.result.type =3D STK_RESULT_TYPE_HELP_REQUESTED;
+
+	rsp.select_item.item_id =3D item->id;
+
+	stk_respond(stk, &rsp, select_item_cb);
+}
+
+static void menu_selection_cb(const struct ofono_error *error,
+				const unsigned char *data, int len,
+				struct ofono_stk *stk)
+{
+	DBusMessage *reply;
+
+	if (len)
+		ofono_error("Selecting item returned %i bytes of data", len);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(stk->pending);
+	else
+		reply =3D dbus_message_new_method_return(stk->pending);
+
+	__ofono_dbus_pending_reply(&stk->pending, reply);
+}
+
+static void send_menu_selection(struct ofono_stk *stk, struct stk_item *it=
em,
+				gboolean help)
+{
+	struct stk_envelope e;
+
+	memset(&e, 0, sizeof(e));
+
+	e.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+	e.menu_selection.item_id =3D item->id;
+	e.menu_selection.help_request =3D help;
+
+	stk_send_envelope(stk, &e, menu_selection_cb);
+}
+
+static DBusMessage *stk_menu_select(DBusConnection *conn, DBusMessage *msg,
+					void *data, gboolean help)
+{
+	struct ofono_stk *stk =3D data;
+	DBusMessageIter iter;
+	uint8_t selection;
+	struct stk_menu *menu;
+	struct stk_item *item;
+
+	if (stk->pending)
+		return __ofono_error_busy(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_BYTE)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &selection);
+	if (dbus_message_iter_next(&iter))
+		return __ofono_error_invalid_args(msg);
+
+	menu =3D stk->default_menu;
+	if (stk->current_menu)
+		menu =3D stk->current_menu;
+
+	if (!menu)
+		return __ofono_error_failed(msg);
+
+	if (help =3D=3D TRUE && !menu->has_help)
+		return __ofono_error_failed(msg);
+
+	item =3D g_slist_nth_data(menu->items, selection);
+	if (!item)
+		return __ofono_error_invalid_args(msg);
+
+	stk->pending =3D dbus_message_ref(msg);
+
+	if (stk->current_menu)
+		select_item_respond(stk, item, help);
+	else
+		send_menu_selection(stk, item, help);
+
+	return NULL;
+}
+
+static DBusMessage *stk_select(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	return stk_menu_select(conn, msg, data, FALSE);
+}
+
+static DBusMessage *stk_get_help(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return stk_menu_select(conn, msg, data, TRUE);
+}
+
+static DBusMessage *stk_back_or_terminate(DBusConnection *conn,
+					DBusMessage *msg, void *data,
+					enum stk_result_type type)
+{
+	struct ofono_stk *stk =3D data;
+	DBusMessageIter iter;
+	struct stk_response rsp;
+
+	if (stk->pending)
+		return __ofono_error_busy(msg);
+
+	if (!stk->current_menu)
+		return __ofono_error_failed(msg);
+
+	if (dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	stk->pending =3D dbus_message_ref(msg);
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
+
+	stk_respond(stk, &rsp, select_item_cb);
+
+	return NULL;
+}
+
+static DBusMessage *stk_go_back(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	return stk_back_or_terminate(conn, msg, data,
+					STK_RESULT_TYPE_GO_BACK);
+}
+
+static DBusMessage *stk_end_session(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	return stk_back_or_terminate(conn, msg, data,
+					STK_RESULT_TYPE_USER_TERMINATED);
+}
+
+static GDBusMethodTable stk_methods[] =3D {
+	{ "GetProperties",	"",	"a{sv}",	stk_get_properties },
+	{ "SetProperty",	"sv",	"",		stk_set_property },
+	{ "Select",		"y",	"",		stk_select,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RequestHelp",	"y",	"",		stk_get_help,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GoBack",		"",	"",		stk_go_back,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ "EndSession",		"",	"",		stk_end_session,
+				G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable stk_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ }
+};
+
 static gboolean handle_command_more_time(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -238,6 +720,59 @@ static gboolean handle_command_more_time(const struct =
stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean handle_command_select_item(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 2)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	stk->current_menu =3D stk_menu_create(cmd->select_item.alpha_id,
+					&cmd->select_item.text_attr,
+					cmd->select_item.items,
+					&cmd->select_item.item_text_attr_list,
+					&cmd->select_item.next_act,
+					cmd->select_item.item_id,
+					soft_key, has_help);
+
+	emit_menu_changed(stk);
+
+	stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
+							select_item_timeout,
+							stk);
+
+	return FALSE;
+}
+
+static gboolean handle_command_set_up_menu(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 0)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	if (stk->default_menu) {
+		stk_menu_free(stk->default_menu);
+		stk->default_menu =3D NULL;
+	}
+
+	if (cmd->setup_menu.items =3D=3D NULL)
+		goto out;
+
+	stk->default_menu =3D stk_menu_create(cmd->setup_menu.alpha_id,
+					&cmd->setup_menu.text_attr,
+					cmd->setup_menu.items,
+					&cmd->setup_menu.item_text_attr_list,
+					&cmd->setup_menu.next_act,
+					0, soft_key, has_help);
+
+out:
+	if (stk->current_menu =3D=3D NULL)
+		emit_menu_changed(stk);
+
+	return TRUE;
+}
+
 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -259,6 +794,33 @@ void ofono_stk_driver_unregister(const struct ofono_st=
k_driver *d)
 =

 static void stk_unregister(struct ofono_atom *atom)
 {
+	struct ofono_stk *stk =3D __ofono_atom_get_data(atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
+	const char *path =3D __ofono_atom_get_path(atom);
+
+	if (stk->pending_cmd) {
+		stk_command_free(stk->pending_cmd);
+		stk->pending_cmd =3D NULL;
+
+		if (stk->cmd_timeout) {
+			g_source_remove(stk->cmd_timeout);
+			stk->cmd_timeout =3D 0;
+		}
+	}
+
+	if (stk->current_menu) {
+		stk_menu_free(stk->current_menu);
+		stk->current_menu =3D NULL;
+	}
+
+	if (stk->default_menu) {
+		stk_menu_free(stk->default_menu);
+		stk->default_menu =3D NULL;
+	}
+
+	ofono_modem_remove_interface(modem, OFONO_SIM_APP_INTERFACE);
+	g_dbus_unregister_interface(conn, path, OFONO_SIM_APP_INTERFACE);
 }
 =

 static void stk_remove(struct ofono_atom *atom)
@@ -308,14 +870,35 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem=
 *modem,
 		break;
 	}
 =

+	stk->timeout =3D 20;
+
 	stk_command_handler_register(stk, STK_COMMAND_TYPE_MORE_TIME,
 					handle_command_more_time);
+	stk_command_handler_register(stk, STK_COMMAND_TYPE_SELECT_ITEM,
+					handle_command_select_item);
+	stk_command_handler_register(stk, STK_COMMAND_TYPE_SETUP_MENU,
+					handle_command_set_up_menu);
 =

 	return stk;
 }
 =

 void ofono_stk_register(struct ofono_stk *stk)
 {
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+
+	if (!g_dbus_register_interface(conn, path, OFONO_SIM_APP_INTERFACE,
+					stk_methods, stk_signals, NULL,
+					stk, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_SIM_APP_INTERFACE);
+
+		return;
+	}
+
+	ofono_modem_add_interface(modem, OFONO_SIM_APP_INTERFACE);
+
 	__ofono_atom_register(stk->atom, stk_unregister);
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============1177180744073441818==--

