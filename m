Content-Type: multipart/mixed; boundary="===============6883492610153203308=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 06/24] gatchat: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-7-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-6-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6883492610153203308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 gatchat/gatchat.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index d7d0060..3f290ac 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -305,8 +305,9 @@ static void at_command_destroy(struct at_command *cmd)
 	g_free(cmd);
 }
 =

-static void free_terminator(struct terminator_info *info)
+static void free_terminator(gpointer pointer)
 {
+	struct terminator_info *info =3D pointer;
 	g_free(info->terminator);
 	info->terminator =3D NULL;
 	g_free(info);
@@ -325,8 +326,7 @@ static void chat_cleanup(struct at_chat *chat)
 	chat->command_queue =3D NULL;
 =

 	/* Cleanup any response lines we have pending */
-	g_slist_foreach(chat->response_lines, (GFunc)g_free, NULL);
-	g_slist_free(chat->response_lines);
+	g_slist_free_full(chat->response_lines, g_free);
 	chat->response_lines =3D NULL;
 =

 	/* Cleanup registered notifications */
@@ -357,9 +357,7 @@ static void chat_cleanup(struct at_chat *chat)
 	chat->syntax =3D NULL;
 =

 	if (chat->terminator_list) {
-		g_slist_foreach(chat->terminator_list,
-					(GFunc)free_terminator, NULL);
-		g_slist_free(chat->terminator_list);
+		g_slist_free_full(chat->terminator_list, free_terminator);
 		chat->terminator_list =3D NULL;
 	}
 }
@@ -461,8 +459,7 @@ static void at_chat_finish_command(struct at_chat *p, g=
boolean ok, char *final)
 		cmd->callback(ok, &result, cmd->user_data);
 	}
 =

-	g_slist_foreach(response_lines, (GFunc)g_free, NULL);
-	g_slist_free(response_lines);
+	g_slist_free_full(response_lines, g_free);
 =

 	g_free(final);
 	at_command_destroy(cmd);
-- =

1.9.1

--===============6883492610153203308==--

