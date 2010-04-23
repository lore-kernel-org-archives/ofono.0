Content-Type: multipart/mixed; boundary="===============3356204218242473059=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] gatchat: implement suspend/resume
Date: Fri, 23 Apr 2010 15:07:22 -0700
Message-ID: <1272060442-15783-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3356204218242473059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow a caller to suspend and resume without losing command queue.
---
 gatchat/gatchat.c |   41 +++++++++++++++++++++++++++++++++++++++++
 gatchat/gatchat.h |    3 +++
 gatchat/gsmdial.c |   10 ++++------
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 613aad2..13d5f00 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -92,6 +92,7 @@ struct _GAtChat {
 	GAtSyntax *syntax;
 	gboolean destroyed;			/* Re-entrancy guard */
 	GSList *terminator_list;		/* Non-standard terminator */
+	gboolean suspended;
 };
 =

 struct terminator_info {
@@ -289,6 +290,11 @@ static void read_watcher_destroy_notify(gpointer user_=
data)
 {
 	GAtChat *chat =3D user_data;
 =

+	if (chat->suspended =3D=3D TRUE) {
+		chat->read_watch =3D 0;
+		return;
+	}
+
 	g_at_chat_cleanup(chat);
 	chat->read_watch =3D 0;
 =

@@ -886,6 +892,9 @@ static void g_at_chat_wakeup_writer(GAtChat *chat)
 	if (chat->write_watch !=3D 0)
 		return;
 =

+	if (chat->suspended =3D=3D TRUE)
+		return;
+
 	if (chat->use_write_watch =3D=3D TRUE) {
 		chat->write_watch =3D g_io_add_watch_full(chat->channel,
 				G_PRIORITY_DEFAULT,
@@ -1037,6 +1046,38 @@ gboolean g_at_chat_shutdown(GAtChat *chat)
 	return TRUE;
 }
 =

+void g_at_chat_suspend(GAtChat *chat)
+{
+	if (chat->channel =3D=3D NULL || chat->suspended =3D=3D TRUE)
+		return;
+
+	chat->suspended =3D TRUE;
+
+	if (chat->read_watch)
+		g_source_remove(chat->read_watch);
+
+	if (chat->write_watch)
+		g_source_remove(chat->write_watch);
+}
+
+void g_at_chat_resume(GAtChat *chat)
+{
+	if (chat->suspended =3D=3D FALSE)
+		return;
+
+	chat->suspended =3D FALSE;
+
+	if (chat->read_watch =3D=3D 0)
+	chat->read_watch =3D g_io_add_watch_full(chat->channel,
+				G_PRIORITY_DEFAULT,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				received_data, chat,
+				read_watcher_destroy_notify);
+
+	if (g_queue_get_length(chat->command_queue) > 0)
+		g_at_chat_wakeup_writer(chat);
+}
+
 gboolean g_at_chat_set_syntax(GAtChat *chat, GAtSyntax *syntax)
 {
 	if (chat =3D=3D NULL)
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 58c7155..17217ed 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -48,6 +48,9 @@ void g_at_chat_unref(GAtChat *chat);
 =

 gboolean g_at_chat_shutdown(GAtChat *chat);
 =

+void g_at_chat_suspend(GAtChat *chat);
+void g_at_chat_resume(GAtChat *chat);
+
 gboolean g_at_chat_set_syntax(GAtChat *chat, GAtSyntax *syntax);
 =

 gboolean g_at_chat_set_disconnect_function(GAtChat *chat,
diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
index 02d01f3..720cdb1 100644
--- a/gatchat/gsmdial.c
+++ b/gatchat/gsmdial.c
@@ -240,6 +240,8 @@ static void ppp_connect(GAtPPPConnectStatus success,
 static void ppp_disconnect(gpointer user_data)
 {
 	g_print("PPP Link down\n");
+	g_at_chat_resume(control);
+	g_at_chat_resume(modem);
 }
 =

 static void connect_cb(gboolean ok, GAtResult *result, gpointer user_data)
@@ -254,12 +256,8 @@ static void connect_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	/* get the data IO channel */
 	channel =3D g_at_chat_get_channel(modem);
 =

-	/*
-	 * shutdown gatchat or else it tries to take all the input
-	 * from the modem and does not let PPP get it.
-	 */
-	g_at_chat_shutdown(control);
-	g_at_chat_shutdown(modem);
+	g_at_chat_suspend(control);
+	g_at_chat_suspend(modem);
 =

 	/* open ppp */
 	ppp =3D g_at_ppp_new(channel);
-- =

1.6.6.1


--===============3356204218242473059==--

