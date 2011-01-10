Content-Type: multipart/mixed; boundary="===============1785983693668403577=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 2/4] stk: Handle Launch Browser proactive command
Date: Mon, 10 Jan 2011 11:43:41 +0200
Message-ID: <1294652623-17287-3-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294652623-17287-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1785983693668403577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c |   67 +++++++++++++++++++++++++++++++
 src/stkagent.h |    5 ++
 3 files changed, 194 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 932e49a..0511b68 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -99,6 +99,11 @@ struct extern_req {
 static void envelope_queue_run(struct ofono_stk *stk);
 static void timers_update(struct ofono_stk *stk);
 =

+#define ADD_ERROR_RESULT(result, error, addn_info)		\
+		result.type =3D error;				\
+		result.additional_len =3D sizeof(addn_info);	\
+		result.additional =3D addn_info;			\
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -2338,6 +2343,118 @@ static gboolean handle_command_play_tone(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void confirm_launch_browser_cb(enum stk_agent_result result,
+					gboolean confirm,
+					void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	unsigned char no_cause[] =3D { 0x00 };
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+
+	stk->respond_on_exit =3D FALSE;
+
+	switch (result) {
+	case STK_AGENT_RESULT_TIMEOUT:
+		confirm =3D FALSE;
+		/* Fall through */
+
+	case STK_AGENT_RESULT_OK:
+		if (confirm)
+			break;
+
+		send_simple_response(stk, STK_RESULT_TYPE_USER_REJECT);
+		return;
+	default:
+		memset(&rsp, 0, sizeof(rsp));
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause);
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
+		return;
+	}
+
+	send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+}
+
+static gboolean handle_command_launch_browser(const struct stk_command *cm=
d,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_launch_browser *lb =3D &cmd->launch_browser;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	static unsigned char no_cause[] =3D { 0x00 };
+	static unsigned char no_service[] =3D { 0x04 };
+	struct ofono_atom *netreg_atom;
+	struct ofono_netreg *netreg;
+	int qualifier =3D cmd->qualifier;
+	char *alpha_id;
+	int err;
+	int status;
+
+	if (qualifier > 3 || qualifier =3D=3D 1) {
+		rsp->result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	if ( lb->browser_id > 4) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	if (ofono_modem_get_online(modem) =3D=3D FALSE) {
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_service);
+		return TRUE;
+	}
+
+	netreg_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_NETREG);
+	if (netreg_atom =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	netreg =3D __ofono_atom_get_data(netreg_atom);
+	status =3D __ofono_netreg_registration_status(netreg);
+
+	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_service);
+		return TRUE;
+	}
+
+	alpha_id =3D dbus_apply_text_attributes(lb->alpha_id ? lb->alpha_id : "",
+							&lb->text_attr);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_launch_browser(stk->current_agent, alpha_id,
+					lb->icon_id.id, lb->url,
+					confirm_launch_browser_cb,
+					stk, NULL, stk->timeout * 1000);
+	g_free(alpha_id);
+
+	if (err < 0) {
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause);
+		return TRUE;
+	}
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2525,6 +2642,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_LAUNCH_BROWSER:
+		respond =3D handle_command_launch_browser(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
diff --git a/src/stkagent.c b/src/stkagent.c
index 2cdc6e1..03b7c87 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -1013,3 +1013,70 @@ int stk_agent_display_action_info(struct stk_agent *=
agent, const char *text,
 =

 	return 0;
 }
+
+static void confirm_launch_browser_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_confirmation_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	dbus_bool_t confirm;
+
+	if (check_error(agent, reply, 0, &result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		cb(STK_AGENT_RESULT_TERMINATE, FALSE, agent->user_data);
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, FALSE, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_BOOLEAN, &confirm,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to ConfirmLaunchBrowser()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, confirm, agent->user_data);
+
+	CALLBACK_END();
+}
+
+int stk_agent_launch_browser(struct stk_agent *agent, const char *text,
+				unsigned char icon_id, const char *url,
+				stk_agent_confirmation_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"LaunchBrowser");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_STRING, &url,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+						agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, confirm_launch_browser_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 6477dbf..c6a2b74 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -140,3 +140,8 @@ void append_menu_items_variant(DBusMessageIter *iter,
 =

 int stk_agent_display_action_info(struct stk_agent *agent, const char *tex=
t,
 					const struct stk_icon_id *icon);
+
+int stk_agent_launch_browser(struct stk_agent *agent, const char *text,
+				unsigned char icon_id, const char *url,
+				stk_agent_confirmation_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
-- =

1.7.0.4


--===============1785983693668403577==--

