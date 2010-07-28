Content-Type: multipart/mixed; boundary="===============3827423656823123420=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] stk: Handle the Display Text proactive command.
Date: Wed, 28 Jul 2010 12:26:11 +0200
Message-ID: <1280312771-30579-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280312771-30579-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3827423656823123420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.c |   36 ++++++++++++++++++++++
 src/stkagent.h |    5 +++
 3 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index c804fc6..a09cfb0 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -66,6 +66,7 @@ struct ofono_stk {
 	struct stk_agent *default_agent;
 	struct stk_agent *current_agent; /* Always equals one of the above */
 	struct stk_menu *main_menu, *select_item_menu;
+	gboolean session_ended;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -984,6 +985,90 @@ static gboolean handle_command_select_item(const struc=
t stk_command *cmd,
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
+		if (stk->session_ended && stk->session_agent)
+			session_agent_remove(stk);
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
+	stk->cancel_cmd =3D stk_request_cancel;
+	stk->session_ended =3D FALSE;
+
+	stk_agent_display_text(stk->current_agent, dt->text, 0, priority,
+				confirm, request_text_cb, stk, timeout);
+
+	return cmd->display_text.immediate_response;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1071,6 +1156,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
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
index ce7ad18..7072e90 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -396,3 +396,39 @@ void stk_agent_request_selection(struct stk_agent *age=
nt,
 =

 	agent->request_selection_menu =3D menu;
 }
+
+static void display_text_cb(struct stk_agent *agent,
+				enum stk_agent_result result,
+				DBusMessage *reply)
+{
+	stk_agent_generic_cb cb =3D agent->user_cb;
+
+	if (result =3D=3D STK_AGENT_RESULT_OK && dbus_message_get_args(
+				reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayText()");
+
+		result =3D STK_AGENT_RESULT_TERMINATE;
+	}
+
+	cb(result, agent->user_data);
+}
+
+void stk_agent_display_text(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, ofono_bool_t urgent,
+				ofono_bool_t ack, stk_agent_generic_cb cb,
+				void *user_data, int timeout)
+{
+	dbus_bool_t priority =3D urgent;
+	dbus_bool_t confirm =3D ack;
+
+	if (!stk_agent_request_start(agent, "DisplayText", display_text_cb,
+					cb, user_data, timeout))
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
index a19df92..1d3a725 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -69,5 +69,10 @@ void stk_agent_request_selection(struct stk_agent *agent,
 					stk_agent_selection_cb cb,
 					void *user_data, int timeout);
 =

+void stk_agent_display_text(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, ofono_bool_t urgent,
+				ofono_bool_t ack, stk_agent_generic_cb cb,
+				void *user_data, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============3827423656823123420==--

