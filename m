Content-Type: multipart/mixed; boundary="===============7653110614401506972=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] stk: Handle the Display Text proactive command.
Date: Mon, 26 Jul 2010 15:14:40 +0200
Message-ID: <1280150080-6257-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280150080-6257-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7653110614401506972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 0aaf83d..9e3c14f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -79,6 +79,7 @@ struct ofono_stk {
 	gboolean in_session;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
+	gboolean session_ended;
 };
 =

 struct envelope_op {
@@ -1100,6 +1101,125 @@ static gboolean handle_command_select_item(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static void request_text_send(DBusMessage *call, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_command_display_text *dt =3D &stk->pending_cmd->display_text;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t confirm =3D (qualifier & (1 << 7)) !=3D 0;
+	dbus_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
+	unsigned char icon_id =3D 0;
+
+	dbus_message_set_member(call, "DisplayText");
+
+	dbus_message_append_args(call,
+					DBUS_TYPE_STRING, &dt->text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BOOLEAN, &priority,
+					DBUS_TYPE_BOOLEAN, &confirm,
+					DBUS_TYPE_INVALID);
+}
+
+static void request_text_cb(enum stk_agent_result result, DBusMessage *rep=
ly,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	gboolean confirm;
+	struct stk_response rsp;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+
+	/*
+	 * Check if we have already responded to the proactive command
+	 * because immediate response was requested.
+	 */
+	if (!stk->pending_cmd || stk->pending_cmd->type !=3D
+			STK_COMMAND_TYPE_DISPLAY_TEXT ||
+			stk->pending_cmd->display_text.immediate_response) {
+		/*
+		 * If session has ended in the meantime now is the time
+		 * to go back to main menu or close the application
+		 * window.
+		 */
+		if (stk->session_ended && stk->session_agent)
+			session_agent_remove(stk);
+
+		return;
+	}
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
+		confirm =3D (stk->pending_cmd->qualifier & (1 << 7)) !=3D 0;
+		if (confirm)
+			type =3D STK_RESULT_TYPE_NO_RESPONSE;
+
+		goto send;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		goto send;
+
+	case STK_AGENT_RESULT_CANCEL:
+		return;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Reply not understood");
+	}
+
+send:
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
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
+
+	if (cmd->display_text.duration.interval) {
+		timeout =3D cmd->display_text.duration.interval;
+		switch (cmd->display_text.duration.unit) {
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
+	} else
+		stk_agent_request_cancel(stk);
+
+	stk->cancel_cmd =3D stk_agent_request_cancel;
+	stk->session_ended =3D FALSE;
+
+	stk_agent_request_start(stk,
+				request_text_send, request_text_cb, timeout);
+
+	return cmd->display_text.immediate_response;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1117,12 +1237,42 @@ void ofono_stk_proactive_session_end_notify(struct =
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
+	if (!stk->pending_cmd && stk->session_agent->cmd_cb) {
+		stk->session_ended =3D TRUE;
+
+		return;
+	}
+
+	app_agent_remove(stk->session_agent);
 =

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

@@ -1192,6 +1342,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
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
-- =

1.7.1.86.g0e460.dirty


--===============7653110614401506972==--

