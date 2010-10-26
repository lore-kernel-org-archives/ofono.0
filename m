Content-Type: multipart/mixed; boundary="===============2638002693552359743=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Handle more commands in proactive_command_handled_notify.
Date: Tue, 26 Oct 2010 10:52:05 +0200
Message-ID: <1288083128-24058-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2638002693552359743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 54994df..359f8e4 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -822,6 +822,7 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 	return FALSE;
 }
 =

+/* Note: may be called from ofono_stk_proactive_command_handled_notify */
 static gboolean handle_command_set_idle_text(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -1041,6 +1042,7 @@ static gboolean handle_command_poll_interval(const st=
ruct stk_command *cmd,
 	return TRUE;
 }
 =

+/* Note: may be called from ofono_stk_proactive_command_handled_notify */
 static gboolean handle_command_set_up_menu(const struct stk_command *cmd,
 						struct stk_response *rsp,
 						struct ofono_stk *stk)
@@ -2407,6 +2409,7 @@ void ofono_stk_proactive_command_handled_notify(struc=
t ofono_stk *stk,
 						const unsigned char *pdu)
 {
 	struct stk_command *cmd;
+	struct stk_response dummyrsp;
 =

 	stk_proactive_command_cancel(stk);
 =

@@ -2431,6 +2434,30 @@ void ofono_stk_proactive_command_handled_notify(stru=
ct ofono_stk *stk,
 				&cmd->send_sms.text_attr,
 				&cmd->send_sms.icon_id);
 		break;
+
+	case STK_COMMAND_TYPE_SETUP_IDLE_MODE_TEXT:
+		handle_command_set_idle_text(cmd, &dummyrsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_SETUP_MENU:
+		handle_command_set_up_menu(cmd, &dummyrsp, stk);
+		break;
+
+	case STK_COMMAND_TYPE_SETUP_CALL:
+		/* TODO */
+		break;
+
+	case STK_COMMAND_TYPE_SEND_USSD:
+		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id,
+				&cmd->send_ussd.text_attr,
+				&cmd->send_ussd.icon_id);
+		break;
+
+	case STK_COMMAND_TYPE_SEND_DTMF:
+		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
+				&cmd->send_dtmf.text_attr,
+				&cmd->send_dtmf.icon_id);
+		break;
 	}
 =

 	stk_command_free(cmd);
-- =

1.7.1.86.g0e460.dirty


--===============2638002693552359743==--

