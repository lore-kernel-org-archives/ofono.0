Content-Type: multipart/mixed; boundary="===============5746103757819175237=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 1/2] gatchat: add g_at_chat_retry()
Date: Mon, 12 Aug 2019 22:38:31 +0200
Message-ID: <20190812203832.19096-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5746103757819175237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current API doesn't support canceling an in-progress command;
instead g_at_chat_cancel() simply removes the callback.

In cases where the modem doesn't respond at all to a command, a chat is
simply stalled without any way to write new commands to the modem.

Support that case by adding a g_at_chat_retry() function to the API. The
function does nothing if the command is not yet in-progress, or if the
command is finished. Otherwise, it resets the bytes-written counter to
re-write the command string.
---
 gatchat/gatchat.c | 31 +++++++++++++++++++++++++++++++
 gatchat/gatchat.h |  7 +++++++
 2 files changed, 38 insertions(+)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 3f290ac2..71dc94f5 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -1047,6 +1047,29 @@ static guint at_chat_send_common(struct at_chat *cha=
t, guint gid,
 	return c->id;
 }
 =

+static gboolean at_chat_retry(struct at_chat *chat, guint gid)
+{
+	struct at_command *cmd =3D g_queue_peek_head(chat->command_queue);
+
+	if (!cmd)
+		return FALSE;
+
+	/* do nothing if command is not yet started, or already finished */
+	if (cmd->id !=3D gid)
+		return FALSE;
+
+	/* do nothing if command is not fully written */
+	if (chat->cmd_bytes_written !=3D strlen(cmd->cmd))
+		return FALSE;
+
+	/* reset number of written bytes to re-write command */
+	chat->cmd_bytes_written =3D 0;
+
+	chat_wakeup_writer(chat);
+
+	return TRUE;
+}
+
 static struct at_notify *at_notify_create(struct at_chat *chat,
 						const char *prefix,
 						gboolean pdu)
@@ -1543,6 +1566,14 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat=
 *chat, const char *cmd,
 					NULL, func, user_data, notify);
 }
 =

+gboolean g_at_chat_retry(GAtChat *chat, guint id)
+{
+	if (chat =3D=3D NULL || id =3D=3D 0)
+		return FALSE;
+
+	return at_chat_retry(chat->parent, id);
+}
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	/* We use id 0 for wakeup commands */
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 7290b34f..32870318 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -147,6 +147,13 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat *=
chat, const char *cmd,
 				const char **valid_resp, GAtResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
 =

+/*!
+ * Retry an already created command. This does nothing if the command is
+ * still waiting in the queue. If the command has been written to the chan=
nel,
+ * but no response is received yet, the retry writes the command again.
+ */
+gboolean g_at_chat_retry(GAtChat *chat, guint id);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

-- =

2.22.0


--===============5746103757819175237==--

