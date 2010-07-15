Content-Type: multipart/mixed; boundary="===============7577266949403283605=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] stk: Handle the Get Input proactive command.
Date: Thu, 15 Jul 2010 15:18:11 +0200
Message-ID: <1279199891-22746-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1279199891-22746-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7577266949403283605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 6fbdbe4..fd5113b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1485,6 +1485,111 @@ static gboolean handle_command_get_inkey(const stru=
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
+	const char *default_text =3D cmd->default_text ? cmd->default_text : "";
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
+static void request_get_text_cb(struct ofono_stk *stk,
+				enum stk_agent_result result,
+				DBusMessage *reply)
+{
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	dbus_bool_t packed =3D (qualifier & (1 << 3)) !=3D 0;
+	dbus_bool_t help =3D (qualifier & (1 << 7)) !=3D 0;
+	enum stk_result_type type =3D STK_RESULT_TYPE_SUCCESS;
+	struct stk_response rsp;
+	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	char *text;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		break;
+
+	case STK_AGENT_RESULT_HELP:
+		if (!help) {
+			type =3D STK_RESULT_TYPE_USER_TERMINATED;
+			ofono_error("Help requested but not available");
+
+			goto send;
+		}
+
+		type =3D STK_RESULT_TYPE_HELP_REQUESTED;
+		goto send;
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
+		return;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		type =3D STK_RESULT_TYPE_USER_TERMINATED;
+		ofono_error("Reply not understood");
+
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
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+}
+
+static gboolean handle_command_get_input(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	app_agent_request_start(stk,
+				request_get_text_send, request_get_text_cb, 0);
+
+	stk->cancel_cmd =3D app_agent_request_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (!stk->pending_cmd)
@@ -1606,6 +1711,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 			respond =3D handle_command_get_inkey(stk->pending_cmd,
 								&rsp, stk);
 			break;
+		case STK_COMMAND_TYPE_GET_INPUT:
+			respond =3D handle_command_get_input(stk->pending_cmd,
+								&rsp, stk);
+			break;
 		}
 =

 		if (respond)
-- =

1.7.1.86.g0e460.dirty


--===============7577266949403283605==--

