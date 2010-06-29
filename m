Content-Type: multipart/mixed; boundary="===============0011921594684110093=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 9/9] stk: Handle the Display Text command.
Date: Tue, 29 Jun 2010 12:14:08 +0200
Message-ID: <1277806448-5322-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277806448-5322-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0011921594684110093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index fd6dcb0..ff47649 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -63,6 +63,7 @@ enum stk_agent_state {
 	STK_AGENT_IDLE =3D 0,
 	STK_AGENT_MAIN_MENU,
 	STK_AGENT_SELECT_ITEM,
+	STK_AGENT_DISPLAY_TEXT,
 };
 =

 struct ofono_stk {
@@ -962,6 +963,110 @@ out:
 	return TRUE;
 }
 =

+static void request_text_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_command_display_text *txt =3D &stk->pending_cmd->display_text;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t confirm =3D (qualifier & (1 << 7)) !=3D 0;
+	dbus_bool_t priority =3D (qualifier & (1 << 0)) !=3D 0;
+	dbus_bool_t navigation =3D !txt->immediate_response;
+
+	dbus_message_set_member(call, "DisplayText");
+
+	dbus_message_append_args(call,
+					DBUS_TYPE_STRING, &txt->text,
+					DBUS_TYPE_BOOLEAN, &confirm,
+					DBUS_TYPE_BOOLEAN, &priority,
+					DBUS_TYPE_BOOLEAN, &navigation,
+					DBUS_TYPE_INVALID);
+}
+
+static void request_text_cb(struct ofono_stk *stk, DBusMessage *reply)
+{
+	struct stk_command_display_text *txt =3D &stk->pending_cmd->display_text;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	gboolean confirm =3D (qualifier & (1 << 7)) !=3D 0;
+	DBusError err;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	if (!reply) {
+		if (stk->cmd_timeout) {
+			app_agent_request_cancel(stk);
+
+			goto out;
+		}
+
+		if (confirm)
+			type =3D STK_RESULT_TYPE_NO_RESPONSE;
+
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
+			ofono_error("Unknown reply %s", err.name);
+		}
+
+		dbus_error_free(&err);
+		goto send;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Reply not understood");
+	}
+
+send:
+	if (txt->immediate_response)
+		goto out;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
+
+	if (stk_respond(stk, &rsp, display_command_cb))
+		display_command_cb(&error, stk);
+
+	return;
+out:
+	display_idle(stk);
+}
+
+
+static gboolean handle_command_display_text(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D 0;
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
+	stk->custom_timeout =3D timeout;
+	app_agent_request_start(stk, request_text_send, request_text_cb,
+				STK_AGENT_DISPLAY_TEXT);
+
+	return cmd->display_text.immediate_response;
+}
+
 void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1032,6 +1137,9 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 			respond =3D handle_command_set_up_menu(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_DISPLAY_TEXT:
+			respond =3D handle_command_display_text(stk->pending_cmd,
+								&rsp, stk);
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============0011921594684110093==--

