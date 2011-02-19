Content-Type: multipart/mixed; boundary="===============8205026888783296634=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Handle Refresh if also performed by modem.
Date: Sat, 19 Feb 2011 11:00:37 +0100
Message-ID: <1298109638-13556-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8205026888783296634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bc46b2f..c35f457 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1981,6 +1981,7 @@ static void free_idle_mode_text(struct ofono_stk *stk)
 	memset(&stk->idle_mode_icon, 0, sizeof(stk->idle_mode_icon));
 }
 =

+/* Note: may be called from ofono_stk_proactive_command_handled_notify */
 static gboolean handle_command_refresh(const struct stk_command *cmd,
 					struct stk_response *rsp,
 					struct ofono_stk *stk)
@@ -2025,7 +2026,8 @@ static gboolean handle_command_refresh(const struct s=
tk_command *cmd,
 =

 	default:
 		ofono_info("Undefined Refresh qualifier: %d", cmd->qualifier);
-		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		if (rsp !=3D NULL)
+			rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 		return TRUE;
 	}
 =

@@ -2048,11 +2050,18 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 		sim =3D __ofono_atom_get_data(sim_atom);
 =

 	if (sim =3D=3D NULL) {
-		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		if (rsp !=3D NULL)
+			rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 		return TRUE;
 	}
 =

-	if (cmd->qualifier < 4) {
+	/*
+	 * For now we can handle the Refresh types that don't require
+	 * a SIM reset except if that part of the task has been already
+	 * handled by modem firmware (indicated by rsp =3D=3D NULL) in which
+	 * case we just restart our SIM initialisation.
+	 */
+	if (cmd->qualifier < 4 || rsp =3D=3D NULL) {
 		int qualifier =3D stk->pending_cmd->qualifier;
 		GSList *file_list =3D stk->pending_cmd->refresh.file_list;
 =

@@ -2062,10 +2071,15 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 		/*
 		 * Queue the TERMINAL RESPONSE before triggering potential
 		 * file accesses.
+		 *
+		 * TODO: Find out if we need to send the "Refresh performed
+		 * with additional EFs read" response.
 		 */
-		err =3D stk_respond(stk, rsp, stk_command_cb);
-		if (err)
-			stk_command_cb(&failure, stk);
+		if (rsp !=3D NULL) {
+			err =3D stk_respond(stk, rsp, stk_command_cb);
+			if (err)
+				stk_command_cb(&failure, stk);
+		}
 =

 		/* TODO: use the alphaId / icon */
 		/* TODO: if AID is supplied, check its value */
@@ -2084,6 +2098,9 @@ static gboolean handle_command_refresh(const struct s=
tk_command *cmd,
 			break;
 		case 2:
 		case 3:
+		case 4:
+		case 5:
+		case 6:
 			free_idle_mode_text(stk);
 			__ofono_sim_refresh(sim, file_list, FALSE, TRUE);
 			break;
@@ -2779,6 +2796,10 @@ void ofono_stk_proactive_command_handled_notify(stru=
ct ofono_stk *stk,
 				&cmd->send_dtmf.text_attr,
 				&cmd->send_dtmf.icon_id);
 		break;
+
+	case STK_COMMAND_TYPE_REFRESH:
+		handle_command_refresh(stk->pending_cmd, NULL, stk);
+		break;
 	}
 =

 	stk_command_free(cmd);
-- =

1.7.1.86.g0e460.dirty


--===============8205026888783296634==--

