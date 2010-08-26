Content-Type: multipart/mixed; boundary="===============2682857296918528120=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] stk: Handle the Set Up Call proactive command.
Date: Thu, 26 Aug 2010 13:36:48 +0200
Message-ID: <1282822608-17535-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1282822608-17535-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2682857296918528120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  188 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 188 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index a7e594e..eb31b0f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1399,6 +1399,188 @@ static gboolean handle_command_get_input(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void call_setup_connected(struct ofono_call *call, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	struct stk_response rsp;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	static unsigned char facility_rejected_result[] =3D { 0x9d };
+
+	if (!call) {
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
+		rsp.result.additional_len =3D sizeof(facility_rejected_result);
+		rsp.result.additional =3D facility_rejected_result;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		return;
+	}
+
+	if (call->status =3D=3D CALL_STATUS_ACTIVE)
+		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+	else
+		send_simple_response(stk, STK_RESULT_TYPE_USER_CANCEL);
+}
+
+static void call_setup_cancel(struct ofono_stk *stk)
+{
+	struct ofono_voicecall *vc;
+	struct ofono_atom *vc_atom;
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (!vc_atom)
+		return;
+
+	vc =3D __ofono_atom_get_data(vc_atom);
+	if (vc)
+		__ofono_voicecall_dial_cancel(vc);
+}
+
+static void confirm_call_cb(enum stk_agent_result result, gboolean confirm,
+				void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+	const struct stk_command_setup_call *sc =3D &stk->pending_cmd->setup_call;
+	uint8_t qualifier =3D stk->pending_cmd->qualifier;
+	static unsigned char busy_on_call_result[] =3D { 0x02 };
+	static unsigned char no_cause_result[] =3D { 0x00 };
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+	struct stk_response rsp;
+	int err;
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
+
+	case STK_AGENT_RESULT_TERMINATE:
+	default:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		return;
+	}
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (vc_atom)
+		vc =3D __ofono_atom_get_data(vc_atom);
+
+	if (!vc) {
+		send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+		return;
+	}
+
+	err =3D __ofono_voicecall_dial(vc, sc->addr.number, sc->addr.ton_npi,
+					sc->alpha_id_call_setup, 0,
+					qualifier >> 1, call_setup_connected,
+					stk);
+	if (err >=3D 0) {
+		stk->cancel_cmd =3D call_setup_cancel;
+
+		return;
+	}
+
+	if (err =3D=3D -EBUSY) {
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp.result.additional_len =3D sizeof(busy_on_call_result);
+		rsp.result.additional =3D busy_on_call_result;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&error, stk);
+
+		return;
+	}
+
+	if (err =3D=3D -ENOSYS) {
+		send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+
+		return;
+	}
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	rsp.result.type =3D STK_RESULT_TYPE_NETWORK_UNAVAILABLE;
+	rsp.result.additional_len =3D sizeof(no_cause_result);
+	rsp.result.additional =3D no_cause_result;
+
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+}
+
+static gboolean handle_command_set_up_call(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_setup_call *sc =3D &cmd->setup_call;
+	uint8_t qualifier =3D cmd->qualifier;
+	static unsigned char busy_on_call_result[] =3D { 0x02 };
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+	int err;
+
+	if (qualifier > 5) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	/*
+	 * Passing called party subaddress and establishing non-speech
+	 * calls are not supported.
+	 */
+	if (sc->ccp.len || sc->subaddr.len) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
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
+	if (__ofono_voicecall_busy(vc) && (qualifier =3D=3D 0 || qualifier =3D=3D=
 1)) {
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_call_result);
+		rsp->result.additional =3D busy_on_call_result;
+		return TRUE;
+	}
+
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	err =3D stk_agent_confirm_call(stk->current_agent, sc->alpha_id_usr_cfm,
+					0, confirm_call_cb, stk, NULL,
+					stk->timeout * 1000);
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
@@ -1482,6 +1664,7 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 		case STK_COMMAND_TYPE_GET_INKEY:
 		case STK_COMMAND_TYPE_GET_INPUT:
 		case STK_COMMAND_TYPE_PLAY_TONE:
+		case STK_COMMAND_TYPE_SETUP_CALL:
 			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
 			return;
 =

@@ -1543,6 +1726,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SETUP_CALL:
+		respond =3D handle_command_set_up_call(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1.86.g0e460.dirty


--===============2682857296918528120==--

