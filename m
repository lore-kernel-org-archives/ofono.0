Content-Type: multipart/mixed; boundary="===============2882470390034143891=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/5] stk: Handle the Select Item proactive command.
Date: Thu, 22 Jul 2010 13:42:52 +0200
Message-ID: <1279798973-6612-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279798973-6612-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2882470390034143891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 17daa00..563bedd 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -95,7 +95,7 @@ struct ofono_stk {
 	int short_timeout;
 	struct stk_app_agent *primary_agent;
 	struct stk_app_agent *default_agent;
-	struct stk_menu *main_menu;
+	struct stk_menu *main_menu, *select_item_menu;
 	gboolean in_session;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
@@ -1212,6 +1212,115 @@ out:
 	return TRUE;
 }
 =

+static void request_menu_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_menu *menu =3D stk->select_item_menu;
+
+	dbus_message_set_member(call, "RequestSelection");
+
+	append_menu(call, menu);
+}
+
+static void request_menu_cb(struct ofono_stk *stk,
+				enum stk_agent_result result,
+				DBusMessage *reply)
+{
+	enum stk_result_type type;
+	unsigned char selection;
+	struct stk_menu *menu =3D stk->select_item_menu;
+	struct stk_item *item =3D NULL;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		type =3D STK_RESULT_TYPE_SUCCESS;
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
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		goto send;
+
+	case STK_AGENT_RESULT_CANCEL:
+		goto out;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_BYTE, &selection,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Can't parse the reply to SelectItem()");
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
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
+
+	if (item)
+		rsp.select_item.item_id =3D item->id;
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+
+out:
+	stk_menu_free(menu);
+	stk->select_item_menu =3D NULL;
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
+	if (!stk->in_session) {
+		stk->in_session =3D TRUE;
+
+		if (stk->main_menu)
+			emit_menu_changed(stk);
+	}
+
+	app_agent_request_start(stk,
+				request_menu_send, request_menu_cb, 0);
+
+	stk->cancel_cmd =3D stk_agent_request_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1302,6 +1411,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
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
-- =

1.7.1.86.g0e460.dirty


--===============2882470390034143891==--

