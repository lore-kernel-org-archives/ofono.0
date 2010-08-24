Content-Type: multipart/mixed; boundary="===============2639841985123160189=="
MIME-Version: 1.0
From: Yong Su <yong.su@windriver.com>
Subject: [PATCH 2/4] Support text mode sms sending and receiving
Date: Tue, 24 Aug 2010 14:35:37 +0800
Message-ID: <1282631737-15873-1-git-send-email-yong.su@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2639841985123160189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index f61fe53..c2aca58 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -137,6 +137,29 @@ gboolean g_at_chat_set_wakeup_command(GAtChat *chat, c=
onst char *cmd,
 void g_at_chat_add_terminator(GAtChat *chat, char *terminator,
 				int len, gboolean success);
 =

+/**
+ * Send AT command with length, such as SMS text mode which contains 0x00 =
or 0x0A, 0x0D
+ */
+guint g_at_chat_send_with_len(GAtChat *chat, const char *cmd, int cmdlen,
+		const char **prefix_list, GAtResultFunc func,
+		gpointer user_data, GDestroyNotify notify);
+
+/**
+ * Call back function to handle receive Text Mode SMS
+ * Get the message content length, include 0x1A or 0x001A
+ */
+typedef int (*GAtExpectMsgLenFunc)(const char* line);
+
+/**
+ * Modify from g_at_chat_register, add parameter expect_msglen_func
+ */
+guint g_at_chat_register_with_func(GAtChat *chat, const char *prefix,
+				GAtNotifyFunc func, gboolean expect_pdu,
+				GAtExpectMsgLenFunc expect_msglen_func,
+				gpointer user_data, GDestroyNotify notify);
+
+
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.6.3.3


--===============2639841985123160189==--

