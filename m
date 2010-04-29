Content-Type: multipart/mixed; boundary="===============2162320397094670120=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] gatchat: Emit notification when command is sent to modem.
Date: Thu, 29 Apr 2010 13:32:46 +0200
Message-ID: <1272540766-19069-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2162320397094670120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Function g_at_chat_send_with_callback takes an additional parameter
that is a function to call when command is sent to hardware.
---
 gatchat/gatchat.c |   35 +++++++++++++++++++++++++++--------
 gatchat/gatchat.h |   17 +++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 4552767..000b624 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -49,6 +49,7 @@ struct at_command {
 	guint id;
 	GAtResultFunc callback;
 	GAtNotifyFunc listing;
+	GAtSubmitNotifyFunc submit_callback;
 	gpointer user_data;
 	GDestroyNotify notify;
 };
@@ -148,6 +149,7 @@ static struct at_command *at_command_create(const char =
*cmd,
 						const char **prefix_list,
 						gboolean expect_pdu,
 						GAtNotifyFunc listing,
+						GAtSubmitNotifyFunc sent,
 						GAtResultFunc func,
 						gpointer user_data,
 						GDestroyNotify notify,
@@ -203,6 +205,7 @@ static struct at_command *at_command_create(const char =
*cmd,
 	c->prefixes =3D prefixes;
 	c->callback =3D func;
 	c->listing =3D listing;
+	c->submit_callback =3D sent;
 	c->user_data =3D user_data;
 	c->notify =3D notify;
 =

@@ -700,7 +703,7 @@ static gboolean wakeup_no_response(gpointer user_data)
 =

 	g_at_chat_finish_command(chat, FALSE, NULL);
 	cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE,
-				NULL, wakeup_cb, chat, NULL, TRUE);
+				NULL, NULL, wakeup_cb, chat, NULL, TRUE);
 =

 	if (!cmd) {
 		chat->timeout_source =3D 0;
@@ -752,7 +755,8 @@ static gboolean can_write_data(gpointer data)
 =

 	if (chat->cmd_bytes_written =3D=3D 0 && wakeup_first =3D=3D TRUE) {
 		cmd =3D at_command_create(chat->wakeup, none_prefix, FALSE,
-					NULL, wakeup_cb, chat, NULL, TRUE);
+					NULL, NULL, wakeup_cb, chat, NULL,
+					TRUE);
 =

 		if (!cmd)
 			return FALSE;
@@ -789,6 +793,9 @@ static gboolean can_write_data(gpointer data)
 	if (bytes_written < towrite)
 		return TRUE;
 =

+	if (cmd->submit_callback)
+		cmd->submit_callback(cmd->id, cmd->user_data);
+
 	/* Full command submitted, update timer */
 	if (chat->wakeup_timer)
 		g_timer_start(chat->wakeup_timer);
@@ -967,7 +974,8 @@ gboolean g_at_chat_set_debug(GAtChat *chat,
 static guint send_common(GAtChat *chat, const char *cmd,
 			const char **prefix_list,
 			gboolean expect_pdu,
-			GAtNotifyFunc listing, GAtResultFunc func,
+			GAtNotifyFunc listing, GAtSubmitNotifyFunc sent,
+			GAtResultFunc func,
 			gpointer user_data, GDestroyNotify notify)
 {
 	struct at_command *c;
@@ -975,8 +983,8 @@ static guint send_common(GAtChat *chat, const char *cmd,
 	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
 		return 0;
 =

-	c =3D at_command_create(cmd, prefix_list, expect_pdu, listing, func,
-				user_data, notify, FALSE);
+	c =3D at_command_create(cmd, prefix_list, expect_pdu, listing,
+				sent, func, user_data, notify, FALSE);
 =

 	if (!c)
 		return 0;
@@ -995,7 +1003,7 @@ guint g_at_chat_send(GAtChat *chat, const char *cmd,
 			const char **prefix_list, GAtResultFunc func,
 			gpointer user_data, GDestroyNotify notify)
 {
-	return send_common(chat, cmd, prefix_list, FALSE, NULL, func,
+	return send_common(chat, cmd, prefix_list, FALSE, NULL, NULL, func,
 				user_data, notify);
 }
 =

@@ -1007,7 +1015,7 @@ guint g_at_chat_send_listing(GAtChat *chat, const cha=
r *cmd,
 	if (listing =3D=3D NULL)
 		return 0;
 =

-	return send_common(chat, cmd, prefix_list, FALSE, listing, func,
+	return send_common(chat, cmd, prefix_list, FALSE, listing, NULL, func,
 				user_data, notify);
 }
 =

@@ -1019,7 +1027,18 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, cons=
t char *cmd,
 	if (listing =3D=3D NULL)
 		return 0;
 =

-	return send_common(chat, cmd, prefix_list, TRUE, listing, func,
+	return send_common(chat, cmd, prefix_list, TRUE, listing, NULL, func,
+				user_data, notify);
+}
+
+guint g_at_chat_send_with_callback(GAtChat *chat, const char *cmd,
+					const char **valid_resp,
+					GAtSubmitNotifyFunc sent,
+					GAtResultFunc func,
+					gpointer user_data,
+					GDestroyNotify notify)
+{
+	return send_common(chat, cmd, valid_resp, TRUE, NULL, sent, func,
 				user_data, notify);
 }
 =

diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index ea6626e..80d87be 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -37,6 +37,7 @@ typedef struct _GAtChat GAtChat;
 typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
 				gpointer user_data);
 typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
+typedef void (*GAtSubmitNotifyFunc)(guint id, gpointer user_data);
 =

 GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *syntax);
 GAtChat *g_at_chat_new_blocking(GIOChannel *channel, GAtSyntax *syntax);
@@ -117,6 +118,22 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, const =
char *cmd,
 				GAtNotifyFunc listing, GAtResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
 =

+/*!
+ * Same as g_at_chat_send but with an ability to return a notification the
+ * moment the command finally leaves the queue and is submitted to lower
+ * layer.
+ *
+ * This is useful for cases where the modem's response time needs to be
+ * measured, assuming that the lower layers processing time is shorter
+ * than the minimum accuracy needed.
+ */
+guint g_at_chat_send_with_callback(GAtChat *chat, const char *cmd,
+					const char **valid_resp,
+					GAtSubmitNotifyFunc sent,
+					GAtResultFunc func,
+					gpointer user_data,
+					GDestroyNotify notify);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

-- =

1.6.1


--===============2162320397094670120==--

