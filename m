Content-Type: multipart/mixed; boundary="===============8500681672710698512=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@linux.intel.com>
Subject: [PATCH 3/4] stk: Handle set up call in handled_notify
Date: Wed, 06 Jul 2011 03:06:12 -0700
Message-ID: <1309946773-7747-4-git-send-email-jeevaka.badrappan@linux.intel.com>
In-Reply-To: <1309946773-7747-1-git-send-email-jeevaka.badrappan@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8500681672710698512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 9575f0e..26faa11 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -77,6 +77,8 @@ struct ofono_stk {
 	struct timeval get_inkey_start_ts;
 	int dtmf_id;
 =

+	gboolean modem_handled_cmd;
+
 	__ofono_sms_sim_download_cb_t sms_pp_cb;
 	void *sms_pp_userdata;
 };
@@ -1785,6 +1787,44 @@ static void confirm_call_cb(enum stk_agent_result re=
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
+	__ofono_voicecall_set_alpha_and_icon_id(vc, sc->alpha_id_call_setup,
+						sc->icon_id_call_setup.id);
+
+	stk->modem_handled_cmd =3D TRUE;
+
+	return;
+out:
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+}
+
 static gboolean handle_command_set_up_call(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -2601,6 +2641,40 @@ static gboolean handle_command_launch_browser(const =
struct stk_command *cmd,
 	return FALSE;
 }
 =

+static void handle_setup_call_confirmation_req(struct stk_command *cmd,
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
+	stk->pending_cmd =3D cmd;
+	stk->cancel_cmd =3D stk_request_cancel;
+
+	return;
+
+out:
+	if (stk->driver->user_confirmation)
+		stk->driver->user_confirmation(stk, FALSE);
+
+	stk_command_free(cmd);
+}
+
 static void stk_proactive_command_cancel(struct ofono_stk *stk)
 {
 	if (stk->immediate_response)
@@ -2615,8 +2689,38 @@ static void stk_proactive_command_cancel(struct ofon=
o_stk *stk)
 	}
 }
 =

+static void proactive_session_end_handled_cmd(struct ofono_stk *stk)
+{
+	stk->modem_handled_cmd =3D FALSE;
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
+
+	default:
+		break;
+	}
+}
+
 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk)
 {
+	if (stk->modem_handled_cmd =3D=3D TRUE)
+		proactive_session_end_handled_cmd(stk);
+
 	/* Wait until we receive the next command */
 	if (stk->immediate_response)
 		return;
@@ -2858,8 +2962,8 @@ void ofono_stk_proactive_command_handled_notify(struc=
t ofono_stk *stk,
 		break;
 =

 	case STK_COMMAND_TYPE_SETUP_CALL:
-		/* TODO */
-		break;
+		handle_setup_call_confirmation_req(cmd, stk);
+		return;
 =

 	case STK_COMMAND_TYPE_SEND_USSD:
 		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,
-- =

1.7.4.1


--===============8500681672710698512==--

