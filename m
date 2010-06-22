Content-Type: multipart/mixed; boundary="===============2194650337679437828=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/8] stk: Forget previous command if a new one comes.
Date: Tue, 22 Jun 2010 13:20:48 +0200
Message-ID: <1277205651-29369-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2194650337679437828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3959dc7..b43f090 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -51,6 +51,8 @@ typedef gboolean (*command_handler_t)(const struct stk_co=
mmand *cmd,
 					struct stk_response *rsp,
 					struct ofono_stk *stk);
 =

+typedef void (*command_cancel_t)(struct ofono_stk *stk);
+
 struct stk_menu {
 	char *title;
 	GSList *items;
@@ -70,6 +72,8 @@ struct ofono_stk {
 	struct stk_command *pending_cmd;
 	DBusMessage *pending;
 	gint cmd_timeout;
+	command_cancel_t cancel_cmd;
+	gboolean cancelled; /* Only valid when .pending set */
 =

 	struct stk_menu *default_menu;
 	struct stk_menu *current_menu; /* For Select Item menus */
@@ -183,6 +187,19 @@ void ofono_stk_proactive_command_notify(struct ofono_s=
tk *stk,
 	char *buf;
 	int i;
 =

+	if (stk->pending_cmd) {
+		/*
+		 * In theory this shouldn't happen, but it depends on
+		 * hardware.  We received a new command before we managed
+		 * to send a TERMINAL RESPONSE to the previous one.  3GPP
+		 * says in the current revision only one command can be
+		 * executing at any time, so assume that the previous one
+		 * is cancelled and the card just expects a response to
+		 * the new one.
+		 */
+		stk->cancel_cmd(stk);
+	}
+
 	buf =3D g_try_malloc(length * 2 + 1);
 	if (!buf)
 		return;
@@ -513,11 +530,39 @@ static DBusMessage *stk_set_property(DBusConnection *=
conn,
 	return __ofono_error_invalid_args(msg);
 }
 =

+static void select_item_cancel(struct ofono_stk *stk)
+{
+	if (stk->pending)
+		/*
+		 * TODO: D-bus command is just executing.  Should we go
+		 * ahead and respond to it with failure, or wait for the
+		 * result from driver?
+		 */
+		stk->cancelled =3D TRUE;
+
+	if (stk->cmd_timeout) {
+		g_source_remove(stk->cmd_timeout);
+		stk->cmd_timeout =3D 0;
+	}
+
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+
+	stk_menu_free(stk->current_menu);
+	stk->current_menu =3D NULL;
+
+	emit_menu_changed(stk);
+}
+
 static void select_item_cb(const struct ofono_error *error,
 				struct ofono_stk *stk)
 {
 	DBusMessage *reply;
 =

+	if (stk->cancelled =3D=3D TRUE)
+		/* Command cancelled */
+		goto out;
+
 	if (stk->cmd_timeout) {
 		/*
 		 * If the command has not timed out yet, return error and
@@ -629,6 +674,7 @@ static DBusMessage *stk_menu_select(DBusConnection *con=
n, DBusMessage *msg,
 	if (!item)
 		return __ofono_error_invalid_args(msg);
 =

+	stk->cancelled =3D FALSE;
 	stk->pending =3D dbus_message_ref(msg);
 =

 	if (stk->current_menu)
@@ -668,6 +714,7 @@ static DBusMessage *stk_back_or_terminate(DBusConnectio=
n *conn,
 	if (dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
 =

+	stk->cancelled =3D FALSE;
 	stk->pending =3D dbus_message_ref(msg);
 =

 	memset(&rsp, 0, sizeof(rsp));
@@ -740,6 +787,7 @@ static gboolean handle_command_select_item(const struct=
 stk_command *cmd,
 	stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
 							select_item_timeout,
 							stk);
+	stk->cancel_cmd =3D select_item_cancel;
 =

 	return FALSE;
 }
-- =

1.7.1.86.g0e460.dirty


--===============2194650337679437828==--

