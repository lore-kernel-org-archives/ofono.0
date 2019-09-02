Content-Type: multipart/mixed; boundary="===============5531661776704154708=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [RFC] gatchat: implement timeout setting for commands
Date: Mon, 02 Sep 2019 23:10:11 +0200
Message-ID: <20190902211011.61386-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5531661776704154708==
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

If a timeout occurs, the passed callback is invoked with 'ok' set to
false, and no final response in the result. This allows callbacks to
identify the timeout with this snippet:

  if (!ok) {
    decode_at_error(&error, g_at_result_final_response(result));
    if (error.type =3D=3D OFONO_ERROR_TYPE_FAILURE) {
      /* handle timeout */
    }
  }
---
 gatchat/gatchat.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatchat.h |  9 +++++++
 plugins/quectel.c |  3 ---
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 9e777107..ba4d2346 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -97,6 +97,8 @@ struct at_chat {
 	gdouble inactivity_time;		/* Period of inactivity */
 	guint wakeup_timeout;			/* How long to wait for resp */
 	GTimer *wakeup_timer;			/* Keep track of elapsed time */
+	guint command_timeout;			/* How long to wait for command resp */
+	gint command_source;			/* Handle commands with no response */
 	GAtSyntax *syntax;
 	gboolean destroyed;			/* Re-entrancy guard */
 	gboolean in_read_handler;		/* Re-entrancy guard */
@@ -353,6 +355,11 @@ static void chat_cleanup(struct at_chat *chat)
 		chat->timeout_source =3D 0;
 	}
 =

+	if (chat->command_source) {
+		g_source_remove(chat->command_source);
+		chat->command_source =3D 0;
+	}
+
 	g_at_syntax_unref(chat->syntax);
 	chat->syntax =3D NULL;
 =

@@ -436,6 +443,11 @@ static void at_chat_finish_command(struct at_chat *p, =
gboolean ok, char *final)
 	struct at_command *cmd =3D g_queue_pop_head(p->command_queue);
 	GSList *response_lines;
 =

+	if (p->command_source) {
+		g_source_remove(p->command_source);
+		p->command_source =3D 0;
+	}
+
 	/* Cannot happen, but lets be paranoid */
 	if (cmd =3D=3D NULL)
 		return;
@@ -823,6 +835,22 @@ static gboolean wakeup_no_response(gpointer user_data)
 	return TRUE;
 }
 =

+static gboolean command_no_response(gpointer user_data)
+{
+	struct at_chat *chat =3D user_data;
+	struct at_command *cmd =3D g_queue_peek_head(chat->command_queue);
+
+	if (chat->debugf)
+		chat->debugf("command got no response\n", chat->debug_data);
+
+	if (cmd =3D=3D NULL)
+		return FALSE;
+
+	at_chat_finish_command(chat, FALSE, NULL);
+
+	return TRUE;
+}
+
 static gboolean can_write_data(gpointer data)
 {
 	struct at_chat *chat =3D data;
@@ -923,6 +951,12 @@ static gboolean can_write_data(gpointer data)
 	if (chat->wakeup_timer)
 		g_timer_start(chat->wakeup_timer);
 =

+	/* Handle no response */
+	if (chat->command_timeout)
+		chat->command_source =3D g_timeout_add(chat->command_timeout,
+							command_no_response,
+							chat);
+
 	return FALSE;
 }
 =

@@ -1065,11 +1099,29 @@ static gboolean at_chat_retry(struct at_chat *chat,=
 guint id)
 	/* reset number of written bytes to re-write command */
 	chat->cmd_bytes_written =3D 0;
 =

+	/* cancel potential timeout */
+	if (chat->command_source) {
+		g_source_remove(chat->command_source);
+		chat->command_source =3D 0;
+	}
+
 	chat_wakeup_writer(chat);
 =

 	return TRUE;
 }
 =

+static gboolean at_chat_set_timeout(struct at_chat *chat, size_t seconds)
+{
+	if (chat->command_source) {
+		g_source_remove(chat->command_source);
+		chat->command_source =3D 0;
+	}
+
+	chat->command_timeout =3D seconds * 1000;
+
+	return TRUE;
+}
+
 static struct at_notify *at_notify_create(struct at_chat *chat,
 						const char *prefix,
 						gboolean pdu)
@@ -1574,6 +1626,14 @@ gboolean g_at_chat_retry(GAtChat *chat, guint id)
 	return at_chat_retry(chat->parent, id);
 }
 =

+gboolean g_at_chat_set_timeout(GAtChat *chat, size_t seconds)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	return at_chat_set_timeout(chat->parent, seconds);
+}
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	/* We use id 0 for wakeup commands */
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 32870318..4514740b 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -154,6 +154,15 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat *=
chat, const char *cmd,
  */
 gboolean g_at_chat_retry(GAtChat *chat, guint id);
 =

+/*!
+ * Set the timeout for commands. If the timeout is configured and no respo=
nse
+ * is received from a written command within the timeout, the passed callb=
ack
+ * is called with ok as false, and a result that decodes to
+ * OFONO_ERROR_TYPE_FAILURE. Setting the timeout to zero disables the call=
ing
+ * of the callback.
+ */
+gboolean g_at_chat_set_timeout(GAtChat *chat, size_t seconds);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

diff --git a/plugins/quectel.c b/plugins/quectel.c
index ccfc6c5f..13947c78 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -879,9 +879,6 @@ static void init_cmd_cb(gboolean ok, GAtResult *result,=
 void *user_data)
 =

 	DBG("%p", modem);
 =

-	if (!ok)
-		return;
-
 	rts_cts =3D ofono_modem_get_string(modem, "RtsCts");
 =

 	if (strcmp(rts_cts, "on") =3D=3D 0)
-- =

2.22.1


--===============5531661776704154708==--

