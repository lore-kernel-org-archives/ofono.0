Content-Type: multipart/mixed; boundary="===============0467492761661080792=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH v4 2/2] stk: Handle set up call in handled_notify
Date: Mon, 25 Jul 2011 11:15:27 -0700
Message-ID: <1311617727-10294-3-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1311617727-10294-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0467492761661080792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++------=
----
 1 files changed, 140 insertions(+), 26 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index e8ffb42..e85e595 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1790,6 +1790,45 @@ static void confirm_call_cb(enum stk_agent_result re=
sult, gboolean confirm,
 		stk_command_cb(&error, stk);
 }
 =

+static void confirm_handled_call_cb(enum stk_agent_result result,
+					gboolean confirm, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	const struct stk_command_setup_call *sc =3D
+					&stk->pending_cmd->setup_call;
+	struct ofono_voicecall *vc =3D NULL;
+	struct ofono_atom *vc_atom;
+
+	if (stk->driver->user_confirmation =3D=3D NULL)
+		goto out;
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		stk->driver->user_confirmation(stk, FALSE);
+		goto out;
+	}
+
+	stk->driver->user_confirmation(stk, confirm);
+
+	vc_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_VOICECALL);
+	if (vc_atom)
+		vc =3D __ofono_atom_get_data(vc_atom);
+
+	if (vc =3D=3D NULL)
+		goto out;
+
+	__ofono_voicecall_set_alpha_and_icon_id(vc, sc->addr.number,
+						sc->addr.ton_npi,
+						sc->alpha_id_call_setup,
+						sc->icon_id_call_setup.id);
+
+	return;
+
+out:
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+}
+
 static gboolean handle_command_set_up_call(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -2606,6 +2645,77 @@ static gboolean handle_command_launch_browser(const =
struct stk_command *cmd,
 	return FALSE;
 }
 =

+static void proactive_command_handled_end(struct ofono_stk *stk)
+{
+	if (stk->pending_cmd =3D=3D NULL)
+		return;
+
+	switch(stk->pending_cmd->type) {
+	case STK_COMMAND_TYPE_SETUP_CALL:
+	{
+		struct ofono_voicecall *vc =3D NULL;
+		struct ofono_atom *vc_atom;
+
+		vc_atom =3D __ofono_modem_find_atom(
+					__ofono_atom_get_modem(stk->atom),
+					OFONO_ATOM_TYPE_VOICECALL);
+		if (vc_atom)
+			vc =3D __ofono_atom_get_data(vc_atom);
+
+		if (vc !=3D NULL)
+			__ofono_voicecall_clear_alpha_and_icon_id(vc);
+
+		break;
+	}
+	case STK_COMMAND_TYPE_SEND_SMS:
+	case STK_COMMAND_TYPE_SEND_USSD:
+	case STK_COMMAND_TYPE_SEND_SS:
+	case STK_COMMAND_TYPE_SEND_DTMF:
+		stk_alpha_id_unset(stk);
+		break;
+
+	default:
+		break;
+	}
+
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+	stk->cancel_cmd =3D NULL;
+}
+
+static gboolean handle_setup_call_confirmation_req(struct stk_command *cmd,
+						struct ofono_stk *stk)
+{
+	const struct stk_command_setup_call *sc =3D &cmd->setup_call;
+	int err;
+	char *alpha_id =3D dbus_apply_text_attributes(
+					sc->alpha_id_usr_cfm ?
+					sc->alpha_id_usr_cfm : "",
+					&sc->text_attr_usr_cfm);
+	if (alpha_id =3D=3D NULL)
+		goto out;
+
+	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
+					&sc->icon_id_usr_cfm,
+					confirm_handled_call_cb,
+					stk, NULL,
+					stk->timeout * 1000);
+	g_free(alpha_id);
+
+	if (err < 0)
+		goto out;
+
+	stk->cancel_cmd =3D proactive_command_handled_end;
+
+	return TRUE;
+
+out:
+	if (stk->driver->user_confirmation)
+		stk->driver->user_confirmation(stk, FALSE);
+
+	return FALSE;
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2816,8 +2926,8 @@ void ofono_stk_proactive_command_handled_notify(struc=
t ofono_stk *stk,
 						int length,
 						const unsigned char *pdu)
 {
-	struct stk_command *cmd;
 	struct stk_response dummyrsp;
+	gboolean ok =3D TRUE;
 =

 	/*
 	 * Modems send us the proactive command details and terminal responses
@@ -2826,69 +2936,73 @@ void ofono_stk_proactive_command_handled_notify(str=
uct ofono_stk *stk,
 	 * responses here
 	 */
 	if (length > 0 && pdu[0] =3D=3D 0x81) {
-		stk_alpha_id_unset(stk);
+		proactive_command_handled_end(stk);
 		return;
 	}
 =

 	stk_proactive_command_cancel(stk);
 =

-	cmd =3D stk_command_new_from_pdu(pdu, length);
+	stk->pending_cmd =3D stk_command_new_from_pdu(pdu, length);
 =

-	if (cmd =3D=3D NULL || cmd->status !=3D STK_PARSE_RESULT_OK) {
+	if (stk->pending_cmd =3D=3D NULL ||
+			stk->pending_cmd->status !=3D STK_PARSE_RESULT_OK) {
 		ofono_error("Can't parse proactive command");
 =

-		if (cmd)
-			stk_command_free(cmd);
-		return;
+		ok =3D FALSE;
+		goto out;
 	}
 =

-	DBG("type: %d", cmd->type);
+	DBG("type: %d", stk->pending_cmd->type);
 =

-	switch (cmd->type) {
+	switch (stk->pending_cmd->type) {
 	case STK_COMMAND_TYPE_MORE_TIME:
 		break;
 =

 	case STK_COMMAND_TYPE_SEND_SMS:
-		stk_alpha_id_set(stk, cmd->send_sms.alpha_id,
-				&cmd->send_sms.text_attr,
-				&cmd->send_sms.icon_id);
+		stk_alpha_id_set(stk, stk->pending_cmd->send_sms.alpha_id,
+				&stk->pending_cmd->send_sms.text_attr,
+				&stk->pending_cmd->send_sms.icon_id);
 		break;
 =

 	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
-		handle_command_set_idle_text(cmd, &dummyrsp, stk);
+		handle_command_set_idle_text(stk->pending_cmd, &dummyrsp, stk);
 		break;
 =

 	case STK_COMMAND_TYPE_SETUP_MENU:
-		handle_command_set_up_menu(cmd, &dummyrsp, stk);
+		handle_command_set_up_menu(stk->pending_cmd, &dummyrsp, stk);
 		break;
 =

 	case STK_COMMAND_TYPE_SETUP_CALL:
-		/* TODO */
+		ok =3D handle_setup_call_confirmation_req(stk->pending_cmd, stk);
 		break;
 =

 	case STK_COMMAND_TYPE_SEND_USSD:
-		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,
-				&cmd->send_ussd.text_attr,
-				&cmd->send_ussd.icon_id);
+		stk_alpha_id_set(stk, stk->pending_cmd->send_ussd.alpha_id,
+				&stk->pending_cmd->send_ussd.text_attr,
+				&stk->pending_cmd->send_ussd.icon_id);
 		break;
 =

 	case STK_COMMAND_TYPE_SEND_SS:
-		stk_alpha_id_set(stk, cmd->send_ss.alpha_id,
-				&cmd->send_ss.text_attr,
-				&cmd->send_ss.icon_id);
+		stk_alpha_id_set(stk, stk->pending_cmd->send_ss.alpha_id,
+				&stk->pending_cmd->send_ss.text_attr,
+				&stk->pending_cmd->send_ss.icon_id);
 =

 	case STK_COMMAND_TYPE_SEND_DTMF:
-		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
-				&cmd->send_dtmf.text_attr,
-				&cmd->send_dtmf.icon_id);
+		stk_alpha_id_set(stk, stk->pending_cmd->send_dtmf.alpha_id,
+				&stk->pending_cmd->send_dtmf.text_attr,
+				&stk->pending_cmd->send_dtmf.icon_id);
 		break;
 =

 	case STK_COMMAND_TYPE_REFRESH:
-		handle_command_refresh(cmd, NULL, stk);
+		handle_command_refresh(stk->pending_cmd, NULL, stk);
 		break;
 	}
 =

-	stk_command_free(cmd);
+out:
+	if (ok =3D=3D FALSE) {
+		stk_command_free(stk->pending_cmd);
+		stk->pending_cmd =3D NULL;
+	}
 }
 =

 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
-- =

1.7.4.1


--===============0467492761661080792==--

