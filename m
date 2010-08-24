Content-Type: multipart/mixed; boundary="===============1785142185726925396=="
MIME-Version: 1.0
From: Yong Su <yong.su@windriver.com>
Subject: [PATCH 1/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 14:34:19 +0800
Message-ID: <1282631659-15840-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1785142185726925396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |  236 +++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 224 insertions(+), 12 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index e85d908..1527611 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -41,6 +41,8 @@
 struct at_chat;
 static void chat_wakeup_writer(struct at_chat *chat);
 =

+static char *extract_line_with_crlf(struct at_chat *p,struct ring_buffer *=
rbuf);
+
 static const char *none_prefix[] =3D { NULL };
 =

 struct at_command {
@@ -53,6 +55,7 @@ struct at_command {
 	GAtNotifyFunc listing;
 	gpointer user_data;
 	GDestroyNotify notify;
+	gint cmd_len;
 };
 =

 struct at_notify_node {
@@ -66,6 +69,7 @@ struct at_notify_node {
 struct at_notify {
 	GSList *nodes;
 	gboolean pdu;
+	GAtExpectMsgLenFunc expect_msglen_func;
 };
 =

 struct at_chat {
@@ -208,7 +212,8 @@ static struct at_command *at_command_create(guint gid, =
const char *cmd,
 	}
 =

 	c->cmd[len] =3D '\0';
-
+	/* Normal AT Command without length*/
+	c->cmd_len =3D -1;
 	c->gid =3D gid;
 	c->expect_pdu =3D expect_pdu;
 	c->prefixes =3D prefixes;
@@ -330,6 +335,17 @@ static gboolean at_chat_match_notify(struct at_chat *c=
hat, char *line)
 		if (notify->pdu) {
 			chat->pdu_notify =3D line;
 =

+			/* Read expect message length
+			 * If length is -1, use original solution
+			 */
+			if(notify->expect_msglen_func){
+				int len =3D notify->expect_msglen_func(line);
+				chat->syntax->expect_msg_len =3D len;
+			}else{
+				chat->syntax->expect_msg_len =3D -1;
+			}
+
+
 			if (chat->syntax->set_hint)
 				chat->syntax->set_hint(chat->syntax,
 							G_AT_SYNTAX_EXPECT_PDU);
@@ -665,7 +681,14 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 			break;
 =

 		case G_AT_SYNTAX_RESULT_PDU:
-			have_pdu(p, extract_line(p, rbuf));
+			/* Modify support SMS Text Mode */
+			if(p->syntax->expect_msg_len =3D=3D -1){
+				have_pdu(p, extract_line(p,rbuf));
+			}else{
+				have_pdu(p, extract_line_with_crlf(p,rbuf));
+				/* Reset expect message len */
+				p->syntax->expect_msg_len =3D -1;
+			}
 			break;
 =

 		case G_AT_SYNTAX_RESULT_PROMPT:
@@ -733,7 +756,7 @@ static gboolean can_write_data(gpointer data)
 	struct at_chat *chat =3D data;
 	struct at_command *cmd;
 	gsize bytes_written;
-	gsize towrite;
+	gsize towrite =3D 0;
 	gsize len;
 	char *cr;
 	gboolean wakeup_first =3D FALSE;
@@ -747,7 +770,13 @@ static gboolean can_write_data(gpointer data)
 	if (cmd =3D=3D NULL)
 		return FALSE;
 =

-	len =3D strlen(cmd->cmd);
+	if(cmd->cmd_len =3D=3D -1){
+		/* Normal AT Command length */
+		len =3D strlen(cmd->cmd);
+	}else{
+		/* SMS text mode AT command length */
+		len =3D cmd->cmd_len;
+	}
 =

 	/* For some reason write watcher fired, but we've already
 	 * written the entire command out to the io channel,
@@ -781,12 +810,26 @@ static gboolean can_write_data(gpointer data)
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
+		if (cr) {
+			towrite =3D cr - (cmd->cmd + chat->cmd_bytes_written) + 1;
+		}
+	} else {
+		/* SMS text mode AT command write */
+		if(chat->cmd_bytes_written =3D=3D 0){
+			/* SMS text mode AT command write prefix */
+			cr =3D strchr(cmd->cmd + chat->cmd_bytes_written, '\r');
+			if (cr) {
+				towrite =3D cr - (cmd->cmd + chat->cmd_bytes_written) + 1;
+			}
+		}else{
+			/* SMS text mode AT command write msg content */
+			towrite =3D len - chat->cmd_bytes_written;
+		}
+	}
 =

 #ifdef WRITE_SCHEDULER_DEBUG
 	if (towrite > 5)
@@ -936,7 +979,8 @@ static guint at_chat_send_common(struct at_chat *chat, =
guint gid,
 =

 static struct at_notify *at_notify_create(struct at_chat *chat,
 						const char *prefix,
-						gboolean pdu)
+						gboolean pdu,
+						GAtExpectMsgLenFunc expect_msglen_func)
 {
 	struct at_notify *notify;
 	char *key;
@@ -953,6 +997,7 @@ static struct at_notify *at_notify_create(struct at_cha=
t *chat,
 	}
 =

 	notify->pdu =3D pdu;
+	notify->expect_msglen_func =3D expect_msglen_func;
 =

 	g_hash_table_insert(chat->notify_list, key, notify);
 =

@@ -1040,7 +1085,7 @@ static guint at_chat_register(struct at_chat *chat, g=
uint group,
 	notify =3D g_hash_table_lookup(chat->notify_list, prefix);
 =

 	if (!notify)
-		notify =3D at_notify_create(chat, prefix, expect_pdu);
+		notify =3D at_notify_create(chat, prefix, expect_pdu, NULL);
 =

 	if (!notify || notify->pdu !=3D expect_pdu)
 		return 0;
@@ -1433,3 +1478,170 @@ gboolean g_at_chat_unregister_all(GAtChat *chat)
 =

 	return at_chat_unregister_group(chat->parent, chat->group);
 }
+
+/**
+ * Add extract function for reading line with CR and LF
+ * SMS response as Text Mode will use this function to extract line
+ */
+
+static char *extract_line_with_crlf(struct at_chat *p,struct ring_buffer *=
rbuf)
+{
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
+	unsigned int pos =3D 0;
+	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, pos);
+	int strip_front =3D 0;
+	int line_length =3D 0;
+	char *line;
+
+	while (pos < p->read_so_far) {
+
+		line_length +=3D 1;
+		buf +=3D 1;
+		pos +=3D 1;
+
+		if (pos =3D=3D wrap)
+			buf =3D ring_buffer_read_ptr(rbuf, pos);
+	}
+
+	line =3D g_try_new(char, line_length + 1);
+
+	if (!line) {
+		ring_buffer_drain(rbuf, p->read_so_far);
+		return NULL;
+	}
+
+	ring_buffer_drain(rbuf, strip_front);
+	ring_buffer_read(rbuf, line, line_length);
+	ring_buffer_drain(rbuf, p->read_so_far - strip_front - line_length);
+
+	line[line_length] =3D '\0';
+
+	return line;
+}
+
+/**
+ * Create SMS text mode command with length
+ */
+static struct at_command *at_command_with_len_create(const char *cmd, int =
cmdlen,
+		const char **prefix_list, GAtResultFunc func, gpointer user_data,
+		GDestroyNotify notify) {
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
+	/* SMS text mode AT command with length*/
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
+/**
+ * Send AT command with length, such as SMS text mode which contains 0x00 =
or 0x0A, 0x0D
+ */
+guint g_at_chat_send_with_len(GAtChat *child, const char *cmd, int cmdlen,=
 const char **prefix_list,
+		GAtResultFunc func, gpointer user_data, GDestroyNotify notify) {
+
+	struct at_command *c;
+	struct at_chat *chat;
+	chat =3D child->parent;
+
+	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
+		return 0;
+
+	c =3D at_command_with_len_create(cmd, cmdlen, prefix_list, func, user_dat=
a, notify);
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
+
+/**
+ * Modify from g_at_chat_register, add parameter expect_msglen_func
+ */
+guint g_at_chat_register_with_func(GAtChat *child, const char *prefix,
+				GAtNotifyFunc func, gboolean expect_pdu,
+				GAtExpectMsgLenFunc expect_msglen_func,
+				gpointer user_data,
+				GDestroyNotify destroy_notify)
+{
+	struct at_notify *notify;
+	struct at_notify_node *node;
+	struct at_chat *chat;
+	chat =3D child->parent;
+
+	if (chat =3D=3D NULL || chat->notify_list =3D=3D NULL)
+		return 0;
+
+	if (func =3D=3D NULL)
+		return 0;
+
+	if (prefix =3D=3D NULL || strlen(prefix) =3D=3D 0)
+		return 0;
+
+	notify =3D g_hash_table_lookup(chat->notify_list, prefix);
+
+	if (!notify)
+		notify =3D at_notify_create(chat, prefix, expect_pdu, expect_msglen_func=
);
+
+	if (!notify || notify->pdu !=3D expect_pdu)
+		return 0;
+
+	node =3D g_try_new0(struct at_notify_node, 1);
+	if (!node)
+		return 0;
+
+	node->id =3D chat->next_notify_id++;
+	node->callback =3D func;
+	node->user_data =3D user_data;
+	node->notify =3D destroy_notify;
+
+	notify->nodes =3D g_slist_prepend(notify->nodes, node);
+
+	return node->id;
+}
-- =

1.6.3.3


--===============1785142185726925396==--

