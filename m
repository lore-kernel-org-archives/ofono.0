Content-Type: multipart/mixed; boundary="===============0646815803746061324=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] stk: Handle STK menus.
Date: Thu, 15 Jul 2010 15:18:08 +0200
Message-ID: <1279199891-22746-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279199891-22746-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0646815803746061324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  244 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index f3d8247..34fe931 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -92,6 +92,7 @@ struct ofono_stk {
 =

 	int timeout;
 	struct stk_app_agent *app_agent;
+	struct stk_menu *main_menu, *select_item_menu;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -118,6 +119,7 @@ struct sms_submit_req {
 =

 static void envelope_queue_run(struct ofono_stk *stk);
 static void timers_update(struct ofono_stk *stk);
+static void go_to_main_menu(struct ofono_stk *stk);
 =

 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
@@ -553,7 +555,7 @@ static gboolean app_agent_send_menu(gpointer user_data)
 =

 	stk->app_agent->send_menu_source =3D 0;
 =

-	/* TODO */
+	go_to_main_menu(stk);
 =

 	return FALSE;
 }
@@ -632,7 +634,9 @@ static struct stk_app_agent *app_agent_create(struct of=
ono_stk *stk,
 							app_agent_disconnect_cb,
 							stk, NULL);
 =

-	agent->send_menu_source =3D g_timeout_add(0, app_agent_send_menu, stk);
+	if (stk->main_menu)
+		agent->send_menu_source =3D g_timeout_add(0, app_agent_send_menu,
+							stk);
 =

 	return agent;
 }
@@ -992,6 +996,216 @@ static gboolean handle_command_poll_interval(const st=
ruct stk_command *cmd,
 	return TRUE;
 }
 =

+static void menu_selection_envelope_cb(struct ofono_stk *stk, gboolean ok,
+					const unsigned char *data, int len)
+{
+	if (!ok) {
+		ofono_error("Sending Menu Selection to UICC failed");
+		return;
+	}
+
+	if (len)
+		ofono_error("Menu Selection returned %i bytes of unwanted data",
+				len);
+
+	DBG("Menu Selection envelope submission gave no error");
+}
+
+static void request_menu_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_command *cmd =3D stk->pending_cmd;
+	gboolean select_item =3D cmd && cmd->type =3D=3D STK_COMMAND_TYPE_SELECT_=
ITEM;
+	struct stk_menu *menu =3D select_item ?
+		stk->select_item_menu : stk->main_menu;
+
+	dbus_message_set_member(call, "SelectItem");
+
+	append_menu(call, menu, !select_item);
+}
+
+static void request_menu_cb(struct ofono_stk *stk, enum stk_agent_result r=
esult,
+				DBusMessage *reply)
+{
+	enum stk_result_type type;
+	struct stk_command *cmd =3D stk->pending_cmd;
+	gboolean select_item =3D cmd && cmd->type =3D=3D STK_COMMAND_TYPE_SELECT_=
ITEM;
+	dbus_int16_t selection;
+	dbus_bool_t help =3D FALSE;
+	struct stk_menu *menu =3D select_item ?
+		stk->select_item_menu : stk->main_menu;
+	struct stk_item *item =3D NULL;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		type =3D STK_RESULT_TYPE_GO_BACK;
+		goto send;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		type =3D STK_RESULT_TYPE_NO_RESPONSE;
+		goto send;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		/* Nothing to do if agent unregistered while in main menu */
+		if (!select_item)
+			goto out;
+
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		goto send;
+
+	case STK_AGENT_RESULT_CANCEL:
+		goto out;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_INT16, &selection,
+					DBUS_TYPE_BOOLEAN, &help,
+					DBUS_TYPE_INVALID) !=3D FALSE) {
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
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+	} else {
+		struct stk_envelope e;
+
+		if (type !=3D STK_RESULT_TYPE_SUCCESS &&
+				type !=3D STK_RESULT_TYPE_HELP_REQUESTED) {
+			ofono_error("Invalid reply to main menu request");
+
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
+		if (stk_send_envelope(stk, &e, menu_selection_envelope_cb, 0))
+			menu_selection_envelope_cb(stk, FALSE, NULL, -1);
+	}
+
+out:
+	if (select_item) {
+		stk_menu_free(menu);
+		stk->select_item_menu =3D NULL;
+	}
+}
+
+static gboolean handle_command_select_item(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	gboolean soft_key =3D (cmd->qualifier & (1 << 2)) !=3D 0;
+	gboolean has_help =3D (cmd->qualifier & (1 << 7)) !=3D 0;
+
+	stk->select_item_menu =3D stk_menu_create(
+					cmd->select_item.alpha_id,
+					&cmd->select_item.text_attr,
+					cmd->select_item.items,
+					&cmd->select_item.item_text_attr_list,
+					&cmd->select_item.next_act,
+					cmd->select_item.item_id,
+					soft_key, has_help);
+
+	if (!stk->select_item_menu) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	app_agent_request_start(stk,
+				request_menu_send, request_menu_cb, 0);
+
+	stk->cancel_cmd =3D app_agent_request_cancel;
+
+	return FALSE;
+}
+
+static void go_to_main_menu(struct ofono_stk *stk)
+{
+	if (!stk->app_agent || stk->app_agent->cmd_cb || !stk->main_menu)
+		return;
+
+	app_agent_request_start(stk,
+				request_menu_send, request_menu_cb, -1);
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
+		return TRUE;
+
+	stk->main_menu =3D stk_menu_create(cmd->setup_menu.alpha_id,
+					&cmd->setup_menu.text_attr,
+					cmd->setup_menu.items,
+					&cmd->setup_menu.item_text_attr_list,
+					&cmd->setup_menu.next_act,
+					0, soft_key, has_help);
+
+	if (!stk->main_menu) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	app_agent_request_start(stk,
+				request_menu_send, request_menu_cb, -1);
+
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1008,6 +1222,14 @@ static void stk_proactive_command_cancel(struct ofon=
o_stk *stk)
 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk)
 {
 	stk_proactive_command_cancel(stk);
+
+	/*
+	 * Always go back to main menu, let the client decide whether
+	 * to display it or not depending on the type of UI.  TS 102.223
+	 * offers only a recommendation as to whether to release screen
+	 * (aka. close the UI) or show menu.
+	 */
+	go_to_main_menu(stk);
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -1068,6 +1290,14 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 			respond =3D handle_command_poll_interval(stk->pending_cmd,
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
@@ -1139,6 +1369,16 @@ static void stk_unregister(struct ofono_atom *atom)
 		stk->timers_source =3D 0;
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
 	g_queue_foreach(stk->envelope_q, (GFunc) g_free, NULL);
 	g_queue_free(stk->envelope_q);
 =

-- =

1.7.1.86.g0e460.dirty


--===============0646815803746061324==--

