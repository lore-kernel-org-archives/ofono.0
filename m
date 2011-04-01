Content-Type: multipart/mixed; boundary="===============6834703566791170743=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 24/26] gatchat: add g_at_chat_send_escape_sequence()
 prototype
Date: Fri, 01 Apr 2011 10:56:26 +0200
Message-ID: <1301648188-7208-25-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6834703566791170743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index eb82daa..326ebe2 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -132,6 +132,8 @@ guint g_at_chat_send_and_expect_short_prompt(GAtChat *c=
hat, const char *cmd,
 				const char **valid_resp, GAtResultFunc func,
 				gpointer user_data, GDestroyNotify notify);
 =

+void g_at_chat_send_escape_sequence(GAtChat *chat);
+
 gboolean g_at_chat_cancel(GAtChat *chat, guint id);
 gboolean g_at_chat_cancel_all(GAtChat *chat);
 =

-- =

1.7.1


--===============6834703566791170743==--

