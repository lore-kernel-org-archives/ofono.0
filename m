Content-Type: multipart/mixed; boundary="===============7910516296222793622=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] stk: Handle the Get Input proactive command.
Date: Wed, 30 Jun 2010 17:24:14 +0200
Message-ID: <1277911458-4984-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7910516296222793622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SimApplication agent method signature is:
string/Back/Terminate/Help GetText(string message, string default,
		string charset, byte min, byte max, bool help_available,
		bool password)

	charset is one of:
		"digit" - one of 0-9, *, #, +
		"gsm" - only characters from the GSM SMS charset
		"any"
	The returned string must be between min and max characters long.
	The default value should be used as the initial value of the
	text field being edited by user.  If password is True, individual
	characters entered must not be revealed on the screen, but
	indication of new characters can be given, for example by showing
	them as '*'.
---
 src/stk.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a2649b1..0ae74e6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -66,6 +66,7 @@ enum stk_agent_state {
 	STK_AGENT_SELECT_ITEM,
 	STK_AGENT_DISPLAY_TEXT,
 	STK_AGENT_GET_KEY,
+	STK_AGENT_GET_TEXT,
 };
 =

 struct ofono_stk {
@@ -1221,6 +1222,108 @@ static gboolean handle_command_get_inkey(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void request_get_text_send(struct ofono_stk *stk, DBusMessage *call)
+{
+	struct stk_command_get_input *cmd =3D &stk->pending_cmd->get_input;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t alphabet =3D (qualifier & (1 << 0)) !=3D 0;
+	dbus_bool_t ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
+	dbus_bool_t hidden =3D (qualifier & (1 << 2)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	const char *charset =3D
+		!alphabet ? "digit" :
+		 (ucs2 ? "any" : "gsm");
+	const char *default_text =3D cmd->default_text ?: "";
+
+	dbus_message_set_member(call, "GetText");
+
+	dbus_message_append_args(call,
+					DBUS_TYPE_STRING, &cmd->text,
+					DBUS_TYPE_STRING, &default_text,
+					DBUS_TYPE_STRING, &charset,
+					DBUS_TYPE_BYTE, &cmd->resp_len.min,
+					DBUS_TYPE_BYTE, &cmd->resp_len.max,
+					DBUS_TYPE_BOOLEAN, &help,
+					DBUS_TYPE_BOOLEAN, &hidden,
+					DBUS_TYPE_INVALID);
+}
+
+static void request_get_text_cb(struct ofono_stk *stk, DBusMessage *reply)
+{
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t packed =3D (qualifier & (1 << 3)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	DBusError err;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	char *text;
+
+	if (!reply) {
+		if (stk->cmd_timeout) {
+			app_agent_request_cancel(stk);
+
+			display_idle(stk);
+			return;
+		}
+
+		type =3D STK_RESULT_TYPE_NO_RESPONSE;
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
+		else if (g_str_equal(err.name, OFONO_NAVIGATION_GETHELP) &&
+				help)
+			type =3D STK_RESULT_TYPE_HELP_REQUESTED;
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
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+
+		ofono_error("Reply not understood");
+		goto send;
+	}
+
+send:
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D type;
+
+	if (type =3D=3D STK_RESULT_TYPE_SUCCESS) {
+		rsp.get_input.text.text =3D text;
+		rsp.get_input.text.packed =3D packed;
+		rsp.get_input.text.yesno =3D FALSE;
+	}
+
+	if (stk_respond(stk, &rsp, display_command_cb))
+		display_command_cb(&error, stk);
+}
+
+static gboolean handle_command_get_input(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	app_agent_request_start(stk, request_get_text_send, request_get_text_cb,
+				STK_AGENT_GET_TEXT);
+
+	return FALSE;
+}
+
 void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1298,6 +1401,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		case STK_COMMAND_TYPE_GET_INKEY:
 			respond =3D handle_command_get_inkey(stk->pending_cmd,
 								&rsp, stk);
+			break;
+		case STK_COMMAND_TYPE_GET_INPUT:
+			respond =3D handle_command_get_input(stk->pending_cmd,
+								&rsp, stk);
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============7910516296222793622==--

