Content-Type: multipart/mixed; boundary="===============3958073560367197417=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/9] stk: Handle Select Item and Set Up Menu commands.
Date: Tue, 29 Jun 2010 12:14:07 +0200
Message-ID: <1277806448-5322-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3958073560367197417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  261 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9136732..fd6dcb0 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -61,6 +61,8 @@ struct stk_app_agent {
 =

 enum stk_agent_state {
 	STK_AGENT_IDLE =3D 0,
+	STK_AGENT_MAIN_MENU,
+	STK_AGENT_SELECT_ITEM,
 };
 =

 struct ofono_stk {
@@ -72,11 +74,15 @@ struct ofono_stk {
 	enum stk_agent_state app_agent_state;
 	int timeout; /* Manufacturer defined timeout */
 	int custom_timeout; /* Command defined, overrides default */
+	guint display_source;
 	guint cmd_timeout;
 =

 	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
 	void (*cmd_cb)(struct ofono_stk *stk, DBusMessage *reply);
 =

+	struct stk_menu *main_menu;
+	struct stk_menu *select_item_menu;
+
 	gboolean envelope_q_busy;
 	GQueue *envelope_q;
 };
@@ -95,6 +101,7 @@ struct envelope_op {
 #define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX "Terminated"
 =

 static void envelope_queue_run(struct ofono_stk *stk);
+static void display_idle(struct ofono_stk *stk);
 =

 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			void (*cb)(const struct ofono_error *error,
@@ -722,6 +729,239 @@ static gboolean handle_command_more_time(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static void display_command_cb(const struct ofono_error *error,
+				struct ofono_stk *stk)
+{
+	stk_command_cb(error, stk);
+
+	display_idle(stk);
+}
+
+static void display_envelope_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
+{
+	if (!ok) {
+		ofono_error("Sending envelope to UICC failed");
+		return;
+	}
+
+	if (len)
+		ofono_error("Envelope returned %i bytes of unwanted data",
+				len);
+
+	DBG("Envelope submission gave no error");
+
+	display_idle(stk);
+}
+
+static void request_menu_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_menu *menu =3D stk->main_menu;
+	gboolean select_item =3D stk->pending_cmd !=3D NULL &&
+		stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SELECT_ITEM;
+
+	if (select_item)
+		menu =3D stk->select_item_menu;
+
+	dbus_message_set_member(call, "SelectItem");
+
+	append_menu(call, menu, !select_item);
+}
+
+static void request_menu_cb(struct ofono_stk *stk, DBusMessage *reply)
+{
+	DBusError err;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	gboolean select_item =3D stk->app_agent_state =3D=3D STK_AGENT_SELECT_ITE=
M;
+	dbus_int16_t selection;
+	dbus_bool_t help =3D FALSE;
+	struct stk_menu *menu =3D select_item ?
+		stk->select_item_menu : stk->main_menu;
+	struct stk_item *item =3D NULL;
+
+	if (!reply) {
+		if (!select_item) {
+			/* Main menu request is cancelled, nothing to do */
+			display_idle(stk);
+			goto out;
+		}
+
+		if (stk->cmd_timeout) {
+			app_agent_request_cancel(stk);
+
+			display_idle(stk);
+			goto out;
+		}
+
+		type =3D STK_RESULT_TYPE_NO_RESPONSE;
+		goto send;
+	}
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		if (g_str_equal(err.name, OFONO_NAVIGATION_TERMINATED))
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		else if (g_str_equal(err.name, OFONO_NAVIGATION_GOBACK))
+			type =3D STK_RESULT_TYPE_GO_BACK;
+		else {
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+			ofono_error("Unknown reply %s\n", err.name);
+		}
+
+		dbus_error_free(&err);
+		goto send;
+	} else if (dbus_message_get_args(reply, NULL,
+						DBUS_TYPE_INT16, &selection,
+						DBUS_TYPE_BOOLEAN, &help,
+						DBUS_TYPE_INVALID) !=3D FALSE) {
+		if (help =3D=3D FALSE)
+			type =3D STK_RESULT_TYPE_SUCCESS;
+		else
+			type =3D STK_RESULT_TYPE_HELP_REQUESTED;
+	} else if (dbus_message_get_args(reply, NULL,
+						DBUS_TYPE_INT16, &selection,
+						DBUS_TYPE_INVALID) !=3D FALSE) {
+		type =3D STK_RESULT_TYPE_SUCCESS;
+	} else {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Can't parse the reply to SelectItem()");
+		goto send;
+	}
+
+	if (help !=3D FALSE && !menu->has_help) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Help requested but not available");
+
+		goto send;
+	}
+
+	item =3D g_slist_nth_data(menu->items, selection);
+	if (!item) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Invalid item selected");
+	}
+
+send:
+	if (select_item) {
+		struct stk_response rsp;
+		struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+		memset(&rsp, 0, sizeof(rsp));
+		rsp.result.type =3D type;
+
+		if (item)
+			rsp.select_item.item_id =3D item->id;
+
+		if (stk_respond(stk, &rsp, display_command_cb))
+			display_command_cb(&error, stk);
+	} else {
+		struct stk_envelope e;
+
+		if (type !=3D STK_RESULT_TYPE_SUCCESS &&
+				type !=3D STK_RESULT_TYPE_HELP_REQUESTED) {
+			ofono_error("Invalid reply to main menu request");
+
+			display_idle(stk);
+			goto out;
+		}
+
+		memset(&e, 0, sizeof(e));
+
+		e.type =3D STK_ENVELOPE_TYPE_MENU_SELECTION;
+		e.src =3D STK_DEVICE_IDENTITY_TYPE_KEYPAD,
+		e.menu_selection.item_id =3D item->id;
+		e.menu_selection.help_request =3D help;
+
+		if (stk_send_envelope(stk, &e, display_envelope_cb, 0))
+			display_envelope_cb(stk, FALSE, NULL, -1);
+	}
+
+out:
+	if (select_item) {
+		stk_menu_free(menu);
+		stk->select_item_menu =3D NULL;
+	}
+}
+
+static gboolean display_idle_cb(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->display_source =3D 0;
+
+	if (stk->app_agent_state !=3D STK_AGENT_IDLE)
+		return FALSE;
+
+	if (stk->main_menu) {
+		stk->custom_timeout =3D -1; /* No timeout */
+		app_agent_request_start(stk, request_menu_send,
+					request_menu_cb, STK_AGENT_MAIN_MENU);
+	}
+
+	return FALSE;
+}
+
+static void display_idle(struct ofono_stk *stk)
+{
+	if (stk->display_source)
+		return;
+
+	stk->display_source =3D g_timeout_add(0, display_idle_cb, stk);
+}
+
+static gboolean handle_command_select_item(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 2)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	stk->select_item_menu =3D stk_menu_create(cmd->select_item.alpha_id,
+					&cmd->select_item.text_attr,
+					cmd->select_item.items,
+					&cmd->select_item.item_text_attr_list,
+					&cmd->select_item.next_act,
+					cmd->select_item.item_id,
+					soft_key, has_help);
+
+	app_agent_request_start(stk, request_menu_send, request_menu_cb,
+				STK_AGENT_SELECT_ITEM);
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
+out:
+	stk->custom_timeout =3D -1; /* No timeout */
+	app_agent_request_start(stk, request_menu_send, request_menu_cb,
+				STK_AGENT_MAIN_MENU);
+
+	return TRUE;
+}
+
 void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -784,6 +1024,14 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 			respond =3D handle_command_more_time(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_SELECT_ITEM:
+			respond =3D handle_command_select_item(stk->pending_cmd,
+								&rsp, stk);
+			break;
+		case STK_COMMAND_TYPE_SETUP_MENU:
+			respond =3D handle_command_set_up_menu(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
@@ -851,6 +1099,19 @@ static void stk_unregister(struct ofono_atom *atom)
 		}
 	}
 =

+	if (stk->select_item_menu) {
+		stk_menu_free(stk->select_item_menu);
+		stk->select_item_menu =3D NULL;
+	}
+
+	if (stk->main_menu) {
+		stk_menu_free(stk->main_menu);
+		stk->main_menu =3D NULL;
+	}
+
+	if (stk->display_source)
+		g_source_remove(stk->display_source);
+
 	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
 	g_queue_free(stk->envelope_q);
 =

-- =

1.7.1.86.g0e460.dirty


--===============3958073560367197417==--

