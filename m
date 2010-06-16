Content-Type: multipart/mixed; boundary="===============7649698346190485805=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] Add STK Menu D-bus interface.
Date: Wed, 16 Jun 2010 17:26:55 +0200
Message-ID: <1276702015-8711-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1276702015-8711-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7649698346190485805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is tested on the F3607gw only, here's a proposed api (comments
welcome).  The patch implements two STK commands: Menu Selection and
Set Up Menu.  Set Up Menu just sets up a menu from which the user can
choose an option at any time, request help on an item etc, the menu
can change when a new Set Up Menu commands is issued by SIM.  Menu
Selection does more or less the same thing, but the menu is only valid
for the period when the command is executing.  The selected option or
"No response" result needs to be returned in TERMINAL RESPONSE, meaning
that the menu can't stay for too long because other STK communication
is blocked.  (the F3607gw will even cancel the command on it's own
after some 20-30 seconds by sending us *STKEND - not handle yet)

ofono.org.SimApplication
Methods:
	dict GetProperties()
		Returns properties.

	SetProperty(string name, int value)
		Sets a property (only MenuTimeout is writable).

	Select(int item_number)
		Selects the given item, the number is a 0-based item
		index in the MenuItems array.  For Menu Selection this
		terminates the command and brings back the default
		menu (set up by Set Up Menu).

	RequestHelp(int item_number)
		Returns a help request to the card for the given menu
		item.  For Menu Selection this also terminates the
		command.

	GoBack()
		Sends a Go Back response to the Menu Selection command.
		(Only valid when the command is executing)

	EndSession()
		Sends a User Terminated Session response to the Menu
		Selection command.  (Only valid when the command is
		executing)

Signals:
	PropertyChanged(string name, variant value)

Properties:
	string[] MenuItems
		List of menu entries.  When a Menu Selection command is
		executing this is the temporary menu, after the command
		terminates it goes back to presenting the global menu
		given by Set Up Menu.  An other possibility would be
		for there to be a list of menu objects, each having a
		list of items, title, help available indicator and
		Select, GetHelp, GoBack, EndSession methods.  This
		would also avoid a race when a user calls Select() at
		the same time the MenuItems changes.

	string MenuTitle

	bool HelpAvailable

	int Timeout (read-write)
		Only present when Menu Selection is executing.  After
		the given number of seconds from the command's start,
		or from last write, expires, "No Response" is returned
		to the card.
---
 include/dbus.h |    1 +
 src/stk.c      |  520 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 521 insertions(+), 0 deletions(-)

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
index 9a9d596..56bf573 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -51,12 +51,28 @@ typedef gboolean (*command_handler_t)(const struct stk_=
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
 	command_handler_t handlers[256];
 	struct stk_command *pending_cmd;
+	DBusMessage *pending;
+
+	struct stk_menu *default_menu;
+	struct stk_menu *current_menu; /* For Select Item menus */
+	int timeout;
 };
 =

 static void stk_respond(struct ofono_stk *stk, struct stk_command *cmd,
@@ -226,6 +242,415 @@ static void stk_command_handler_register(struct ofono=
_stk *stk,
 	stk->handlers[type] =3D handler;
 }
 =

+static struct stk_menu *stk_menu_create(const char *title,
+		const struct stk_text_attribute *title_attr, GSList *items,
+		const struct stk_item_text_attribute_list *item_attrs,
+		const struct stk_items_next_action_indicator *next_action,
+		int default_item, gboolean soft_key, gboolean has_help)
+{
+	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
+	GSList *l;
+
+	ret->title =3D g_strdup(title);
+	ret->default_item =3D default_item;
+	ret->items =3D g_slist_copy((GSList *) items);
+	memcpy(&ret->next_action, next_action, sizeof(ret->next_action));
+	memcpy(&ret->title_attr, title_attr, sizeof(ret->title_attr));
+	memcpy(&ret->item_attrs, item_attrs, sizeof(ret->item_attrs));
+	ret->soft_key =3D soft_key;
+	ret->has_help =3D has_help;
+
+	for (l =3D ret->items; l; l =3D l->next) {
+		struct stk_item *i =3D g_memdup(l->data, sizeof(*i));
+
+		i->text =3D g_strdup(i->text);
+		l->data =3D i;
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
+
+	if (stk->default_menu)
+		menu =3D stk->default_menu;
+	if (stk->current_menu)
+		menu =3D stk->current_menu;
+
+	if (stk->current_menu)
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"MenuTimeout",
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
+	if (menu->default_item >=3D 0) {
+		byteval =3D menu->default_item;
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"DefaultSelection",
+						DBUS_TYPE_BYTE, &byteval);
+	}
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
+	if (stk->current_menu)
+		ofono_dbus_dict_append(&dict, "MenuTimeout",
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
+	if (stk->current_menu && !strcmp(property, "MenuTimeout")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT16)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &timeout);
+		if (dbus_message_iter_next(&iter))
+			return __ofono_error_invalid_args(msg);
+
+		stk->timeout =3D timeout;
+		/* TODO: reschedule */
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"MenuTimeout",
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
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Selecting item returned error: %s",
+			telephony_error_to_str(error));
+
+		__ofono_dbus_pending_reply(&stk->pending,
+					__ofono_error_failed(stk->pending));
+		return;
+	}
+
+	__ofono_dbus_pending_reply(&stk->pending,
+				dbus_message_new_method_return(stk->pending));
+
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+
+	stk_menu_free(stk->current_menu);
+	stk->current_menu =3D NULL;
+
+	emit_menu_changed(stk);
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
+	stk_respond(stk, NULL, &rsp, select_item_cb);
+}
+
+static void menu_selection_cb(const struct ofono_error *error,
+				const unsigned char *data, int len,
+				struct ofono_stk *stk)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Selecting item returned error: %s",
+			telephony_error_to_str(error));
+
+		__ofono_dbus_pending_reply(&stk->pending,
+					__ofono_error_failed(stk->pending));
+		return;
+	}
+
+	if (len)
+		ofono_error("Selecting item returned %i bytes of data", len);
+
+	__ofono_dbus_pending_reply(&stk->pending,
+				dbus_message_new_method_return(stk->pending));
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
+	if (!stk->pending_cmd)
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
+	stk_respond(stk, NULL, &rsp, select_item_cb);
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
@@ -235,6 +660,57 @@ static gboolean handle_command_more_time(const struct =
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
+	/* TODO: schedule timeout */
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
+					-1, soft_key, has_help);
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
@@ -256,6 +732,29 @@ void ofono_stk_driver_unregister(const struct ofono_st=
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
+		/* TODO: potentially cancel the timeout */
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
@@ -305,14 +804,35 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem=
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


--===============7649698346190485805==--

