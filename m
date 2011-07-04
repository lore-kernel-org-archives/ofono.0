Content-Type: multipart/mixed; boundary="===============4643206796267613335=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 04/11] stk: Add support for the proactive command 'Close
 channel'
Date: Mon, 04 Jul 2011 18:06:35 +0200
Message-ID: <1309795602-26046-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1309795602-26046-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4643206796267613335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 64ef91a..8d4f7c0 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -504,6 +504,37 @@ static void cancel_pending_dtmf(struct ofono_stk *stk)
 		__ofono_voicecall_tone_cancel(vc, stk->dtmf_id);
 }
 =

+static void ofono_stk_deactivate_context_cb(int error, void *data)
+{
+}
+
+static void stk_close_channel(struct ofono_stk *stk)
+{
+	int err;
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	struct ofono_atom *gprs_atom;
+
+	gprs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_GPRS);
+	if (gprs_atom =3D=3D NULL || !__ofono_atom_get_registered(gprs_atom))
+		goto out;
+
+	err =3D __ofono_gprs_private_context_deactivate(
+					__ofono_atom_get_data(gprs_atom),
+					ofono_stk_deactivate_context_cb,
+					stk);
+
+	if (err =3D=3D 0)
+		return;
+
+out:
+	stk->bip.channel.id =3D 0;
+	stk->bip.channel.status =3D STK_CHANNEL_PACKET_DATA_SERVICE_NOT_ACTIVATED;
+
+	if (stk->pending_cmd && stk->pending_cmd->type =3D=3D
+						STK_COMMAND_TYPE_CLOSE_CHANNEL)
+		send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
+}
+
 static void user_termination_cb(enum stk_agent_result result, void *user_d=
ata)
 {
 	struct ofono_stk *stk =3D user_data;
@@ -518,6 +549,9 @@ static void user_termination_cb(enum stk_agent_result r=
esult, void *user_data)
 	}
 =

 	send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+
+	if (stk->bip.channel.id)
+		stk_close_channel(stk);
 }
 =

 static void stk_alpha_id_set(struct ofono_stk *stk,
@@ -662,6 +696,8 @@ out:
 	if (stk_respond(stk, &rsp, stk_command_cb))
 		stk_command_cb(&failure, stk);
 =

+	if (rsp.result.type !=3D STK_RESULT_TYPE_SUCCESS)
+		stk_close_channel(stk);
 }
 =

 static int duration_to_msecs(const struct stk_duration *duration)
@@ -2827,6 +2863,38 @@ static gboolean handle_command_open_channel(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static gboolean handle_command_close_channel(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_close_channel *cc =3D &cmd->close_channel;
+
+	/* Check if channel identifier is valid */
+	if (cmd->dst !=3D (stk->bip.channel.id | 0x20)) {
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
+	if (cc->alpha_id && cc->alpha_id[0] !=3D '\0')
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
 static gboolean handle_command_get_channel_status(const struct stk_command=
 *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -3035,6 +3103,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_CLOSE_CHANNEL:
+		respond =3D handle_command_close_channel(stk->pending_cmd,
+							&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_GET_CHANNEL_STATUS:
 		respond =3D handle_command_get_channel_status(stk->pending_cmd,
 							&rsp, stk);
-- =

1.7.1


--===============4643206796267613335==--

