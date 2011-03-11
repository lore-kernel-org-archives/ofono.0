Content-Type: multipart/mixed; boundary="===============1864487989524714149=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 07/12] gatchat: implementation for +CPOS send
Date: Fri, 11 Mar 2011 14:23:04 +0200
Message-ID: <1299846189-15132-8-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299846189-15132-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1864487989524714149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 3fd564d..64f131d 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -1468,6 +1468,19 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, cons=
t char *cmd,
 					listing, func, user_data, notify);
 }
 =

+guint g_at_chat_send_and_expect_short_prompt(GAtChat *chat, const char *cm=
d,
+			const char **prefix_list, GAtResultFunc func,
+			gpointer user_data, GDestroyNotify notify)
+{
+	if(chat !=3D NULL)
+		chat->parent->syntax->set_hint(chat->parent->syntax,
+					G_AT_SYNTAX_EXPECT_SHORT_PROMPT);
+
+	return at_chat_send_common(chat->parent, chat->group,
+					cmd, prefix_list, FALSE, NULL,
+					func, user_data, notify);
+}
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id)
 {
 	/* We use id 0 for wakeup commands */
-- =

1.7.0.4


--===============1864487989524714149==--

