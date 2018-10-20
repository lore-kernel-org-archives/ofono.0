Content-Type: multipart/mixed; boundary="===============1960648341305127813=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] gatchat: export gatchat at_chat_finish_command
Date: Sat, 20 Oct 2018 12:26:16 +0200
Message-ID: <20181020102616.26572-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1960648341305127813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added the function g_at_chat_finish_command, in order to be able to
interrupt a pending command.
The function is useful in special cases, for example to implement
a custom g_at_chat_set_wakeup_command. This command will never
return if the device does not answer, and therefore it is unsuitable
to probe configurations.
---
 gatchat/gatchat.c | 4 ++++
 gatchat/gatchat.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 3f290ac2..edb55efe 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -465,6 +465,10 @@ static void at_chat_finish_command(struct at_chat *p, =
gboolean ok, char *final)
 	at_command_destroy(cmd);
 }
 =

+void g_at_chat_finish_command(GAtChat *chat) {
+	at_chat_finish_command(chat->parent, FALSE, NULL);
+}
+
 static struct terminator_info terminator_table[] =3D {
 	{ "OK", -1, TRUE },
 	{ "ERROR", -1, FALSE },
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 7290b34f..36fa87f0 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -167,6 +167,8 @@ void g_at_chat_add_terminator(GAtChat *chat, char *term=
inator,
 void g_at_chat_blacklist_terminator(GAtChat *chat,
 						GAtChatTerminator terminator);
 =

+void g_at_chat_finish_command(GAtChat *chat);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.17.1


--===============1960648341305127813==--

