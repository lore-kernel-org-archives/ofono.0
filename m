Content-Type: multipart/mixed; boundary="===============2070735831601446999=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] stk: Handle the Get Input proactive command.
Date: Wed, 04 Aug 2010 06:55:04 +0200
Message-ID: <1280897704-15361-4-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280897704-15361-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2070735831601446999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9331934..91a4586 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1329,6 +1329,97 @@ static gboolean handle_command_get_inkey(const struc=
t stk_command *cmd,
 	return FALSE;
 }
 =

+static void request_string_cb(enum stk_agent_result result, char *string,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	gboolean packed =3D (qualifier & (1 << 3)) !=3D 0;
+	struct stk_response rsp;
+
+	switch (result) {
+	case STK_AGENT_RESULT_OK:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+		rsp.get_input.text.text =3D string;
+		rsp.get_input.text.packed =3D packed;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		break;
+
+	case STK_AGENT_RESULT_BACK:
+		send_simple_response(stk, STK_RESULT_TYPE_GO_BACK);
+		break;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		send_simple_response(stk, STK_RESULT_TYPE_NO_RESPONSE);
+		break;
+
+	case STK_AGENT_RESULT_HELP:
+		if ((qualifier & (1 << 7)) =3D=3D 0) {
+			ofono_error("Help requested but not available");
+
+			send_simple_response(stk,
+					STK_RESULT_TYPE_USER_TERMINATED);
+			break;
+		}
+
+		send_simple_response(stk, STK_RESULT_TYPE_HELP_REQUESTED);
+		break;
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		break;
+	}
+}
+
+static gboolean handle_command_get_input(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D stk->timeout * 1000;
+	const struct stk_command_get_input *gi =3D &cmd->get_input;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
+	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
+	gboolean hidden =3D (qualifier & (1 << 2)) !=3D 0;
+	uint8_t icon_id =3D 0;
+	int err;
+
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	if (alphabet)
+		err =3D stk_agent_request_input(stk->current_agent, gi->text,
+						icon_id, gi->default_text, ucs2,
+						gi->resp_len.min,
+						gi->resp_len.max, hidden,
+						request_string_cb,
+						stk, NULL, timeout);
+	else
+		err =3D stk_agent_request_digits(stk->current_agent, gi->text,
+						icon_id, gi->default_text,
+						gi->resp_len.min,
+						gi->resp_len.max, hidden,
+						request_string_cb,
+						stk, NULL, timeout);
+
+	if (err < 0) {
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -1468,6 +1559,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_GET_INPUT:
+		respond =3D handle_command_get_input(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1.86.g0e460.dirty


--===============2070735831601446999==--

