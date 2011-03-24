Content-Type: multipart/mixed; boundary="===============2662977983199357981=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 07/12] gatchat: implementation for +CPOS send
Date: Thu, 24 Mar 2011 15:46:31 +0200
Message-ID: <1300974396-15801-8-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2662977983199357981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |   37 +++++++++++++++++++++++++++++++++----
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 3fd564d..eeb8d24 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -53,6 +53,7 @@ struct at_command {
 	GAtNotifyFunc listing;
 	gpointer user_data;
 	GDestroyNotify notify;
+	gboolean short_prompt;
 };
 =

 struct at_notify_node {
@@ -725,9 +726,18 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
 =

 	GAtSyntaxResult result;
+	struct at_command *cmd;
 =

 	p->in_read_handler =3D TRUE;
 =

+	cmd =3D g_queue_peek_head(p->command_queue);
+	if (cmd)
+		if (cmd->short_prompt &&
+				!g_strcmp0(*cmd->prefixes, "+CPOS:") &&
+				p->syntax->set_hint)
+			p->syntax->set_hint(p->syntax,
+					G_AT_SYNTAX_EXPECT_SHORT_PROMPT);
+
 	while (p->suspended =3D=3D FALSE && (p->read_so_far < len)) {
 		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
 		result =3D p->syntax->feed(p->syntax, (char *)buf, &rbytes);
@@ -754,6 +764,12 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 			break;
 =

 		case G_AT_SYNTAX_RESULT_PROMPT:
+			if (cmd)
+				if (cmd->short_prompt &&
+						!g_strcmp0(*cmd->prefixes,
+						"+CPOS:"))
+					cmd->short_prompt =3D FALSE;
+
 			chat_wakeup_writer(p);
 			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
@@ -995,7 +1011,8 @@ static guint at_chat_send_common(struct at_chat *chat,=
 guint gid,
 					GAtNotifyFunc listing,
 					GAtResultFunc func,
 					gpointer user_data,
-					GDestroyNotify notify)
+					GDestroyNotify notify,
+					gboolean short_prompt)
 {
 	struct at_command *c;
 =

@@ -1007,6 +1024,7 @@ static guint at_chat_send_common(struct at_chat *chat=
, guint gid,
 	if (c =3D=3D NULL)
 		return 0;
 =

+	c->short_prompt =3D short_prompt;
 	c->id =3D chat->next_cmd_id++;
 =

 	g_queue_push_tail(chat->command_queue, c);
@@ -1439,7 +1457,7 @@ guint g_at_chat_send(GAtChat *chat, const char *cmd,
 {
 	return at_chat_send_common(chat->parent, chat->group,
 					cmd, prefix_list, FALSE, NULL,
-					func, user_data, notify);
+					func, user_data, notify, FALSE);
 }
 =

 guint g_at_chat_send_listing(GAtChat *chat, const char *cmd,
@@ -1452,7 +1470,8 @@ guint g_at_chat_send_listing(GAtChat *chat, const cha=
r *cmd,
 =

 	return at_chat_send_common(chat->parent, chat->group,
 					cmd, prefix_list, FALSE,
-					listing, func, user_data, notify);
+					listing, func, user_data, notify,
+					FALSE);
 }
 =

 guint g_at_chat_send_pdu_listing(GAtChat *chat, const char *cmd,
@@ -1465,7 +1484,17 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, cons=
t char *cmd,
 =

 	return at_chat_send_common(chat->parent, chat->group,
 					cmd, prefix_list, TRUE,
-					listing, func, user_data, notify);
+					listing, func, user_data, notify,
+					FALSE);
+}
+
+guint g_at_chat_send_and_expect_short_prompt(GAtChat *chat, const char *cm=
d,
+			const char **prefix_list, GAtResultFunc func,
+			gpointer user_data, GDestroyNotify notify)
+{
+	return at_chat_send_common(chat->parent, chat->group,
+					cmd, prefix_list, FALSE, NULL,
+					func, user_data, notify, TRUE);
 }
 =

 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
-- =

1.7.0.4


--===============2662977983199357981==--

