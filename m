Content-Type: multipart/mixed; boundary="===============1583503593102744498=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] stk: Handle the Display Text proactive command.
Date: Wed, 28 Jul 2010 08:09:37 +0200
Message-ID: <1280297377-20692-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280297377-20692-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1583503593102744498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |  137 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 src/stkagent.c |   36 +++++++++++++++
 src/stkagent.h |    5 ++
 3 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9322de9..eba8904 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -67,6 +67,7 @@ struct ofono_stk {
 	struct stk_app_agent *current_agent; /* Always one of the above two */
 	struct stk_menu *main_menu, *select_item_menu;
 	gboolean in_session;
+	gboolean session_ended;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -991,6 +992,102 @@ static gboolean handle_command_select_item(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void request_text_cb(enum stk_agent_result result, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	gboolean confirm;
+	struct stk_response rsp;
+
+	/*
+	 * Check if we have already responded to the proactive command
+	 * because immediate response was requested, or the command is
+	 * being cancelled.
+	 */
+	if (!stk->pending_cmd || stk->pending_cmd->type !=3D
+			STK_COMMAND_TYPE_DISPLAY_TEXT ||
+			result =3D=3D STK_AGENT_RESULT_CANCEL) {
+		/*
+		 * If session has ended in the meantime now is the time
+		 * to go back to main menu or close the application
+		 * window.
+		 */
+		if (stk->session_ended && stk->session_agent) {
+			session_agent_remove(stk);
+
+			stk->in_session =3D FALSE;
+			if (stk->main_menu)
+				emit_menu_changed(stk);
+		}
+
+		return;
+	}
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		rsp.result.type =3D STK_RESULT_TYPE_GO_BACK;
+		break;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		confirm =3D (stk->pending_cmd->qualifier & (1 << 7)) !=3D 0;
+		rsp.result.type =3D confirm ?
+			STK_RESULT_TYPE_NO_RESPONSE : STK_RESULT_TYPE_SUCCESS;
+		break;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		rsp.result.type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		break;
+	}
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+}
+
+static gboolean handle_command_display_text(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D stk->short_timeout * 1000;
+	struct stk_command_display_text *dt =3D &stk->pending_cmd->display_text;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	ofono_bool_t confirm =3D (qualifier & (1 << 7)) !=3D 0;
+	ofono_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
+
+	if (dt->duration.interval) {
+		timeout =3D dt->duration.interval;
+		switch (dt->duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			timeout *=3D 60;
+		case STK_DURATION_TYPE_SECONDS:
+			timeout *=3D 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			timeout *=3D 100;
+		}
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
+	stk->session_ended =3D FALSE;
+
+	app_agent_display_text(stk->current_agent, dt->text, 0, priority,
+				confirm, request_text_cb, timeout);
+
+	return cmd->display_text.immediate_response;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1008,12 +1105,42 @@ void ofono_stk_proactive_session_end_notify(struct =
ofono_stk *stk)
 {
 	stk_proactive_command_cancel(stk);
 =

-	if (stk->session_agent)
-		app_agent_remove(stk->session_agent);
+	if (!stk->session_agent)
+		goto out;
+
+	/*
+	 * Go back to main menu, except when a DisplayText command has
+	 * been issued with the Immediate Response flag set (TS 102.223
+	 * Section 6.9):
+	 * "If the text is to be sustained, the terminal shall display
+	 * the text of applicable DISPLAY TEXT commands beyond the sending
+	 * of the TERMINAL RESPONSE and possibly beyond the end of the
+	 * proactive session.
+	 *
+	 * If a variable display timeout was indicated for a DISPLAY TEXT
+	 * command, then the session releases the display back into terminal
+	 * control no later then the period stated by the duration. If the
+	 * text is to be sustained beyond an immediate response, the
+	 * terminal shall display the text for a period that does not
+	 * exceed the duration."
+	 *
+	 * For this case we set a flag and when the text stops being
+	 * displayed we will make sure to go to main menu then.
+	 */
+	if (!stk->pending_cmd && app_agent_busy(stk->session_agent)) {
+		stk->session_ended =3D TRUE;
+
+		return;
+	}
 =

+	app_agent_remove(stk->session_agent);
+
+out:
 	if (stk->in_session) {
 		stk->in_session =3D FALSE;
-		emit_menu_changed(stk);
+
+		if (stk->main_menu)
+			emit_menu_changed(stk);
 	}
 }
 =

@@ -1083,6 +1210,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 			respond =3D handle_command_select_item(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_DISPLAY_TEXT:
+			respond =3D handle_command_display_text(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
diff --git a/src/stkagent.c b/src/stkagent.c
index 19da43a..627cdf3 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -390,3 +390,39 @@ void app_agent_request_selection(struct stk_app_agent =
*agent,
 =

 	agent->request_selection_menu =3D menu;
 }
+
+static void display_text_cb(struct stk_app_agent *agent,
+				enum stk_agent_result result,
+				DBusMessage *reply)
+{
+	app_agent_generic_cb cb =3D agent->user_cb;
+
+	if (result =3D=3D STK_AGENT_RESULT_OK && dbus_message_get_args(
+				reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayText()");
+
+		result =3D STK_AGENT_RESULT_TERMINATE;
+	}
+
+	cb(result, agent->data);
+}
+
+void app_agent_display_text(struct stk_app_agent *agent,
+				const char *text, uint8_t icon_id,
+				ofono_bool_t urgent, ofono_bool_t ack,
+				app_agent_generic_cb cb, int timeout)
+{
+	dbus_bool_t priority =3D urgent;
+	dbus_bool_t confirm =3D ack;
+
+	if (!app_agent_request_start(agent, "DisplayText", display_text_cb,
+					cb, timeout))
+		return;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BOOLEAN, &priority,
+					DBUS_TYPE_BOOLEAN, &confirm,
+					DBUS_TYPE_INVALID);
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index eab2055..e7689a3 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -67,5 +67,10 @@ void app_agent_request_selection(struct stk_app_agent *a=
gent,
 					const struct stk_menu *menu,
 					app_agent_selection_cb cb, int timeout);
 =

+void app_agent_display_text(struct stk_app_agent *agent,
+				const char *text, uint8_t icon_id,
+				ofono_bool_t urgent, ofono_bool_t ack,
+				app_agent_generic_cb cb, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu *menu);
-- =

1.7.1.86.g0e460.dirty


--===============1583503593102744498==--

