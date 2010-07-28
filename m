Content-Type: multipart/mixed; boundary="===============6366188033363097304=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] stk: Handle the main menu.
Date: Wed, 28 Jul 2010 12:26:09 +0200
Message-ID: <1280312771-30579-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280312771-30579-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6366188033363097304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 files changed, 171 insertions(+), 4 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index f192c4d..bd7679c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -54,6 +54,7 @@ struct ofono_stk {
 	struct stk_command *pending_cmd;
 	void (*cancel_cmd)(struct ofono_stk *stk);
 	GQueue *envelope_q;
+	DBusMessage *pending;
 =

 	struct stk_timer timers[8];
 	guint timers_source;
@@ -64,6 +65,7 @@ struct ofono_stk {
 	struct stk_agent *session_agent;
 	struct stk_agent *default_agent;
 	struct stk_agent *current_agent; /* Always equals one of the above */
+	struct stk_menu *main_menu;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -291,6 +293,63 @@ static void stk_menu_free(struct stk_menu *menu)
 	g_free(menu);
 }
 =

+static void emit_menu_changed(struct ofono_stk *stk)
+{
+	static struct stk_menu_item end_item =3D {};
+	static struct stk_menu no_menu =3D {
+		.title =3D "",
+		.items =3D &end_item,
+		.has_help =3D FALSE,
+		.default_item =3D -1,
+	};
+	static char *name =3D "MainMenu";
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+	struct stk_menu *menu =3D stk->main_menu ? stk->main_menu : &no_menu;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_STK_INTERFACE,
+						"MainMenuTitle",
+						DBUS_TYPE_STRING, &menu->title);
+
+	signal =3D dbus_message_new_signal(path, OFONO_STK_INTERFACE,
+						"PropertyChanged");
+	if (!signal) {
+		ofono_error("Unable to allocate new %s.PropertyChanged signal",
+				OFONO_SIM_APP_INTERFACE);
+
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	append_menu_items_variant(&iter, menu->items);
+
+	g_dbus_send_message(conn, signal);
+}
+
+static void dict_append_menu(DBusMessageIter *dict, struct stk_menu *menu)
+{
+	DBusMessageIter entry;
+	const char *key =3D "MainMenu";
+
+	ofono_dbus_dict_append(dict, "MainMenuTitle",
+				DBUS_TYPE_STRING, &menu->title);
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_menu_items_variant(&entry, menu->items);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
 {
 	/* TODO */
@@ -324,6 +383,9 @@ static DBusMessage *stk_get_properties(DBusConnection *=
conn,
 	ofono_dbus_dict_append(&dict, "IdleModeText",
 				DBUS_TYPE_STRING, &idle_mode_text);
 =

+	if (stk->main_menu)
+		dict_append_menu(&dict, stk->main_menu);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -435,14 +497,65 @@ static DBusMessage *stk_unregister_agent(DBusConnecti=
on *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+static void menu_selection_envelope_cb(struct ofono_stk *stk, gboolean ok,
+					const unsigned char *data, int len)
+{
+	unsigned char selection;
+	const char *agent_path;
+	DBusMessage *reply;
+
+	if (!ok) {
+		ofono_error("Sending Menu Selection to UICC failed");
+
+		reply =3D __ofono_error_failed(stk->pending);
+
+		goto out;
+	}
+
+	if (len)
+		ofono_error("Menu Selection returned %i bytes of unwanted data",
+				len);
+
+	DBG("Menu Selection envelope submission gave no error");
+
+	dbus_message_get_args(stk->pending, NULL,
+				DBUS_TYPE_BYTE, &selection,
+				DBUS_TYPE_OBJECT_PATH, &agent_path,
+				DBUS_TYPE_INVALID);
+
+	stk->session_agent =3D stk_agent_new(agent_path,
+					dbus_message_get_sender(stk->pending),
+					FALSE);
+	if (!stk->session_agent) {
+		reply =3D __ofono_error_failed(stk->pending);
+
+		goto out;
+	}
+
+	stk_agent_set_destroy_watch(stk->session_agent,
+					session_agent_notify, stk);
+
+	stk->current_agent =3D stk->session_agent;
+
+	reply =3D dbus_message_new_method_return(stk->pending);
+
+out:
+	__ofono_dbus_pending_reply(&stk->pending, reply);
+}
+
 static DBusMessage *stk_select_item(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct ofono_stk *stk =3D data;
 	const char *agent_path;
-	unsigned char selection;
+	unsigned char selection, i;
+	struct stk_envelope e;
+	struct stk_menu *menu =3D stk->main_menu;
 =

-	if (stk->session_agent)
+	if (stk->pending)
+		return __ofono_error_busy(msg);
+
+	if (stk->session_agent || !menu)
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL,
@@ -451,9 +564,26 @@ static DBusMessage *stk_select_item(DBusConnection *co=
nn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	/* TODO */
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	for (i =3D 0; i < selection && menu->items[i].text; i++);
+
+	if (i !=3D selection)
+		return __ofono_error_invalid_format(msg);
+
+	memset(&e, 0, sizeof(e));
+	e.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+	e.menu_selection.item_id =3D menu->items[selection].item_id;
+	e.menu_selection.help_request =3D FALSE;
 =

-	return __ofono_error_not_implemented(msg);
+	if (stk_send_envelope(stk, &e, menu_selection_envelope_cb, 0))
+		return __ofono_error_failed(msg);
+
+	stk->pending =3D dbus_message_ref(msg);
+
+	return NULL;
 }
 =

 static GDBusMethodTable stk_methods[] =3D {
@@ -765,6 +895,34 @@ static gboolean handle_command_poll_interval(const str=
uct stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean handle_command_set_up_menu(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean modified =3D FALSE;
+
+	if (stk->main_menu) {
+		stk_menu_free(stk->main_menu);
+		stk->main_menu =3D NULL;
+
+		modified =3D TRUE;
+	}
+
+	if (cmd->setup_menu.items) {
+		stk->main_menu =3D stk_menu_create_from_set_up_menu(cmd);
+
+		if (stk->main_menu)
+			modified =3D TRUE;
+		else
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+	}
+
+	if (modified)
+		emit_menu_changed(stk);
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -844,6 +1002,10 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 			respond =3D handle_command_poll_interval(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_SETUP_MENU:
+			respond =3D handle_command_set_up_menu(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
@@ -916,6 +1078,11 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk->timers_source =3D 0;
 	}
 =

+	if (stk->main_menu) {
+		stk_menu_free(stk->main_menu);
+		stk->main_menu =3D NULL;
+	}
+
 	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
 	g_queue_free(stk->envelope_q);
 =

-- =

1.7.1.86.g0e460.dirty


--===============6366188033363097304==--

