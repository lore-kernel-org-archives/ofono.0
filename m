Content-Type: multipart/mixed; boundary="===============6954583267241870641=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] stk: Check if an agent is registered when UI is required
Date: Thu, 30 Aug 2012 18:20:41 +0200
Message-ID: <1346343641-27051-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6954583267241870641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of unsolicited proactive command, we could have a crash
when no agent was registered.
---
 src/stk.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/stk.c b/src/stk.c
index 18a8eaf..4c24abb 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -515,6 +515,9 @@ static gboolean stk_alpha_id_set(struct ofono_stk *stk,
 	if (alpha =3D=3D NULL)
 		return FALSE;
 =

+	if (stk->current_agent =3D=3D NULL)
+		return FALSE;
+
 	if (stk->respond_on_exit)
 		stk_agent_display_action(stk->current_agent, alpha, icon,
 						user_termination_cb, stk, NULL);
@@ -2645,6 +2648,9 @@ static gboolean handle_setup_call_confirmation_req(st=
ruct stk_command *cmd,
 	if (alpha_id =3D=3D NULL)
 		goto out;
 =

+	if (stk->current_agent =3D=3D FALSE)
+		goto out;
+
 	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
 					&sc->icon_id_usr_cfm,
 					confirm_handled_call_cb,
@@ -2752,6 +2758,9 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 		case STK_COMMAND_TYPE_GET_INPUT:
 		case STK_COMMAND_TYPE_PLAY_TONE:
 		case STK_COMMAND_TYPE_SETUP_CALL:
+		case STK_COMMAND_TYPE_SEND_SMS:
+		case STK_COMMAND_TYPE_SEND_USSD:
+		case STK_COMMAND_TYPE_SEND_DTMF:
 			send_simple_response(stk, STK_RESULT_TYPE_NOT_CAPABLE);
 			return;
 =

-- =

1.7.9.5


--===============6954583267241870641==--

