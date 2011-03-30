Content-Type: multipart/mixed; boundary="===============8662629282152996751=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/4] stk: Handle user termination for Send DTMF
Date: Wed, 30 Mar 2011 12:27:42 +0200
Message-ID: <1301480864-8116-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8662629282152996751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 94ad396..780e0c2 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -473,6 +473,16 @@ static void emit_menu_changed(struct ofono_stk *stk)
 	g_dbus_send_message(conn, signal);
 }
 =

+static void user_termination_cb(enum stk_agent_result result, void *user_d=
ata)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE) {
+		stk->respond_on_exit =3D FALSE;
+		send_simple_response(stk, STK_RESULT_TYPE_USER_TERMINATED);
+	}
+}
+
 static void stk_alpha_id_set(struct ofono_stk *stk,
 		const char *text, const struct stk_text_attribute *attr,
 		const struct stk_icon_id *icon)
@@ -484,7 +494,13 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 	 * and no alpha identifier cases equally. This may be changed once
 	 * better idea is found out.
 	 */
-	if (alpha !=3D NULL)
+	if (alpha =3D=3D NULL)
+		return;
+
+	if (stk->respond_on_exit)
+		stk_agent_display_action(stk->current_agent, alpha, icon,
+						user_termination_cb, stk, NULL);
+	else
 		stk_agent_display_action_info(stk->current_agent, alpha, icon);
 =

 	g_free(alpha);
@@ -2329,10 +2345,6 @@ static gboolean handle_command_send_dtmf(const struc=
t stk_command *cmd,
 		return TRUE;
 	}
 =

-	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
-				&cmd->send_dtmf.text_attr,
-				&cmd->send_dtmf.icon_id);
-
 	/*
 	 * Note that we don't strictly require an agent to be connected,
 	 * but to comply with 6.4.24 we need to send a End Session when
@@ -2342,6 +2354,10 @@ static gboolean handle_command_send_dtmf(const struc=
t stk_command *cmd,
 	stk->cancel_cmd =3D send_dtmf_cancel;
 	stk->dtmf_id =3D err;
 =

+	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id,
+				&cmd->send_dtmf.text_attr,
+				&cmd->send_dtmf.icon_id);
+
 	return FALSE;
 }
 =

-- =

1.7.1


--===============8662629282152996751==--

