Content-Type: multipart/mixed; boundary="===============1335227971640590660=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/8] Add a proactive command cancel notification.
Date: Tue, 22 Jun 2010 13:20:49 +0200
Message-ID: <1277205651-29369-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1335227971640590660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/stk.h |    2 ++
 src/stk.c     |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/stk.h b/include/stk.h
index ad3f6c5..4e5d01e 100644
--- a/include/stk.h
+++ b/include/stk.h
@@ -65,6 +65,8 @@ void *ofono_stk_get_data(struct ofono_stk *stk);
 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
 					int length, const unsigned char *pdu);
 =

+void ofono_stk_proactive_command_cancel(struct ofono_stk *stk);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/src/stk.c b/src/stk.c
index b43f090..b752e49 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -253,6 +253,14 @@ done:
 	g_free(buf);
 }
 =

+void ofono_stk_proactive_command_cancel(struct ofono_stk *stk)
+{
+	if (!stk->pending_cmd)
+		return;
+
+	stk->cancel_cmd(stk);
+}
+
 static gboolean stk_command_handler_register(struct ofono_stk *stk,
 						enum stk_command_type type,
 						command_handler_t handler)
-- =

1.7.1.86.g0e460.dirty


--===============1335227971640590660==--

