Content-Type: multipart/mixed; boundary="===============7814733651239695154=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] stk: Separate Dbus request cancelling from command
 cancelling.
Date: Wed, 30 Jun 2010 17:24:17 +0200
Message-ID: <1277911458-4984-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277911458-4984-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7814733651239695154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   38 ++++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 0ae74e6..5ce0d2a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -74,6 +74,8 @@ struct ofono_stk {
 	void *driver_data;
 	struct ofono_atom *atom;
 	struct stk_command *pending_cmd;
+	void (*cancel_cmd)(struct ofono_stk *stk);
+	gboolean cancelled;
 	struct stk_app_agent *app_agent;
 	enum stk_agent_state app_agent_state;
 	int timeout; /* Manufacturer defined timeout */
@@ -792,9 +794,7 @@ static void request_menu_cb(struct ofono_stk *stk, DBus=
Message *reply)
 			goto out;
 		}
 =

-		if (stk->cmd_timeout) {
-			app_agent_request_cancel(stk);
-
+		if (stk->cancelled) {
 			display_idle(stk);
 			goto out;
 		}
@@ -935,6 +935,8 @@ static gboolean handle_command_select_item(const struct=
 stk_command *cmd,
 	app_agent_request_start(stk, request_menu_send, request_menu_cb,
 				STK_AGENT_SELECT_ITEM);
 =

+	stk->cancel_cmd =3D app_agent_request_cancel;
+
 	return FALSE;
 }
 =

@@ -997,11 +999,8 @@ static void request_text_cb(struct ofono_stk *stk, DBu=
sMessage *reply)
 	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
 =

 	if (!reply) {
-		if (stk->cmd_timeout) {
-			app_agent_request_cancel(stk);
-
+		if (stk->cancelled)
 			goto out;
-		}
 =

 		if (confirm)
 			type =3D STK_RESULT_TYPE_NO_RESPONSE;
@@ -1068,6 +1067,8 @@ static gboolean handle_command_display_text(const str=
uct stk_command *cmd,
 	app_agent_request_start(stk, request_text_send, request_text_cb,
 				STK_AGENT_DISPLAY_TEXT);
 =

+	stk->cancel_cmd =3D app_agent_request_cancel;
+
 	return cmd->display_text.immediate_response;
 }
 =

@@ -1108,9 +1109,7 @@ static void request_get_key_cb(struct ofono_stk *stk,=
 DBusMessage *reply)
 	char *key;
 =

 	if (!reply) {
-		if (stk->cmd_timeout) {
-			app_agent_request_cancel(stk);
-
+		if (stk->cancelled) {
 			display_idle(stk);
 			return;
 		}
@@ -1219,6 +1218,8 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	app_agent_request_start(stk, request_get_key_send, request_get_key_cb,
 				STK_AGENT_GET_KEY);
 =

+	stk->cancel_cmd =3D app_agent_request_cancel;
+
 	return FALSE;
 }
 =

@@ -1260,9 +1261,7 @@ static void request_get_text_cb(struct ofono_stk *stk=
, DBusMessage *reply)
 	char *text;
 =

 	if (!reply) {
-		if (stk->cmd_timeout) {
-			app_agent_request_cancel(stk);
-
+		if (stk->cancelled) {
 			display_idle(stk);
 			return;
 		}
@@ -1321,6 +1320,8 @@ static gboolean handle_command_get_input(const struct=
 stk_command *cmd,
 	app_agent_request_start(stk, request_get_text_send, request_get_text_cb,
 				STK_AGENT_GET_TEXT);
 =

+	stk->cancel_cmd =3D app_agent_request_cancel;
+
 	return FALSE;
 }
 =

@@ -1329,7 +1330,14 @@ void ofono_stk_proactive_command_cancel(struct ofono=
_stk *stk)
 	if (!stk->pending_cmd)
 		return;
 =

-	stk->cmd_cb(stk, NULL);
+	stk->cancelled =3D TRUE;
+
+	stk->cancel_cmd(stk);
+
+	if (stk->pending_cmd) {
+		stk_command_free(stk->pending_cmd);
+		stk->pending_cmd =3D NULL;
+	}
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -1358,6 +1366,8 @@ void ofono_stk_proactive_command_notify(struct ofono_=
stk *stk,
 	for (i =3D 0; i < length; i ++)
 		sprintf(buf + i * 2, "%02hhx", pdu[i]);
 =

+	stk->cancelled =3D FALSE;
+
 	stk->pending_cmd =3D stk_command_new_from_pdu(pdu, length);
 	if (!stk->pending_cmd) {
 		ofono_error("Can't parse proactive command: %s", buf);
-- =

1.7.1.86.g0e460.dirty


--===============7814733651239695154==--

