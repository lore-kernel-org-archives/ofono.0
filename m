Content-Type: multipart/mixed; boundary="===============0349700056331910047=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] stk: Handle the Select Item proactive command.
Date: Wed, 28 Jul 2010 08:09:36 +0200
Message-ID: <1280297377-20692-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280297377-20692-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0349700056331910047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkagent.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++
 src/stkagent.h |    7 +++++
 3 files changed, 140 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index fcd5eab..9322de9 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -65,7 +65,7 @@ struct ofono_stk {
 	struct stk_app_agent *session_agent;
 	struct stk_app_agent *default_agent;
 	struct stk_app_agent *current_agent; /* Always one of the above two */
-	struct stk_menu *main_menu;
+	struct stk_menu *main_menu, *select_item_menu;
 	gboolean in_session;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
@@ -924,6 +924,73 @@ static gboolean handle_command_set_up_menu(const struc=
t stk_command *cmd,
 	return TRUE;
 }
 =

+static void request_menu_cb(enum stk_agent_result result, uint8_t id,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	struct stk_response rsp;
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.select_item.item_id =3D id;
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		rsp.result.type =3D STK_RESULT_TYPE_GO_BACK;
+		break;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		rsp.result.type =3D STK_RESULT_TYPE_NO_RESPONSE;
+		break;
+
+	case STK_AGENT_RESULT_CANCEL:
+		goto out;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		rsp.result.type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		break;
+	}
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+
+out:
+	stk_menu_free(stk->select_item_menu);
+	stk->select_item_menu =3D NULL;
+}
+
+static gboolean handle_command_select_item(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	stk->select_item_menu =3D stk_menu_create_from_select_item(cmd);
+
+	if (!stk->select_item_menu) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+
+		return TRUE;
+	}
+
+	if (!stk->in_session) {
+		stk->in_session =3D TRUE;
+
+		if (stk->main_menu)
+			emit_menu_changed(stk);
+	}
+
+	stk->cancel_cmd =3D stk_agent_request_cancel;
+
+	app_agent_request_selection(stk->current_agent, stk->select_item_menu,
+					request_menu_cb, stk->timeout * 1000);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1012,6 +1079,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 			respond =3D handle_command_set_up_menu(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_SELECT_ITEM:
+			respond =3D handle_command_select_item(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
diff --git a/src/stkagent.c b/src/stkagent.c
index 0daf7d0..19da43a 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -51,6 +51,8 @@ struct stk_app_agent {
 	void *data;
 	ofono_bool_t is_default;
 	GDestroyNotify notify;
+
+	const struct stk_menu *request_selection_menu;
 };
 =

 #define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Error"
@@ -329,3 +331,62 @@ void append_menu_items_variant(DBusMessageIter *iter,
 =

 	dbus_message_iter_close_container(iter, &variant);
 }
+
+static void request_selection_cb(struct stk_app_agent *agent,
+					enum stk_agent_result result,
+					DBusMessage *reply)
+{
+	const struct stk_menu *menu =3D agent->request_selection_menu;
+	app_agent_selection_cb cb =3D (app_agent_selection_cb) agent->user_cb;
+	unsigned char selection, i;
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, 0, agent->data);
+
+		return;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_BYTE, &selection,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to RequestSelection()");
+
+		cb(STK_AGENT_RESULT_TERMINATE, 0, agent->data);
+
+		return;
+	}
+
+	for (i =3D 0; i < selection && menu->items[i].text; i++);
+
+	if (i !=3D selection) {
+		ofono_error("Invalid item selected");
+
+		cb(STK_AGENT_RESULT_TERMINATE, 0, agent->data);
+
+		return;
+	}
+
+	cb(result, menu->items[selection].item_id, agent->data);
+}
+
+void app_agent_request_selection(struct stk_app_agent *agent,
+					const struct stk_menu *menu,
+					app_agent_selection_cb cb, int timeout)
+{
+	dbus_int16_t default_item =3D menu->default_item;
+	DBusMessageIter iter;
+
+	if (!app_agent_request_start(agent, "RequestSelection",
+					request_selection_cb,
+					(app_agent_generic_cb) cb, timeout))
+		return;
+
+	dbus_message_iter_init_append(agent->msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &menu->title);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon_id);
+	append_menu_items(&iter, menu);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
+
+	agent->request_selection_menu =3D menu;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index d1f3ffb..eab2055 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -46,6 +46,9 @@ enum stk_agent_result {
 typedef void (*app_agent_generic_cb)(enum stk_agent_result result,
 					void *user_data);
 =

+typedef void (*app_agent_selection_cb)(enum stk_agent_result result,
+					uint8_t id, void *user_data);
+
 struct stk_app_agent;
 =

 struct stk_app_agent *app_agent_create(const char *path, const char *sende=
r,
@@ -60,5 +63,9 @@ ofono_bool_t app_agent_matches(struct stk_app_agent *agen=
t,
 =

 void app_agent_request_cancel(struct stk_app_agent *agent);
 =

+void app_agent_request_selection(struct stk_app_agent *agent,
+					const struct stk_menu *menu,
+					app_agent_selection_cb cb, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu *menu);
-- =

1.7.1.86.g0e460.dirty


--===============0349700056331910047==--

