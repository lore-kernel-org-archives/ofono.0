Content-Type: multipart/mixed; boundary="===============2780730259477868520=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 2/2] Remove dead assignments at gatchat
Date: Tue, 02 Feb 2010 20:08:30 -0200
Message-ID: <1265148510-24408-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1265148510-24408-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2780730259477868520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 5b0851b..d5362db 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -312,7 +312,6 @@ static gboolean g_at_chat_match_notify(GAtChat *chat, c=
har *line)
 {
 	GHashTableIter iter;
 	struct at_notify *notify;
-	char *prefix;
 	gpointer key, value;
 	gboolean ret =3D FALSE;
 	GAtResult result;
@@ -322,7 +321,6 @@ static gboolean g_at_chat_match_notify(GAtChat *chat, c=
har *line)
 	result.final_or_pdu =3D 0;
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		prefix =3D key;
 		notify =3D value;
 =

 		if (!g_str_has_prefix(line, key))
@@ -753,7 +751,7 @@ static void wakeup_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 static gboolean wakeup_no_response(gpointer user)
 {
 	GAtChat *chat =3D user;
-	struct at_command *cmd =3D g_queue_peek_head(chat->command_queue);
+	struct at_command *cmd;
 =

 	if (chat->debugf)
 		chat->debugf("Wakeup got no response\n", chat->debug_data);
@@ -1259,7 +1257,6 @@ gboolean g_at_chat_unregister(GAtChat *chat, guint id)
 {
 	GHashTableIter iter;
 	struct at_notify *notify;
-	char *prefix;
 	gpointer key, value;
 	GSList *l;
 =

@@ -1269,7 +1266,6 @@ gboolean g_at_chat_unregister(GAtChat *chat, guint id)
 	g_hash_table_iter_init(&iter, chat->notify_list);
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		prefix =3D key;
 		notify =3D value;
 =

 		l =3D g_slist_find_custom(notify->nodes, GUINT_TO_POINTER(id),
@@ -1294,7 +1290,6 @@ gboolean g_at_chat_unregister_all(GAtChat *chat)
 {
 	GHashTableIter iter;
 	struct at_notify *notify;
-	char *prefix;
 	gpointer key, value;
 	GSList *l;
 =

@@ -1304,7 +1299,6 @@ gboolean g_at_chat_unregister_all(GAtChat *chat)
 	g_hash_table_iter_init(&iter, chat->notify_list);
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		prefix =3D key;
 		notify =3D value;
 =

 		for (l =3D notify->nodes; l; l =3D l->next)
-- =

1.6.4.4


--===============2780730259477868520==--

