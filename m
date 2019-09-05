Content-Type: multipart/mixed; boundary="===============1078192348563828344=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2] gatchat: implement timeout setting for commands
Date: Thu, 05 Sep 2019 13:07:30 +0200
Message-ID: <20190905110730.117268-1-martin@geanix.com>
In-Reply-To: <20190902211011.61386-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1078192348563828344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The adds a function to the set a chat-wide timeout for at commands. It
allows plugins to handle cases where the modem fails to respond with
either an OK or an error.

Without these timeouts, the plugin is never notified about a hanging
command, and it has no way to detect it; effectively leaving the device
in a broken state, where only a full restart of the ofono service
unbreaks it.

If a timeout occurs, the passed callback so the plugin can reset the
modem to a known state.
---
 gatchat/gatchat.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatchat.h | 10 +++++++
 2 files changed, 76 insertions(+)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..8e36ca1a 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -97,6 +97,10 @@ struct at_chat {
 	gdouble inactivity_time;		/* Period of inactivity */
 	guint wakeup_timeout;			/* How long to wait for resp */
 	GTimer *wakeup_timer;			/* Keep track of elapsed time */
+	guint cmd_timeout_ms;			/* How long to wait for command resp */
+	gint cmd_timeout_source;		/* Handle commands with no response */
+	GAtTimeoutFunc cmd_timeout_func;	/* Function to call in case of timeout */
+	gpointer cmd_timeout_data;		/* Data to pass to cmd_timeout_func */
 	GAtSyntax *syntax;
 	gboolean destroyed;			/* Re-entrancy guard */
 	gboolean in_read_handler;		/* Re-entrancy guard */
@@ -353,6 +357,11 @@ static void chat_cleanup(struct at_chat *chat)
 		chat->timeout_source =3D 0;
 	}
 =

+	if (chat->cmd_timeout_source) {
+		g_source_remove(chat->cmd_timeout_source);
+		chat->cmd_timeout_source =3D 0;
+	}
+
 	g_at_syntax_unref(chat->syntax);
 	chat->syntax =3D NULL;
 =

@@ -436,6 +445,11 @@ static void at_chat_finish_command(struct at_chat *p, =
gboolean ok, char *final)
 	struct at_command *cmd =3D g_queue_pop_head(p->command_queue);
 	GSList *response_lines;
 =

+	if (p->cmd_timeout_source) {
+		g_source_remove(p->cmd_timeout_source);
+		p->cmd_timeout_source =3D 0;
+	}
+
 	/* Cannot happen, but lets be paranoid */
 	if (cmd =3D=3D NULL)
 		return;
@@ -823,6 +837,19 @@ static gboolean wakeup_no_response(gpointer user_data)
 	return TRUE;
 }
 =

+static gboolean command_no_response(gpointer user_data)
+{
+	struct at_chat *chat =3D user_data;
+
+	if (chat->debugf)
+		chat->debugf("command got no response\n", chat->debug_data);
+
+	if (chat->cmd_timeout_func)
+		chat->cmd_timeout_func(chat->cmd_timeout_data);
+
+	return TRUE;
+}
+
 static gboolean can_write_data(gpointer data)
 {
 	struct at_chat *chat =3D data;
@@ -923,6 +950,12 @@ static gboolean can_write_data(gpointer data)
 	if (chat->wakeup_timer)
 		g_timer_start(chat->wakeup_timer);
 =

+	/* Handle no response */
+	if (chat->cmd_timeout_ms)
+		chat->cmd_timeout_source =3D g_timeout_add(chat->cmd_timeout_ms,
+							command_no_response,
+							chat);
+
 	return FALSE;
 }
 =

@@ -1065,11 +1098,34 @@ static gboolean at_chat_retry(struct at_chat *chat,=
 guint id)
 	/* reset number of written bytes to re-write command */
 	chat->cmd_bytes_written =3D 0;
 =

+	/* cancel potential timeout */
+	if (chat->cmd_timeout_source) {
+		g_source_remove(chat->cmd_timeout_source);
+		chat->cmd_timeout_source =3D 0;
+	}
+
 	chat_wakeup_writer(chat);
 =

 	return TRUE;
 }
 =

+static gboolean at_chat_set_command_timeout(struct at_chat *chat,
+						size_t seconds,
+						GAtTimeoutFunc func,
+						gpointer user_data)
+{
+	if (chat->cmd_timeout_source) {
+		g_source_remove(chat->cmd_timeout_source);
+		chat->cmd_timeout_source =3D 0;
+	}
+
+	chat->cmd_timeout_ms =3D seconds * 1000;
+	chat->cmd_timeout_func =3D func;
+	chat->cmd_timeout_data =3D user_data;
+
+	return TRUE;
+}
+
 static struct at_notify *at_notify_create(struct at_chat *chat,
 						const char *prefix,
 						gboolean pdu)
@@ -1574,6 +1630,16 @@ gboolean g_at_chat_retry(GAtChat *chat, guint id)
 	return at_chat_retry(chat->parent, id);
 }
 =

+gboolean g_at_chat_set_command_timeout(GAtChat *chat, size_t seconds,
+					GAtTimeoutFunc func, gpointer user_data)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	return at_chat_set_command_timeout(chat->parent, seconds, func,
+						user_data);
+}
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	/* We use id 0 for wakeup commands */
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 32870318..eb42aac5 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -38,6 +38,7 @@ typedef struct _GAtChat GAtChat;
 typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
 				gpointer user_data);
 typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
+typedef void (*GAtTimeoutFunc)(gpointer user_data);
 =

 enum _GAtChatTerminator {
 	G_AT_CHAT_TERMINATOR_OK,
@@ -154,6 +155,15 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat *=
chat, const char *cmd,
  */
 gboolean g_at_chat_retry(GAtChat *chat, guint id);
 =

+/*!
+ * Set the timeout for commands. If the timeout is configured and no respo=
nse
+ * is received from a written command within the timeout, the callback is
+ * called to the plugin handle it.
+ */
+gboolean g_at_chat_set_command_timeout(GAtChat *chat, size_t seconds,
+					GAtTimeoutFunc func,
+					gpointer user_data);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

-- =

2.23.0


--===============1078192348563828344==--

