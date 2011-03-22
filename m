Content-Type: multipart/mixed; boundary="===============8650982638862355837=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/6] stk: Introduce BIP command handlers
Date: Tue, 22 Mar 2011 13:51:17 +0100
Message-ID: <1300798280-4281-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8650982638862355837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  307 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 307 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 68b6240..d224360 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -79,6 +79,9 @@ struct ofono_stk {
 =

 	__ofono_sms_sim_download_cb_t sms_pp_cb;
 	void *sms_pp_userdata;
+	struct stk_channel channel;
+	struct stk_channel_data rx_buffer;
+	struct stk_channel_data tx_buffer;
 };
 =

 struct envelope_op {
@@ -2548,6 +2551,285 @@ static gboolean handle_command_launch_browser(const=
 struct stk_command *cmd,
 	return FALSE;
 }
 =

+static void confirm_open_channel_cb(enum stk_agent_result result,
+					gboolean confirm,
+					void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	unsigned char no_cause[] =3D { 0x00 };
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+
+	stk->respond_on_exit =3D FALSE;
+
+	switch (result) {
+	case STK_AGENT_RESULT_TERMINATE:
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+		return;
+
+	case STK_AGENT_RESULT_TIMEOUT:
+		confirm =3D FALSE;
+		/* Fall through */
+
+	case STK_AGENT_RESULT_OK:
+		if (confirm)
+			break;
+		/* Fall through */
+
+	default:
+		memset(&rsp, 0, sizeof(rsp));
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause);
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
+		return;
+	}
+
+	/*
+	 * TODO
+	 * setup the channel
+	 */
+
+	/* For now, return  "Command beyond terminal's capabilities" */
+	send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+}
+
+static gboolean handle_command_open_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_open_channel *oc =3D &cmd->open_channel;
+	char *alpha_id;
+	int err;
+
+	/* Don't ask for user confirmation if AID is a null data object*/
+	if (oc->alpha_id && strlen(oc->alpha_id) =3D=3D 0) {
+		/*
+		 * TODO
+		 * setup the channel
+		 */
+
+		/* For now, return  "Command beyond terminal's capabilities" */
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	alpha_id =3D dbus_apply_text_attributes(oc->alpha_id ? oc->alpha_id : "",
+							&oc->text_attr);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_confirm_open_channel(stk->current_agent, alpha_id,
+						&oc->icon_id,
+						confirm_open_channel_cb,
+						stk, NULL, stk->timeout * 1000);
+	g_free(alpha_id);
+
+	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		return TRUE;
+	}
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	return FALSE;
+}
+
+static void channel_activity_cb(enum stk_agent_result result, void *user_d=
ata)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
+		stk->respond_on_exit =3D FALSE;
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+	}
+}
+
+static gboolean handle_command_close_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_close_channel *cc =3D &cmd->close_channel;
+	char *alpha_id;
+	int err;
+
+	/*
+	 * Don't inform the user about the link closing phase if AID is
+	 * a null data object
+	 * */
+	if (cc->alpha_id && strlen(cc->alpha_id) =3D=3D 0)
+		goto close;
+
+	alpha_id =3D dbus_apply_text_attributes(cc->alpha_id ? cc->alpha_id : "",
+							&cc->text_attr);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_display_channel_activity(stk->current_agent, alpha_id,
+							&cc->icon_id,
+							channel_activity_cb,
+							stk, NULL);
+	g_free(alpha_id);
+
+	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		return TRUE;
+	}
+
+close:
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+	/*
+	 * TODO
+	 * close the channel
+	 * Send the Terminal Response once the PDP context is deactivated
+	 */
+
+	/* For now, return  "Command beyond terminal's capabilities" */
+	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+	return TRUE;
+}
+
+static gboolean handle_command_receive_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_receive_data *rd =3D &cmd->receive_data;
+	char *alpha_id;
+	int err;
+
+	/*
+	 * Don't inform the user during data transfer
+	 * if AID is a null data object
+	 */
+	if (rd->alpha_id && strlen(rd->alpha_id) =3D=3D 0)
+		goto receive;
+
+	alpha_id =3D dbus_apply_text_attributes(rd->alpha_id ? rd->alpha_id : "",
+							&rd->text_attr);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_display_channel_activity(stk->current_agent, alpha_id,
+							&rd->icon_id,
+							channel_activity_cb,
+							stk, NULL);
+	g_free(alpha_id);
+
+	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		return TRUE;
+	}
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+receive:
+	/*
+	 * TODO
+	 * return data available in the Rx buffer corresponding to the
+	 * channel identifier
+	 */
+
+	/* For now, return  "Command beyond terminal's capabilities" */
+	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+	return TRUE;
+}
+
+static gboolean handle_command_send_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_send_data *sd =3D &cmd->send_data;
+	char *alpha_id;
+	int err;
+
+	/*
+	 * Don't inform the user during data transfer
+	 * if AID is a null data object
+	 */
+	if (sd->alpha_id && strlen(sd->alpha_id) =3D=3D 0)
+		goto send;
+
+	alpha_id =3D dbus_apply_text_attributes(sd->alpha_id ? sd->alpha_id : "",
+							&sd->text_attr);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
+	}
+
+	err =3D stk_agent_display_channel_activity(stk->current_agent, alpha_id,
+							&sd->icon_id,
+							channel_activity_cb,
+							stk, NULL);
+	g_free(alpha_id);
+
+	if (err < 0) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		/*
+		 * We most likely got an out of memory error, tell SIM
+		 * to retry
+		 */
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		return TRUE;
+	}
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+send:
+	/*
+	 * TODO
+	 * send the data immediately or store the provided data in the Tx buffer
+	 * corresponding to the channel identifier
+	 */
+	/* For now, return  "Command beyond terminal's capabilities"	*/
+	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+	return TRUE;
+}
+
+static gboolean handle_command_get_channel_status(const struct stk_command=
 *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+	rsp->channel_status.channel.id =3D stk->channel.id;
+	rsp->channel_status.channel.status =3D stk->channel.status;
+	return TRUE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2741,6 +3023,31 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_OPEN_CHANNEL:
+		respond =3D handle_command_open_channel(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
+		respond =3D handle_command_close_channel(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_RECEIVE_DATA:
+		respond =3D handle_command_receive_data(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_SEND_DATA:
+		respond =3D handle_command_send_data(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
+		respond =3D handle_command_get_channel_status(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.1


--===============8650982638862355837==--

