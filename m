Content-Type: multipart/mixed; boundary="===============5428128452156831501=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4] stk: Handle the Send DTMF proactive command.
Date: Thu, 21 Oct 2010 07:09:06 +0200
Message-ID: <1287637748-7230-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1287637748-7230-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5428128452156831501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default_agent_notify and session_agent_notify changes below are
needed for respond_on_exit commands to be able to free up their
resources, reset alpha id, etc.  Commands other than Send DTMF that
use respond_on_exit are all associated with a agent method call and
get notified about agent exit in the callback.
---
 src/stk.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 142 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 60b308b..d42a05f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -74,6 +74,7 @@ struct ofono_stk {
 	char *idle_mode_text;
 	struct stk_icon_id idle_mode_icon;
 	struct timeval get_inkey_start_ts;
+	int dtmf_id;
 };
 =

 struct envelope_op {
@@ -460,8 +461,12 @@ static void default_agent_notify(gpointer user_data)
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
@@ -475,6 +480,9 @@ static void session_agent_notify(gpointer user_data)
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
@@ -1852,6 +1860,134 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static void send_dtmf_cancel(struct ofono_stk *stk)
+{
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+
+	stk->respond_on_exit =3D FALSE;
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (vc_atom)
+		vc =3D __ofono_atom_get_data(vc_atom);
+
+	if (vc) /* Should be always true here */
+		__ofono_voicecall_tone_cancel(vc, stk->dtmf_id);
+
+	stk_alpha_id_unset(stk);
+}
+
+static void dtmf_sent_cb(int error, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->respond_on_exit =3D FALSE;
+
+	stk_alpha_id_unset(stk);
+
+	if (error =3D=3D ENOENT) {
+		struct stk_response rsp;
+		static unsigned char not_in_speech_call_result[] =3D { 0x07 };
+		static struct ofono_error failure =3D
+			{ .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp.result.additional_len =3D sizeof(not_in_speech_call_result);
+		rsp.result.additional =3D not_in_speech_call_result;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
+		return;
+	}
+
+	if (error =3D=3D EINVAL)
+		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+	else if (error)
+		send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+	else
+		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+}
+
+static gboolean handle_command_send_dtmf(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	static unsigned char not_in_speech_call_result[] =3D { 0x07 };
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+	char dtmf[256], *digit;
+	char *dtmf_from =3D "01234567890abcABC";
+	char *dtmf_to =3D "01234567890*#p*#p";
+	int err, pos;
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
+	/* Convert the DTMF string to phone number format */
+	for (pos =3D 0; cmd->send_dtmf.dtmf[pos] !=3D 0; pos++) {
+		digit =3D strchr(dtmf_from, cmd->send_dtmf.dtmf[pos]);
+		if (!digit) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+			return TRUE;
+		}
+
+		dtmf[pos] =3D dtmf_to[digit - dtmf_from];
+	}
+	dtmf[pos] =3D 0;
+
+	err =3D __ofono_voicecall_tone_send(vc, dtmf, dtmf_sent_cb, stk);
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
+	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id, &cmd->send_dtmf.icon_id);
+
+	/*
+	 * Note that we don't strictly require an agent to be connected,
+	 * but to comply with 6.4.24 we need to send a End Session when
+	 * the user decides so.
+	 */
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D send_dtmf_cancel;
+	stk->dtmf_id =3D err;
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2024,6 +2160,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
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


--===============5428128452156831501==--

