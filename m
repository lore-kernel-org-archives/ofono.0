Content-Type: multipart/mixed; boundary="===============6156774059807495678=="
MIME-Version: 1.0
From: Yong Su <yong.su@windriver.com>
Subject: [PATCH] Add support for text mode SMS sending
Date: Tue, 24 Aug 2010 18:31:19 +0800
Message-ID: <1282645879-25437-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6156774059807495678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++=
----
 gatchat/gatchat.h |    8 +++
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index e85d908..6a9329c 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -53,6 +53,7 @@ struct at_command {
 	GAtNotifyFunc listing;
 	gpointer user_data;
 	GDestroyNotify notify;
+	gint cmd_len;
 };
 =

 struct at_notify_node {
@@ -208,7 +209,8 @@ static struct at_command *at_command_create(guint gid, =
const char *cmd,
 	}
 =

 	c->cmd[len] =3D '\0';
-
+	/* Normal AT Command without length */
+	c->cmd_len =3D -1;
 	c->gid =3D gid;
 	c->expect_pdu =3D expect_pdu;
 	c->prefixes =3D prefixes;
@@ -733,7 +735,7 @@ static gboolean can_write_data(gpointer data)
 	struct at_chat *chat =3D data;
 	struct at_command *cmd;
 	gsize bytes_written;
-	gsize towrite;
+	gsize towrite =3D 0;
 	gsize len;
 	char *cr;
 	gboolean wakeup_first =3D FALSE;
@@ -747,7 +749,13 @@ static gboolean can_write_data(gpointer data)
 	if (cmd =3D=3D NULL)
 		return FALSE;
 =

-	len =3D strlen(cmd->cmd);
+	if (cmd->cmd_len =3D=3D -1) {
+		/* Normal AT Command length */
+		len =3D strlen(cmd->cmd);
+	} else {
+		/* SMS text mode AT command length */
+		len =3D cmd->cmd_len;
+	}
 =

 	/* For some reason write watcher fired, but we've already
 	 * written the entire command out to the io channel,
@@ -781,12 +789,25 @@ static gboolean can_write_data(gpointer data)
 						wakeup_no_response, chat);
 	}
 =

-	towrite =3D len - chat->cmd_bytes_written;
-
-	cr =3D strchr(cmd->cmd + chat->cmd_bytes_written, '\r');
-
-	if (cr)
-		towrite =3D cr - (cmd->cmd + chat->cmd_bytes_written) + 1;
+	if (cmd->cmd_len =3D=3D -1) {
+		/* Normal AT Command write */
+		towrite =3D len - chat->cmd_bytes_written;
+		cr =3D strchr(cmd->cmd + chat->cmd_bytes_written, '\r');
+		if (cr)
+			towrite =3D cr - (cmd->cmd + chat->cmd_bytes_written) + 1;
+	} else {
+		/* SMS text mode AT command write */
+		if (chat->cmd_bytes_written =3D=3D 0) {
+			/* SMS text mode AT command write prefix */
+			cr =3D strchr(cmd->cmd + chat->cmd_bytes_written, '\r');
+			if (cr)
+				towrite =3D cr - (cmd->cmd
+						+ chat->cmd_bytes_written) + 1;
+		} else {
+			/* SMS text mode AT command write message content */
+			towrite =3D len - chat->cmd_bytes_written;
+		}
+	}
 =

 #ifdef WRITE_SCHEDULER_DEBUG
 	if (towrite > 5)
@@ -1433,3 +1454,89 @@ gboolean g_at_chat_unregister_all(GAtChat *chat)
 =

 	return at_chat_unregister_group(chat->parent, chat->group);
 }
+
+/*
+ * Create SMS text mode command with length
+ */
+static struct at_command *at_command_with_len_create(const char *cmd,
+		int cmdlen, const char **prefix_list, GAtResultFunc func,
+		gpointer user_data, GDestroyNotify notify) {
+	struct at_command *c;
+	gsize len;
+
+	char **prefixes =3D NULL;
+
+	if (prefix_list) {
+		int num_prefixes =3D 0;
+		int i;
+
+		while (prefix_list[num_prefixes])
+			num_prefixes +=3D 1;
+
+		prefixes =3D g_new(char *, num_prefixes + 1);
+
+		for (i =3D 0; i < num_prefixes; i++)
+			prefixes[i] =3D strdup(prefix_list[i]);
+
+		prefixes[num_prefixes] =3D NULL;
+	}
+
+	c =3D g_try_new0(struct at_command, 1);
+
+	if (!c)
+		return 0;
+
+	len =3D cmdlen;
+	c->cmd =3D g_try_new(char, len+1);
+
+	if (!c->cmd) {
+		g_free(c);
+		return 0;
+	}
+
+	memcpy(c->cmd, cmd, len);
+
+	/* SMS text mode AT command with length */
+	c->cmd[len] =3D '\0';
+	c->cmd_len =3D len;
+
+	c->expect_pdu =3D FALSE;
+	c->prefixes =3D prefixes;
+	c->callback =3D func;
+	c->listing =3D NULL;
+	c->user_data =3D user_data;
+	c->notify =3D notify;
+
+	return c;
+}
+/*
+ * Send AT command with length.
+ * Such as SMS text mode which contains 0x00 or 0x0A, 0x0D
+ */
+guint g_at_chat_send_with_len(GAtChat *child, const char *cmd, int cmdlen,
+			const char **prefix_list,
+			GAtResultFunc func, gpointer user_data,
+			GDestroyNotify notify) {
+
+	struct at_command *c;
+	struct at_chat *chat;
+	chat =3D child->parent;
+
+	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
+		return 0;
+
+	c =3D at_command_with_len_create(cmd, cmdlen, prefix_list, func,
+			user_data, notify);
+
+	if (!c)
+		return 0;
+
+	c->id =3D chat->next_cmd_id++;
+
+	g_queue_push_tail(chat->command_queue, c);
+
+	if (g_queue_get_length(chat->command_queue) =3D=3D 1)
+		chat_wakeup_writer(chat);
+
+	return c->id;
+}
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index f61fe53..edd2137 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -137,6 +137,14 @@ gboolean g_at_chat_set_wakeup_command(GAtChat *chat, c=
onst char *cmd,
 void g_at_chat_add_terminator(GAtChat *chat, char *terminator,
 				int len, gboolean success);
 =

+/*
+ * Send AT command with length.
+ * Such as SMS text mode which contains 0x00 or 0x0A, 0x0D
+ */
+guint g_at_chat_send_with_len(GAtChat *chat, const char *cmd, int cmdlen,
+		const char **prefix_list, GAtResultFunc func,
+		gpointer user_data, GDestroyNotify notify);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.3.3


--===============6156774059807495678==--

