Content-Type: multipart/mixed; boundary="===============1161173009055688738=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] stk: Handle the Select Item proactive command.
Date: Wed, 28 Jul 2010 12:26:10 +0200
Message-ID: <1280312771-30579-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280312771-30579-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1161173009055688738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/stkagent.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/stkagent.h |    8 ++++++
 3 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bd7679c..c804fc6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -65,7 +65,7 @@ struct ofono_stk {
 	struct stk_agent *session_agent;
 	struct stk_agent *default_agent;
 	struct stk_agent *current_agent; /* Always equals one of the above */
-	struct stk_menu *main_menu;
+	struct stk_menu *main_menu, *select_item_menu;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -923,6 +923,67 @@ static gboolean handle_command_set_up_menu(const struc=
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
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	stk_agent_request_selection(stk->current_agent, stk->select_item_menu,
+					request_menu_cb, stk,
+					stk->timeout * 1000);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1006,6 +1067,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
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
index 3f80ba1..ce7ad18 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -52,6 +52,8 @@ struct stk_agent {
 	ofono_bool_t is_default;
 	GDestroyNotify destroy_notify;
 	void *destroy_data;
+
+	const struct stk_menu *request_selection_menu;
 };
 =

 #define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Error"
@@ -333,3 +335,64 @@ void append_menu_items_variant(DBusMessageIter *iter,
 =

 	dbus_message_iter_close_container(iter, &variant);
 }
+
+static void request_selection_cb(struct stk_agent *agent,
+					enum stk_agent_result result,
+					DBusMessage *reply)
+{
+	const struct stk_menu *menu =3D agent->request_selection_menu;
+	stk_agent_selection_cb cb =3D (stk_agent_selection_cb) agent->user_cb;
+	unsigned char selection, i;
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, 0, agent->user_data);
+
+		return;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_BYTE, &selection,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to RequestSelection()");
+
+		cb(STK_AGENT_RESULT_TERMINATE, 0, agent->user_data);
+
+		return;
+	}
+
+	for (i =3D 0; i < selection && menu->items[i].text; i++);
+
+	if (i !=3D selection) {
+		ofono_error("Invalid item selected");
+
+		cb(STK_AGENT_RESULT_TERMINATE, 0, agent->user_data);
+
+		return;
+	}
+
+	cb(result, menu->items[selection].item_id, agent->user_data);
+}
+
+void stk_agent_request_selection(struct stk_agent *agent,
+					const struct stk_menu *menu,
+					stk_agent_selection_cb cb,
+					void *user_data, int timeout)
+{
+	dbus_int16_t default_item =3D menu->default_item;
+	DBusMessageIter iter;
+
+	if (!stk_agent_request_start(agent, "RequestSelection",
+					request_selection_cb,
+					(stk_agent_generic_cb) cb,
+					user_data, timeout))
+		return;
+
+	dbus_message_iter_init_append(agent->msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &menu->title);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon_id);
+	append_menu_items(&iter, menu->items);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
+
+	agent->request_selection_menu =3D menu;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 5561fa4..a19df92 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -46,6 +46,9 @@ enum stk_agent_result {
 typedef void (*stk_agent_generic_cb)(enum stk_agent_result result,
 					void *user_data);
 =

+typedef void (*stk_agent_selection_cb)(enum stk_agent_result result,
+					uint8_t id, void *user_data);
+
 struct stk_agent;
 =

 struct stk_agent *stk_agent_new(const char *path, const char *sender,
@@ -61,5 +64,10 @@ void stk_agent_set_destroy_watch(struct stk_agent *agent=
, GDestroyNotify notify,
 =

 void stk_agent_request_cancel(struct stk_agent *agent);
 =

+void stk_agent_request_selection(struct stk_agent *agent,
+					const struct stk_menu *menu,
+					stk_agent_selection_cb cb,
+					void *user_data, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============1161173009055688738==--

