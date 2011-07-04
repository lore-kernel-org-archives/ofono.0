Content-Type: multipart/mixed; boundary="===============0215765314216709787=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 08/11] stk: Add support for the proactive command 'Send
 data'
Date: Mon, 04 Jul 2011 18:06:39 +0200
Message-ID: <1309795602-26046-9-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0215765314216709787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 156 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 612eafb..1e5869a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -620,6 +620,43 @@ static void stk_alpha_id_unset(struct ofono_stk *stk)
 	stk_agent_request_cancel(stk->current_agent);
 }
 =

+static gsize stk_channel_data_write(struct ofono_stk *stk, gboolean packag=
e,
+					const unsigned char *data, gsize len)
+{
+	GIOStatus status;
+	gssize bytes_written;
+	int flags =3D 0;
+
+	if (stk->bip.protocol =3D=3D STK_TRANSPORT_PROTOCOL_UDP_CLIENT_REMOTE) {
+		if (package =3D=3D TRUE)
+			flags =3D MSG_MORE;
+
+		bytes_written =3D sendto(g_io_channel_unix_get_fd(stk->bip.io),
+					data, len, flags,
+					(struct sockaddr *) &stk->bip.dest_addr,
+					sizeof(stk->bip.dest_addr));
+
+		if (bytes_written =3D=3D -1 && stk->bip.read_watch > 0) {
+			g_source_remove(stk->bip.read_watch);
+			return 0;
+		}
+	} else {
+		status =3D g_io_channel_write_chars(stk->bip.io, (gchar *)data,
+					len, (gsize *) &bytes_written, NULL);
+
+		if (status !=3D G_IO_STATUS_NORMAL && stk->bip.read_watch > 0) {
+			g_source_remove(stk->bip.read_watch);
+			return 0;
+		}
+	}
+
+	DBG("Send %zd bytes", bytes_written);
+
+	stk->bip.tx_avail +=3D bytes_written;
+
+	return bytes_written;
+}
+
 static gboolean receive_callback(GIOChannel *channel, GIOCondition cond,
 				gpointer userdata)
 {
@@ -778,7 +815,17 @@ static void ofono_stk_activate_context_cb(int error, c=
onst char *interface,
 				sizeof(struct stk_bearer_description));
 	} else if (stk->pending_cmd->type =3D=3D STK_COMMAND_TYPE_SEND_DATA &&
 			stk->bip.link_on_demand) {
-		/* TODO send data */
+		const struct stk_command_send_data *sd =3D
+						&stk->pending_cmd->send_data;
+		gboolean package =3D (stk->pending_cmd->qualifier =3D=3D
+				STK_SEND_DATA_STORE_DATA) ? TRUE : FALSE;
+
+		if (stk_channel_data_write(stk, package, sd->data.array,
+						sd->data.len) =3D=3D 0) {
+				ofono_error("Failed to send data");
+				rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+				goto out;
+		}
 		rsp.send_data.tx_avail =3D stk->bip.tx_avail;
 	} else {
 		/* TODO send channel status event */
@@ -912,6 +959,70 @@ out:
 		stk_close_channel(stk);
 }
 =

+static void stk_send_data(struct ofono_stk *stk,
+				struct stk_common_byte_array data,
+				unsigned char qualifier)
+{
+	struct stk_response rsp;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (data.len > stk->bip.tx_avail) {
+		rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
+		goto out;
+	}
+
+	if (stk->bip.channel.status =3D=3D
+			STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED &&
+			stk->bip.link_on_demand =3D=3D TRUE) {
+		int err;
+		struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+		struct ofono_atom *gprs_atom;
+
+		gprs_atom =3D __ofono_modem_find_atom(modem,
+							OFONO_ATOM_TYPE_GPRS);
+		if (gprs_atom =3D=3D NULL ||
+				!__ofono_atom_get_registered(gprs_atom)) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		err =3D __ofono_gprs_private_context_activate(
+					__ofono_atom_get_data(gprs_atom),
+					&stk->bip.context,
+					ofono_stk_activate_context_cb, stk);
+
+		if (err =3D=3D -EBUSY) {
+			rsp.result.type =3D STK_RESULT_TYPE_BIP_ERROR;
+			goto out;
+		} else if (err < 0) {
+			rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+			goto out;
+		}
+
+		return;
+	} else {
+		gboolean package =3D (qualifier =3D=3D STK_SEND_DATA_STORE_DATA) ?
+						TRUE : FALSE;
+
+		if (stk_channel_data_write(stk, package, data.array,
+						data.len) =3D=3D 0) {
+				ofono_error("Failed to send data");
+				rsp.result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+				goto out;
+		}
+		stk->bip.tx_avail -=3D data.len;
+		rsp.send_data.tx_avail =3D stk->bip.tx_avail;
+	}
+
+out:
+	if (stk_respond(stk, &rsp, stk_command_cb))
+		stk_command_cb(&failure, stk);
+}
+
 static void stk_receive_data(struct ofono_stk *stk, unsigned char toread)
 {
 	struct stk_response rsp;
@@ -3195,6 +3306,45 @@ static gboolean handle_command_receive_data(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static gboolean handle_command_send_data(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_send_data *sd =3D &cmd->send_data;
+	unsigned char addnl_info[1];
+
+	/* Check if channel identifier is valid or already closed */
+	if (cmd->dst !=3D (stk->bip.channel.id | 0x20)) {
+		addnl_info[1] =3D STK_RESULT_ADDNL_BIP_PB_CHANNEL_ID_NOT_VALID;
+		ADD_ERROR_RESULT(rsp->result, STK_RESULT_TYPE_BIP_ERROR,
+					addnl_info);
+		return TRUE;
+	}
+
+	/* Check if the link was dropped */
+	if (stk->bip.channel.status =3D=3D STK_CHANNEL_LINK_DROPPED) {
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
+	if (sd->alpha_id && sd->alpha_id[0] !=3D '\0')
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
 static gboolean handle_command_get_channel_status(const struct stk_command=
 *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -3413,6 +3563,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_SEND_DATA:
+		respond =3D handle_command_send_data(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
 		respond =3D handle_command_get_channel_status(stk->pending_cmd,
 							&rsp, stk);
-- =

1.7.1


--===============0215765314216709787==--

