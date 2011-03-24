Content-Type: multipart/mixed; boundary="===============4240823777963558532=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 05/12] gatchat: introduce send for +CPOS
Date: Thu, 24 Mar 2011 15:46:29 +0200
Message-ID: <1300974396-15801-6-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4240823777963558532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 8cbb559..eb82daa 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -124,6 +124,14 @@ guint g_at_chat_send_pdu_listing(GAtChat *chat, const =
char *cmd,
 				GAtNotifyFunc listing, GAtResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
 =

+/*!
+ * Same as g_at_chat_send except parser will know to expect short prompt s=
yntax
+ * used with +CPOS.
+ */
+guint g_at_chat_send_and_expect_short_prompt(GAtChat *chat, const char *cm=
d,
+				const char **valid_resp, GAtResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

-- =

1.7.0.4


--===============4240823777963558532==--

