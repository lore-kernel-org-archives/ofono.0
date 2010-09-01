Content-Type: multipart/mixed; boundary="===============0301918139272731630=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 06/11] Send USSD proactive command handling
Date: Wed, 01 Sep 2010 04:00:31 -0700
Message-ID: <1283338836-13572-6-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0301918139272731630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3fda2af..66a98b4 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1590,6 +1590,117 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static void send_ussd_callback( int error, int dcs, const unsigned char* m=
sg,
+                                int msg_len, void* userdata)
+{
+	struct ofono_stk *stk =3D userdata;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+
+	if (stk->pending_cmd->send_ussd.alpha_id &&
+		stk->pending_cmd->send_ussd.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	switch (error) {
+	case OFONO_USSD_FAILURE_NONE:
+		memset(&rsp, 0, sizeof(rsp));
+
+		rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+		rsp.send_ussd.dcs =3D dcs;
+		rsp.send_ussd.text =3D g_memdup(msg, msg_len);
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+		        stk_command_cb(&failure, stk);
+
+		break;
+	case OFONO_USSD_FAILURE_USER_TERMINATED:
+		send_simple_response(stk, STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION);
+		break;
+	case OFONO_USSD_FAILURE_TIMED_OUT:
+		send_simple_response(stk, STK_RESULT_TYPE_NETWORK_UNAVAILABLE);
+		break;
+	case OFONO_USSD_FAILURE_RETURN_ERROR:
+		send_simple_response(stk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
+		break;
+	}
+}
+
+static gboolean handle_command_send_ussd(const struct stk_command *cmd,
+                                        struct stk_response *rsp,
+                                        struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	static unsigned char busy_on_ss_result[] =3D { 0x03 };
+	static unsigned char busy_on_ussd_result[] =3D { 0x08 };
+	int err;
+
+	struct ofono_atom *cf_atom;
+	struct ofono_atom *cb_atom;
+	struct ofono_atom *cs_atom;
+	struct ofono_atom *ussd_atom;
+
+	struct ofono_call_forwarding *cf;
+	struct ofono_call_barring *cb;
+	struct ofono_call_settings *cs;
+	struct ofono_ussd *ussd;
+
+	cf_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_FORWARDIN=
G);
+	cb_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_BARRING);
+	cs_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_SETTINGS);
+	ussd_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
+
+	if (!cf_atom || !__ofono_atom_get_registered(cf_atom) ||
+		!cb_atom || !__ofono_atom_get_registered(cb_atom) ||
+		!cs_atom || !__ofono_atom_get_registered(cs_atom)) {
+	=

+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	cf =3D __ofono_atom_get_data(cf_atom);
+	cb =3D __ofono_atom_get_data(cb_atom);
+	cs =3D __ofono_atom_get_data(cs_atom);
+	ussd =3D __ofono_atom_get_data(ussd_atom);
+
+	if (__ofono_call_barring_is_busy(cb) ||
+		__ofono_call_forwarding_is_busy(cf) ||
+		__ofono_call_settings_is_busy(cs)){
+		=

+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_ss_result);
+		rsp->result.additional =3D busy_on_ss_result;
+		return TRUE;
+	}
+
+	if (__ofono_ussd_is_busy(ussd)){
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
+		rsp->result.additional =3D busy_on_ussd_result;
+		return TRUE;
+	}
+
+	err =3D __ofono_ussd_initiate( ussd, cmd->send_ussd.ussd_string.dcs,
+                         cmd->send_ussd.ussd_string.string,
+                         cmd->send_ussd.ussd_string.len,
+                         send_ussd_callback, stk);
+
+	if (err >=3D 0) {
+		return FALSE;
+	}
+
+	if (err =3D=3D -ENOSYS) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+
+		return TRUE;
+	}
+
+	if (cmd->send_ussd.alpha_id && cmd->send_ussd.alpha_id[0])
+		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -1740,6 +1851,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		respond =3D handle_command_set_up_call(stk->pending_cmd,
 							&rsp, stk);
 		break;
+	case STK_COMMAND_TYPE_SEND_USSD:
+		respond =3D handle_command_send_ussd(stk->pending_cmd,
+                                           &rsp, stk);
+		break;
 =

 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============0301918139272731630==--

