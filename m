Content-Type: multipart/mixed; boundary="===============4469913600383312486=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 7/8] stk: Handling of Send USSD proactive command
Date: Mon, 13 Sep 2010 16:00:16 -0700
Message-ID: <1284418817-28575-8-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1284418817-28575-7-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4469913600383312486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 143 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 04bfc65..e9e42be 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1590,6 +1590,145 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 	return FALSE;
 }
 =

+static void send_ussd_callback(int error, int dcs, const unsigned char *ms=
g,
+				int msg_len, void *userdata)
+{
+	struct ofono_stk *stk =3D userdata;
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct stk_response rsp;
+	enum sms_charset charset;
+
+	if (stk->pending_cmd->send_ussd.alpha_id &&
+			stk->pending_cmd->send_ussd.alpha_id[0])
+		stk_alpha_id_unset(stk);
+
+	memset(&rsp, 0, sizeof(rsp));
+
+	switch (error) {
+	case 0:
+		if (cbs_dcs_decode(dcs, NULL, NULL, &charset,
+					NULL, NULL, NULL)) {
+			if (charset =3D=3D SMS_CHARSET_7BIT)
+				rsp.send_ussd.text.dcs =3D 0x00;
+			else if (charset =3D=3D SMS_CHARSET_8BIT)
+				rsp.send_ussd.text.dcs =3D 0x04;
+			else if (charset =3D=3D SMS_CHARSET_UCS2)
+				rsp.send_ussd.text.dcs =3D 0x08;
+
+			rsp.result.type =3D STK_RESULT_TYPE_SUCCESS;
+			rsp.send_ussd.text.text =3D msg;
+			rsp.send_ussd.text.len =3D msg_len;
+		} else {
+			rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
+			rsp.result.additional =3D (unsigned char *) &error;
+			rsp.result.additional_len =3D 1;
+			rsp.send_ussd.text.dcs =3D -1;
+		}
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
+		break;
+	case -ECANCELED:
+		send_simple_response(stk,
+				STK_RESULT_TYPE_USSD_OR_SS_USER_TERMINATION);
+		break;
+	case -ETIMEDOUT:
+		send_simple_response(stk, STK_RESULT_TYPE_NETWORK_UNAVAILABLE);
+		break;
+	default:
+		rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
+		rsp.result.additional =3D (unsigned char *) &error;
+		rsp.result.additional_len =3D 1;
+		rsp.send_ussd.text.dcs =3D -1;
+
+		if (stk_respond(stk, &rsp, stk_command_cb))
+			stk_command_cb(&failure, stk);
+
+		break;
+	}
+}
+
+static gboolean handle_command_send_ussd(const struct stk_command *cmd,
+					struct stk_response *rsp,
+					struct ofono_stk *stk)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(stk->atom);
+	static unsigned char busy_on_ss_result[] =3D { 0x03 };
+	static unsigned char busy_on_ussd_result[] =3D { 0x08 };
+	struct ofono_atom *atom;
+	struct ofono_ussd *ussd;
+	int err;
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_FORWARDING);
+	if (atom && __ofono_atom_get_registered(atom)) {
+		struct ofono_call_forwarding *cf =3D __ofono_atom_get_data(atom);
+
+		if (__ofono_call_forwarding_is_busy(cf)) {
+			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
+			rsp->result.additional =3D busy_on_ss_result;
+			return TRUE;
+		}
+	}
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_BARRING);
+	if (atom && __ofono_atom_get_registered(atom)) {
+		struct ofono_call_barring *cb =3D __ofono_atom_get_data(atom);
+
+		if (__ofono_call_barring_is_busy(cb)) {
+			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
+			rsp->result.additional =3D busy_on_ss_result;
+			return TRUE;
+		}
+	}
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_CALL_SETTINGS);
+	if (atom && __ofono_atom_get_registered(atom)) {
+		struct ofono_call_settings *cs =3D __ofono_atom_get_data(atom);
+
+		if (__ofono_call_settings_is_busy(cs)) {
+			rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+			rsp->result.additional_len =3D sizeof(busy_on_ss_result);
+			rsp->result.additional =3D busy_on_ss_result;
+			return TRUE;
+		}
+	}
+
+	atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_USSD);
+	if (!atom || !__ofono_atom_get_registered(atom)) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	ussd =3D __ofono_atom_get_data(atom);
+	if (__ofono_ussd_is_busy(ussd)) {
+		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
+		rsp->result.additional_len =3D sizeof(busy_on_ussd_result);
+		rsp->result.additional =3D busy_on_ussd_result;
+		return TRUE;
+	}
+
+	err =3D __ofono_ussd_initiate(ussd, cmd->send_ussd.ussd_string.dcs,
+					cmd->send_ussd.ussd_string.string,
+					cmd->send_ussd.ussd_string.len,
+					send_ussd_callback, stk);
+
+	if (err >=3D 0)
+		return FALSE;
+
+	if (err =3D=3D -ENOSYS) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
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
@@ -1740,7 +1879,10 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 		respond =3D handle_command_set_up_call(stk->pending_cmd,
 							&rsp, stk);
 		break;
-
+	case STK_COMMAND_TYPE_SEND_USSD:
+		respond =3D handle_command_send_ussd(stk->pending_cmd,
+							&rsp, stk);
+		break;
 	default:
 		rsp.result.type =3D STK_RESULT_TYPE_COMMAND_NOT_UNDERSTOOD;
 		break;
-- =

1.7.0.4


--===============4469913600383312486==--

