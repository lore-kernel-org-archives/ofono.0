Content-Type: multipart/mixed; boundary="===============6992413352526691035=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 25/26] gatchat: add g_at_chat_send_escape_sequence()
 definition
Date: Fri, 01 Apr 2011 10:56:27 +0200
Message-ID: <1301648188-7208-26-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6992413352526691035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 546bd68..ae276eb 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -41,6 +41,9 @@
 #define COMMAND_FLAG_EXPECT_PDU			0x1
 #define COMMAND_FLAG_EXPECT_SHORT_PROMPT	0x2
 =

+/* Time to wait before and after +++ sequence */
+#define GUARD_TIMEOUTS 1500
+
 struct at_chat;
 static void chat_wakeup_writer(struct at_chat *chat);
 =

@@ -102,6 +105,7 @@ struct at_chat {
 	gboolean in_read_handler;		/* Re-entrancy guard */
 	gboolean in_notify;
 	GSList *terminator_list;		/* Non-standard terminator */
+	guint guard_timeout;			/* guard_timeout CB id */
 };
 =

 struct _GAtChat {
@@ -958,6 +962,9 @@ static void at_chat_unref(struct at_chat *chat)
 		chat_cleanup(chat);
 	}
 =

+	if (chat->guard_timeout)
+		g_source_remove(chat->guard_timeout);
+
 	if (chat->in_read_handler)
 		chat->destroyed =3D TRUE;
 	else
@@ -1495,6 +1502,31 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat=
 *chat, const char *cmd,
 					NULL, func, user_data, notify);
 }
 =

+static gboolean resume_chat(gpointer user_data)
+{
+	struct at_chat *chat =3D user_data;
+
+	at_chat_resume(chat);
+
+	return FALSE;
+}
+
+static gboolean at_send_escape_sequence(gpointer user_data)
+{
+	struct at_chat *chat =3D user_data;
+
+	g_at_io_write(chat->io, "+++", 3);
+
+	chat->guard_timeout =3D g_timeout_add(GUARD_TIMEOUTS, resume_chat, chat);
+
+	return FALSE;
+}
+
+void g_at_chat_send_escape_sequence(GAtChat *chat)
+{
+	chat->parent->guard_timeout =3D g_timeout_add(GUARD_TIMEOUTS, at_send_esc=
ape_sequence, chat->parent);
+}
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	/* We use id 0 for wakeup commands */
-- =

1.7.1


--===============6992413352526691035==--

