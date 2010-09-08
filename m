Content-Type: multipart/mixed; boundary="===============3011403189723315272=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] stk: Handle the Send DTMF proactive command.
Date: Wed, 08 Sep 2010 19:59:55 +0200
Message-ID: <1283968796-5308-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1283968796-5308-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3011403189723315272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 135 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3fda2af..b469467 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -434,8 +434,12 @@ static void default_agent_notify(gpointer user_data)
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	if (stk->current_agent =3D=3D stk->default_agent && stk->respond_on_exit)
+	if (stk->current_agent =3D=3D stk->default_agent && stk->respond_on_exit)=
 {
+		if (stk->pending_cmd)
+			stk->cancel_cmd(stk);
+
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+	}
 =

 	stk->default_agent =3D NULL;
 	stk->current_agent =3D stk->session_agent;
@@ -449,6 +453,9 @@ static void session_agent_notify(gpointer user_data)
 	DBG("Session Agent removed");
 =

 	if (stk->current_agent =3D=3D stk->session_agent && stk->respond_on_exit)=
 {
+		if (stk->pending_cmd)
+			stk->cancel_cmd(stk);
+
 		DBG("Sending Terminate response for session agent");
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
 	}
@@ -1590,6 +1597,128 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static void send_dtmf_cancel(struct ofono_stk *stk)
+{
+	struct ofono_voicecall *vc;
+	struct ofono_atom *vc_atom;
+
+	stk->respond_on_exit =3D FALSE;
+
+	if (stk->pending_cmd->send_dtmf.alpha_id &&
+			stk->pending_cmd->send_dtmf.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (!vc_atom)
+		return;
+
+	vc =3D __ofono_atom_get_data(vc_atom);
+	if (vc)
+		__ofono_voicecall_tone_cancel(vc);
+}
+
+static void dtmf_sent_cb(int err, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->respond_on_exit =3D FALSE;
+
+	if (stk->pending_cmd->send_dtmf.alpha_id &&
+			stk->pending_cmd->send_dtmf.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	if (err =3D=3D -ENOENT) {
+		struct stk_response rsp;
+		static unsigned char not_in_speech_call_result[] =3D { 0x07 };
+		static struct ofono_error error =3D
+			{ .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp.result.additional_len =3D sizeof(not_in_speech_call_result);
+		rsp.result.additional =3D not_in_speech_call_result;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		return;
+	}
+
+	if (err =3D=3D -EINVAL) {
+		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+		return;
+	}
+
+	if (err =3D=3D 0)
+		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+	else
+		send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+}
+
+static gboolean handle_command_send_dtmf(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	static unsigned char not_in_speech_call_result[] =3D { 0x07 };
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+	int err;
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (vc_atom)
+		vc =3D __ofono_atom_get_data(vc_atom);
+
+	if (!vc) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	err =3D __ofono_voicecall_send_tone(vc, cmd->send_dtmf.dtmf,
+						dtmf_sent_cb, stk);
+
+	if (err =3D=3D -EBUSY) {
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		return TRUE;
+	}
+
+	if (err =3D=3D -ENOSYS) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	if (err =3D=3D -ENOENT) {
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(not_in_speech_call_result);
+		rsp->result.additional =3D not_in_speech_call_result;
+		return TRUE;
+	}
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
+	if (cmd->send_dtmf.alpha_id && cmd->send_dtmf.alpha_id[0])
+		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id);
+
+	/*
+	 * Note that we don't strictly require an agent to be connected,
+	 * but to comply with 6.4.24 we need to send a End Session when
+	 * the user decides so.
+	 */
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D send_dtmf_cancel;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -1741,6 +1870,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SEND_DTMF:
+		respond =3D handle_command_send_dtmf(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1.86.g0e460.dirty


--===============3011403189723315272==--

