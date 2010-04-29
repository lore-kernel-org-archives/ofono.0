Content-Type: multipart/mixed; boundary="===============2241876982099457278=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/4][RFC] gatchat: Allow cancelling a running command.
Date: Thu, 29 Apr 2010 13:32:34 +0200
Message-ID: <1272540754-19028-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2241876982099457278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Users need to be extra careful using the cancel functions because
there's a potential race condition where an OK or ERROR for the command
being cancelled arrives just the same moment the next command in the
queue is being submitted, and is treated as a response to that command.

Ideally we would have some kind of "barrier" command that could be
inserted into the queue and whose response would be different than
OK or ERROR.
---
 gatchat/gatchat.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index f94605f..4552767 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -1026,6 +1026,7 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, const=
 char *cmd,
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	GList *l;
+	gboolean head;
 =

 	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
 		return FALSE;
@@ -1040,18 +1041,20 @@ gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 	if (!l)
 		return FALSE;
 =

-	if (l =3D=3D g_queue_peek_head(chat->command_queue) &&
-			chat->cmd_bytes_written > 0) {
-		struct at_command *c =3D l->data;
+	head =3D l->data =3D=3D g_queue_peek_head(chat->command_queue);
 =

-		/* We can't actually remove it since it is most likely
-		 * already in progress, just null out the callback
-		 * so it won't be called
-		 */
-		c->callback =3D NULL;
-	} else {
-		at_command_destroy(l->data);
-		g_queue_remove(chat->command_queue, l->data);
+	at_command_destroy(l->data);
+	g_queue_remove(chat->command_queue, l->data);
+
+	if (head) {
+		chat->cmd_bytes_written =3D 0;
+
+		g_slist_foreach(chat->response_lines, (GFunc)g_free, NULL);
+		g_slist_free(chat->response_lines);
+		chat->response_lines =3D NULL;
+
+		if (g_queue_get_length(chat->command_queue) > 0)
+			chat_wakeup_writer(chat);
 	}
 =

 	return TRUE;
@@ -1071,15 +1074,10 @@ gboolean g_at_chat_cancel_all(GAtChat *chat)
 			continue;
 		}
 =

-		if (n =3D=3D 0 && chat->cmd_bytes_written > 0) {
-			c->callback =3D NULL;
-			n +=3D 1;
-			continue;
-		}
-
 		at_command_destroy(c);
 		g_queue_remove(chat->command_queue, c);
 	}
+	chat->cmd_bytes_written =3D 0;
 =

 	return TRUE;
 }
-- =

1.6.1


--===============2241876982099457278==--

