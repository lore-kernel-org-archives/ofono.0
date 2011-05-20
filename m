Content-Type: multipart/mixed; boundary="===============9009131698671952483=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 2/8] stk: Introduce BIP command handlers
Date: Fri, 20 May 2011 18:26:15 +0200
Message-ID: <1305908781-8322-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1305908781-8322-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9009131698671952483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  426 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 425 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 8214b65..fb376a6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -41,6 +41,7 @@
 #include "smsutil.h"
 #include "stkutil.h"
 #include "stkagent.h"
+#include "gprs.h"
 #include "util.h"
 =

 static GSList *g_drivers =3D NULL;
@@ -79,6 +80,11 @@ struct ofono_stk {
 =

 	__ofono_sms_sim_download_cb_t sms_pp_cb;
 	void *sms_pp_userdata;
+	struct stk_channel channel;
+	struct stk_channel_data rx_buffer;
+	struct stk_channel_data tx_buffer;
+	gboolean link_on_demand;
+	struct ofono_gprs *gprs;
 };
 =

 struct envelope_op {
@@ -104,6 +110,13 @@ static void timers_update(struct ofono_stk *stk);
 		result.additional_len =3D sizeof(addn_info);	\
 		result.additional =3D addn_info;			\
 =

+/*
+ * According the structure and coding of the Terminal response defined in
+ * TS 102 223 section 6.8, the maximum number of bytes possible for the ch=
annel
+ * data object is 243
+ */
+#define CHANNEL_DATA_OBJECT_MAX_LENGTH 243
+
 static int stk_respond(struct ofono_stk *stk, struct stk_response *rsp,
 			ofono_stk_generic_cb_t cb)
 {
@@ -474,12 +487,43 @@ static void emit_menu_changed(struct ofono_stk *stk)
 	g_dbus_send_message(conn, signal);
 }
 =

+static void stk_close_channel(struct ofono_stk *stk)
+{
+	/*
+	 * TODO
+	 * Deactivate and remove PDP context
+	 * Send the Terminal Response once the PDP context is deactivated
+	 */
+
+	/* Temporary implementation */
+	g_free(stk->rx_buffer.data.array);
+	g_free(stk->tx_buffer.data.array);
+	stk->rx_buffer.data.array =3D NULL;
+	stk->tx_buffer.data.array =3D NULL;
+
+	stk->channel.id =3D 0;
+	stk->channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+
+	if (stk->pending_cmd &&
+			stk->pending_cmd->type =3D=3D
+				STK_COMMAND_TYPE_CLOSE_CHANNEL)
+		send_simple_response(stk, STK_RESULT_TYPE_SUCCESS);
+}
+
 static void user_termination_cb(enum stk_agent_result result, void *user_d=
ata)
 {
 	struct ofono_stk *stk =3D user_data;
 =

-	if (result =3D=3D STK_AGENT_RESULT_TERMINATE)
+	if (result !=3D STK_AGENT_RESULT_TERMINATE)
+		return;
+
+	if (stk->pending_cmd) {
+		stk->cancel_cmd(stk);
 		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+	}
+
+	if (stk->channel.id)
+		stk_close_channel(stk);
 }
 =

 static void stk_alpha_id_set(struct ofono_stk *stk,
@@ -510,6 +554,147 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+
+static void stk_open_channel(struct ofono_stk *stk)
+{
+	const struct stk_command_open_channel *oc;
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	if (stk->pending_cmd =3D=3D NULL ||
+		stk->pending_cmd->type !=3D STK_COMMAND_TYPE_OPEN_CHANNEL)
+		return;
+
+	oc =3D &stk->pending_cmd->open_channel;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	stk->rx_buffer.data.array =3D g_try_malloc(oc->buf_size);
+	if (stk->rx_buffer.data.array =3D=3D NULL) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		goto out;
+	}
+
+	stk->tx_buffer.data.array =3D g_try_malloc(oc->buf_size);
+	if (stk->tx_buffer.data.array =3D=3D NULL) {
+		unsigned char no_cause_result[] =3D { 0x00 };
+
+		ADD_ERROR_RESULT(rsp.result, STK_RESULT_TYPE_TERMINAL_BUSY,
+					no_cause_result);
+		goto out;
+	}
+
+	stk->rx_buffer.data.len =3D oc->buf_size;
+	stk->rx_buffer.rx_remaining =3D 0;
+	stk->tx_buffer.data.len =3D oc->buf_size;
+	stk->tx_buffer.tx_avail =3D oc->buf_size;
+	stk->link_on_demand =3D (stk->pending_cmd->qualifier &
+				STK_OPEN_CHANNEL_FLAG_IMMEDIATE) ? FALSE : TRUE;
+
+	/*
+	 * TODO
+	 * Add a new primary PDP context based on the provided settings
+	 * Send the Terminal Response or wait until the PDP context is activated
+	 * in case of immediate link establishment not in background.
+	 */
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+	if (rsp.result.type =3D=3D STK_RESULT_TYPE_NOT_CAPABLE && stk->channel.id)
+		stk_close_channel(stk);
+}
+
+static void stk_send_data(struct ofono_stk *stk,
+				struct stk_common_byte_array data,
+				unsigned char qualifier)
+{
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	unsigned int offset;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (data.len > stk->tx_buffer.data.len ||
+		data.len > stk->tx_buffer.tx_avail) {
+		rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
+		goto out;
+	}
+
+	if (data.len) {
+		offset =3D stk->tx_buffer.data.len - stk->tx_buffer.tx_avail;
+		memcpy(stk->tx_buffer.data.array + offset, data.array,
+				data.len);
+
+		stk->tx_buffer.tx_avail -=3D data.len;
+
+		if (qualifier =3D=3D STK_SEND_DATA_STORE_DATA) {
+			rsp.send_data.tx_avail =3D stk->tx_buffer.tx_avail;
+			goto out;
+		}
+	}
+
+	if (stk->channel.status =3D=3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVA=
TED
+			&& stk->link_on_demand =3D=3D TRUE) {
+		/*
+		 * TODO
+		 * activate the context, update the channel status
+		 * once the context is activated, send the data immediately
+		 * and flush the tx buffer
+		 */
+	} else {
+		/*
+		 * TODO
+		 * send the data immediately, flush the tx buffer
+		 */
+		rsp.send_data.tx_avail =3D stk->tx_buffer.data.len;
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
+
+static void stk_receive_data(struct ofono_stk *stk, unsigned char data_len)
+{
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (stk->rx_buffer.rx_remaining =3D=3D 0) {
+		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
+		goto out;
+	}
+
+	if (data_len > stk->rx_buffer.rx_remaining) {
+		rsp.result.type =3D STK_RESULT_TYPE_MISSING_INFO;
+		data_len =3D stk->rx_buffer.rx_remaining;
+	}
+
+	if (data_len > CHANNEL_DATA_OBJECT_MAX_LENGTH)
+		data_len =3D CHANNEL_DATA_OBJECT_MAX_LENGTH;
+
+	rsp.receive_data.rx_data.array =3D stk->rx_buffer.data.array;
+	rsp.receive_data.rx_data.len =3D data_len;
+	stk->rx_buffer.rx_remaining -=3D data_len;
+	rsp.receive_data.rx_remaining =3D stk->rx_buffer.rx_remaining;
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+
+	if (rsp.receive_data.rx_data.len && stk->rx_buffer.rx_remaining > 0)
+		memmove(stk->rx_buffer.data.array, stk->rx_buffer.data.array +
+				data_len, stk->rx_buffer.rx_remaining);
+}
+
 static int duration_to_msecs(const struct stk_duration *duration)
 {
 	int msecs =3D duration->interval;
@@ -2589,6 +2774,220 @@ static gboolean handle_command_launch_browser(const=
 struct stk_command *cmd,
 	return FALSE;
 }
 =

+
+static void open_channel_cancel(struct ofono_stk *stk)
+{
+	/* TODO */
+}
+
+static void confirm_open_channel_cb(enum stk_agent_result result,
+					gboolean confirm,
+					void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
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
+	stk_open_channel(stk);
+}
+
+static gboolean handle_command_open_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	const struct stk_command_open_channel *oc =3D &cmd->open_channel;
+	struct ofono_atom *gprs_atom;
+	int err;
+
+	/* Check first if channel is available */
+	if (stk->channel.id) {
+		unsigned char addnl_info[1];
+
+		addnl_info[0] =3D STK_RESULT_ADDNL_BIP_PB_NO_CHANNEL_AVAIL;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+				addnl_info);
+		return TRUE;
+	}
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	if (gprs_atom =3D=3D NULL || !__ofono_atom_get_registered(gprs_atom)) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	stk->gprs =3D __ofono_atom_get_data(gprs_atom);
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D open_channel_cancel;
+
+	/*
+	 * Don't ask for user confirmation if AID is a null data object
+	 * or is not provided
+	 */
+	if (oc->alpha_id && strlen(oc->alpha_id) > 0) {
+		char *alpha_id;
+
+		alpha_id =3D dbus_apply_text_attributes(oc->alpha_id,
+								&oc->text_attr);
+		if (alpha_id =3D=3D NULL) {
+			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+			return TRUE;
+		}
+
+		err =3D stk_agent_confirm_open_channel(stk->current_agent,
+							alpha_id,
+							&oc->icon_id,
+							confirm_open_channel_cb,
+							stk, NULL,
+							stk->timeout * 1000);
+		g_free(alpha_id);
+
+		if (err < 0) {
+			unsigned char no_cause_result[] =3D { 0x00 };
+
+			ADD_ERROR_RESULT(rsp->result,
+						STK_RESULT_TYPE_TERMINAL_BUSY,
+						no_cause_result);
+			return TRUE;
+		}
+
+		return FALSE;
+	}
+
+	stk_open_channel(stk);
+
+	return FALSE;
+}
+
+static gboolean handle_command_close_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_close_channel *cc =3D &cmd->close_channel;
+
+	/* Check if channel identifier is valid */
+	if (cmd->dst !=3D (stk->channel.id | 0x20)) {
+		unsigned char addnl_info[1];
+
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/*
+	 * Don't inform the user about the link closing phase if AID is
+	 * a null data object or is not provided
+	 */
+	if (cc->alpha_id && strlen(cc->alpha_id) > 0)
+		stk_alpha_id_set(stk, cc->alpha_id, &cc->text_attr,
+							&cc->icon_id);
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	stk_close_channel(stk);
+
+	return FALSE;
+}
+
+static gboolean handle_command_receive_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_receive_data *rd =3D &cmd->receive_data;
+
+	/* Check if channel identifier is valid or already closed */
+	if (cmd->dst !=3D (stk->channel.id | 0x20)) {
+		unsigned char addnl_info[1];
+
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/*
+	 * Don't inform the user during data transfer if AID is
+	 * a null data object or is not provided
+	 */
+	if (rd->alpha_id && strlen(rd->alpha_id) > 0)
+		stk_alpha_id_set(stk, rd->alpha_id, &rd->text_attr,
+					&rd->icon_id);
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	stk_receive_data(stk, rd->data_len);
+
+	return FALSE;
+}
+
+static gboolean handle_command_send_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_send_data *sd =3D &cmd->send_data;
+	unsigned char addnl_info[1];
+
+	/* Check if channel identifier is valid or already closed */
+	if (cmd->dst !=3D (stk->channel.id | 0x20)) {
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/* Check if the link was dropped */
+	if (stk->channel.status =3D=3D STK_CHANNEL_LINK_DROPPED) {
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_CLOSED;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/*
+	 * Don't inform the user during data transfer if AID is
+	 * a null data object or is not provided
+	 */
+	if (sd->alpha_id && strlen(sd->alpha_id) > 0)
+		stk_alpha_id_set(stk, sd->alpha_id, &sd->text_attr,
+							&sd->icon_id);
+
+	stk->respond_on_exit =3D TRUE;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	stk_send_data(stk, sd->data, cmd->qualifier);
+
+	return FALSE;
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
@@ -2782,6 +3181,31 @@ void ofono_stk_proactive_command_notify(struct ofono=
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


--===============9009131698671952483==--

