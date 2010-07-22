Content-Type: multipart/mixed; boundary="===============8529502971513574382=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] stk: Handle the main menu.
Date: Thu, 22 Jul 2010 13:42:51 +0200
Message-ID: <1279798973-6612-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279798973-6612-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8529502971513574382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 22cf99b..17daa00 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -86,6 +86,7 @@ struct ofono_stk {
 	struct stk_command *pending_cmd;
 	void (*cancel_cmd)(struct ofono_stk *stk);
 	GQueue *envelope_q;
+	DBusMessage *pending;
 =

 	struct stk_timer timers[8];
 	guint timers_source;
@@ -94,6 +95,8 @@ struct ofono_stk {
 	int short_timeout;
 	struct stk_app_agent *primary_agent;
 	struct stk_app_agent *default_agent;
+	struct stk_menu *main_menu;
+	gboolean in_session;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -351,6 +354,65 @@ static void append_menu(DBusMessage *msg, struct stk_m=
enu *menu)
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
 }
 =

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
+	struct stk_menu *menu =3D &no_menu;
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	char *name =3D "MainMenu";
+
+	if (stk->main_menu && !stk->in_session)
+		menu =3D stk->main_menu;
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
+	append_menu_items(&iter, menu);
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
+	append_menu_items(&entry, menu);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
 {
 	/* TODO */
@@ -384,6 +446,9 @@ static DBusMessage *stk_get_properties(DBusConnection *=
conn,
 	ofono_dbus_dict_append(&dict, "IdleModeText",
 				DBUS_TYPE_STRING, &idle_mode_text);
 =

+	if (stk->main_menu && !stk->in_session)
+		dict_append_menu(&dict, stk->main_menu);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
@@ -717,14 +782,69 @@ static DBusMessage *stk_unregister_agent(DBusConnecti=
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
+	if (dbus_message_get_args(stk->pending, NULL,
+					DBUS_TYPE_BYTE, &selection,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		reply =3D __ofono_error_failed(stk->pending);
+
+		goto out;
+	}
+
+	stk->primary_agent =3D app_agent_create(stk, agent_path,
+					dbus_message_get_sender(stk->pending));
+	if (!stk->primary_agent) {
+		reply =3D __ofono_error_failed(stk->pending);
+
+		goto out;
+	}
+
+	reply =3D dbus_message_new_method_return(stk->pending);
+
+	if (!stk->in_session) {
+		stk->in_session =3D TRUE;
+		emit_menu_changed(stk);
+	}
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
 	unsigned char selection;
+	struct stk_envelope e;
+	struct stk_menu *menu =3D stk->main_menu;
+	struct stk_item *item =3D NULL;
 =

-	if (stk->primary_agent)
+	if (stk->pending)
+		return __ofono_error_busy(msg);
+
+	if (stk->primary_agent || !menu)
 		return __ofono_error_busy(msg);
 =

 	if (dbus_message_get_args(msg, NULL,
@@ -733,7 +853,20 @@ static DBusMessage *stk_select_item(DBusConnection *co=
nn,
 					DBUS_TYPE_INVALID) =3D=3D FALSE)
 		return __ofono_error_invalid_args(msg);
 =

-	/* TODO */
+	item =3D g_slist_nth_data(menu->items, selection);
+	if (!item)
+		return __ofono_error_invalid_format(msg);
+
+	memset(&e, 0, sizeof(e));
+	e.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+	e.menu_selection.item_id =3D item->id;
+	e.menu_selection.help_request =3D FALSE;
+
+	if (stk_send_envelope(stk, &e, menu_selection_envelope_cb, 0))
+		return __ofono_error_failed(msg);
+
+	stk->pending =3D dbus_message_ref(msg);
 =

 	return NULL;
 }
@@ -1047,6 +1180,38 @@ static gboolean handle_command_poll_interval(const s=
truct stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean handle_command_set_up_menu(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 0)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	if (stk->main_menu) {
+		stk_menu_free(stk->main_menu);
+		stk->main_menu =3D NULL;
+	}
+
+	if (cmd->setup_menu.items =3D=3D NULL)
+		goto out;
+
+	stk->main_menu =3D stk_menu_create(cmd->setup_menu.alpha_id,
+					&cmd->setup_menu.text_attr,
+					cmd->setup_menu.items,
+					&cmd->setup_menu.item_text_attr_list,
+					&cmd->setup_menu.next_act,
+					0, soft_key, has_help);
+
+	if (!stk->main_menu)
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+out:
+	if (!stk->in_session)
+		emit_menu_changed(stk);
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1068,6 +1233,11 @@ void ofono_stk_proactive_session_end_notify(struct o=
fono_stk *stk)
 		app_agent_remove(stk->primary_agent);
 		stk->primary_agent =3D NULL;
 	}
+
+	if (stk->in_session) {
+		stk->in_session =3D FALSE;
+		emit_menu_changed(stk);
+	}
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -1128,6 +1298,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
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
@@ -1200,6 +1374,11 @@ static void stk_unregister(struct ofono_atom *atom)
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


--===============8529502971513574382==--

