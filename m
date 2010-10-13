Content-Type: multipart/mixed; boundary="===============1961171334887510169=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 02/13] stk: Handle the Send DTMF proactive command.
Date: Wed, 13 Oct 2010 15:54:05 +0200
Message-ID: <1286978056-16600-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1961171334887510169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In this version 'p' is used as the pause character in DTMF strings as
it seems in more widespread use than comma.  ISImodem already
understands 'p'.  atmodem support comes in the next patch.
---
 src/stk.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
---
 1 files changed, 168 insertions(+), 9 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 80b4d23..3792d2f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -70,7 +70,7 @@ struct ofono_stk {
 	gboolean respond_on_exit;
 	ofono_bool_t immediate_response;
 	guint remove_agent_source;
-	struct sms_submit_req *sms_submit_req;
+	struct extern_req *extern_req;
 	char *idle_mode_text;
 	struct timeval get_inkey_start_ts;
 };
@@ -83,7 +83,7 @@ struct envelope_op {
 			const unsigned char *data, int length);
 };
 =

-struct sms_submit_req {
+struct extern_req {
 	struct ofono_stk *stk;
 	gboolean cancelled;
 };
@@ -435,8 +435,12 @@ static void default_agent_notify(gpointer user_data)
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
@@ -450,6 +454,9 @@ static void session_agent_notify(gpointer user_data)
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
@@ -660,7 +667,7 @@ static gboolean handle_command_more_time(const struct s=
tk_command *cmd,
 =

 static void send_sms_cancel(struct ofono_stk *stk)
 {
-	stk->sms_submit_req->cancelled =3D TRUE;
+	stk->extern_req->cancelled =3D TRUE;
 =

 	if (!stk->pending_cmd->send_sms.alpha_id ||
 			!stk->pending_cmd->send_sms.alpha_id[0])
@@ -671,7 +678,7 @@ static void send_sms_cancel(struct ofono_stk *stk)
 =

 static void send_sms_submit_cb(gboolean ok, void *data)
 {
-	struct sms_submit_req *req =3D data;
+	struct extern_req *req =3D data;
 	struct ofono_stk *stk =3D req->stk;
 	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 	struct stk_response rsp;
@@ -697,6 +704,12 @@ static void send_sms_submit_cb(gboolean ok, void *data)
 		stk_command_cb(&failure, stk);
 }
 =

+static void extern_req_start(struct ofono_stk *stk)
+{
+	stk->extern_req =3D g_new0(struct extern_req, 1);
+	stk->extern_req->stk =3D stk;
+}
+
 static gboolean handle_command_send_sms(const struct stk_command *cmd,
 					struct stk_response *rsp,
 					struct ofono_stk *stk)
@@ -715,15 +728,14 @@ static gboolean handle_command_send_sms(const struct =
stk_command *cmd,
 =

 	sms =3D __ofono_atom_get_data(sms_atom);
 =

-	stk->sms_submit_req =3D g_new0(struct sms_submit_req, 1);
-	stk->sms_submit_req->stk =3D stk;
+	extern_req_start(stk);
 =

 	msg_list.data =3D (void *) &cmd->send_sms.gsm_sms;
 	msg_list.next =3D NULL;
 =

 	if (__ofono_sms_txq_submit(sms, &msg_list, 0, NULL, send_sms_submit_cb,
-				stk->sms_submit_req, g_free) < 0) {
-		g_free(stk->sms_submit_req);
+				stk->extern_req, g_free) < 0) {
+		g_free(stk->extern_req);
 		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
 		return TRUE;
 	}
@@ -1824,6 +1836,148 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static void send_dtmf_cancel(struct ofono_stk *stk)
+{
+	stk->respond_on_exit =3D FALSE;
+	stk->extern_req->cancelled =3D TRUE;
+
+	if (stk->pending_cmd->send_dtmf.alpha_id &&
+			stk->pending_cmd->send_dtmf.alpha_id[0])
+		stk_alpha_id_unset(stk);
+}
+
+static void dtmf_sent_cb(const struct ofono_error *error, void *user_data)
+{
+	struct extern_req *req =3D user_data;
+	struct ofono_stk *stk =3D req->stk;
+	gboolean cancelled =3D req->cancelled;
+
+	g_free(req);
+
+	if (cancelled) {
+		DBG("Received a DTMF Sent callback after the "
+				"proactive command was cancelled");
+		return;
+	}
+
+	stk->respond_on_exit =3D FALSE;
+
+	if (stk->pending_cmd->send_dtmf.alpha_id &&
+			stk->pending_cmd->send_dtmf.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
+			error->error =3D=3D ENOENT) {
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
+	if (error->type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
+			error->error =3D=3D ENOENT) {
+		send_simple_response(stk, STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD);
+		return;
+	}
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
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
+	extern_req_start(stk);
+
+	err =3D __ofono_voicecall_send_tone(vc, dtmf,
+						dtmf_sent_cb, stk->extern_req);
+	if (err < 0)
+		g_free(stk->extern_req);
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
@@ -1996,6 +2150,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
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


--===============1961171334887510169==--

