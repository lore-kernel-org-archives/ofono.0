Content-Type: multipart/mixed; boundary="===============8719535526480499109=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] stk: Handle the Select Item proactive command.
Date: Mon, 26 Jul 2010 15:14:39 +0200
Message-ID: <1280150080-6257-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280150080-6257-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8719535526480499109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 105 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index f212e9a..0aaf83d 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -75,7 +75,7 @@ struct ofono_stk {
 	guint remove_agent_source;
 	struct stk_app_agent *session_agent;
 	struct stk_app_agent *default_agent;
-	struct stk_menu *main_menu;
+	struct stk_menu *main_menu, *select_item_menu;
 	gboolean in_session;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
@@ -1000,6 +1000,106 @@ static gboolean handle_command_set_up_menu(const st=
ruct stk_command *cmd,
 	return TRUE;
 }
 =

+static void request_menu_send(DBusMessage *call, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_menu *menu =3D stk->select_item_menu;
+
+	dbus_message_set_member(call, "RequestSelection");
+
+	append_menu(call, menu);
+}
+
+static void request_menu_cb(enum stk_agent_result result, DBusMessage *rep=
ly,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_menu *menu =3D stk->select_item_menu;
+	struct stk_item *item =3D NULL;
+	enum stk_result_type type;
+	unsigned char selection;
+	struct stk_response rsp;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
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
+	stk_agent_request_start(stk,
+				request_menu_send, request_menu_cb, 0);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1088,6 +1188,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
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


--===============8719535526480499109==--

